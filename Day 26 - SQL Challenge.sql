CREATE DATABASE flat;
USE flat;

CREATE TABLE LIFT (
    ID INT PRIMARY KEY,
    CAPACITY INT
);

INSERT INTO LIFT (ID, CAPACITY) VALUES (1, 300);
INSERT INTO LIFT (ID, CAPACITY) VALUES (2, 350);

CREATE TABLE PASSENGER (
    NAME VARCHAR(50),
    WEIGHT INT,
    LIFT_ID INT,
    FOREIGN KEY (LIFT_ID) REFERENCES LIFT(ID)
);

INSERT INTO PASSENGER (NAME, WEIGHT, LIFT_ID) VALUES ('Rahul', 85, 1);
INSERT INTO PASSENGER (NAME, WEIGHT, LIFT_ID) VALUES ('Adarsh', 73, 1);
INSERT INTO PASSENGER (NAME, WEIGHT, LIFT_ID) VALUES ('Riti', 95, 1);
INSERT INTO PASSENGER (NAME, WEIGHT, LIFT_ID) VALUES ('Dheeraj', 80, 1);
INSERT INTO PASSENGER (NAME, WEIGHT, LIFT_ID) VALUES ('Vimal', 83, 2);
INSERT INTO PASSENGER (NAME, WEIGHT, LIFT_ID) VALUES ('Neha', 77, 2);
INSERT INTO PASSENGER (NAME, WEIGHT, LIFT_ID) VALUES ('Priti', 73, 2);
INSERT INTO PASSENGER (NAME, WEIGHT, LIFT_ID) VALUES ('Himanshi', 85, 2);

/*
The relationship between the LIFT and LIFT_PASSENGERS table is such that multiple passengers can attempt to enter the same lift, but the total weight of the passengers in a lift cannot exceed the lifts' capacity.
Your task is to write a SQL query that produces a comma-separated list of passengers who can be accommodated in each lift without exceeding the lift's capacity. 
The passengers in the list should be ordered by their weight in increasing order.
You can assume that the weights of the passengers are unique within each lift.
*/
 
SELECT * FROM LIFT;
SELECT * FROM PASSENGER;


WITH main as (
SELECT *,
	SUM(WEIGHT) OVER (PARTITION BY ID ORDER BY WEIGHT) weight_till_now,
    CASE WHEN CAPACITY >= SUM(WEIGHT) OVER (PARTITION BY ID ORDER BY WEIGHT) THEN 1 ELSE 0 END flag
FROM LIFT l
JOIN PASSENGER p
ON l.ID = p.LIFT_ID
)
SELECT LIFT_ID, GROUP_CONCAT(NAME SEPARATOR ", ") name
FROM main
WHERE flag = 1
GROUP BY LIFT_ID;