# docker-sia

[![Docker Pulls](https://img.shields.io/docker/pulls/esurdam/sia.svg?maxAge=604800)](https://hub.docker.com/r/esurdam/sia/) 
[![License](http://img.shields.io/:license-mit-blue.svg)](LICENSE)

Based on [docker-sia](https://github.com/NebulousLabs/docker-sia).
Optimized for UNRAID

## Supported Tags

### Latest
* **latest**: The latest official binary release.
* **alpine-latest**: The latest official binary release based on Alpine Linux.

### Versions
* **1.5.5**: 1.5.5, alpine-1.5.5

## Usage

```bash
mkdir sia-data
docker run \
  --detach \
  --volume $(pwd)/sia-data:/sia-data \
  --publish 127.0.0.1:9980:9980 \
  --publish 9981:9981 \
  --publish 9982:9982 \
  --publish 9983:9983 \
  --publish 9984:9984 \
  --name sia-container \
   esurdam/sia
```

**Important**: Never publish port 9980 to all interfaces. This is a 
security-sensitive API, so only expose it beyond 127.0.0.1 if you know what 
you're doing.

By default, the container uses the following defaults:  
- `SIA_DIR` is `/sia`
- `SIA_DATA_DIR` is `/sia-data`
- `SIAD_DATA_DIR` is `/sia-data`

You can change the values of `SIA_DATA_DIR` and `SIAD_DATA_DIR` by supplying new
environment variables for the container using the `-e` option:  
`-e SIA_DATA_DIR=/new-sia-data-dir`  
`-e SIAD_DATA_DIR=/new-siad-data-dir`

Once the container is running, you can execute `siac` from within the container:

```bash
$ docker exec -it sia-container siac consensus
Synced: No
Height: 3800
Progress (estimated): 2.4%
```

You can also call `siad` from outside the container:

```bash
$ curl -A "Sia-Agent" "http://localhost:9980/consensus"
{"synced":false,"height":4690,"currentblock":"0000000000007d656e3bb0099737892b9073259cb05883b04c6f518fbf0faffb","target":[0,0,0,0,0,2,200,179,126,85,220,153,25,190,195,228,72,53,129,181,62,124,175,60,255,90,105,68,179,16,6,71],"difficulty":"101104922300609"}
```

## Logs

If you are interested in `siad`'s logs you can start the container with the 
following option `--log-driver local` and docker will keep the logs on disk.
More info [here](https://docs.docker.com/config/containers/logging/local).  

If you want to follow the logs while still being detached from the container,
you can use `docker logs -f <container>`

## More examples

For more usage examples, see the blog post, ["Fun with Sia and Docker."](https://blog.spaceduck.io/sia-docker/)
