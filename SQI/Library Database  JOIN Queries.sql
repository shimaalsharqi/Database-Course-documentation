--Display library ID, name, and the name of the manager. 
select
l.L_ID,l.L_name,s.full_name
from librarys l
join Staff s
ON l.L_ID=s.L_ID

--Display library names and the books available in each one
select
l.L_name,b.availability_status
from  books b
join librarys l
ON l.L_ID=b.L_ID

--Display all member data along with their loan history. 
SELECT 
    m.M_ID,
    m.full_name,
    m.email,
    m.phone_number,
    m.MembershipStartDate,
    l.loan_ID,
    l.loan_date,
    l.Due_Date,
    l.return_date,
    l.status,
    l.B_ID
FROM members m
LEFT JOIN loan l
    ON m.M_ID = l.M_ID
ORDER BY m.M_ID, l.loan_date

--Display all books located in 'Zamalek' or 'Downtown'. 
SELECT 
    b.B_ID,
    b.Book_ISBN,
    b.title,
    b.shelf_location,
    b.availability_status,
    b.price,
    b.genre,
    l.L_name,
    l.L_location
FROM books b
JOIN librarys l
    ON b.L_ID = l.L_ID
WHERE l.L_location IN ('Sur', 'Sohar')