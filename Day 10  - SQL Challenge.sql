CREATE DATABASE company;

USE company;


create table employee 
(
emp_name varchar(10),
dep_id int,
salary int
);


insert into employee values 
('Siva',1,30000),('Ravi',2,40000),('Prasad',1,50000),('Sai',2,20000);


-- Write a query to print the highest and lowest salaried employee in each department.



SELECT * FROM employee;


WITH salary_table as (
SELECT dep_id,
	MAX(salary) max_salary, MIN(salary) min_salary
FROM employee
GROUP BY dep_id
)
SELECT employee.dep_id,
 	MAX(CASE WHEN salary = max_salary  THEN emp_name END) emp_name_max_salary,
 	MAX(CASE WHEN salary = min_salary THEN emp_name END) emp_name_min_salary
FROM employee
JOIN salary_table 
ON salary_table.dep_id = employee.dep_id
GROUP BY employee.dep_id;	
--  #note taking MAX() ---  aggregate function - ignores the null value


-- Case when 2 employee have same salary as max salary
WITH salary_table as (
SELECT dep_id, emp_name,
    DENSE_RANK() OVER (PARTITION BY dep_id ORDER BY salary DESC) as Dept_max_salary,
	DENSE_RANK() OVER (PARTITION BY dep_id ORDER BY salary) as Dept_min_salary

FROM employee
)
SELECT dep_id,
	 GROUP_CONCAT(CASE WHEN Dept_max_salary = 1 THEN emp_name END) emp_name_max_salary,
	 GROUP_CONCAT(CASE WHEN Dept_min_salary = 1 THEN emp_name END) emp_name_min_salary
FROM salary_table
GROUP BY dep_id;
