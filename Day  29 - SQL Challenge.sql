create database player;
use player;

create table players_location
(
name varchar(20),
city varchar(20)
);
insert into players_location
values ('Sachin','Mumbai'),('Virat','Delhi') , ('Rahul','Bangalore'),('Rohit','Mumbai'),('Mayank','Bangalore');

/*
Desired output table should look like:
----------------------------------
|Bangalore  |Mumbai     |Delhi   |
----------------------------------
|Mayank	    |Rohit      |Virat   |
|Rahul      |Sachin	|null    |
----------------------------------
*/


select * from players_location;


with main as (
select *, row_number() over(partition by city order by name) player_number
from players_location
)
select --  player_number,
	   max(case when city = "Bangalore" then name end) as Bangalore,
	   max(case when city = "Mumbai" then name end) as Mumbai,
	   max(case when city = "Delhi" then name end) as Delhi
from main # run the code till here and do order by player_number to understand why we did group by also while checking don't use max in case statement
group by player_number
order by player_number;
