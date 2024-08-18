CREATE DATABASE criteria_qualified;
USE criteria_qualified;

create table Ameriprise_LLC
(
teamID varchar(2),
memberID varchar(10),
Criteria1 varchar(1),
Criteria2 varchar(1)
  
);
insert into Ameriprise_LLC values 
('T1','T1_mbr1','Y','Y'),
('T1','T1_mbr2','Y','Y'),
('T1','T1_mbr3','Y','Y'),
('T1','T1_mbr4','Y','Y'),
('T1','T1_mbr5','Y','N'),
('T2','T2_mbr1','Y','Y'),
('T2','T2_mbr2','Y','N'),
('T2','T2_mbr3','N','Y'),
('T2','T2_mbr4','N','N'),
('T2','T2_mbr5','N','N'),
('T3','T3_mbr1','Y','Y'),
('T3','T3_mbr2','Y','Y'),
('T3','T3_mbr3','N','Y'),
('T3','T3_mbr4','N','Y'),
('T3','T3_mbr5','Y','N');


-- If both Criteria1 and Criteri2 are 'Y' for at least 2 team members within the same team, then entire team is eligible for qualifing else team is not eligible for qualification.
-- Show the members who actually qualified and did not qualify the program.

SELECT * FROM Ameriprise_LLC;


WITH cte as (
SELECT teamID, 
       COUNT(teamID) qualifying_team
FROM Ameriprise_LLC
WHERE Criteria1 = 'Y' AND Criteria2 = 'Y' 
GROUP BY teamID
HAVING COUNT(teamID) >= 2
)
SELECT a.*,
      CASE WHEN a.Criteria1 = 'Y' AND a.Criteria2 = 'Y' AND qualifying_team >= 2 THEN "YES! Qualified" ELSE "Better Luck Next Time" END Result
FROM Ameriprise_LLC a
LEFT JOIN cte c ON c.teamID = a.teamID;
