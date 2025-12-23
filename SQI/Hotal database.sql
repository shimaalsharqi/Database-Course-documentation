create database HotalDB
use HotalDB
CREATE TABLE Branches (
    branch_id INT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    location VARCHAR(50) NOT NULL
);
CREATE TABLE Staff (
    s_id INT PRIMARY KEY,
    s_name VARCHAR(50) NOT NULL,
    job_title VARCHAR(50),
    salary DECIMAL(10,2),
    branch_id INT,

    FOREIGN KEY (branch_id)
        REFERENCES Branches(branch_id)
);
CREATE TABLE Customer (
    c_id INT PRIMARY KEY,
    c_name VARCHAR(50) NOT NULL,
    phone VARCHAR(20),
    email VARCHAR(100)
);
CREATE TABLE Booking (
    id_booking INT PRIMARY KEY,
    check_in DATE NOT NULL,
    check_out DATE NOT NULL,
    c_id INT,

    FOREIGN KEY (c_id)
        REFERENCES Customer(c_id)
);
CREATE TABLE Rooms (
    room_number INT PRIMARY KEY,
    type VARCHAR(30),
    nightly_rate DECIMAL(10,2),
    branch_id INT,

    FOREIGN KEY (branch_id)
        REFERENCES Branches(branch_id)
);
CREATE TABLE Rooms_Booking (
    room_number INT,
    id_booking INT,
    availability VARCHAR(20),

    PRIMARY KEY (room_number, id_booking),

    FOREIGN KEY (room_number)
        REFERENCES Rooms(room_number),

    FOREIGN KEY (id_booking)
        REFERENCES Booking(id_booking)
);
CREATE TABLE Staff_Booking (
    s_id INT,
    id_booking INT,

    PRIMARY KEY (s_id, id_booking),

    FOREIGN KEY (s_id)
        REFERENCES Staff(s_id),

    FOREIGN KEY (id_booking)
        REFERENCES Booking(id_booking)
);
INSERT INTO Branches VALUES
(1, 'Main Branch', 'Muscat'),
(2, 'City Branch', 'Salalah'),
(3, 'Airport Branch', 'Muscat Airport'),
(4, 'Beach Branch', 'Sur'),
(5, 'Mall Branch', 'Sohar');
INSERT INTO Staff VALUES
(101, 'Ahmed Ali', 'Manager', 1200.00, 1),
(102, 'Sara Omar', 'Receptionist', 700.00, 1),
(103, 'Khalid Hassan', 'Supervisor', 900.00, 2),
(104, 'Mona Saleh', 'Receptionist', 650.00, 3),
(105, 'Yousef Said', 'Accountant', 1000.00, 4);
INSERT INTO Customer VALUES
(201, 'Ali Nasser', '91234567', 'ali@gmail.com'),
(202, 'Fatma Said', '92345678', 'fatma@gmail.com'),
(203, 'Hassan Noor', '93456789', 'hassan@gmail.com'),
(204, 'Aisha Salem', '94567890', 'aisha@gmail.com'),
(205, 'Omar Khalid', '95678901', 'omar@gmail.com');
INSERT INTO Booking VALUES
(301, '2025-01-10', '2025-01-15', 201),
(302, '2025-02-01', '2025-02-05', 202),
(303, '2025-03-10', '2025-03-12', 203),
(304, '2025-04-20', '2025-04-25', 204),
(305, '2025-05-01', '2025-05-03', 205);
INSERT INTO Rooms VALUES
(401, 'Single', 35.00, 1),
(402, 'Double', 50.00, 1),
(403, 'Suite', 120.00, 2),
(404, 'Single', 40.00, 3),
(405, 'Double', 55.00, 4);
INSERT INTO Rooms_Booking VALUES
(401, 301, 'Available'),
(402, 301, 'Booked'),
(403, 302, 'Booked'),
(404, 303, 'Available'),
(405, 304, 'Booked');
INSERT INTO Staff_Booking VALUES
(101, 301),
(102, 301),
(103, 302),
(104, 303),
(105, 304);

-- 1. Display all guest records.
SELECT * FROM Customer;

-- 2. Display each guest’s name, contact number, and email.
SELECT c_name, phone, email FROM Customer;

-- 3. Display all bookings with check-in and check-out dates.
SELECT id_booking, check_in, check_out, c_id FROM Booking;

-- 4. Display each room number and its price per night as NightlyRate.
SELECT room_number, nightly_rate AS NightlyRate FROM Rooms;

-- 5. List rooms priced above 100 per night.
SELECT * FROM Rooms WHERE nightly_rate > 100;

-- 6. Display staff members working as 'Receptionist'.
SELECT * FROM Staff WHERE job_title = 'Receptionist';

-- 7. Display bookings made in 2024.
SELECT * FROM Booking WHERE YEAR(check_in) = 2024;

-- 8. Display bookings ordered by total cost descending.
-- (Assuming total cost = nightly_rate * number of nights)
SELECT b.id_booking, SUM(DATEDIFF(day, b.check_in, b.check_out) * r.nightly_rate) AS TotalCost
FROM Booking b
JOIN Rooms_Booking rb ON b.id_booking = rb.id_booking
JOIN Rooms r ON rb.room_number = r.room_number
GROUP BY b.id_booking
ORDER BY TotalCost DESC;

-- 9. Display the maximum, minimum, and average room price.
SELECT MAX(nightly_rate) AS MaxPrice, MIN(nightly_rate) AS MinPrice, AVG(nightly_rate) AS AvgPrice
FROM Rooms;

-- 10. Display total number of rooms.
SELECT COUNT(*) AS TotalRooms FROM Rooms;

-- 11. Display guests whose names start with 'M'.
SELECT * FROM Customer WHERE c_name LIKE 'M%';

-- 12. Display rooms priced between 80 and 150 per night.
SELECT * FROM Rooms WHERE nightly_rate BETWEEN 80 AND 150;

-- 13. Insert yourself as a guest (Guest ID = 9011).
INSERT INTO Customer (c_id, c_name, phone, email)
VALUES (9013, 'Your Name', '99999999', 'yourmail@example.com');

-- 14. Create a booking for room 205.
-- (Assuming booking ID = 901 and guest ID = 9011)

INSERT INTO Rooms_Booking (room_number, id_booking, availability)
VALUES (405, 902, 'Booked');

-- 15. Insert another guest with NULL contact and email.
INSERT INTO Customer (c_id, c_name, phone, email)
VALUES (9012, 'Guest Two', NULL, NULL);

-- 16. Update your booking to change check-out date.
UPDATE Booking
SET check_out = '2025-12-31'
WHERE id_booking = 901;

-- 17. Increase nightly rates by 10% for 'Suite' rooms (luxury rooms).
UPDATE Rooms
SET nightly_rate = nightly_rate * 1.10
WHERE type = 'Suite';

-- 18. Update bookings to extend check-out by 1 day for past bookings.
UPDATE Booking
SET check_out = DATEADD(day, 1, check_out)
WHERE check_out < GETDATE();

-- 19. Delete bookings that have no rooms assigned.
DELETE FROM Booking
WHERE id_booking NOT IN (SELECT id_booking FROM Rooms_Booking);