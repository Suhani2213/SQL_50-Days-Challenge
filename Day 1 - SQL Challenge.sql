Create database Olympics;
USE Olympics;

CREATE TABLE events (
ID int,
event varchar(255),
YEAR INt,
GOLD varchar(255),
SILVER varchar(255),
BRONZE varchar(255)
);



INSERT INTO events VALUES (1,'100m',2016, 'Amthhew Mcgarray','donald','barbara');
INSERT INTO events VALUES (2,'200m',2016, 'Nichole','Alvaro Eaton','janet Smith');
INSERT INTO events VALUES (3,'500m',2016, 'Charles','Nichole','Susana');
INSERT INTO events VALUES (4,'100m',2016, 'Ronald','maria','paula');
INSERT INTO events VALUES (5,'200m',2016, 'Alfred','carol','Steven');
INSERT INTO events VALUES (6,'500m',2016, 'Nichole','Alfred','Brandon');
INSERT INTO events VALUES (7,'100m',2016, 'Charles','Dennis','Susana');
INSERT INTO events VALUES (8,'200m',2016, 'Thomas','Dawn','catherine');
INSERT INTO events VALUES (9,'500m',2016, 'Thomas','Dennis','paula');
INSERT INTO events VALUES (10,'100m',2016, 'Charles','Dennis','Susana');
INSERT INTO events VALUES (11,'200m',2016, 'jessica','Donald','Stefeney');
INSERT INTO events VALUES (12,'500m',2016,'Thomas','Steven','Catherine');


-- Write a Query to find number of gold medals per swimmer for only swimmer who won gold medal.



SELECT * FROM events;


SELECT
    GOLD AS Name, COUNT(1) AS 'No. of Gold medal'
FROM
    events
WHERE
    GOLD NOT IN (SELECT 
            SILVER
        FROM
            events)
        AND GOLD NOT IN (SELECT 
            BRONZE
        FROM
            events)
GROUP BY GOLD
ORDER BY GOLD ASC;
