create database BANKDB
use BANKDB
CREATE TABLE Branches (
    Branch_ID INT PRIMARY KEY,
    Phone_Number VARCHAR(20),
    Address VARCHAR(100)
)
CREATE TABLE Employees (
    Employee_ID INT PRIMARY KEY,
    Position VARCHAR(50),
    Name VARCHAR(50),
    Branch_ID INT,
    FOREIGN KEY (Branch_ID) REFERENCES Branches(Branch_ID)
)
CREATE TABLE Customers (
    C_ID INT PRIMARY KEY,
    C_Name VARCHAR(50),
    DB VARCHAR(50),
    Address VARCHAR(100),
    Phone_NO VARCHAR(20)
)
CREATE TABLE Employee_Customers (
    Employee_ID INT,
    C_ID INT,
    Opening_Accounts BIT,       -- 1 = yes, 0 = no
    Processing_Loans BIT,
    PRIMARY KEY (Employee_ID, C_ID),
    FOREIGN KEY (Employee_ID) REFERENCES Employees(Employee_ID),
    FOREIGN KEY (C_ID) REFERENCES Customers(C_ID)
)
CREATE TABLE Loans (
    L_ID INT PRIMARY KEY,
    Type VARCHAR(50),
    Amount DECIMAL(15,2),
    Date DATE,
    Employee_ID INT,
    C_ID INT,
    FOREIGN KEY (Employee_ID) REFERENCES Employees(Employee_ID),
    FOREIGN KEY (C_ID) REFERENCES Customers(C_ID)
)
CREATE TABLE Accounts (
    Account_Number INT PRIMARY KEY,
    Savings DECIMAL(15,2),
    Checking DECIMAL(15,2),
    Date_of_Creation DATE,
    Balance DECIMAL(15,2),
    C_ID INT,
    FOREIGN KEY (C_ID) REFERENCES Customers(C_ID)
)
CREATE TABLE Transactions (
    Transaction_ID INT PRIMARY KEY,
    Date DATE,
    Amount DECIMAL(15,2),
    Withdrawals DECIMAL(15,2),
    Deposits DECIMAL(15,2),
    Transfers DECIMAL(15,2),
    Account_Number INT,
    FOREIGN KEY (Account_Number) REFERENCES Accounts(Account_Number)
)
INSERT INTO Branches (Branch_ID, Phone_Number, Address) VALUES
(1, '912345678', '123 Main St, Muscat'),
(2, '923456789', '45 Al Khuwair, Muscat'),
(3, '934567890', '78 Seeb Road, Muscat'),
(4, '945678901', '12 Ruwi St, Muscat'),
(5, '956789012', '34 Bousher Rd, Muscat')

INSERT INTO Employees (Employee_ID, Position, Name, Branch_ID) VALUES
(101, 'Manager', 'Ahmed Ali', 1),
(102, 'Teller', 'Fatma Salim', 2),
(103, 'Loan Officer', 'Hassan Khalid', 3),
(104, 'Cashier', 'Aisha Mohammed', 4),
(105, 'Clerk', 'Omar Said', 5)

INSERT INTO Customers (C_ID, C_Name, DB, Address, Phone_NO) VALUES
(201, 'Sami Omar', 'DB001', '12 Al Hail, Muscat', '901234567'),
(202, 'Laila Said', 'DB002', '34 Al Khoud, Muscat', '912345678'),
(203, 'Yousef Ahmed', 'DB003', '56 Ruwi, Muscat', '923456789'),
(204, 'Nora Khalid', 'DB004', '78 Seeb, Muscat', '934567890'),
(205, 'Salim Hassan', 'DB005', '90 Bousher, Muscat', '945678901')

INSERT INTO Employee_Customers (Employee_ID, C_ID, Opening_Accounts, Processing_Loans) VALUES
(101, 201, 1, 0),
(102, 202, 1, 1),
(103, 203, 0, 1),
(104, 204, 1, 0),
(105, 205, 0, 1)


INSERT INTO Loans (L_ID, Type, Amount, Date, Employee_ID, C_ID) VALUES
(301, 'Personal', 5000, '2025-01-10', 103, 203),
(302, 'Home', 150000, '2025-02-15', 103, 201),
(303, 'Car', 25000, '2025-03-20', 105, 205),
(304, 'Education', 10000, '2025-04-05', 102, 202),
(305, 'Business', 50000, '2025-05-12', 101, 204)

INSERT INTO Accounts (Account_Number, Savings, Checking, Date_of_Creation, Balance, C_ID) VALUES
(401, 5000, 2000, '2025-01-01', 7000, 201),
(402, 10000, 5000, '2025-01-10', 15000, 202),
(403, 2000, 3000, '2025-02-05', 5000, 203),
(404, 7000, 1000, '2025-03-12', 8000, 204),
(405, 12000, 4000, '2025-04-20', 16000, 205)

INSERT INTO Transactions (Transaction_ID, Date, Amount, Withdrawals, Deposits, Transfers, Account_Number) VALUES
(501, '2025-01-15', 1000, 500, 500, 0, 401),
(502, '2025-02-20', 2000, 0, 2000, 0, 402),
(503, '2025-03-10', 500, 0, 500, 0, 403),
(504, '2025-04-05', 1500, 500, 1000, 0, 404),
(505, '2025-05-12', 3000, 1000, 2000, 0, 405)

--Display all customer records
SELECT * FROM Customers

--Display customer full name, phone, and membership start date.
SELECT c.C_Name, c.Phone_NO, a.Date_of_Creation AS Membership_Start_Date
FROM Customers c
JOIN Accounts a ON c.C_ID = a.C_ID

-- Display each loan ID, amount, and type.
SELECT L_ID, Amount, Type FROM Loans

-- Display account number and annual interest (5% of balance) as AnnualInterest.
SELECT Account_Number, Balance * 0.05 AS AnnualInterest
FROM Accounts

-- List customers with loan amounts greater than 100000 LE.
SELECT c.C_Name, l.Amount
FROM Customers c
JOIN Loans l ON c.C_ID = l.C_ID
WHERE l.Amount > 100000

-- List accounts with balances above 2000
SELECT Account_Number, Balance
FROM Accounts
WHERE Balance > 2000

-- Display accounts opened in 2023.
SELECT * FROM Accounts
WHERE YEAR(Date_of_Creation) = 2023

--Display accounts ordered by balance descending.
SELECT * FROM Accounts
ORDER BY Balance DESC

-- Display the maximum, minimum, and average account balance.
SELECT MAX(Balance) AS MaxBalance, MIN(Balance) AS MinBalance, AVG(Balance) AS AvgBalance
FROM Accounts
--Display total number of customers.
SELECT COUNT(*) AS TotalCustomers
FROM Customers
-- Display customers with NULL phone numbers.
SELECT * FROM Customers
WHERE Phone_NO IS NULL

-- Insert yourself as a new customer and open an account with balance 10000.
INSERT INTO Customers (C_ID, C_Name, DB, Address, Phone_NO)
VALUES (206, 'Shima AlSharqi', 'DB006', 'Muscat, Oman', '912345679')

INSERT INTO Accounts (Account_Number, Savings, Checking, Date_of_Creation, Balance, C_ID)
VALUES (406, 5000, 5000, GETDATE(), 10000, 206)

-- Insert another customer with NULL phone and address.
INSERT INTO Customers (C_ID, C_Name, DB, Address, Phone_NO)
VALUES (207, 'Ali Hassan', 'DB007', NULL, NULL)
--Increase your account balance by 20%.
UPDATE Accounts
SET Balance = Balance * 1.20
WHERE C_ID = 206
--Increase balance by 5% for accounts with balance less than 5000.
UPDATE Accounts
SET Balance = Balance * 1.05
WHERE Balance < 5000

-- Update phone number to 'Not Provided' where phone is NULL.
UPDATE Customers
SET Phone_NO = 'Not Provided'
WHERE Phone_NO IS NULL
-- Delete closed accounts
DELETE FROM Accounts
WHERE Balance = 0