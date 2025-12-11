create database Training_Company
use Training_Company
create table Emp
(
	Fname nvarchar(20) not null,
	Mname nvarchar(20),
	Lname nvarchar(20) not null,
	Ssn int primary key identity(1,1 ),
	Bdate date,
	EmployeeAddress nvarchar(100),
	Gender bit default 0,
	Salary int CONSTRAINT CK_Employee_Salary check(Salary between 500 and 3500),
	Super_ssn int,
	foreign key (Super_ssn) references Emp(Ssn)
)
create table Dept
(
	Dname nvarchar(20) not null,
	Dnumber int primary key identity(1, 1),
	Mgr_ssn int,
	Mgr_start_date date not null,
	foreign key (Mgr_ssn) references Emp(Ssn)
)
create table pro
(
Pnumber int primary key identity(1, 1),
Pname varchar(20),
Location varchar(20),
City varchar(20),
Dnumber int ,
foreign key (Dnumber) references Dept(Dnumber)
)
 create table Dependent
 (
 DepName int primary key identity(1, 1),
 Birth_date date,
 DGender bit default 0,
 Ssn int,
 foreign key (Ssn ) references Emp(Ssn)
 )
