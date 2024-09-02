CREATE DATABASE city;
USE city;


CREATE TABLE city_population (
    state VARCHAR(50),
    city VARCHAR(50),
    population INT
);

-- Insert the data
INSERT INTO city_population (state, city, population) VALUES ('haryana', 'ambala', 100);
INSERT INTO city_population (state, city, population) VALUES ('haryana', 'panipat', 200);
INSERT INTO city_population (state, city, population) VALUES ('haryana', 'gurgaon', 300);
INSERT INTO city_population (state, city, population) VALUES ('punjab', 'amritsar', 150);
INSERT INTO city_population (state, city, population) VALUES ('punjab', 'ludhiana', 400);
INSERT INTO city_population (state, city, population) VALUES ('punjab', 'jalandhar', 250);
INSERT INTO city_population (state, city, population) VALUES ('maharashtra', 'mumbai', 1000);
INSERT INTO city_population (state, city, population) VALUES ('maharashtra', 'pune', 600);
INSERT INTO city_population (state, city, population) VALUES ('maharashtra', 'nagpur', 300);
INSERT INTO city_population (state, city, population) VALUES ('karnataka', 'bangalore', 900);
INSERT INTO city_population (state, city, population) VALUES ('karnataka', 'mysore', 400);
INSERT INTO city_population (state, city, population) VALUES ('karnataka', 'mangalore', 200);

-- find the cities with the maximum and minimum populations within each state



SELECT * FROM city_population;



-- METHOD 1
WITH CTE AS (
SELECT *,
 dense_rank() OVER (PARTITION BY state ORDER BY population DESC) as max_population_rnk,
 dense_rank() OVER (PARTITION BY state ORDER BY population) as min_population_rnk
FROM city_population
)
SELECT state,
	MAX(CASE WHEN max_population_rnk = 1 THEN city end) as max_population_city,
   MAX( CASE WHEN min_population_rnk = 1 THEN city end) as min_population_city
FROM CTE
GROUP BY state
ORDER BY state;

-- METHOD 2
with cte as (
SELECT *, 
	MAX(population) OVER(PARTITION BY state)max_population, 
    MIN(population) OVER(PARTITION BY state) min_population
FROM city_population
)
SELECT state,
	MAX(CASE WHEN population = max_population THEN city end) max_population_city,
    MAX(CASE WHEN population = min_population THEN city end) min_population_city
FROM cte
GROUP BY state
ORDER BY state;