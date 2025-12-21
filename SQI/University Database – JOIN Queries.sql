-----------------------------------------------University Database – JOIN Queries
--1. Display the department ID, name, and the full name of the faculty managing it
select
d.D_name,f.Name, d.Department_id
from DEPARTMENT d
join FACULTY f
ON d.Department_id =f.Department_id

--2. Display each program's name and the name of the department offering it.
select
d.D_name,c.Course_name
from DEPARTMENT d
join Course c
ON d.Department_id =c.Department_id

--3. Display the full student data and the full name of their faculty advisor.
select 
s.*,t.advisor
from STUDENT s
Full join STUDENT t
on s.S_id=t.S_id


--Display full data about courses whose titles start with "I" (e.g., "Introduction to...")
SELECT *
FROM COURSE
WHERE Course_name LIKE 'I%'

--6. Display names of students whose GPA is between 2.5 and 3.5
SELECT 
    F_name AS StudentName
FROM STUDENT
WHERE  GPA BETWEEN 2.5 AND 3.5