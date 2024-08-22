create database cricket;
use cricket;


create table icc_world_cup
(
match_no int,
team_1 Varchar(20),
team_2 Varchar(20),
winner Varchar(20)
);


INSERT INTO icc_world_cup values(1,'ENG','NZ','NZ');
INSERT INTO icc_world_cup values(2,'PAK','NED','PAK');
INSERT INTO icc_world_cup values(3,'AFG','BAN','BAN');
INSERT INTO icc_world_cup values(4,'SA','SL','SA');
INSERT INTO icc_world_cup values(5,'AUS','IND','IND');
INSERT INTO icc_world_cup values(6,'NZ','NED','NZ');
INSERT INTO icc_world_cup values(7,'ENG','BAN','ENG');
INSERT INTO icc_world_cup values(8,'SL','PAK','PAK');
INSERT INTO icc_world_cup values(9,'AFG','IND','IND');
INSERT INTO icc_world_cup values(10,'SA','AUS','SA');
INSERT INTO icc_world_cup values(11,'BAN','NZ','NZ');
INSERT INTO icc_world_cup values(12,'PAK','IND','IND');


/*
output should look like this:
---------------------------------------------------------------
| Team | Matches Played | Matches Won | Matches Lost | Points |
---------------------------------------------------------------
| NZ   | 3             | 3          | 0            | 6        |
| IND  | 3             | 2          | 1            | 4        |
| PAK  | 3             | 2          | 1            | 4        |
| SA   | 2             | 1          | 1            | 2        |
| ENG  | 2             | 1          | 1            | 2        |
| BAN  | 3             | 1          | 2            | 2        |
| AFG  | 2             | 0          | 2            | 0        |
| AUS  | 2             | 0          | 2            | 0        |
| SL   | 2             | 0          | 2            | 0        |
| NED  | 2             | 0          | 2            | 0        |
---------------------------------------------------------------
*/


select * from icc_world_cup;



-- Method 1
with teams as (
select team_1 as team, count(*) as matchs_played
from icc_world_cup
group by team_1
union all
select team_2 as team, count(*) as matchs_played
from icc_world_cup
group by team_2
), total_matches as (
select sum(matchs_played) as matches_played, team
from teams
group by team
), winner_team as (
select count(winner) as matches_won, winner
from icc_world_cup iwc
group by winner
)
select tm.team,
		tm.matches_played, 
		coalesce(wt.matches_won,0) matches_won, 
		tm.matches_played - coalesce(wt.matches_won, 0) as matches_lost, 
        coalesce(wt.matches_won, 0)* 2  as points
from total_matches tm
left join winner_team wt on tm.team = wt.winner
order by matches_won desc;



-- Method 2
with teams as (
select team_1 as team, count(*) as matchs_played,
		sum(case when team_1 = winner then 1 else 0 end)as win_flag
from icc_world_cup
group by team_1
union all
select team_2 as team, count(*) as matchs_played,
		       sum(case when team_2 = winner then 1 else 0 end)as win_flag
from icc_world_cup
group by team_2
)
select team, 
		sum(matchs_played) as matches_played,
		sum(win_flag) as wins, 
        sum(matchs_played) - sum(win_flag) as lost, 
        (sum(win_flag))*2 as points
from teams
group by team
order by sum(win_flag) desc;





INSERT INTO icc_world_cup values(12,'SA','IND','DRAW');
/*
next step
if a match gets drawn (winner = draw), create a column name draw and increase the point by 1  of the teams whose match got draw
*/


with teams as (
select team_1 as team, count(*) as matchs_played,
		sum(case when team_1 = winner then 1 else 0 end)as win_flag,
        sum(case when winner = 'DRAW' then 0.5 else 0 end)as draws
from icc_world_cup
group by team_1
union all
select team_2 as team, count(*) as matchs_played,
		       sum(case when team_2 = winner then 1 else 0 end)as win_flag,
               sum(case when winner = 'DRAW' then 0.5 else 0 end)as draws
from icc_world_cup
group by team_2
)
select team, 
		sum(matchs_played) as matches_played,
		sum(win_flag) as wins, 
        sum(matchs_played) - sum(win_flag) -  sum(case when draws > 0 then 1 else 0 end ) as lost,
        sum(case when draws > 0 then 1 else 0 end ) as draw,
        (sum(draws + win_flag))*2 as points
from teams
group by team
order by sum(win_flag) desc;