#!/usr/bin/env bash

set -euo pipefail

if ! [ -z ${SYNAPSE_CONFIG_DIR+x} ]; then
	echo Custom SYNAPSE_CONFIG_DIR is not supported, bailing... 1>&2
	exit 1
fi

if ! [ -z ${SYNAPSE_CONFIG_PATH+x} ]; then
	echo Custom SYNAPSE_CONFIG_PATH is not supported, bailing... 1>&2
	exit 1
fi

# People can override if they really want, but dev environments shouldn't pollute the statistics server
if [ -z ${SYNAPSE_REPORT_STATS+x} ]; then
	export SYNAPSE_REPORT_STATS=no
fi

mkdir -p /data
test -f /data/homeserver.yaml || /start.py generate

# Set registration secret to a well-known string
reg_secret_config='registration_shared_secret: "registration_secret"'
grep -q "^$reg_secret_config" /data/homeserver.yaml || sed -i 's/^registration_shared_secret: .*/'"$reg_secret_config"'/' /data/homeserver.yaml

# Disable most communication/federation to the outside world
if grep -q trusted_key_servers /data/homeserver.yaml; then
	sed -i '/trusted_key_servers/,+1d' /data/homeserver.yaml
fi

federation_listener_config='- names: \[client, federation\]'
if grep -q -- "$federation_listener_config" /data/homeserver.yaml; then
	sed -i "s/$federation_listener_config/- names: [client]/" /data/homeserver.yaml
fi

grep -q federation_domain_whitelist /data/homeserver.yaml || printf '\nfederation_domain_whitelist: []\n' >> /data/homeserver.yaml

/start.py "$@"
