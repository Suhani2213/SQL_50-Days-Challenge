CREATE DATABASE puzzle;

USE puzzle;

create table input (
id int,
formula varchar(10),
value int
);

insert into input values 
(1,'1+4',10),
(2,'2+1',5),
(3,'3-2',40),
(4,'4-1',20);

/* OUTPUT TABLE
| id  | formula | value | formula_Value |
|-----|---------|-------|---------------|
|  1  |   1+4   |  10   |       30      |
|  2  |   2+1   |   5   |       15      |
|  3  |   3-2   |  40   |       35      |
|  4  |   4-1   |  20   |       10      |
*/


SELECT * FROM input;


-- METHOD 1
WITH main as(
SELECT *, LEFT(formula, 1) as id1, RIGHT(formula, 1) as id2, SUBSTRING(formula, 2, 1) Operator
FROM input
)
SELECT m.id, m.formula, m.value ,
-- m.id, m.formula, m.value , Operator, i.value as id_value2, # for better understanding /or/ m.*, i.*
CASE WHEN Operator = '+' THEN m.value + i.value ELSE m.value - i.value END as formula_Value
FROM main m
JOIN input i
ON m.id2 = i.id
ORDER BY m.id;



-- METHOD 2 (using self Join dynamic case)
WITH main as(
SELECT *, LEFT(formula, 1) as id1, RIGHT(formula, 1) as id2, SUBSTRING(formula, 2, 1) Operator
FROM input
)
SELECT  m.id, m.formula, m.value,
-- m.*, i.*, i1.* # for better understanding 
CASE WHEN Operator = '+' THEN m.value + i.value ELSE m.value - i.value END as formula_Value
FROM main m
JOIN input i ON m.id2 = i.id
JOIN input i1 ON m.id1 = i1.id
ORDER BY m.id;