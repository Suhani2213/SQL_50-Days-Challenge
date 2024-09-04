create database IPL;
use IPL;


create table stadium (
id int,
visit_date date,
no_of_people int
);

insert into stadium
values (1,'2017-07-01',10)
,(2,'2017-07-02',109)
,(3,'2017-07-03',150)
,(4,'2017-07-04',99)
,(5,'2017-07-05',145)
,(6,'2017-07-06',1455)
,(7,'2017-07-07',199)
,(8,'2017-07-08',188);


-- Write a query to display the records which has 3 or more consecutive rows
-- with the amount of people more than 100(inclusive) each day

select * from stadium;

with cte as (
select *,
	row_number() over(order by visit_date) as rnk,
    id - row_number() over(order by visit_date) as constant_diff
from stadium
where no_of_people > 100
) 
select id, visit_date, no_of_people
from cte
where constant_diff in 
	(select constant_diff
	from cte
	group by constant_diff
	having count(constant_diff) >= 3)
