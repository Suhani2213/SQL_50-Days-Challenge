create database microsoft;
use microsoft;

create table candidates (
emp_id int,
experience varchar(20),
salary int
);
insert into candidates values
(1,'Junior',10000),(2,'Junior',15000),(3,'Junior',40000),(4,'Senior',16000),(5,'Senior',20000),(6,'Senior',50000);


/*
A company wants to hire new employees. The budget of the company for the salaries is $70000. The company's criteria for hiring are:

Keep hiring the senior with the smallest salary until you cannot hire any more seniors.

Use the remaining budget to hire the junior with the smallest salary.

Keep hiring the junior with the smallest salary until you cannot hire any more juniors. Write an SQL query to find the seniors and juniors hired under the mentioned criteria."/

select from candidates;
*/

select *
from candidates;


with total_salary as (
select *, sum(salary) over(partition by experience order by salary rows between unbounded preceding and current row) as cum_salary
from candidates
), seniour_salary as (
select *
from total_salary
where experience = "senior" and cum_salary <= 70000
)
select *
from total_salary
where experience = 'Junior' and cum_salary <= 70000 - (select sum(salary) from seniour_salary) 
union
select * from seniour_salary