create database Training_Company;
use Training_Company;

create table Emp
(
	Fname varchar(20) not null,
	Lname varchar(20) not null,
	Ssn int primary key identity(1,1),
	Bdate date,
	Gender bit default 0,
	Super_ssn int,
	foreign key (Super_ssn) references Emp(Ssn)
);

create table Dept
(
	Dname varchar(20) not null,
	Dnumber int primary key,
	Mgr_ssn int,
	Mgr_start_date date not null,
	foreign key (Mgr_ssn) references Emp(Ssn)
);
ALTER TABLE Emp
add Dnum int,
foreign key (Dnum) references Dept(Dnumber)

create table pro
(
	Pnumber int primary key identity(1, 1),
	Pname varchar(20),
	Location varchar(20),
	City varchar(20),
	Dnumber int,
	foreign key (Dnumber) references Dept(Dnumber)
);

create table Dependent
(
	DepName int primary key identity(1, 1),
	Birth_date date,
	DGender bit default 0,
	Ssn int,
	foreign key (Ssn) references Emp(Ssn)
);

create table location
(
	location varchar(20),
	Dnumber int,
	primary key(location, Dnumber),
	foreign key (Dnumber) references Dept(Dnumber)
);
create table work
(
workingHours int,
Ssn int,
Pnumber int,
primary key(Ssn, Pnumber),
foreign key (Ssn) references Emp(Ssn),
foreign key (Pnumber) references pro(Pnumber)
);
Insert into  Emp(Fname,Lname,Bdate,Gender) 
values('shima','mohammed','2002-07-12',0),
('manar','mohammed','2000-09-12',0),
('aound','suliman','2000-12-02',0),
('Ali','mohammed','2006-10-30',1);
select * from Emp
update Emp set Super_ssn = 1 where Ssn = 2; -- example
update Emp set Super_ssn = 3 where Ssn = 1;
update Emp set Super_ssn = 2 where Ssn = 3;
update Emp set Super_ssn = 1 where Ssn = 4;


Insert into Dept(Dname,Dnumber,Mgr_ssn,Mgr_start_date)
values
('math',14,1,'2025-09-13'),
('Arbic',10,2,'2025-09-12'),
('science',13,1,'2025-09-11'),
('English',12,3,'2025-09-10');

select * from Dept

Insert into pro(Pname, Location, City, Dnumber)
values ('Library Project', 'Building A', 'Muscat', 10),
       ('Website System', 'HQ Office', 'Sohar', 11),
       ('Training App', 'Lab 3', 'Nizwa', 12);
select * from pro
Insert into Dependent(Birth_date, DGender, Ssn)
values('2010-05-16',1,2), 
('2015-11-20',0,3),
('1995-09-21', 0, 2);
select * from Dependent
Insert into location(location, Dnumber)
values
('Muscat Office', 10),
('Sohar Office', 10),
('Nizwa Lab', 11),
('Database Center', 12),
('Training Hall', 13);
select * from location
Insert into work(workingHours, Ssn, Pnumber)
values(4, 1, 1),
(6, 1, 2),
(3, 1, 3);
select * from work