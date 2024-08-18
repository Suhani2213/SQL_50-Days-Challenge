CREATE DATABASE call_centre;

USE call_centre;

create table call_start_logs
(
phone_number varchar(10),
start_time datetime
);
insert into call_start_logs values
('PN1','2022-01-01 10:20:00'),('PN1','2022-01-01 16:25:00'),('PN2','2022-01-01 12:30:00')
,('PN3','2022-01-02 10:00:00'),('PN3','2022-01-02 12:30:00'),('PN3','2022-01-03 09:20:00');

create table call_end_logs
(
phone_number varchar(10),
end_time datetime
);

insert into call_end_logs values
('PN1','2022-01-01 10:45:00'),('PN1','2022-01-01 17:05:00'),('PN2','2022-01-01 12:55:00')
,('PN3','2022-01-02 10:20:00'),('PN3','2022-01-02 12:50:00'),('PN3','2022-01-03 09:40:00');

/* Write a query to get start time and end time of ech call from both 2 tables. 
Also create a column of call duration in minutes. Please do take thet there will be multiple calls from one phone numwber 
and each entry in start table has a correwsponding entry in each table.*/

SELECT * FROM call_start_logs;

SELECT * FROM call_end_logs;

-- Note - with the help of row_number created a key to join both tables.



-- METHOD 1 - using JOIN
WITH start_table as (
SELECT *, row_number() OVER (partition by phone_number ORDER BY start_time) rn
FROM call_start_logs
), end_table as
(SELECT *, row_number() OVER (partition by phone_number ORDER BY end_time) rn
FROM call_end_logs
)
SELECT a.phone_number, start_time, end_time, TIMESTAMPDIFF(MINUTE ,start_time, end_time) as "call duration"
FROM start_table as a
JOIN end_table as b
ON a.phone_number = b.phone_number AND a.rn = b.rn;

-- Note - with the help of row_number, created a primary key to join both tables.


-- METHOD  - using UNION
SELECT phone_number, MIN(call_time) as start_time, MAX(call_time) as end_time , TIMESTAMPDIFF(MINUTE, MIN(call_time), MAX(call_time))  "call duration"
FROM (
SELECT phone_number, start_time as call_time, row_number() OVER (partition by phone_number ORDER BY start_time) rn
FROM call_start_logs
UNION ALL
SELECT phone_number, end_time AS call_tim, row_number() OVER (partition by phone_number ORDER BY end_time) rn
FROM call_end_logs
) a
GROUP BY phone_number, rn;

-- Note - aggregate funtion like max() and min() helps you in avoiding null cellds.
