create database pwc1;
use pwc1;


create table source(id int, name varchar(5));

create table target(id int, name varchar(5));

insert into source values(1,'A'),(2,'B'),(3,'C'),(4,'D');

insert into target values(1,'A'),(2,'B'),(4,'X'),(5,'F');



select * from source;
select * from target;


WITH main AS (
    SELECT s.id AS source_id, s.name AS source_name, t.id AS target_id, t.name AS target_name
    FROM source s
    LEFT JOIN target t ON t.id = s.id
    UNION
    SELECT s.id AS source_id, s.name AS source_name, t.id AS target_id, t.name AS target_name
    FROM source s
    RIGHT JOIN target t ON s.id = t.id
)
SELECT COALESCE(source_id, target_id) AS id -- , source_name, target_name
       ,CASE 
           WHEN source_name IS NULL THEN 'new in target' 
           WHEN target_name IS NULL THEN 'new in source' 
           ELSE 'mismatch' 
       END AS comment
FROM main
WHERE source_name != target_name OR source_name IS NULL OR target_name IS NULL;

