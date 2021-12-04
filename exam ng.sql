-- list avg,min,max grades of the students
Select c.contact_first_name, c.contact_last_name, s.student_epita_email, max(g.grade_score)
from students s
	inner join contacts c
	on c.contact_email = s.student_contact_ref
	
	inner join grades g
	on s.student_epita_email = g.grade_student_epita_email_ref

group by c.contact_first_name, c.contact_last_name, s.student_epita_email
order by c.contact_first_name ASC

--- list one and only columns
Select distinct course_code from courses
order by course_code ASC

-- joining last name and first name

SELECT CONCAT(contact_first_name, ' ', contact_last_name) As Student_Name
FROM contacts

--teachers with number of course
select c.contact_first_name, c.contact_last_name, t.teacher_contact_ref, count(session_prof_ref)
	from teachers as t
	inner join contacts as c
	on c.contact_email = t.teacher_contact_ref
	inner join sessions s
	on t.teacher_epita_email = s.session_prof_ref

group by c.contact_first_name, c.contact_last_name, t.teacher_contact_ref
order by count

--- teachers and there course 
select c.contact_first_name, c.contact_last_name, s.session_course_ref
	from teachers t
	
	inner join contacts c
	on c.contact_email = t.teacher_contact_ref
	
	inner join sessions s
	on t.teacher_epita_email = s.session_prof_ref
	
-- Total number of hours a student attended

SELECT a.attendance_student_ref, 
SUM(EXTRACT(HOUR FROM (CAST(a.attendance_session_end_time AS TIME) - CAST(a.attendance_session_start_time AS TIME))))
FROM public.attendance a
GROUP BY a.attendance_student_ref
ORDER BY a.attendance_student_ref


-- Class or courses names with most absent attendance

SELECT a.attendance_course_ref, SUM(a.attendance_presence) times
FROM public.attendance a
GROUP BY a.attendance_course_ref
ORDER BY times asc;

-- most absent students list we use it in descending order.

SELECT a.attendance_student_ref, SUM(a.attendance_presence) times
FROM public.attendance a
GROUP BY a.attendance_student_ref
ORDER BY times DESC;