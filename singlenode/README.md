# Trino setup with Docker

## Singlenode

```
singlenode
|   docker-compose-singlenode.yaml
|   README.md
|
\---etc
    |   config.properties
    |   jvm.config
    |   log.properties
    |   node.properties
    |
    \---catalog
            tpcds.properties
            tpch.properties
```

### Configuration

* coordinator

  ```
  coordinator=true
  node-scheduler.include-coordinator=true
  http-server.http.port=8080
  discovery-server.enabled=true
  discovery.uri=http://trino-coordinator:8080
  ```

* connector
  * mysql

    ```
    connector.name=mysql
    connection-url=jdbc:mysql://mysql:3306
    connection-user=admin
    connection-password=admin
    ```

  * mongo

    ```
    connector.name=mongodb
    mongodb.connection-url=mongodb://admin:admin@mongodb:27017/
    ```

### Run docker-compose

* run docker-compose

```
cd singlenode
docker-compose -f docker-compose-singlenode.yaml up -d
```

* Grand admin on tiny database

```
docker exec -it sn-mysql bash

bash-4.4# mysql -u root -p

mysql>GRANT ALL PRIVILEGES ON tiny.* TO 'admin'@'%' WITH GRANT OPTION;
mysql>FLUSH PRIVILEGES;
```

## DBeaver

- Select Database

![trino_driver](../images/dbeaver/01_trino_select_database.png)

- Download Driver
  
![trino_driver](../images/dbeaver/02_trino_driver.png)

- Connection
  - host: localhost
  - port: 9090
  - user: trino

![trino_driver](../images/dbeaver/03_trino_connection.png)

