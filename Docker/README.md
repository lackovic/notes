# Docker

_Table of Contents_

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
<!-- generated with [DocToc](https://github.com/thlorenz/doctoc) -->

- [Basic operations](#basic-operations)
- [Customize containers list](#customize-containers-list)
- [Check if Docker Engine is running](#check-if-docker-engine-is-running)
- [Docker compose](#docker-compose)
  - [Basic operations](#basic-operations-1)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->


## Basic operations

```sh
## List running containers (formerly "docker ps")
docker container ls

# List all containers, running and stopped
docker container ls -a

# Check whether one specific container is running
docker container ls -a | grep container_name

# Stop all running containers
docker stop $(docker ps -q)

# List images
docker image ls

# List dangling images
docker images -f dangling=true

# Remove dangling images
docker image prune

# Remove dangling and unused images
docker image prune -a

# Follow the logs of a running container
docker logs -f <container_name>

# Enter and open a shell in a running container
docker exec -it <container_name> bash

# Print a list of the environment variables of a running container
docker exec -it <container_name> env

# Run a SQL query in a Postgres container
docker exec container-name bash -c 'psql -d database-name -U username --command "select * from users;"'

# Inspect an image (use /bin/sh for alpine images)
docker image pull <image_name>
docker run -t -i <image_id> /bin/bash
```

## Customize containers list

```sh
# Show id, image, name and status of all containers
docker container ls -a --format "table {{ .ID }}\t{{ .Image }}\t{{ .Names }}\t{{ .Status }}"

# Show name, status and ports of all containers
docker container ls -a --format "table {{ .Names }}\t{{ .Status }}\t{{ .Ports }}"

# Filter containers by name
docker container ls -f name=container-name
```

Set a format to use it as a default in your `~/.docker/config.json`:

```js
{ "psFormat": "table {{ .Names }}\t{{ .Status }}\t{{ .Ports }}" }
```

- [Source](https://github.com/moby/moby/issues/7477)

## Check if Docker Engine is running

Run:

```sh
docker version
```

If docker **is running** you will see:

```sh
Client: Docker Engine - Community
 Version:           ...
 [omitted]

Server: Docker Engine - Community
 Engine:
  Version:          ...
 [omitted]
```

If docker **is not running** you will see:

```sh
Client: Docker Engine - Community
 Version:           ...
 [omitted]

Error response from daemon: Bad response from Docker engine
```

## Docker compose

Docker Compose is a way to configure docker containers together as a logical unit, define resources they all share and run containers together.

Some of the advantages include:

- it keeps track of the container it starts (via labels). If you re-run `docker-compose up -d` without changes it won’t try to recreate any containers. If on the other hand you change a service a `docker-compose up -d` will recreate only that service and any service that depends on it.

- with `logs` you can look at outputs of all involved containers merged together

- `ls` covers just the containers stemming from the given compose-file.

### Basic operations

```sh
# build
docker-compose build

# start
docker-compose up -d

# stop
docker-compose down --remove-orphans

# restart
docker-compose up -d --force-recreate

# rebuild
docker-compose down --remove-orphans && docker-compose build && docker-compose up -d

# clean up stale images
docker system prune

# prevent containers to start automatically
docker update --restart=no $(docker container ls -a -q)

# make one container start automatically
docker update --restart=always container_name
```
- [Restart policies (--restart)](https://docs.docker.com/engine/reference/run/#restart-policies---restart)