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


--Display all books whose titles start with 'S'. 
Select 
title
from books
where title like 'S%'

--List members who borrowed books priced between 100 and 300 LE.  
Select 
m.full_name,b.price
from members m
join review r
ON m.M_ID=r.M_ID
join books b
ON  r.B_ID= b.B_ID
where b.price between 10 and 30

--Retrieve members who borrowed and returned books titled 'SQL Guide '

select
m.full_name,r.status,b.title
from members m
join loan r
ON m.M_ID=r.M_ID
join books b 
ON b.B_ID= r.B_ID
where r.status  = 'Returned' and b.title = 'SQL Guide'

--Find all members assisted by librarian "Sarah Fathy".

SELECT 
    m.M_ID,
    m.full_name,
    m.email,
    m.phone_number,
    m.MembershipStartDate
FROM Staff s
JOIN librarys l
    ON s.L_ID = l.L_ID
JOIN books b
    ON b.L_ID = l.L_ID
JOIN loan lo
    ON lo.B_ID = b.B_ID
JOIN members m
    ON m.M_ID = lo.M_ID
WHERE s.full_name = 'Fatma Said'
  AND s.position = 'Librarian'

  --Display each member’s name and the books they borrowed, ordered by book title. 
SELECT
    m.full_name, 
    b.title 
FROM members m
JOIN loan l
    ON m.M_ID = l.M_ID
JOIN books b
    ON l.B_ID = b.B_ID
ORDER BY b.title

-- For each book located in 'Muscat', show title, library name, manager, and shelf info
select * from books
select * from librarys
Select 
b.title,b.shelf_location,l.L_name,s.position
from books b
join librarys l
ON b.L_ID = l.L_ID
join Staff s
ON s.L_ID = l.L_ID
where L_location = 'Muscat' and s.position = 'manager'

--Display all staff members who manage libraries. 
SELECT
    S_ID,
    full_name,
    position,
    s_contact_number,
    L_ID
FROM Staff
WHERE position = 'Manager'

--Display all members and their reviews, even if some didn’t submit any review yet.
SELECT
    m.M_ID,
    m.full_name,
    m.email,
    r.R_ID,
    r.Review_Date,
    r.comments,
    r.rating,
    r.B_ID
FROM members m
LEFT JOIN review r
    ON m.M_ID = r.M_ID
ORDER BY m.M_ID