# PostgreSQL CLI notes

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
**Contents**

- [Basic psql commands](#basic-psql-commands)
- [Basic commands for psql interactive terminal](#basic-commands-for-psql-interactive-terminal)
- [Basic SQL queries](#basic-sql-queries)
- [Use empty password for postgres user on Windows](#use-empty-password-for-postgres-user-on-windows)
- [Dump data from a specific user of specific tables from a database](#dump-data-from-a-specific-user-of-specific-tables-from-a-database)
- [See your database schema in dbdiagram.io](#see-your-database-schema-in-dbdiagramio)
- [Set a default database to connect to](#set-a-default-database-to-connect-to)
- [Restart PostgresQL](#restart-postgresql)
- [External resources](#external-resources)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## Basic psql commands

```sh
# Output version information
psql -V

# Connect to a host database as user
psql -h <host> -d <db_name> -U <user>
# default host = /var/run/postgresql
```

## Basic commands for psql interactive terminal

```sh
# List of databases
\l

# Connect to a database
\c database_name

# List all tables in the current database
\dt

# List the columns details of a table
\d+ table_name

# List all users
\du

## Change the password for a user
\password username

## Exit from PostgreSQL CLI
\q
```

## Basic SQL queries

```sql
-- List just the columns names of a table
SELECT * FROM table_name WHERE FALSE;

-- Specify a number of records to return
SELECT * FROM table_name LIMIT <number>;

-- Clear all the data from a database
DROP DATABASE "db_name";
CREATE DATABASE "db_name";

-- List columns with indexes for a table
SELECT * FROM pg_indexes WHERE tablename = 'mytable';

-- List columns names, types and nullability for a table
SELECT column_name, data_type, is_nullable
FROM information_schema.columns
WHERE table_name = 'mytable';
```

## Use empty password for postgres user on Windows

Edit your `C:\Program Files\PostgreSQL\10\data\pg_hba.conf` and
replace the IPv4 and IPv6 local connections with:
```sh
# TYPE  DATABASE        USER            ADDRESS                 METHOD

# IPv4 local connections:
host    all             all             127.0.0.1/32            trust
# IPv6 local connections:
host    all             all             ::1/128                 trust
```

## Dump data from a specific user of specific tables from a database

```sh
pg_dump -U username -t table1 -t table2 -t table3 -O --column-inserts --data-only database_name
```

## See your database schema in dbdiagram.io

You have two options:

* Run [this query](https://github.com/matthewoldham/dbdiagram.io-ddl-queries/blob/master/sql/postgresql.sql) to generate the DDL
* Run one of the following and import it in dbdiagram.io:
```
pg_dump -F t -f dump.bin database-name
pg_dump -F t -p dump.sql database-name
```

## Set a default database to connect to

In your `~/.bashrc` or similar:

```sh
export PGDATABASE=my-database
```

## Restart PostgresQL

```sh
/etc/init.d/postgresql restart
```

## External resources

* [PostgreSQL cheatsheet](https://gist.github.com/Kartones/dd3ff5ec5ea238d4c546)
