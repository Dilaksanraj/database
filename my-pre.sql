
/*get number of students*/
select count(1) from students;



/*get students population in each year*/

select student_population_year_ref, count(1) from students
group by student_population_year_ref;



/*get students population in each year with course reference*/

select s.student_population_year_ref,s.student_population_code_ref,count(1) from students s
group by s.student_population_year_ref,s.student_population_code_ref
order by s.student_population_year_ref;



/*get students population in each program*/


select student_population_code_ref, count(1) as number_of_students from students
group by student_population_code_ref;



/* calculate age from dob */

SELECT contact_first_name, date_part('year',age(contact_birthdate)) as contact_age, * FROM contacts;



/*add age column to contacts*/

alter table only contacts add column contact_age integer NULL;



/*calculate age from dob and insert in col contact_age*/

update contacts as c1 set contact_age = 
(SELECT date_part('year',age(contact_birthdate)) as c_age 
 FROM contacts as c2 where c1.contact_email=c2.contact_email);



/*avg student age*/

select avg(c.contact_age) as student_avg_age from students as s left join contacts as c
on c.contact_email=s.student_contact_ref;



--select all student with thire contact information

select s.student_epita_email, c.contact_email , c.contact_first_name ,c.contact_last_name , c.contact_city from students s 
inner join contacts c on s.student_contact_ref = c.contact_email;



--select all the student who has contact information

select * from students s 
left join contacts c on c.contact_email  = s.student_contact_ref;




/*avg session duration for a course*/

select avg(EXTRACT(EPOCH FROM TO_TIMESTAMP(session_end_time, 'HH24:MI:SS')::TIME - TO_TIMESTAMP(session_start_time, 'HH24:MI:SS')::TIME)/3600) as duration,
s.session_course_ref
from sessions as s left join courses as c
on c.course_code=s.session_course_ref
group by s.session_course_ref;




/*find the student with most absents / presents
select count(a.attendance_student_ref) as absents, a.attendance_student_ref*/

select sum(a.attendance_presence) as absents,
c.contact_first_name, c.contact_last_name
from contacts as c
left join students as s on s.student_contact_ref=c.contact_email
left join attendance as a on s.student_epita_email=a.attendance_student_ref
group by c.contact_first_name, c.contact_last_name
order by absents ASC
limit 5;



/*find the student with most absents*/

select count(a.attendance_student_ref) as absents,
c.contact_first_name, c.contact_last_name
from contacts as c
left join students as s on s.student_contact_ref=c.contact_email
left join attendance as a on s.student_epita_email=a.attendance_student_ref
where a.attendance_presence=1
group by c.contact_first_name, c.contact_last_name
order by absents ASC
limit 2




/*find students who are not graded*/
/*first solution*/

select s.student_epita_email
from students as s 
where s.student_epita_email not in 
(select g.grade_student_epita_email_ref from grades as g)



/*second solution*/

SELECT s.student_epita_email
FROM students as s
WHERE NOT EXISTS
  (SELECT *
   FROM grades as g
   WHERE s.student_epita_email = g.grade_student_epita_email_ref)
   
   
   
/*third solution*/
   
SELECT s.student_epita_email
FROM students as s
LEFT OUTER JOIN grades as g
  ON (s.student_epita_email = g.grade_student_epita_email_ref)
  WHERE g.grade_student_epita_email_ref IS NULL

  
  

/*find the teachers who are not in any session*/
  
SELECT c.contact_first_name, c.contact_last_name, t.teacher_epita_email
from contacts as c
inner join teachers as t
on c.contact_email = t.teacher_contact_ref
LEFT OUTER JOIN sessions as s
  ON t.teacher_epita_email = s.session_prof_ref
  WHERE s.session_prof_ref IS null
  
  
  
  
  
select * from teachers;
select * from sessions;
select * from courses;
select * from contacts;
select * from students;
select * from grades;
select * from attendance;
select * from programs p;
select * from populations p



--my exam-pre
--select the students epita email and full name with  thire  attendance count where present (Assume 1 is presents)

select count(a.attendance_student_ref) as number_of_presents ,s.student_epita_email, CONCAT(c.contact_first_name,'',c.contact_last_name) as student_full_name 
from attendance a
join students s on a.attendance_student_ref = s.student_epita_email
join contacts c on c.contact_email = s.student_contact_ref
where a.attendance_presence  = 1
group by s.student_epita_email,c.contact_first_name,c.contact_last_name
order by s.student_epita_email;



--with subject

select c.contact_first_name ||' ' || c.contact_last_name as student_full_name, s.student_epita_email, a.attendance_course_ref, count(a.attendance_course_ref) as no_of_present
from attendance a
join students s on a.attendance_student_ref = s.student_epita_email
join contacts c on c.contact_email =s.student_contact_ref
where a.attendance_presence = 1
group by s.student_epita_email, a.attendance_course_ref , c.contact_first_name, c.contact_last_name
order by s.student_epita_email; 



--most present subject

select count( a.attendance_course_ref),a.attendance_course_ref from attendance as a
where a.attendance_presence = 0
group by a.attendance_course_ref
order by count desc;


--total number of attendance for python

select count(1) from attendance a
where a.attendance_course_ref like '%PYTHON%';



--all highest score with student details and subject

select s.student_epita_email,g.grade_score as max_score, g.grade_course_code_ref from grades g 
inner join students s on g.grade_student_epita_email_ref = s.student_epita_email
group by s.student_epita_email, g.grade_score,g.grade_course_code_ref
order by g.grade_score desc;



--max score for python

select MAX(g.grade_score) FROM grades as g
where g.grade_course_code_ref = 'PG_PYTHON';



--grade with students email for pyhton

select g.grade_score, g.grade_course_code_ref, s.student_epita_email FROM grades as g
join students s on s.student_epita_email = grade_student_epita_email_ref 
where g.grade_course_code_ref = 'PG_PYTHON'
group by g.grade_course_code_ref,s.student_epita_email,g.grade_score
order by g.grade_score desc;



--get all teacher with full name

select t.teacher_epita_email, concat(c.contact_first_name,' ', c.contact_last_name) as teacher_full_name from teachers t
join contacts c on t.teacher_contact_ref = c.contact_email;



--testing

select * from programs p ;
select * from courses c ;
select * from contacts c;



--rank example
SELECT g.grade_score,g.grade_student_epita_email_ref,g.grade_course_code_ref,
RANK() OVER(
	ORDER BY g.grade_score DESC
)
FROM grades g ;



--no of sessions for particular course

select count(s.session_course_ref) as number_of_session, s.session_course_ref as course from sessions s 
group by s.session_course_ref;



-- total grade of a particular(example: for ammie corrio) student in each subject

select g.grade_student_epita_email_ref,
s.student_epita_email,
g.grade_course_code_ref,
s.student_population_period_ref,
s.student_population_year_ref,
sum(g.grade_score) as total
from grades g
join students s on g.grade_student_epita_email_ref =s.student_epita_email
where s.student_population_period_ref ='SPRING' and grade_student_epita_email_ref ='ammie.corrio@epita.fr'
group by g.grade_student_epita_email_ref ,
s.student_epita_email ,
g.grade_course_code_ref,
s.student_population_period_ref,
s.student_population_year_ref;



--select total marks in each subject for all student in 'SPIRING'

select g.grade_student_epita_email_ref, g.grade_course_code_ref, sum(g.grade_score)as total from grades g
join students s on s.student_epita_email = g.grade_student_epita_email_ref
where s.student_population_period_ref ='SPRING'
group by g.grade_student_epita_email_ref, g.grade_course_code_ref
order by g.grade_student_epita_email_ref;



--total score for each score for each students

select g.grade_course_code_ref,g.grade_student_epita_email_ref, avg(g.grade_score) as score from grades g
group by g.grade_course_code_ref, g.grade_student_epita_email_ref
order by score desc;



--average score for each corse

select avg(g.grade_score)::numeric(10,2), g.grade_course_code_ref from grades g
group by g.grade_course_code_ref;


select * from grades g
order by g.grade_student_epita_email_ref,g.grade_course_code_ref;

select  * from sessions s
right join teachers t on t.teacher_epita_email = s.session_prof_ref
where s.session_prof_ref is not null;


--suggestion to improve the database
add fk to teachers table in order to get the contact information of teachers
no primary key for attendance table;

--case select name,
SELECT g.grade_score, g.grade_student_epita_email_ref,
       CASE
           WHEN g.grade_score >= 10 THEN 'Pass'
           
           WHEN g.grade_score <10 THEN 'fails'
       END status
FROM grades g 
ORDER BY g.grade_student_epita_email_ref ;

--join and  limit will list only first highest score data
select max(g.grade_score), CONCAT (c.contact_first_name, ' ', c.contact_last_name) as full_name from grades g 
join students s on s.student_epita_email = grade_student_epita_email_ref 
join contacts c on s.student_contact_ref = c.contact_email 
where g.grade_course_code_ref = 'SE_ADV_JS'
group by c.contact_last_name, c.contact_first_name
limit(1);

select max(g.grade_score) as max_score  from grades g where g.grade_course_code_ref = 'SE_ADV_JS'

select * from grades g where g.grade_course_code_ref = 'SE_ADV_JS'


--no of student in each program and years

select count(s.student_population_code_ref) as no_of_student, s.student_population_code_ref,s.student_population_year_ref from students s
group by s.student_population_code_ref,s.student_population_year_ref;
