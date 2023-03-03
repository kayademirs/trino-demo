# Trino setup with Docker

## Multinode

```
|   docker-compose-multinode.yaml
|   README.md
|
\---etc
    +---coordinator
    |   |   config.properties
    |   |   jvm.config
    |   |   log.properties
    |   |   node.properties
    |   |
    |   \---catalog
    |           tpcds.properties
    |           tpch.properties
    |
    \---worker
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

#### Coordinator

```
coordinator=true
node-scheduler.include-coordinator=false
http-server.http.port=8080
discovery.uri=http://coordinator:8080
```

#### Worker

- TIP: All worker configurations in a Trino cluster should be identical.

```
coordinator=false
http-server.http.port=8080
discovery.uri=http://coordinator:8080
```

#### Connector

- mysql

```
connector.name=mysql
connection-url=jdbc:mysql://mysql:3306
connection-user=admin
connection-password=admin
```

- mongo

 ```
connector.name=mongodb
mongodb.connection-url=mongodb://admin:admin@mongodb:27017/
 ```

- minio

```
connector.name=hive
hive.metastore.uri=thrift://hive-metastore:9083
hive.s3.aws-access-key=trainkey
hive.s3.aws-secret-key=trainsecret
hive.s3.endpoint=http://minio:9000
hive.s3.path-style-access=true
```

#### Hive Metastore Configuration

Create metastore-site.xml file. This file contains connection information. We configure the Metastore to connect to Minio.

```
 <configuration>
    <property>
        <name>metastore.thrift.uris</name>
        <value>thrift://hive-metastore:9083</value>
        <description>Thrift URI for the remote metastore. Used by metastore client to connect to remote metastore.</description>
    </property>
    <property>
        <name>metastore.task.threads.always</name>
        <value>org.apache.hadoop.hive.metastore.events.EventCleanerTask,org.apache.hadoop.hive.metastore.MaterializationsCacheCleanerTask</value>
    </property>
    <property>
        <name>metastore.expression.proxy</name>
        <value>org.apache.hadoop.hive.metastore.DefaultPartitionExpressionProxy</value>
    </property>
    <property>
        <name>javax.jdo.option.ConnectionDriverName</name>
        <value>com.mysql.jdbc.Driver</value>
    </property>
    <property>
        <name>javax.jdo.option.ConnectionURL</name>
        <value>jdbc:mysql://mariadb:3306/metastore_db</value>
    </property>
    <property>
        <name>javax.jdo.option.ConnectionUserName</name>
        <value>admin</value>
    </property>
    <property>
        <name>javax.jdo.option.ConnectionPassword</name>
        <value>admin</value>
    </property>

    <property>
        <name>fs.s3a.impl</name>
        <value>org.apache.hadoop.fs.s3a.S3AFileSystem</value>
    </property>
    <property>
        <name>fs.s3a.access.key</name>
        <value>trainkey</value>
    </property>
    <property>
        <name>fs.s3a.secret.key</name>
        <value>trainsecret</value>
    </property>
    <property>
        <name>fs.s3a.endpoint</name>
        <value>http://minio:9000</value>
    </property>
    <property>
        <name>fs.s3a.path.style.access</name>
        <value>true</value>
    </property>
</configuration>
```

### Run docker-compose

```
cd multinode
docker-compose -f docker-compose-multinode.yaml up -d
```

- Grand admin on tiny database
*password: admin*

```
docker exec -it mn-mysql bash
bash-4.4# mysql -u root -p
```

```
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
  - port: 9091
  - user: trino

![trino_driver](../images/dbeaver/03_trino_connection.png)


