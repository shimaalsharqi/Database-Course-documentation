--Display branch ID, name, and the name of the employee who manages it. 
SELECT B.Branch_ID, B.Address AS Branch_Name, E.Name AS Manager_Name
FROM Branches B
JOIN Employees E 
    ON B.Branch_ID = E.Branch_ID
WHERE E.Position = 'Manager'

--Display branch names and the accounts opened under each.
SELECT 
    B.Address AS Branch_Name,
    A.Account_Number
FROM Branches B
JOIN Employees E 
    ON B.Branch_ID = E.Branch_ID
JOIN Employee_Customers EC 
    ON E.Employee_ID = EC.Employee_ID
JOIN Accounts A 
    ON EC.C_ID = A.C_ID

--Display full customer details along with their loans. 
SELECT 
    C.C_ID,
    C.C_Name,
    C.DB,
    C.Address,
    C.Phone_NO,
    L.L_ID,
    L.Type,
    L.Amount,
    L.Date
FROM Customers C
Left JOIN Loans L
    ON C.C_ID = L.C_ID

--Display loan records where the loan office is in 'Seeb' or 'Ruwi'. 
SELECT 
    L.L_ID,
    L.Type,
    L.Amount,
    L.Date,
    B.Address AS Branch_Address
FROM Loans L
JOIN Employees E 
    ON L.Employee_ID = E.Employee_ID
JOIN Branches B 
    ON E.Branch_ID = B.Branch_ID
WHERE B.Address LIKE '%Seeb%'
   OR B.Address LIKE '%Ruwi%'

 --Display account data where the type starts with "S" (e.g., "Savings").
 Select * from Accounts 
 where Accounts_type like 'S%'

 --List customers with accounts having between 2000 and 5000
 select 
 b.Balance,c.C_Name
 from  Customers c
 join Accounts b
 ON b.C_ID=c.C_ID
 where b.Balance between 2000 and 5000
 
 --Retrieve customer names who borrowed more than 100,000 LE from 'Cairo Main Branch'. 
 SELECT 
    C.C_Name
FROM Customers C
JOIN Loans L
    ON C.C_ID = L.C_ID
JOIN Employees E
    ON L.Employee_ID = E.Employee_ID
JOIN Branches B
    ON E.Branch_ID = B.Branch_ID
WHERE L.Amount > 1000
  AND B.Address like '%Muscat%'

  --Find all customers assisted by employee "Omar Said". 
  SELECT 
    C.C_ID,
    C.C_Name
FROM Employees E
JOIN Employee_Customers EC
    ON E.Employee_ID = EC.Employee_ID
JOIN Customers C
    ON EC.C_ID = C.C_ID
WHERE E.Name = 'Omar Said'

--Display each customer’s name and the accounts they hold, sorted by account type 
SELECT 
    C.C_Name,
    A.Account_Number,
    CASE 
        WHEN A.Savings > 0 THEN 'Savings'
        WHEN A.Checking > 0 THEN 'Checking'
    END AS Account_Type
FROM Customers C
JOIN Accounts A
    ON C.C_ID = A.C_ID
ORDER BY Account_Type

--For each loan issued in Muscat, show loan ID, customer name, employee handling it, and branch name.
SELECT 
    L.L_ID,
    C.C_Name AS Customer_Name,
    E.Name AS Employee_Name,
    B.Address AS Branch_Name
FROM Loans L
JOIN Customers C 
    ON L.C_ID = C.C_ID
JOIN Employees E
    ON L.Employee_ID = E.Employee_ID
JOIN Branches B
    ON E.Branch_ID = B.Branch_ID
WHERE B.Address LIKE '%Muscat%'

-- Display all employees who manage any branch
SELECT * FROM Employees 
WHERE Position = 'Manager'

--Display all customers and their transactions, even if some customers have no transactions yet
SELECT 
    C.C_ID,
    C.C_Name,
    T.*,
    A.Account_Number
FROM Customers C
LEFT JOIN Accounts A
    ON C.C_ID = A.C_ID
LEFT JOIN Transactions T
    ON A.Account_Number = T.Account_Number