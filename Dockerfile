FROM docker.io/matrixdotorg/synapse:v1.120.0

LABEL org.opencontainers.image.source=https://github.com/SeaGL/matrix-synapse-dev-image
LABEL org.opencontainers.image.description="Developer environment-optimized Matrix Synapse image"

COPY downstream_start.sh /downstream_start.sh
ENTRYPOINT /downstream_start.sh
