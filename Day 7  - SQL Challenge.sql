/* There are 2 tables, first table has 5 records and second table has 10 records
You can assume any value in each of  the table. Hpw many maximum and minimum record possible in each case of
inner join, left join, right join and full outer join*/


CREATE DATABASE trick;
USE trick;


-- For maximum record possible according to the case
CREATE TABLE t1 (id_1 INT);
CREATE TABLE t2 (id2 INT);

INSERT INTO t1 VALUES (1),(1),(1),(1),(1);
INSERT INTO t2 VALUES (1),(1),(1),(1),(1),(1),(1),(1),(1),(1);

SELECT * 
FROM t1
INNER JOIN t2 ON t1.id_1 = t2.id2;
-- Inner join - 50 records  rerturned

SELECT * 
FROM t1
LEFT JOIN t2 ON t1.id_1 = t2.id2;
-- Left join - 50 records  returned

SELECT * 
FROM t1
RIGHT JOIN t2 ON t1.id_1 = t2.id2;
-- Right join - 50 records  returned

SELECT * 
FROM t1
FULL OUTER JOIN t2 ON t1.id_1 = t2.id2;
-- Full outer join - 50 records returned

/*Maximum record possible
Inner join - 50 records
Left join - 50 records
Right join - 50 records
Full outer join - 50 records*/




--  For minimum record possible according to the case
CREATE TABLE t_2 (id_2 INT);

INSERT INTO t1 VALUES (1),(1),(1),(1),(1);
INSERT INTO t_2 VALUES (2),(2),(2),(2),(2),(2),(2),(2),(2),(2);

SELECT * 
FROM t1
INNER JOIN t_2 ON t1.id_1 = t_2.id_2;
-- Inner join - 0 records rerturned

SELECT * 
FROM t1
LEFT JOIN t_2 ON t1.id_1 = t_2.id_2;
-- Left join - 5 records  returned

SELECT * 
FROM t1
RIGHT JOIN t_2 ON t1.id_1 = t_2.id_2;
-- Right join - 10 records  returned

SELECT * 
FROM t1
FULL OUTER JOIN t_2 ON t1.id_1 = t_2.id_2;
-- Full outer join - 15 records returned

/*Minimum record possible
Inner join - 0 records
Left join - 5 records
Right join - 10 records
Full outer join - 15 records*/
