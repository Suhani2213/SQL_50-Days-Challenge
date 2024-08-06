CREATE DATABASE TAT;

USE TAT;

create table tickets
(
ticket_id varchar(10),
create_date date,
resolved_date date
);


insert into tickets values
(1,'2022-08-01','2022-08-03')
,(2,'2022-08-01','2022-08-12')
,(3,'2022-08-01','2022-08-16');


create table holidays
(
holiday_date date
,reason varchar(100)
);


insert into holidays values
('2022-08-11','Rakhi'),('2022-08-15','Independence day');


/* Write an SQL query to find business days between create date and resolve date by excluding weekends and public holidays */
SELECT * FROM tickets;
SELECT * FROM holidays;




SELECT 
    *,
    DATEDIFF(resolved_date, create_date) - 2 * (FLOOR(DATEDIFF(resolved_date, create_date) / 7)) - no_of_holidays AS Actual_days_to_resolve
FROM
    (SELECT 
        ticket_id,
            create_date,
            resolved_date,
            COUNT(holiday_date) no_of_holidays
    FROM
        tickets AS t
    LEFT JOIN holidays AS h ON h.holiday_date BETWEEN t.create_date AND t.resolved_date
    GROUP BY ticket_id , create_date , resolved_date) AS a;


