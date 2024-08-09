CREATE DATABASE company;

CREATE TABLE emp_salary
(
    emp_id INTEGER  NOT NULL,
    name NVARCHAR(20)  NOT NULL,
    salary NVARCHAR(30),
    dept_id INTEGER
);


INSERT INTO emp_salary
(emp_id, name, salary, dept_id)
VALUES(101, 'sohan', '3000', '11'),
(102, 'rohan', '4000', '12'),
(103, 'mohan', '5000', '13'),
(104, 'cat', '3000', '11'),
(105, 'suresh', '4000', '12'),
(109, 'mahesh', '7000', '12'),
(108, 'kamal', '8000', '11');



-- Write a SQL query to return all employees whose salary is same in same department

SELECT * FROM emp_salary;


-- METHOD 1
-- Using INNER JOIN
WITH same_pay as(
SELECT dept_id, salary
FROM emp_salary
GROUP By dept_id, salary
HAVING COUNT(1)> 1
)
SELECT es.*
FROM emp_salary as es
JOIN same_pay as sp
on es.dept_id = sp.dept_id AND es.salary = sp.salary
ORDER BY emp_id;



-- METHOD 2
-- Using LEFT JOIN
WITH same_pay as(
SELECT salary, dept_id
FROM emp_salary
GROUP BY salary, dept_id
HAVING COUNT(1) = 1
)
SELECT es.*
FROM emp_salary es
LEFT JOIN same_pay sp
on es.salary = sp.salary AND es.dept_id = sp.dept_id
WHERE sp.dept_id IS  NULL
ORDER BY emp_id;



-- METHOD 3
WITH cte AS (
  SELECT *,
    COUNT(*) OVER (PARTITION BY dept_id, salary) num_same_sal
  FROM emp_salary
)

SELECT *
FROM cte
WHERE num_same_sal > 1;



-- METHOD 4
-- Using RIGHT JOIN
WITH same_pay as(
SELECT dept_id, salary
FROM emp_salary
GROUP By dept_id, salary
HAVING COUNT(1)> 1
)
SELECT es.*
FROM emp_salary as es
RIGHT JOIN same_pay as sp
on es.dept_id = sp.dept_id AND es.salary = sp.salary
ORDER BY emp_id;


