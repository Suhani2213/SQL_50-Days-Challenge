create database activity;
use activity;

create table UserActivity
(
username      varchar(20) ,
activity      varchar(20),
startDate     Date   ,
endDate      Date
);

insert into UserActivity values
('Alice','Travel','2020-02-12','2020-02-20')
,('Alice','Dancing','2020-02-21','2020-02-23')
,('Alice','Travel','2020-02-24','2020-02-28')
,('Bob','Travel','2020-02-11','2020-02-18');


-- Get the second most recent activity, if there is only one activity then return the one

select * from UserActivity;

with main as (
select *,
		row_number() over (partition by username order by startDate desc) rnk,
        count(1) over (partition by username) total_activity
from UserActivity
) select username, activity, startDate, endDate
from main
where rnk = 2 or total_activity = 1;