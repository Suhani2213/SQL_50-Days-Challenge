create database pwc;
use pwc;

create table company_revenue 
(
company varchar(100),
year int,
revenue int
);

insert into company_revenue values 
('ABC1',2000,100),('ABC1',2001,110),('ABC1',2002,120),('ABC2',2000,100),('ABC2',2001,90),('ABC2',2002,120)
,('ABC3',2000,500),('ABC3',2001,400),('ABC3',2002,600),('ABC3',2003,800);


/*
 Find the company only whose revenue is increasing increasing every year.

Note: Suppose a company revenue is increasing for 3 years and a very next year revenue is dipped in that case it should not come in output
The out should be ABC1.
*/


select * from company_revenue;



-- METHOD 1
WITH main as (
SELECT *,
	   LAG(revenue,1,0) OVER(PARTITION BY company order by year) as prev_rev, 
       revenue - LAG(revenue,1,0) OVER(PARTITION BY company order by year)  yoy_growth,
COUNT(year) OVER (PARTITION BY company) Total_year
FROM company_revenue
)
SELECT company-- , Total_year, COUNT(1) rev_increase_years
FROM main m
where yoy_growth > 0
GROUP BY company, Total_year
HAVING Total_year = COUNT(1);
-- Logic -- how many years of data in each company(count of total years) = count of years when where revenue is increased




-- METHOD 2
WITH main as (
SELECT *, 
--     LAG(revenue,1,0) OVER(PARTITION BY company order by year) as prev_rev,
       revenue - LAG(revenue,1,0) OVER(PARTITION BY company order by year)  yoy_growth
FROM company_revenue
)
SELECT company
FROM main
where company not in (SELECT company FROM main WHERE yoy_growth < 0)
GROUP BY company;