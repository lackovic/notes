# Redis

## Basic commands

```sh
# Set a key and assign it a value
redis-cli SET <key> <value>

# Get a value associated to a key
redis-cli GET <key>

# List all keys
redis-cli KEYS '*'

# Delete all keys of all databases
redis-cli FLUSHALL

# Delete all keys of the currently selected database
redis-cli FLUSHDB

# Delete all keys of the specified database
redis-cli -n <database_number> FLUSHDB
```

## Troubleshooting

1. check the configuration file of the app (e.g. `/opt/<appname>/config/redis.yaml`) for hostnames, ports and sentinels

1. verify that Redis is running with `redis-cli ping` (you should get `PONG` back)

1. check the connection with the sentinels with (you should get `PONG` back):

   ```
   nc sentinel.hostname.net 6388
   ping
   ```

1. check the local network ports `netstat -an | grep :6379`

1. check whether Redis is running in a Docker container `docker container ls`

1. check the app that is using Redis log with `tail /var/log/<appname>/<servicename> -F`
