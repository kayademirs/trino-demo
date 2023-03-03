create schema mysql.tiny;
create table mysql.tiny.nation AS SELECT * FROM tpch.tiny.nation;
create table mysql.tiny.region  AS SELECT * FROM tpch.tiny.region  ;


create schema mongo.tiny;
CREATE TABLE mongo.tiny.customer AS SELECT * FROM tpch.tiny.customer;
CREATE TABLE mongo.tiny.orders AS SELECT * FROM tpch.tiny.orders ;

/* SELECT ALL MONGO*/
select * from mongo.tiny.customer;
select * from mongo.tiny.orders ;


/*SELECT ALL MYSQL*/
select * from mysql.tiny.nation;
select * from mysql.tiny.region;


/* JOIN ALL DATA*/
select 
c.name as customer, o.totalprice, o.orderdate, n.name as nation, r.name as region 
from mongo.tiny.customer as c
inner join mongo.tiny.orders as o on o.custkey = c.custkey 
inner join mysql.tiny.nation as n on n.nationkey = c.nationkey 
inner join mysql.tiny.region as r on r.regionkey = n.regionkey 

/*save result*/
create table mongo.tiny.report_table as select 
c.name as customer, o.totalprice, o.orderdate, n.name as nation, r.name as region 
from mongo.tiny.customer as c
inner join mongo.tiny.orders as o on o.custkey = c.custkey 
inner join mysql.tiny.nation as n on n.nationkey = c.nationkey 
inner join mysql.tiny.region as r on r.regionkey = n.regionkey 


/* show new table */
select * from mongo.tiny.report_table 


select region, cast(sum(totalprice) as int) as price  from mongo.tiny.report_table 
group by region 
order by price desc


select nation , cast(sum(totalprice) as int) as price  from mongo.tiny.report_table 
group by nation  
order by price desc








