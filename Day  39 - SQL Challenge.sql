create database entry;
use entry;



create table entries ( 
name varchar(20),
address varchar(20),
email varchar(20),
floor int,
resources varchar(10));

insert into entries 
values ('A','Bangalore','A@gmail.com',1,'CPU'),('A','Bangalore','A1@gmail.com',1,'CPU'),('A','Bangalore','A2@gmail.com',2,'DESKTOP')
,('B','Bangalore','B@gmail.com',2,'DESKTOP'),('B','Bangalore','B1@gmail.com',2,'DESKTOP'),('B','Bangalore','B2@gmail.com',1,'MONITOR');

/*
Expected Output:
---------------------------------------------------------
|name | most_visit_floor| Total_visits | resources      |
---------------------------------------------------------
|A    |	1               |3	           |CPU,DESKTOP     |
|B	   |2	               |3	           |DESKTOP,MONITOR |
---------------------------------------------------------
*/

select * from entries;

with total_visits as(
select name, count(1) as Total_visits, group_concat(distinct resources) resources 
from entries
group by name
 ), floor_visits as (
select name, floor , count(floor) no_of_floor_visits, dense_rank() over (partition by name order by count(floor)desc) rnk
from entries
group by name, floor
)
select t.name, floor as most_visit_floor ,Total_visits, resources
from total_visits t 
join floor_visits f
on f.name = t.name
where rnk = 1
