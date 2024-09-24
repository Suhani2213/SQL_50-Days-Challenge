create database football;
use football;

CREATE TABLE matches_record (
    match_id INT PRIMARY KEY,
    winning_team_id INT,
    loosing_team_id INT,
    goals_won_by INT
);

INSERT INTO matches_record (match_id, winning_team_id, loosing_team_id, goals_won_by) VALUES
(1, 1001, 1007, 1),
(2, 1007, 1001, 2),
(3, 1006, 1003, 3),
(4, 1001, 1003, 1),
(5, 1007, 1001, 1),
(6, 1006, 1003, 2),
(7, 1006, 1001, 3),
(8, 1007, 1003, 5),
(9, 1001, 1003, 1),
(10, 1007, 1006, 2),
(11, 1006, 1003, 3),
(12, 1001, 1003, 4),
(13, 1001, 1006, 2),
(14, 1007, 1001, 4),
(15, 1006, 1007, 3),
(16, 1001, 1003, 3),
(17, 1001, 1007, 3),
(18, 1006, 1007, 2),
(19, 1003, 1001, 1);


CREATE TABLE team_details (
    team_id INT PRIMARY KEY,
    team_name VARCHAR(50)
);

INSERT INTO team_details (team_id, team_name) VALUES
(1001, 'Nickmiesters'),
(1003, 'Sunrisers'),
(1006, 'Philippines Pirates'),
(1007, 'Smashers');

/*
TASK: Write a SQL query to find the rank of all the teams

In a Football toumament, some data is recorded.
Every winning team gets a point and the losing team loses a point.
At the end of the toumament, a ranking is given to all the teams based on their total points.
The total points of a team can go be negative. You are given tables: matches record and team details.

The ranking should be calculated according to the following rules:
a. The total points should be ranked from the highest to the lowest.
b. If two teams have the same total points, then the team with the higher number of winning goals would be ranked higher.
*/


select *
from matches_record;


with goals_data as (
select match_id, winning_team_id as team_id, goals_won_by
from matches_record
union all 
select match_id, loosing_team_id as team_id, 0 as goals_won_by
from matches_record
), main_table as (
select g.team_id, t.team_name, sum(g.goals_won_by) total_goals_won,
		sum(case when g.goals_won_by != 0 then 1 else -1 end) as match_point
from team_details t
left join goals_data g on t.team_id = g.team_id
group by g.team_id, t.team_name)
select *,
        dense_rank() over (order by match_point desc, total_goals_won desc) as "rank"
from main_table
;
