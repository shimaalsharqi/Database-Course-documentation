create database college
use college
create table DEPARTMENT
(
Department_id int primary key identity(1, 1) not null,
D_name varchar(20)
)
create table FACULTY
(
F_id int primary key identity(1, 1) not null,
Name varchar(20),
Department varchar(20),
Mobile_no varchar(20),
Salary decimal(8,3),
Department_id int,
foreign key (Department_id) references DEPARTMENT(Department_id)
)
create table HOSTEL
(
Hostel_id int primary key identity(1, 1) not null,
Hostel_name varchar(20),
City varchar(20),
State varchar(20),
Address varchar(20),
Pin_code int,
No_of_seats int
)

create table EXAMS
(
Exam_code varchar(20) primary key not null,
E_Date date,
E_Time time,
Room varchar,
Department_id int,
foreign key (Department_id) references DEPARTMENT(Department_id)
)
create table COURSE
(
Course_id varchar primary key not null,
Course_name varchar(20),
Duration varchar(20),
Department_id int,
foreign key (Department_id) references DEPARTMENT(Department_id)
)
create table SUBJECT
(
Subject_id  varchar primary key not null,
Subject_name varchar(20),
F_id int,
foreign key (F_id) references FACULTY(F_id)
)
create table STUDENT
(
S_id int primary key identity(1, 1) not null,
F_name varchar(20),
L_name varchar(20),
Phone_no varchar(20),
DOB date,
Department_id int,
foreign key (Department_id) references DEPARTMENT(Department_id),
Hostel_id int,
foreign key (Hostel_id) references HOSTEL(Hostel_id)
)
create table FACULTY_STUDENT
(
S_id int,
foreign key (S_id) references STUDENT(S_id),
F_id int,
foreign key (F_id) references FACULTY(F_id)
)
create table STUDENT_COURSE
(
S_id int,
foreign key (S_id) references STUDENT(S_id),
Course_id varchar,
foreign key (Course_id) references COURSE(Course_id)
)
create table STUDENT_EXAMS
(
S_id int,
E_code varchar(20),
primary key(S_id,E_code),
foreign key (E_code) references EXAMS(Exam_code),
foreign key (S_id) references STUDENT(S_id)
)
DROP TABLE STUDENT_EXAMS;
DROP TABLE EXAMS;
CREATE TABLE EXAMS
(
    Exam_code VARCHAR(20) PRIMARY KEY NOT NULL,
    E_Date DATE,
    E_Time TIME,
    Room VARCHAR(20),
    Department_id INT,
    FOREIGN KEY (Department_id) REFERENCES DEPARTMENT(Department_id)
)
CREATE TABLE STUDENT_EXAMS
(
    S_id INT,
    E_code VARCHAR(20),
    PRIMARY KEY (S_id, E_code),
    FOREIGN KEY (S_id) REFERENCES STUDENT(S_id),
    FOREIGN KEY (E_code) REFERENCES EXAMS(Exam_code)
)
DROP TABLE FACULTY_STUDENT;
DROP TABLE STUDENT_COURSE;

create table FACULTY_STUDENT
(
S_id int,
F_id int,
PRIMARY KEY (S_id, F_id),
foreign key (S_id) references STUDENT(S_id),
foreign key (F_id) references FACULTY(F_id)
)
create table STUDENT_COURSE
(
S_id int,
Course_id varchar,
PRIMARY KEY (S_id, Course_id),
foreign key (S_id) references STUDENT(S_id),
foreign key (Course_id) references COURSE(Course_id)
)
create table STUDENT_SUBJECT
(
S_id int,
Subject_id  varchar,
PRIMARY KEY (S_id, Subject_id),
foreign key (S_id) references STUDENT(S_id),
foreign key (Subject_id) references SUBJECT(Subject_id)
)
INSERT INTO DEPARTMENT (D_name)
VALUES
('Computer Science'),
('Mathematics'),
('Physics');
select * from DEPARTMENT

INSERT INTO HOSTEL (Hostel_name, City, State, Address, Pin_code, No_of_seats)
VALUES
('Al Noor Hostel', 'Muscat', 'Muscat', 'Al Khuwair', 112, 200),
('Al Amal Hostel', 'Sohar', 'Al Batinah', 'Salalah Street', 311, 150);

select * from HOSTEL

INSERT INTO FACULTY (Name, Department, Mobile_no, Salary, Department_id)
VALUES
('Dr. Ahmed', 'Computer Science', '91234567', 1500.000, 1),
('Dr. Fatma', 'Mathematics', '92345678', 1400.000, 2);
select * from FACULTY

INSERT INTO COURSE (Course_id, Course_name, Duration, Department_id)
VALUES
('C101', 'Database Systems', '4 Months', 1),
('C102', 'Calculus', '3 Months', 2);

ALTER TABLE COURSE
ALTER COLUMN Course_id VARCHAR(10) NOT NULL;
DROP TABLE STUDENT_COURSE;
DROP TABLE COURSE;
CREATE TABLE COURSE
(
    Course_id VARCHAR(10) PRIMARY KEY NOT NULL,
    Course_name VARCHAR(20),
    Duration VARCHAR(20),
    Department_id INT,
    FOREIGN KEY (Department_id) REFERENCES DEPARTMENT(Department_id)
);

CREATE TABLE STUDENT_COURSE
(
    S_id INT,
    Course_id VARCHAR(10),
    PRIMARY KEY (S_id, Course_id),
    FOREIGN KEY (S_id) REFERENCES STUDENT(S_id),
    FOREIGN KEY (Course_id) REFERENCES COURSE(Course_id)
);
INSERT INTO COURSE (Course_id, Course_name, Duration, Department_id)
VALUES
('C101', 'Database Systems', '4 Months', 1),
('C102', 'Calculus', '3 Months', 2);
select * from COURSE
INSERT INTO STUDENT (F_name, L_name, Phone_no, DOB, Department_id, Hostel_id)
VALUES
('Ali', 'Salim', '91111111', '2002-05-12', 1, 1),
('Aisha', 'Khalid', '92222222', '2003-08-20', 2, 2);
select * from STUDENT
INSERT INTO SUBJECT (Subject_id, Subject_name, F_id)
VALUES
('S01', 'Databases', 1),
('S02', 'Algebra', 2);
DROP TABLE STUDENT_SUBJECT;
DROP TABLE SUBJECT;
CREATE TABLE SUBJECT
(
    Subject_id VARCHAR(10) PRIMARY KEY NOT NULL,
    Subject_name VARCHAR(20),
    F_id INT,
    FOREIGN KEY (F_id) REFERENCES FACULTY(F_id)
);
CREATE TABLE STUDENT_SUBJECT
(
    S_id INT,
    Subject_id VARCHAR(10),
    PRIMARY KEY (S_id, Subject_id),
    FOREIGN KEY (S_id) REFERENCES STUDENT(S_id),
    FOREIGN KEY (Subject_id) REFERENCES SUBJECT(Subject_id)
);
INSERT INTO SUBJECT (Subject_id, Subject_name, F_id)
VALUES
('S01', 'Databases', 1),
('S02', 'Algebra', 2);
select * from SUBJECT
INSERT INTO EXAMS (Exam_code, E_Date, E_Time, Room, Department_id)
VALUES
('E101', '2025-01-15', '09:00', 'R101', 1),
('E102', '2025-01-20', '11:00', 'R202', 2);
select * from EXAMS
INSERT INTO FACULTY_STUDENT (S_id, F_id)
VALUES
(1, 1),
(2, 2);
select * from FACULTY_STUDENT
INSERT INTO STUDENT_COURSE (S_id, Course_id)
VALUES
(1, 'C101'),
(2, 'C102');
select * from STUDENT_COURSE
INSERT INTO STUDENT_SUBJECT (S_id, Subject_id)
VALUES
(1, 'S01'),
(2, 'S02');
select * from STUDENT_SUBJECT
INSERT INTO STUDENT_EXAMS (S_id, E_code)
VALUES
(1, 'E101'),
(2, 'E102');
select * from STUDENT_EXAMS

--Display each student's full name
select F_name + ' '+L_name as full_name 
from  STUDENT
--Display each student’s full name and GPA as GPA Score.
ALTER TABLE STUDENT
ADD GPA DECIMAL(3,2);
UPDATE STUDENT
SET GPA = 3.80
WHERE S_id = 1;

UPDATE STUDENT
SET GPA = 3.40
WHERE S_id = 2;
SELECT S_id, F_name, L_name, GPA
FROM STUDENT;

SELECT 
    F_name + ' ' + L_name AS Full_Name,
    GPA AS GPA_Score
FROM STUDENT;
--List student IDs and names of students with GPA greater than 3.5
SELECT 
    S_id,
    F_name + ' ' + L_name AS Student_Name
FROM STUDENT
WHERE GPA > 3.5;
--Display students with GPA between 3.0 and 3.5.
select *  
 FROM STUDENT
  WHERE GPA between 3.0 and 3.5
  --Display students ordered by GPA descending
  select *
  FROM STUDENT
 ORDER BY GPA DESC;
 --Display the maximum, minimum, and average GPA
 select 
 max(GPA) as max_GPA,
 min(GPA) as min_GPA,
 avg(GPA) as avg_GPA
 FROM STUDENT
 --Display total number of students.
 select count(*) as total_students
  FROM STUDENT
  --Display students whose names end with 'a'
  SELECT *
FROM Student
WHERE F_name LIKE '%a';
--DML
--14. Insert your data as a new student (Student ID = 300045, GPA = 3.6)
INSERT INTO STUDENT (F_name, L_name, Phone_no, DOB, Department_id, Hostel_id,GPA)
VALUES
('may', 'khalifa', '91111111', '2002-05-12', 1, 1,3.6)

set identity_insert STUDENT on

INSERT INTO STUDENT (S_id,F_name, L_name, Phone_no, DOB, Department_id, Hostel_id,GPA)
VALUES
(300045,'may', 'khalifa', '91111111', '2002-05-12', 1, 1,3.6)
set identity_insert STUDENT off
