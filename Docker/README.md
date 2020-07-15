# Docker

## Basic operations

```sh
## List running containers (formerly "docker ps")
docker container ls

# List all containers, running and stopped
docker container ls -a

# Show only id, image, name and status of all containers
docker container ls -a --format "table {{.ID}}\t{{.Image}}\t{{.Names}}\t{{.Status}}"

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
```

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
```
