--Display hotel ID, name, and the name of its manager. 

select
b.branch_id,b.name,s.s_name 
from Branches b
join staff s
ON b.branch_id=s.branch_id
where s.job_title  = 'manager'

-- 2. Display hotel names and the rooms available under them.
SELECT b.name AS HotelName,
       r.room_number,
       r.type,
       r.nightly_rate
FROM Branches b
JOIN Rooms r ON b.branch_id = r.branch_id
JOIN Rooms_Booking rb ON r.room_number = rb.room_number
WHERE rb.availability = 'Available'

--3. Display guest data along with the bookings they made.
SELECT c.c_id,
       c.c_name,
       c.phone,
       c.email,
       b.id_booking,
       b.check_in,
       b.check_out
FROM Customer c
LEFT JOIN Booking b ON c.c_id = b.c_id
-- Display bookings for hotels in 'Muscat' or 'Salalah'.
SELECT b.id_booking,
       b.check_in,
       b.check_out,
       c.c_name,
       br.name AS BranchName,
       br.location
FROM Booking b
JOIN Customer c ON b.c_id = c.c_id
JOIN Rooms_Booking rb ON b.id_booking = rb.id_booking
JOIN Rooms r ON rb.room_number = r.room_number
JOIN Branches br ON r.branch_id = br.branch_id
WHERE br.location IN ('Muscat', 'Salalah')

-- Display all room records where room type starts with "S" (e.g., "Suite", "Single").
SELECT *
FROM Rooms
WHERE type LIKE 'S%'

-- List guests who booked rooms priced between 1500 and 2500 LE.
SELECT  c.c_id,
       c.c_name,
       c.phone,
       c.email
FROM Customer c
JOIN Booking b ON c.c_id = b.c_id
JOIN Rooms_Booking rb ON b.id_booking = rb.id_booking
JOIN Rooms r ON rb.room_number = r.room_number
WHERE r.nightly_rate BETWEEN 1500 AND 2500
-- Retrieve guest names who have bookings marked as 'Booked' in hotel "Main Branch".
SELECT  c.c_name
FROM Customer c
JOIN Booking b ON c.c_id = b.c_id
JOIN Rooms_Booking rb ON b.id_booking = rb.id_booking
JOIN Rooms r ON rb.room_number = r.room_number
JOIN Branches br ON r.branch_id = br.branch_id
WHERE rb.availability = 'Booked'
  AND br.name = 'Main Branch'
  -- Find guests whose bookings were handled by staff member "Mona Saleh".
SELECT  c.c_id,
       c.c_name,
       c.phone,
       c.email
FROM Customer c
JOIN Booking b ON c.c_id = b.c_id
JOIN Staff_Booking sb ON b.id_booking = sb.id_booking
JOIN Staff s ON sb.s_id = s.s_id
WHERE s.s_name = 'Mona Saleh'

-- Display each guest’s name and the rooms they booked, ordered by room type.
SELECT c.c_name,
       r.room_number,
       r.type AS RoomType,
       r.nightly_rate
FROM Customer c
JOIN Booking b ON c.c_id = b.c_id
JOIN Rooms_Booking rb ON b.id_booking = rb.id_booking
JOIN Rooms r ON rb.room_number = r.room_number
ORDER BY r.type
-- For each hotel in 'Muscat', display hotel ID, name, manager name, and contact info.
SELECT b.branch_id AS HotelID,
       b.name AS HotelName,
       s.s_name AS ManagerName,
       s.salary AS ManagerSalary
FROM Branches b
JOIN Staff s ON b.branch_id = s.branch_id
WHERE b.location = 'Muscat'
  AND s.job_title = 'Manager'

  -- Display all staff members who hold 'Manager' positions.
SELECT *
FROM Staff
WHERE job_title = 'Manager'

-- Display all guests and their bookings, even if some guests haven't made any bookings.
SELECT c.c_id,
       c.c_name,
       c.phone,
       c.email,
       b.id_booking,
       b.check_in,
       b.check_out
FROM Customer c
LEFT JOIN Booking b ON c.c_id = b.c_id