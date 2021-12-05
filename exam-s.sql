--- no of students in each program in a year
select student_population_code_ref , student_population_year_ref ,
count (*) as no_of_students_per_program
from students s



group by student_population_code_ref ,student_population_year_ref
order by student_population_code_ref asc;



select s.student_population_year_ref,s.student_population_code_ref,count(1) from students s
group by s.student_population_year_ref,s.student_population_code_ref;



--- no of students in fall 2020



select student_population_period_ref, student_population_year_ref ,
count (*)
from students s
group by student_population_period_ref , student_population_year_ref
having student_population_year_ref =2020



--- no of students in cs



select count(student_population_code_ref)
from students s
where student_population_code_ref='CS'



---NO OF STUDENTS enrolled



select count(student_enrollment_status)
from students s
where student_enrollment_status ='confirmed'


--enrollment status with names

select c.contact_email, c.contact_first_name, c.contact_last_name, s.student_contact_ref,s.student_enrollment_status
from contacts c
join students s on s.student_contact_ref = c.contact_email



group by c.contact_email,s.student_contact_ref, s.student_enrollment_status



--no of sessions for particular course




---adding column and adding some data in the added column




alter table teachers add teacher_first_name varchar(200)



alter table teachers add teacher_last_name varchar(200)



update teachers set teacher_first_name='blair',teacher_last_name='malet'
where teacher_contact_ref = 'bmalet@yahoo.com';



delete from teachers where teacher_contact_ref ='bmalet'



alter table teachers drop teacher_last_name
---
select *from students s




--for one subject



select c.contact_first_name ||' ' || c.contact_last_name as student_full_name, s.student_epita_email, a.attendance_course_ref, count(a.attendance_course_ref) as no_of_present
from attendance a
join students s on a.attendance_student_ref = s.student_epita_email
join contacts c on c.contact_email =s.student_contact_ref
where a.attendance_presence = 1 and a.attendance_course_ref ='PG_PYTHON'
group by s.student_epita_email, a.attendance_course_ref , c.contact_first_name, c.contact_last_name




---subject with highest no.of absent

select a.attendance_course_ref , count(a.attendance_course_ref)from attendance a
where attendance_presence =0
group by a.attendance_course_ref
order by count desc;


---grades of student in spring 2021
select g.grade_student_epita_email_ref,
s.student_epita_email,
g.grade_course_code_ref,
g.grade_exam_type_ref,
s.student_population_period_ref,
s.student_population_year_ref,
g.grade_score
from grades g
join students s on g.grade_student_epita_email_ref =s.student_epita_email
where s.student_population_period_ref ='SPRING'
group by g.grade_student_epita_email_ref ,
s.student_epita_email ,
g.grade_course_code_ref,
s.student_population_period_ref,
s.student_population_year_ref,
g.grade_score,
g.grade_exam_type_ref
order by g.grade_student_epita_email_ref asc;


-- total grade of a particular(example: for ammie corrio) student in each subject

select g.grade_student_epita_email_ref,
s.student_epita_email,
g.grade_course_code_ref,

s.student_population_period_ref,
s.student_population_year_ref,
avg(g.grade_score) as total
from grades g
join students s on g.grade_student_epita_email_ref =s.student_epita_email
where s.student_population_period_ref ='SPRING' and grade_student_epita_email_ref ='ammie.corrio@epita.fr'
group by g.grade_student_epita_email_ref ,
s.student_epita_email ,
g.grade_course_code_ref,
s.student_population_period_ref,
s.student_population_year_ref

---- total grade in one subject

select g.grade_student_epita_email_ref,
s.student_epita_email,
g.grade_course_code_ref,

s.student_population_period_ref,
s.student_population_year_ref,
sum(g.grade_score)
from grades g
join students s on g.grade_student_epita_email_ref =s.student_epita_email
where s.student_population_period_ref ='SPRING' and g.grade_course_code_ref ='DT_RDBMS'
group by g.grade_student_epita_email_ref ,
s.student_epita_email ,
g.grade_course_code_ref,
s.student_population_period_ref,
s.student_population_year_ref, g.grade_score



order by
g.grade_score desc;