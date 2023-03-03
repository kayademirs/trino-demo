CREATE schema mysql.tiny;
CREATE TABLE mysql.tiny.nation AS
SELECT *
FROM tpch.tiny.nation;
CREATE TABLE mysql.tiny.region AS
SELECT *
FROM tpch.tiny.region;
CREATE schema mongo.tiny;
CREATE TABLE mongo.tiny.customer AS
SELECT *
FROM tpch.tiny.customer;
CREATE TABLE mongo.tiny.orders AS
SELECT *
FROM tpch.tiny.orders;


/* SELECT  ALL MONGO */
SELECT *
FROM mongo.tiny.customer;
SELECT *
FROM mongo.tiny.orders;


/* SELECT  ALL MYSQL */
SELECT *
FROM mysql.tiny.nation;
SELECT *
FROM mysql.tiny.region;


/* JOIN ALL DATA */
SELECT c.name AS customer,
    o.totalprice,
    o.orderdate,
    n.name AS nation,
    r.name AS region
FROM mongo.tiny.customer AS c
    INNER JOIN mongo.tiny.orders AS o ON o.custkey = c.custkey
    INNER JOIN mysql.tiny.nation AS n ON n.nationkey = c.nationkey
    INNER JOIN mysql.tiny.region AS r ON r.regionkey = n.regionkey;


/* Write to Minio*/
CREATE SCHEMA minio.vbo WITH (location = 's3a://vbo/') USE minio.vbo;
CREATE TABLE minio.vbo.report_table WITH (format = 'ORC') AS
SELECT c.name AS customer,
    o.totalprice,
    o.orderdate,
    n.name AS nation,
    r.name AS region
FROM tpch.tiny.customer AS c
    INNER JOIN tpch.tiny.orders AS o ON o.custkey = c.custkey
    INNER JOIN tpch.tiny.nation AS n ON n.nationkey = c.nationkey
    INNER JOIN tpch.tiny.region AS r ON r.regionkey = n.regionkey;


SELECT *
FROM minio.vbo.report_table;

SELECT region,
    cast(SUM(totalprice) AS int) AS price
FROM minio.vbo.report_table
GROUP BY region
ORDER BY price desc

SELECT nation,
    cast(SUM(totalprice) AS int) AS price
FROM minio.vbo.report_table
GROUP BY nation
ORDER BY price desc
