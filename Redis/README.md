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
