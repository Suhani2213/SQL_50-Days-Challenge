create database family;
use family;

create table people
(id int primary key not null,
 name varchar(20),
 gender char(2));

create table relations
(
    c_id int,
    p_id int,
    FOREIGN KEY (c_id) REFERENCES people(id),
    foreign key (p_id) references people(id)
);

insert into people (id, name, gender)
values
    (107,'Days','F'),
    (145,'Hawbaker','M'),
    (155,'Hansel','F'),
    (202,'Blackston','M'),
    (227,'Criss','F'),
    (278,'Keffer','M'),
    (305,'Canty','M'),
    (329,'Mozingo','M'),
    (425,'Nolf','M'),
    (534,'Waugh','M'),
    (586,'Tong','M'),
    (618,'Dimartino','M'),
    (747,'Beane','M'),
    (878,'Chatmon','F'),
    (904,'Hansard','F');

insert into relations(c_id, p_id)
values
    (145, 202),
    (145, 107),
    (278,305),
    (278,155),
    (329, 425),
    (329,227),
    (534,586),
    (534,878),
    (618,747),
    (618,904);
/*

Write a query to print the name of a child and his parents in individual colummns  respectively on order of name of the child.

This is what the output should look like
-----------------------------------
| Dimartino | Beane     | Hansard |
| Hawbaker  | Blackston | Days    |
| Keffer    | Canty     | Hansel  |
| Mozingo   | Nolf      | Criss   |
| Waugh     | Tong      | Chatmon |
-----------------------------------
*/


select * from people;

select * from relations;



-- Method 1
with father as (
select c_id,
       p_id, 
       p.name as Father
from people p
JOIN relations r
on p.id = r.p_id and gender = 'M'
), mother as (
select c_id, 
       p_id, 
       p.name as Mother
from people p
JOIN relations r
on p.id = r.p_id and gender = 'F'
)
select p.name as Child,
       Father,
       Mother
from father f
join mother m on f.c_id = m.c_id
join people p on p.id = m.c_id
order by p.name;




-- Method 2
SELECT c.name AS Child,
       MAX(CASE WHEN p.gender = 'M' THEN p.name END) AS Father,
       MAX(CASE WHEN p.gender = 'F' THEN p.name END) AS Mother
FROM relations r
JOIN people p ON p.id = r.p_id
JOIN people c ON c.id = r.c_id
GROUP BY c.name
ORDER BY c.name;

