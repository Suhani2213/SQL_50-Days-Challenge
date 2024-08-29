CREATE DATABASE IBM;
Use IBM;

CREATE TABLE FAMILIES (
    ID VARCHAR(50),
    NAME VARCHAR(50),
    FAMILY_SIZE INT
);

-- Insert data into FAMILIES table
INSERT INTO FAMILIES (ID, NAME, FAMILY_SIZE)
VALUES 
    ('c00dac11bde74750b4d207b9c182a85f', 'Alex Thomas', 9),
    ('eb6f2d3426694667ae3e79d6274114a4', 'Chris Gray', 2),
    ('3f7b5b8e835d4e1c8b3e12e964a741f3', 'Emily Johnson', 4),
    ('9a345b079d9f4d3cafb2d4c11d20f8ce', 'Michael Brown', 6),
    ('e0a5f57516024de2a231d09de2cbe9d1', 'Jessica Wilson', 3);

-- Create COUNTRIES table
CREATE TABLE COUNTRIES (
    ID VARCHAR(50),
    NAME VARCHAR(50),
    MIN_SIZE INT
-- MAX_SIZE INT
);

INSERT INTO COUNTRIES (ID, NAME, MIN_SIZE,MAX_SIZE)
VALUES 
    ('023fd23615bd4ff4b2ae0a13ed7efec9', 'Bolivia', 2 , 4),
    ('be247f73de0f4b2d810367cb26941fb9', 'Cook Islands', 4,8),
    ('3e85ab80a6f84ef3b9068b21dbcc54b3', 'Brazil', 4,7),
    ('e571e164152c4f7c8413e2734f67b146', 'Australia', 5,9),
    ('f35a7bb7d44342f7a  8a42a53115294a8', 'Canada', 3,5),
    ('a1b5a4b5fc5f46f891d9040566a78f27', 'Japan', 10,12);


SELECT * FROM FAMILIES;
SELECT * FROM COUNTRIES;

-- Each tour offers a discount if a minimum number of people book at the same time
-- Write a query to print the maximum number of  discounted tours any 1 family in the FAMILIES table can choose from

SELECT COUNT(1)
FROM COUNTRIES
where MIN_SIZE <= (SELECT max(FAMILY_SIZE) FROM FAMILIES);
-- 'Alex Thomas' family can choose from any of the 5 tours and qulify for the discount





-- For each family, calculate the number of countries they can travel to with a discount. 
-- The discount is based on whether the number of people booking the trip falls within the range of the agency’s people booking trips at the same time.

SELECT f.ID, f.name, COUNT(1) discount_on_country_trip
FROM FAMILIES f		
JOIN COUNTRIES c 
ON f.FAMILY_SIZE BETWEEN c.MIN_SIZE AND  c.MAX_SIZE
GROUP BY f.ID, f.name
ORDER BY COUNT(1) DESC;









-- Write a query to print the maximum number of discounted tours any 1 family in the FAMILIES table can choose from
-- The discount is based on whether the number of people booking the trip falls within the range of the agency’s people booking trips at the same time.

SELECT MAX(discount_on_country_trip) FROM
	(SELECT f.ID, f.name, COUNT(1) discount_on_country_trip
	FROM FAMILIES f		
	JOIN COUNTRIES c 
	ON f.FAMILY_SIZE BETWEEN c.MIN_SIZE AND  c.MAX_SIZE
	GROUP BY f.ID, f.name
	ORDER BY COUNT(1) DESC) a
-- 'Emily Johnson' family can choose from any of the 4 tours and qulify for the discount
