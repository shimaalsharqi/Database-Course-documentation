--Company Database (the provided database) – JOIN Queries
--1. Display the department ID, department name, manager ID, and the full name of the manager.


SELECT 
    Dnum  AS DepartmentID,
    Dname     AS DepartmentName,
    MGRSSN   AS ManagerID,
    Fname + ' ' + Lname AS ManagerFullName
FROM Departments
JOIN Employee
    ON MGRSSN = SSN

--2.Display the names of departments and the names of the projects they control
SELECT
Dname,
Pname
from  Departments d
join Project p
on p.Dnum =  d.Dnum

--3. Display full data of all dependents, along with the full name of the employee they depend on
select d.ESSN,d.Dependent_name,d.sex,d.Bdate,
 Fname + ' ' + Lname AS FullName
from Dependent d full join Employee 
on SSN = ESSN

--4. Display the project ID, name, and location of all projects located in Cairo or Alex.

select Pnumber,Pname,Plocation,City
from Project
where City in ('Cairo' , 'Alex')
--5. Display all project data where the project name starts with the letter 'A'.
select *
from Project
where Pname like 'A%'

--6. Display the IDs and names of employees in department 30 with a salary between 1000 and 2000 LE. 

SELECT 
    SSN AS EmployeeID,
    Fname + ' ' + Lname AS EmployeeName
FROM Employee
WHERE Dno = 30
  AND Salary BETWEEN 1000 AND 2000

 --7. Retrieve  of employees in department 10 who work ≥ 10 hours/week on the "AL Rabwah" project

 select 
 e.Fname + ' ' + Lname AS FullName,p.Pname,w.Hours

 from Employee e
 JOIN  Works_for w

 on e.SSN =w.ESSn
 JOIN Project p
 on p.Pnumber = w.Pno 

where w.Hours >= 10 
and e.Dno = 10
and p.Pname in ('AL Rabwah')
--Find the names of employees who are directly supervised by "Kamel Mohamed"
 select
e.Fname + ' ' +e.Lname AS FullName 
  from Employee m
  join Employee e
  on e.Superssn=m.SSN
  where m.Fname = 'Kamel'
  and m.Lname ='Mohamed'
  
--9. Retrieve the names of employees and the names of the projects they work on, sorted by project name

 select
 Fname + ' ' +Lname AS FullName, Pname
 from Employee
 join Works_for
 on SSN=ESSn
 join Project
 on Pno=Pnumber
 ORDER BY Pname

 --10. For each project located in Cairo, display the project number, controlling department name, manager's last name,
--address, and birthdate


 select
 p.Plocation, p.Pnumber, d.Dname, Address, Bdate,p.City

 from Project p
 join Departments d
 on p.Dnum=d.Dnum

 join Employee
 on d.MGRSSN=SSN 
 where City in ('Cairo')

 -- Display all employees and their dependents, even if some employees have no dependents
  select * from Employee 
  select
  e.Fname,d.Dependent_name
 FROM Employee e
Left JOIN Dependent d
    ON e.SSN = d.ESSN
