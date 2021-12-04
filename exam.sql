CREATING A TABLE

CREATE TABLE STUDENTS(
	student_epita_email varchar(255) PRIMARY KEY,
	student_contact_ref varchar(255) NOT NULL,
	student_enrollment_status char(50) NOT NULL,
	student_population_period_ref char(10) NOT NULL,
	student_population_code_ref char(5) NOT NULL
);

Select * from students;


INSERT A ROW OF DATA INTO A TABLE

INSERT INTO STUDENTS 
(student_epita_email, student_contact_ref, student_enrollment_status, student_population_period_ref, student_population_code_ref)			
VALUES						
    ('mohammad-mansoor.ahmadi@epita.fr', 'ahmadi.mansoor@outlook.com', 'confirmed', 'SPRING', 'SE');

 

4.	DROPING A COLUMN
ALTER TABLE STUDENTS DROP COLUMN "bdate";


5.	DUPLICATING COLUMNS: columns must exist duplicating it. We 1st add two columns a…

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


-- students names who have joined of 2021 
select * from students;
select student_epita_email, student_population_year_ref from students where student_population_year_ref='2021';


-- list of all students names that are selected.
select student_epita_email, student_enrollment_status, student_population_year_ref from students 
where student_enrollment_status = 'selected';

-- list of all the students that the enrollment status is completed.
select student_epita_email, student_enrollment_status, student_population_year_ref from students 
where student_enrollment_status = 'completed';


-- most absent all students list and absent list
-- group by with the unique identifier 
-- and summing the attendance
-- if you want to see one person, than limit 1;

SELECT a.attendance_student_ref, SUM(a.attendance_presence) times
FROM public.attendance a
GROUP BY a.attendance_student_ref
ORDER BY times;

2:





2.1:
-- Only one student that is always present
-- It's not a list. We limit it to one.
-- once you group by, you must in the select.

SELECT a.attendance_student_ref, SUM(a.attendance_presence) times
FROM public.attendance a
GROUP BY a.atte…



4:


5:
-- Highest score in a subject like PG_PYTHON
select MAX(g.grade_score) FROM grades as g
where g.grade_course_code_ref = 'PG_PYTHON'





---minnimu score in students wise
Select  MIN(g.grade_score) from grades as g

where g.grade_student_epita_email_ref = 'lai.gato@epita.fr'


select g.grade_score from grades as g





6:-- List of all the students GRADES who are having PROJECT - TWO COLUMNS ONLY

select grade_student_epita_email_ref as emails, grade_exam_type_ref as exam from grades where grade_exam_type_ref='Project';




