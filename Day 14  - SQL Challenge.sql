CREATE DATABASE fair;
USE fair;

CREATE TABLE family 
(
person varchar(5),
type varchar(10),
age int
);
INSERT INTO family VALUES ('A1','Adult',54)
,('A2','Adult',53),('A3','Adult',52),('A4','Adult',58),('A5','Adult',54),('C1','Child',20),('C2','Child',19),('C3','Child',22),('C4','Child',15);


/* You have a table with columns Name and Type.
The Type column has ‘Adult’ or ‘Child’. 
Write a SQL query to generate a table showing pairs of adults who went for a ride, 
with the condition a child can only go to the ride with an adult but cannot go to a ride alone.
*/


SELECT * FROM family;


WITH adult as(
SELECT *,row_number() OVER (Order BY person) adult_age_rnk
FROM family
WHERE type = 'Adult'
), child as (
SELECT *,row_number() OVER (Order BY person) child_age_rnk
FROM family
WHERE type = 'Child'
)
SELECT a.person as "Adult", c.person as "Child"
FROM adult a
LEFT JOIN child c
ON adult_age_rnk = child_age_rnk;


-- note -- created/ Used row_number to join and to make of pair of adult and child table


/* You have a table with columns Name and Type.
The Type column has ‘Adult’ or ‘Child’. 
Write a SQL query to generate a table showing pairs of adults who went for a ride, 
with the condition a yongest child should only go to the ride with an eldest adult but cannot go to a ride alone.
*/


WITH adult as(
SELECT *,row_number() OVER (Order BY age Desc) adult_age_rnk
FROM family
WHERE type = 'Adult'
), child as (
SELECT *,row_number() OVER (Order BY age) child_age_rnk
FROM family
WHERE type = 'Child'
)
SELECT a.person as "Adult", c.person as "Child"
FROM adult a
LEFT JOIN child c
ON adult_age_rnk = child_age_rnk
ORDER BY a.person;
