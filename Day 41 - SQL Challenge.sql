create database super_store;
use super_store;

CREATE TABLE Persons (
    PersonID INT PRIMARY KEY,
    Name VARCHAR(100),
    Email VARCHAR(100),
    Score INT
);

INSERT INTO Persons (PersonID, Name, Email, Score)
VALUES 
(1, 'Alice', 'alice2018@hotmail.com', 88),
(2, 'Bob', 'bob2018@hotmail.com', 11),
(3, 'Davis', 'davis2018@hotmail.com', 27),
(4, 'Tara', 'tara2018@hotmail.com', 45),
(5, 'John', 'john2018@hotmail.com', 63);


CREATE TABLE Friends (
    PersonID INT,
    FriendID INT
);


INSERT INTO Friends (PersonID, FriendID)
VALUES 
(1, 2),
(1, 3),
(2, 1),
(2, 3),
(3, 5),
(4, 2),
(4, 3),
(4, 5);

/* Write a query to find PersonID, name, number of friends, sum of marks of person 
who have with total score greater than 100
*/

select * from Persons;
select * from Friends;


with main as (
select f.PersonID, count(1) "number of friends", sum(p.Score) "Total Marks"
from Persons p
join Friends f on p.PersonID = f.FriendID
group by f.PersonID
having sum(p.Score) > 100
)
select p.name, m.*
from main m
join Persons p on p.PersonID = m.PersonID;