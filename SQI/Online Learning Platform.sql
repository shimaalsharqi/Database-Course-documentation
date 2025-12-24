create database OnlineCourses
use  OnlineCourses

CREATE TABLE Instructors ( 
InstructorID INT PRIMARY KEY, 
FullName VARCHAR(100), 
Email VARCHAR(100), 
JoinDate DATE 
); 
CREATE TABLE Categories ( 
CategoryID INT PRIMARY KEY, 
CategoryName VARCHAR(50) 
); 
CREATE TABLE Courses ( 
CourseID INT PRIMARY KEY, 
Title VARCHAR(100), 
InstructorID INT, 
CategoryID INT, 
Price DECIMAL(6,2), 
PublishDate DATE, 
FOREIGN KEY (InstructorID) REFERENCES Instructors(InstructorID), 
FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID) 
); 
CREATE TABLE Students ( 
StudentID INT PRIMARY KEY, 
FullName VARCHAR(100), 
Email VARCHAR(100), 
JoinDate DATE 
); 
CREATE TABLE Enrollments ( 
EnrollmentID INT PRIMARY KEY, 
StudentID INT, 
CourseID INT, 
EnrollDate DATE, 
CompletionPercent INT, 
Rating INT CHECK (Rating BETWEEN 1 AND 5), 
FOREIGN KEY (StudentID) REFERENCES Students(StudentID), 
FOREIGN KEY (CourseID) REFERENCES Courses(CourseID) 
); 
 

INSERT INTO Instructors VALUES 
(1, 'Sarah Ahmed', 'sarah@learnhub.com', '2023-01-10'), 
(2, 'Mohammed Al-Busaidi', 'mo@learnhub.com', '2023-05-21'); 
INSERT INTO Categories VALUES 
(1, 'Web Development'), 
(2, 'Data Science'), 
(3, 'Business'); 
INSERT INTO Courses VALUES 
(101, 'HTML & CSS Basics', 1, 1, 29.99, '2023-02-01'), 
(102, 'Python for Data Analysis', 2, 2, 49.99, '2023-03-15'), 
(103, 'Excel for Business', 2, 3, 19.99, '2023-04-10'), 
(104, 'JavaScript Advanced', 1, 1, 39.99, '2023-05-01'); 
INSERT INTO Students VALUES 
(201, 'Ali Salim', 'ali@student.com', '2023-04-01'), 
(202, 'Layla Nasser', 'layla@student.com', '2023-04-05'), 
(203, 'Ahmed Said', 'ahmed@student.com', '2023-04-10'); 
INSERT INTO Enrollments VALUES 
(1, 201, 101, '2023-04-10', 100, 5), 
(2, 202, 102, '2023-04-15', 80, 4), 
(3, 203, 101, '2023-04-20', 90, 4), 
(4, 201, 102, '2023-04-22', 50, 3), 
(5, 202, 103, '2023-04-25', 70, 4), 
(6, 203, 104, '2023-04-28', 30, 2), 
(7, 201, 104, '2023-05-01', 60, 3)

--Part 1: Warm-Up 
--1. Display all courses with prices.
 SElect 
 Title,Price
 from Courses

 --2. Display all students with join dates.
 Select 
 FullName,JoinDate
 from Students

 --3. Show all enrollments with completion percent and rating.
SELECT 
    s.FullName AS StudentName,
    c.Title AS CourseTitle,
    e.CompletionPercent,
    e.Rating
FROM Enrollments e
JOIN Students s ON e.StudentID = s.StudentID
JOIN Courses c ON e.CourseID = c.CourseID

--4. Count instructors who joined in 2023.
select Count(*) as InstructorsJoinedIn2023
from Instructors
WHERE JoinDate BETWEEN '2023-01-01' AND '2023-12-31'
--5. Count students who joined in April 2023.
select *from Students
Select count(*)
from Students 
where JoinDate between '2023-04-01' and '2023-04-30'

--Part 2: Beginner Aggregation
--1. Count total number of students.
select count(*)
from Students
--2. Count total number of enrollments. 
select count(*)
from Enrollments
--3. Find average rating per course. 
select
    c.Title AS CourseTitle,
    AVG(e.Rating) AS AverageRating
FROM Courses c
JOIN Enrollments e ON c.CourseID = e.CourseID
GROUP BY c.Title
--4. Count courses per instructor. 
select 
 i.FullName,
   count(c.Title) as Countcourses
   from Courses c
   join instructors i
   ON c.InstructorID=i.InstructorID
   Group by i.FullName
 --5. Count courses per category.
 Select 
 CategoryID,count(Title) as countcourses
 from Courses
 group by CategoryID

 --6. Count students enrolled in each course. 
Select 
CourseID,count(StudentID) as Countstudents
from Enrollments
 group by CourseID

 --7. Find average course price per category.
 select 
 CategoryID, avg(Price) as averagecourse
 from Courses
  group by CategoryID

 --8. Find maximum course price.
 select 
 max(Price)as maximumCoursePrice
 from Courses

 --9. Find min, max, and average rating per course. 
 select 
 CourseID,
 min(Rating) as minRating,
 max(Rating) as maxRating,
 avg(Rating) as avgRating
 from enrollments
 group by CourseID
  
 --10. Count how many students gave rating = 5.
 select 
 count(StudentID) as CountManyStudents ,Rating
 from Enrollments
 group by Rating 
 Having Rating = 5

 --Part 3: Extended Beginner Practice
 --11. Count enrollments per month.
SELECT 
    MONTH(EnrollDate) AS EnrollMonth,
    COUNT(*) AS TotalEnrollments
FROM Enrollments
GROUP BY MONTH(EnrollDate)
ORDER BY EnrollMonth
--12. Find average course price overall. 
SELECT 
    AVG(Price) AS AverageCoursePrice
FROM Courses

--13. Count students per join month
select 
month(JoinDate) as  joinMonth,
count(*) as CountStudents
from Students
group by month(JoinDate)

--14. Count ratings per value (1–5). 
SELECT 
    Rating,
    COUNT(*) AS RatingCount
FROM Enrollments
GROUP BY Rating
ORDER BY Rating

--15. Find courses that never received rating = 5. 
SELECT c.Title
FROM Courses c
WHERE NOT EXISTS (
    SELECT 1
    FROM Enrollments e
    WHERE e.CourseID = c.CourseID
      AND e.Rating = 5
)


--16. Count courses priced above 30
select 
count(Title)as CountCourses,Price
from Courses
group by Price
having Price > 30

--17. Find average completion percentage.
select 
avg(CompletionPercent) as avgCompletionPercent
from Enrollments
--18. Find course with lowest average rating. 
SELECT TOP 1 
    c.Title AS CourseTitle,
    AVG(e.Rating) AS AvgRating
FROM Courses c
JOIN Enrollments e ON c.CourseID = e.CourseID
GROUP BY c.Title
ORDER BY AvgRating ASC;

--Reflection (End of Day 1) 
--Answer briefly: 

--What was easiest?
--Everything was easy for me when the task was clear, like calculating averages, counts, or displaying data.

-- What was hardest? 
--Questions 15 (Courses that never received rating = 5) and 18 (Course with lowest average rating) were harder because they required more thinking about logic and aggregation.


--What does GROUP BY do in your own words? 
--GROUP BY groups rows based on a column so we can apply aggregate functions (like COUNT, AVG, SUM) to each group separately.

--Day 1 Mini Challenge 
--Course Performance Snapshot 
--Show:
--Course title
-- Total enrollments 
-- Average rating 
-- Average completion % 
SELECT 
    c.Title AS CourseTitle,
    COUNT(e.EnrollmentID) AS TotalEnrollments,
    AVG(e.Rating) AS AverageRating,
    AVG(e.CompletionPercent) AS AverageCompletion
FROM Courses c
LEFT JOIN Enrollments e ON c.CourseID = e.CourseID
GROUP BY c.Title


--Day 2 – JOIN + Aggregation + Analysis
--Part 4: JOIN + Aggregation

--1. Course title + instructor name + enrollments.
select
c.Title,i.FullName,count(e.EnrollmentID) as enrollments
from  Courses c
join Instructors i
ON c.InstructorID=i.InstructorID
join Enrollments e
ON e.CourseID=c.CourseID
group by c.Title,i.FullName

--2. Category name + total courses + average price. 
select
g.CategoryName,count(c.CourseID) as countCourseID , avg(c.Price) as avgPrice
from Courses c
join Categories g
ON c.CategoryID=g.CategoryID
group by g.CategoryName

--3. Instructor name + average course rating. 
select 
i.FullName,avg(e.Rating) as avgRating
from Enrollments e
join Courses c
ON e.CourseID=c.CourseID
join Instructors i
ON i.InstructorID=c.InstructorID
group by i.FullName

--4. Student name + total courses enrolled. 
select
s.FullName,count(e.CourseID) as totalCoursesEnrolled
from Enrollments e
join Students s
ON s.StudentID=e.StudentID
group by s.FullName

--5. Category name + total enrollments.
select
g.CategoryName, count(e.EnrollmentID) as totalEnrollments
from Categories g
join Courses c
ON g.CategoryID=c.CategoryID
join Enrollments e
ON c.CourseID=e.CourseID
group by g.CategoryName

--6. Instructor name + total revenue. 
SELECT 
    i.FullName AS InstructorName,
    SUM(c.Price) AS TotalRevenue
FROM Instructors i
JOIN Courses c ON i.InstructorID = c.InstructorID
JOIN Enrollments e ON c.CourseID = e.CourseID
GROUP BY i.FullName

--7. Course title + % of students completed 100%
SELECT 
    c.Title AS CourseTitle,
    CAST(
        100.0 * SUM(CASE WHEN e.CompletionPercent = 100 THEN 1 ELSE 0 END) 
        / COUNT(e.EnrollmentID) AS DECIMAL(5,2)
    ) AS Completion100Percent
FROM Courses c
LEFT JOIN Enrollments e ON c.CourseID = e.CourseID
GROUP BY c.Title

--Part 5: HAVING Practice 
 
--Use HAVING only. 
--1. Courses with more than 2 enrollments.
select
c.Title,count(e.EnrollmentID) as enrollments
from  Courses c
join Enrollments e
ON e.CourseID=c.CourseID
group by c.Title
having count(e.EnrollmentID)>2

--2. Instructors with average rating above 4. 
select 
i.FullName,avg(e.Rating) as avgRating
from Enrollments e
join Courses c
ON e.CourseID=c.CourseID
join Instructors i
ON i.InstructorID=c.InstructorID
group by i.FullName
having avg(e.Rating) > 4

--3. Courses with average completion below 60%.
select
c.Title,avg(e.CompletionPercent) as avgCompletionPercent
from Courses c
join Enrollments e
ON c.CourseID=e.CourseID
group by c.Title
having avg(e.CompletionPercent) < 60

--4. Categories with more than 1 course.
select
g.CategoryName,count(c.CourseID) as countCourseID 
from Courses c
join Categories g
ON c.CategoryID=g.CategoryID
group by g.CategoryName
having count(c.CourseID) > 1

--5. Students enrolled in at least 2 courses.
select
s.FullName,count(e.CourseID) as totalCoursesEnrolled
from Enrollments e
join Students s
ON s.StudentID=e.StudentID
group by s.FullName
having count(e.CourseID) > = 2


--Part 6: Analytical Thinking
--Best performing course.
select Top 1
c.Title, avg(r.Rating) as avgRating
from Courses c
join Enrollments r
ON c.CourseID=r.CourseID
group by c.Title
order by avg(r.Rating) desc

--2. Instructor to promote.
select Top 1
i.FullName,avg(e.Rating) as avgRating
from Enrollments e
join Courses c
ON e.CourseID=c.CourseID
join Instructors i
ON i.InstructorID=c.InstructorID
group by i.FullName
order by avg(e.Rating) desc

--3. Highest revenue category
SELECT Top 1
    i.FullName AS InstructorName,
    SUM(c.Price) AS TotalRevenue
FROM Instructors i
JOIN Courses c ON i.InstructorID = c.InstructorID
JOIN Enrollments e ON c.CourseID = e.CourseID
GROUP BY i.FullName
Order by SUM(c.Price) desc


--4. Do expensive courses have better ratings?
SELECT 
    c.Price,
    AVG(e.Rating) AS AvgRating
FROM Courses c
JOIN Enrollments e ON c.CourseID = e.CourseID
GROUP BY c.Price
ORDER BY c.Price
--If ratings consistently increase with price, this suggests that expensive courses tend to have better ratings.
--If ratings fluctuate or stay flat, then price does not strongly influence course quality.


--5. Do cheaper courses have higher completion?
SELECT 
    c.Price,
    AVG(e.CompletionPercent) AS AvgCompletion
FROM Courses c
JOIN Enrollments e ON c.CourseID = e.CourseID
GROUP BY c.Price
ORDER BY c.Price
--If completion rates decrease as prices increase, this indicates that cheaper courses are more likely to be fully completed.
--If completion remains similar across prices, then price is not a key factor in student commitment.

--Final Challenge – Mini Analytics Report

--1. Top 3 courses by revenue.
SELECT Top 3
    i.title,
    SUM(i.Price) AS TotalRevenue
from Courses i
GROUP BY i.title
Order by SUM(i.Price) desc

--2. Instructor with most enrollments. 
SELECT Top 1
    i.FullName,
    COUNT(e.EnrollmentID) AS TotalEnrollments
FROM Instructors i
JOIN Courses c ON i.InstructorID = c.InstructorID
JOIN Enrollments e ON c.CourseID = e.CourseID
GROUP BY i.FullName
ORDER BY TotalEnrollments DESC

--3. Course with lowest completion rate. 
SELECT Top 1
    c.CourseID,
    c.Title,
    AVG(e.CompletionPercent) AS completion_rate
FROM courses c
JOIN enrollments e 
    ON c.CourseID = e.CourseID
GROUP BY c.CourseID, c.Title
ORDER BY completion_rate ASC
--4. Category with highest average rating. 
SELECT TOP 1
    c.CourseID,
    c.Title,
    AVG(e.CompletionPercent) AS avg_completion_rate
FROM courses c
JOIN enrollments e
    ON c.CourseID = e.CourseID
GROUP BY c.CourseID, c.Title
ORDER BY avg_completion_rate ASC
--5. Student enrolled in most courses.
SELECT TOP 1
    s.StudentID,
    s.FullName,
    COUNT(e.CourseID) AS total_courses
FROM students s
JOIN enrollments e
    ON s.StudentID = e.StudentID
GROUP BY s.StudentID, s.FullName
ORDER BY total_courses DESC