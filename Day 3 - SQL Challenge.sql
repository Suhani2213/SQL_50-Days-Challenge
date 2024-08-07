create database Med;
Use Med;

create table hospital ( emp_id int
, action varchar(10)
, time datetime);

insert into hospital values ('1', 'in', '2019-12-22 09:00:00');
insert into hospital values ('1', 'out', '2019-12-22 09:15:00');
insert into hospital values ('2', 'in', '2019-12-22 09:00:00');
insert into hospital values ('2', 'out', '2019-12-22 09:15:00');
insert into hospital values ('2', 'in', '2019-12-22 09:30:00');
insert into hospital values ('3', 'out', '2019-12-22 09:00:00');
insert into hospital values ('3', 'in', '2019-12-22 09:15:00');
insert into hospital values ('3', 'out', '2019-12-22 09:30:00');
insert into hospital values ('3', 'in', '2019-12-22 09:45:00');
insert into hospital values ('4', 'in', '2019-12-22 09:45:00');
insert into hospital values ('5', 'out', '2019-12-22 09:40:00');



-- Write a SQL query to find out the number of people present inside the hospital

SELECT * FROM hospital;
-- Method 1
WITh CTE as (
SELECT emp_id,
	max(CASE WHEN action = "in" Then time END) AS In_time, 
	max(CASE WHEN action = "out" Then time END) AS Out_time
FROM hospital
Group BY emp_id
)
SELECT *
FROM CTE
WHERE In_time > Out_time or Out_time is null;



-- Method 2
SELECT emp_id,
	max(CASE WHEN action = "in" Then time END) AS In_time, 
	max(CASE WHEN action = "out" Then time END) AS Out_time
FROM hospital
Group BY emp_id
HAVING max(CASE WHEN action = "in" Then time END) > max(CASE WHEN action = "out" Then time END)
	   or max(CASE WHEN action = "out" Then time END) is null;
       
       
       
-- Method 3
WITH in_time as (
SELECT emp_id, MAX(time) latest_in_time
FROM hospital
WHERE action = "in"
GROUP BY emp_id
), out_time as (
SELECT emp_id, MAX(time) latest_out_time
FROM hospital
WHERE action = "out"
GROUP BY emp_id
)
SELECT *
FROM in_time it
LEFT JOIN out_time ot
on it.emp_id = ot.emp_id
WHERE latest_in_time > latest_out_time or latest_out_time IS NULL;



-- Method 4
WITH latest_time as (
SELECT emp_id, MAX(time) max_latest_time
FROM hospital
GROUP BY emp_id 
), latest_in_time as (
SELECT emp_id, MAX(time) max_latest_in_time
FROM hospital
WHERE action ="in"
GROUP BY emp_id
)
SELECT * 
FROM latest_time lt
JOIN latest_in_time lit
on lt.emp_id = lit.emp_id AND max_latest_time = max_latest_in_time;