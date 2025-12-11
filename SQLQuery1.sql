create database campanyDB
use campanyDB
CREATE TABLE emp(
ID INT PRIMARY KEY,
FirstName VARCHAR(50) NOT NULL,
LastName VARCHAR(50) NOT NULL,
Department VARCHAR(50),
Salary DECIMAL(10,2) CHECK (Salary > 0)
);