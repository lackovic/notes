# Docker

## List running containers

```bash
docker container ls
```
(formerly `docker ps`)

## List of images

```bash
docker image ls
```

## Follow the logs of a running container

```bash
docker logs -f container_name
```

## Enter and open a command line in a running container

```bash
docker exec -it container_name bash
```

## Print a list of the environment variables of a running container

```bash
docker exec -it container_name env
```

## Clean up stale images

```bash
docker system prune
```

## Check if docker is running

Run:
```bash
docker version
```
If docker **is running** you will see:
```bash
Client: Docker Engine - Community
 Version:           ...
 [omitted]

Server: Docker Engine - Community
 Engine:
  Version:          ...
 [omitted]
```
If docker **is not running** you will see:
```bash
Client: Docker Engine - Community
 Version:           ...
 [omitted]

Error response from daemon: Bad response from Docker engine
```