-- LinkedIn Power Creators (Part 2)

CREATE DATABASE LinkedIn;
USE LinkedIn;		


CREATE TABLE personal_profiles 
(
profile_id INT,
name VARCHAR(100),
followers INT
);

INSERT INTO personal_profiles VALUES(1,'Nick Singh',92000);
INSERT INTO personal_profiles VALUES(2,'Zack Wilson',199000);
INSERT INTO personal_profiles VALUES(3,'Daliana Liu',171000);
INSERT INTO personal_profiles VALUES(4,'Ravit Jain',107000);
INSERT INTO personal_profiles VALUES(5,'Vin Vashista',139000);
INSERT INTO personal_profiles VALUES(6,'Susan Wojcicki',39000);


CREATE TABLE employee_company
(
personal_profile_id INT,
company_id INT
);	

INSERT INTO EMPLOYEE_COMPANY VALUES(1,4);
INSERT INTO EMPLOYEE_COMPANY VALUES(1,9);
INSERT INTO EMPLOYEE_COMPANY VALUES(2,2);
INSERT INTO EMPLOYEE_COMPANY VALUES(3,1);
INSERT INTO EMPLOYEE_COMPANY VALUES(4,3);
INSERT INTO EMPLOYEE_COMPANY VALUES(5,6);
INSERT INTO EMPLOYEE_COMPANY VALUES(6,5);



CREATE TABLE company_pages
(
company_id INT,
name VARCHAR(100),
followers INT
);

INSERT INTO company_pages VALUES(1,'The Data Science Podcast',8000);
INSERT INTO company_pages VALUES(2,'Airbnb',700000);
INSERT INTO company_pages VALUES(3,'The Ravit Show',6000);
INSERT INTO company_pages VALUES(4,'DataLemur',200);
INSERT INTO company_pages VALUES(5,'YouTube',16000000);
INSERT INTO company_pages VALUES(6,'DataScience.Vin',4500);
INSERT INTO company_pages VALUES(9,'Ace The Data Science',4479);




/*  The LinkedIn Creator Team wants to find power creators who use their personal profiles like company or influencers pages. One way to identify them is if their personal profile has more followers than the company they work for.

 Write a query that returns the IDs, details of these power creators. We should keep in mind that a person might work at more than one company.*/ 



SELECT * FROM personal_profiles;
SELECT * FROM employee_company;
SELECT * FROM company_pages;



SELECT * 
FROM personal_profiles pp
JOIN employee_company ec on pp.profile_id = ec.personal_profile_id
JOIN company_pages cp on ec.company_id = cp.company_id;


with main as (
SELECT pp.profile_id, 
	pp.name, 
	pp.followers as creator_followers,
	cp.company_id, 
	cp.name as company_name,
	MAX(cp.followers) OVER(PARTITION BY profile_id) as max_company_followers
FROM personal_profiles pp
JOIN employee_company ec on pp.profile_id = ec.personal_profile_id
JOIN company_pages cp on ec.company_id = cp.company_id
)
SELECT profile_id as power_creator_id, 
       name, 
       creator_followers, 
       max_company_followers
FROM main
WHERE creator_followers > max_company_followers
GROUP BY profile_id, name, creator_followers, max_company_followers;
