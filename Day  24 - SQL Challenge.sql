CREATE DATABASE office_accenture;
USE office_accenture;


CREATE TABLE employees  (employee_id int,employee_name varchar(15), email_id varchar(15) );
INSERT INTO employees (employee_id,employee_name, email_id) VALUES ('101','Liam Alton', 'li.al@abc.com');
INSERT INTO employees (employee_id,employee_name, email_id) VALUES ('102','Josh Day', 'jo.da@abc.com');
INSERT INTO employees (employee_id,employee_name, email_id) VALUES ('103','Sean Mann', 'se.ma@abc.com'); 
INSERT INTO employees (employee_id,employee_name, email_id) VALUES ('104','Evan Blake', 'ev.bl@abc.com');
INSERT INTO employees (employee_id,employee_name, email_id) VALUES ('105','Toby Scott', 'jo.da@abc.com');
INSERT INTO employees (employee_id,employee_name, email_id) VALUES ('106','Anjali Chouhan', 'JO.DA@ABC.COM');
INSERT INTO employees (employee_id,employee_name, email_id) VALUES ('107','Ankit Bansal', 'AN.BA@ABC.COM');


/*
In the above table data you can see there is 1 dublicate email (102, 105, 106).
Yo have to fetch only lower case email in the output.employee_id.
In the output, I am expecting only 102 and 105.
---------------------------------------------
|employee_id| employee_name | email_id      |
---------------------------------------------
|101	    |Liam Alton	    |li.al@abc.com  |
|102	    |Josh Day       |jo.da@abc.com  |
|103	    |Sean Mann	    |se.ma@abc.com  |
|104	    |Evan Blake	    |ev.bl@abc.com  |
|105	    |Toby Scott	    |jo.da@abc.com  |
|107	    |Ankit Bansal   |AN.BA@ABC.COM  |
---------------------------------------------
*/






SELECT * FROM employees;

-- Method 1:
WITH main as (
SELECT *, ASCII(email_id),
	RANK() OVER (PARTITION BY email_id ORDER BY ASCII(email_id) DESC) rnk
FROM employees
)
SELECT employee_id, employee_name, email_id
FROM main
WHERE rnk = 1
ORDER BY employee_id;



-- Method 2      
select *-- , ASCII(email_id), ASCII(upper(email_id)) 
from employees
where ASCII(email_id) <> ASCII(upper(email_id))
union
select * from employees where email_id in (
		select email_id from employees
		group by email_id
		having count(email_id) = 1
		);