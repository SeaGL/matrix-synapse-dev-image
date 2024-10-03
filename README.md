# Matrix Synapse developer image

Developer environment-optimized Matrix Synapse Docker image

## WARNING

Don't use this in production!

It comes with **zero security support**! Also the scripts are a little sketchy and under-tested honestly, and even if they weren't this image is not optimized for production use-cases.

## Install

```bash
$ docker pull synapse-dev # TODO
```

## Usage

Basically, the same as [`matrixdotorg/synapse`](https://hub.docker.com/r/matrixdotorg/synapse), with the following exceptions:

* `SYNAPSE_CONFIG_DIR` and `SYNAPSE_CONFIG_PATH` are unsupported; setting them will crash the image
* Configuration is generated automatically at runtime, instead of requiring a separate manual step
* `SYNAPSE_REPORT_STATS` is optional and defaults to `no` (please don't pollute Matrix statistics server with non-production data!)
* The registration secret is always set to `registration_secret`
* Federation is (mostly) disabled
* Specifying a Docker volume is optional (if one is not specified, data will be lost on container recreate)

## Author

AJ Jordan <alex@strugee.net>, <aj@seagl.org>

## License

Creative Commons Zero
