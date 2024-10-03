create database task;
use task;


create table tasks (
date_value date,
state varchar(10)
);

insert into tasks  values ('2019-01-01','success'),('2019-01-02','success'),('2019-01-03','success'),('2019-01-04','fail')
,('2019-01-05','fail'),('2019-01-06','success');
 
 
 
 /*
Expected Output:
---------------------------------
start_date | end_date  | state
---------------------------------
2019-01-01 |2019-01-03 |success
2019-01-04 |2019-01-05 |fail
2019-01-06 |2019-01-06 |success
---------------------------------
*/

select * from tasks;



with all_dates as (
select *,
	   row_number () over (partition by state order by date_value) rn,
       date_sub(date_value, interval row_number () over (partition by state order by date_value) day) group_date
from tasks
-- order by date_value
)
select min(date_value) as start_date, max(date_value) end_date, state
from all_dates
group by group_date, state
order by start_date;