create database airport;
use airport;

CREATE TABLE flights 
(
    cid VARCHAR(512),
    fid VARCHAR(512),
    origin VARCHAR(512),
    Destination VARCHAR(512)
);

INSERT INTO flights (cid, fid, origin, Destination) VALUES ('1', 'f1', 'Del', 'Hyd');
INSERT INTO flights (cid, fid, origin, Destination) VALUES ('1', 'f2', 'Hyd', 'Blr');
INSERT INTO flights (cid, fid, origin, Destination) VALUES ('2', 'f3', 'Mum', 'Agra');
INSERT INTO flights (cid, fid, origin, Destination) VALUES ('2', 'f4', 'Agra', 'Kol');
/*
Find the original and the final destination for each cid
sample output
cid | origin |destination
1   | Del    | Blr
*/

select * from flights;


-- Method 1
with cte as (
select cid, origin, Destination, Rank() over (partition by cid order by fid) as rnk
from flights),
cte1 as (
select cid, origin, Destination, Rank() over (partition by cid order by fid Desc) as rnk
from flights
)
select c1.cid, c1.origin, c2.Destination
from cte c1 
inner join cte1 c2 on c1.cid=c2.cid and c1.rnk=1 and c2.rnk=1;


-- Method 2 (self join)
select o.cid, o.origin, d.Destination
from flights o
join flights d on o.cid = d.cid and d.origin = o.Destination;


-- Method 3
with location_table as (
select cid, fid, origin as location, count(1) as flight_flying from flights group by cid, fid, origin
union all
select cid, fid, Destination as location, count(1) as flight_flying from flights group by cid, fid, Destination
), main as (
select *, dense_rank() over (partition by cid order by fid) as location_flight_no
from
(select cid, fid, location, sum(flight_flying) over (partition by cid, location) location_count-- ,
from location_table lt) a
where location_count = 1
)
select cid,
	   max(case when location_flight_no = 1 then location end) as Origin,
       max(case when location_flight_no = 2 then location end) as destination
from main
group by cid;






