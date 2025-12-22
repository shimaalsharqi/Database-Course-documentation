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

-- Display names of students whose GPA is between 2.5 and 3.5
SELECT 
    F_name AS StudentName,GPA
FROM STUDENT
WHERE  GPA BETWEEN 2.5 AND 3.5

-- Find names of students who are advised by "Dr. Ahmed Hassan".
select
s.F_name+''+s.L_name as fullname
from STUDENT s
join STUDENT a
ON s.S_id=a.S_id
where  a.advisor='Dr. Ahmed Hassan'
--Retrieve each student's name and the titles of courses they are enrolled in, ordered by course title. 
Select 
s.F_name+''+s.L_name as fullname,
c.Course_name as title 
from STUDENT s
join STUDENT_COURSE a
ON s.S_id=a.S_id
join  COURSE c
ON c.Course_id=a.Course_id
order by c.Course_name

-- retrieve course name, department name, and faculty name teaching the class
Select 
c.Course_name,d.D_name,f.Name
From COURSE c
join DEPARTMENT d
ON c.Department_id=d.Department_id
join FACULTY f
ON f.Department_id=d.Department_id

--Display all faculty members who manage any department
select 
f.name,d.D_name
From FACULTY f
 join DEPARTMENT d
ON f.Department_id=d.Department_id

--Display all students and their advisors' names, even if some students don’t have advisors yet
 select 
s.F_name+''+s.L_name as fullname,t.advisor
from STUDENT s
left join STUDENT t
on s.S_id=t.S_id




