# PostgreSQL CLI notes

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
**Contents**

- [Know the installed version](#know-the-installed-version)
- [Login in as admin user](#login-in-as-admin-user)
- [List of databases](#list-of-databases)
- [Connect to a database](#connect-to-a-database)
- [List all tables in the current database](#list-all-tables-in-the-current-database)
- [List just the columns names of a table](#list-just-the-columns-names-of-a-table)
- [List the columns details of a table](#list-the-columns-details-of-a-table)
- [List all users](#list-all-users)
- [Use empty password for postgres user on Windows](#use-empty-password-for-postgres-user-on-windows)
- [Change password for a user](#change-password-for-a-user)
- [Clear all the data from a database](#clear-all-the-data-from-a-database)
- [Dump data from a specific user of specific tables from a database](#dump-data-from-a-specific-user-of-specific-tables-from-a-database)
- [Exit from PostgreSQL CLI](#exit-from-postgresql-cli)
- [See your database schema in dbdiagram.io](#see-your-database-schema-in-dbdiagramio)
- [Set a default database to connect to](#set-a-default-database-to-connect-to)
- [External resources](#external-resources)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## Know the installed version

```bash
psql --version
```

## Login in as admin user

```bash
psql -U postgres
```

## List of databases

```bash
\l
```

## Connect to a database

```bash
\c database_name
```

## List all tables in the current database

```bash
\dt
```

## List just the columns names of a table

```sql
SELECT * FROM table_name WHERE FALSE;
```

## List the columns details of a table

```bash
\d+ table_name
```

## List all users

```bash
\du
```

## Use empty password for postgres user on Windows

Edit your `C:\Program Files\PostgreSQL\10\data\pg_hba.conf` and
replace the IPv4 and IPv6 local connections with:
```bash
# TYPE  DATABASE        USER            ADDRESS                 METHOD

# IPv4 local connections:
host    all             all             127.0.0.1/32            trust
# IPv6 local connections:
host    all             all             ::1/128                 trust
```

## Change password for a user

```bash
\password username
```

## Clear all the data from a database

```sql
DROP DATABASE "db-name";
CREATE DATABASE "db-name";
```

## Dump data from a specific user of specific tables from a database

```bash
pg_dump -U username -t table1 -t table2 -t table3 -O --column-inserts --data-only database_name
```

## Exit from PostgreSQL CLI

```bash
\q
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

## External resources

* [PostgreSQL cheatsheet](https://gist.github.com/Kartones/dd3ff5ec5ea238d4c546)
