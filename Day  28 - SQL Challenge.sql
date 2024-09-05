create database company;
use company;

create table employee 
(
emp_id int,
company varchar(10),
salary int
);

insert into employee values (1,'A',2341);
insert into employee values (2,'A',341);
insert into employee values (3,'A',15);
insert into employee values (4,'A',15314);
insert into employee values (5,'A',451);
insert into employee values (6,'A',513);
insert into employee values (7,'B',15);
insert into employee values (8,'B',13);
insert into employee values (9,'B',1154);
insert into employee values (10,'B',1345);
insert into employee values (11,'B',1221);
insert into employee values (12,'B',234);
insert into employee values (13,'C',2345);
insert into employee values (14,'C',2645);
insert into employee values (15,'C',2645);
insert into employee values (16,'C',2652);
insert into employee values (17,'C',65);

-- Write a SQL query to find the median salary of each company
-- Bonue point if you can solve it without using any built-in SQL function
/*
Median Formula:
odd ->  Median = [(n + 1)/2]th term

Even -> Median = [(n/2)th term + (n/2 + 1)th term]/2
*/

select * from employee;

with main as (
select *, 
	row_number() over (partition by company order by salary) rnk,
    count(1) over (partition by company) cnt
from employee
), main2 as(
select *, cnt/2 as m1, ((cnt /2) + 1) as m2
from main
)
select company, avg(salary) median_salary
from main2
where rnk between m1 and m2
group by company;