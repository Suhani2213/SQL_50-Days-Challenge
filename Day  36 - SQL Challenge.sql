create	 database class;
use class;

create table students
(
student_id int,
student_name varchar(20)
);
insert into students values
(1,'Daniel'),(2,'Jade'),(3,'Stella'),(4,'Jonathan'),(5,'Will');

create table exams
(
exam_id int,
student_id int,
score int);

insert into exams values
(10,1,70),(10,2,80),(10,3,90),(20,1,80),(30,1,70),(30,3,80),(30,4,90),(40,1,60)
,(40,2,70),(40,4,80);


select * from students;
select * from exams;

with all_scores as(
select  exam_id, 
		max(score) highest_score,
        min(score) lowest_score
from exams
group by exam_id
)
select e.student_id, max(case when score = highest_score or score = lowest_score then 1 else 0 end) as red_flag
from all_scores s
join exams e on s.exam_id = e.exam_id
group by student_id
having max(case when score = highest_score or score = lowest_score then 1 else 0 end)  = 0;
