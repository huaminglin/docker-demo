# MySQL Docker Demo

## MYSQL_ROOT_PASSWORD

```
docker logs demomysql
2021-04-07 12:05:45+00:00 [Note] [Entrypoint]: Entrypoint script for MySQL Server 8.0.23-1debian10 started.
2021-04-07 12:05:45+00:00 [Note] [Entrypoint]: Switching to dedicated user 'mysql'
2021-04-07 12:05:45+00:00 [Note] [Entrypoint]: Entrypoint script for MySQL Server 8.0.23-1debian10 started.
2021-04-07 12:05:46+00:00 [ERROR] [Entrypoint]: Database is uninitialized and password option is not specified
    You need to specify one of the following:
    - MYSQL_ROOT_PASSWORD
    - MYSQL_ALLOW_EMPTY_PASSWORD
    - MYSQL_RANDOM_ROOT_PASSWORD
```

## docker exec -it demomysql mysql -u root -p123456

"show databases;"

```
mysql> show databases;
+--------------------+
| Database           |
+--------------------+
| information_schema |
| mysql              |
| performance_schema |
| sys                |
+--------------------+
4 rows in set (0.01 sec)
```
