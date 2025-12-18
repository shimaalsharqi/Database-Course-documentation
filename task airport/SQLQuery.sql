create database airport_system
use airport_system

create table airport 
(
airport_code varchar(20) primary key not null,
city varchar(20),
a_state varchar(20),
a_name varchar(20)
)
create table AIRPLANE_TYPE
(
type_name varchar(20) primary key not null,
company  varchar(20),
max_seats int
)
create table Airplane
(
airplane_id int primary key identity(1,1),
total_seats int,
type_name varchar(20),
foreign key (type_name) references AIRPLANE_TYPE(type_name)
)
create table FLIGHT 
(
flight_no int primary key identity(1,1),
restrictions varchar(20),
airline varchar(20),
weekdays varchar(20)
)
create table FLIGHT_LEG
(
leg_no int primary key identity(1,1),
flight_no int,
airport_code varchar(20),
foreign key (flight_no) references FLIGHT(flight_no),
foreign key (airport_code) references airport(airport_code)
)
create table LEG_INSTANCE
(
L_date date primary key not null,
Departure_time time,
NAS int,
Arrival_time time,
leg_no int,
airplane_id int,
foreign key (leg_no) references FLIGHT_LEG(leg_no),
foreign key (airplane_id) references Airplane(airplane_id)
)
create table customer
(
customer_id int primary key identity(1,1),
customer_name varchar(20),
phone varchar(20)
)
create table RESERVATION
(
RESERVATION_id int primary key identity(1,1),
R_date date,
Seat_NO varchar(20),
customer_id int,
foreign key (customer_id) references customer(customer_id)
)
create table fares
(
Code varchar(20) primary key not null,
Amount decimal(8,3),
flight_no int,
foreign key (flight_no) references FLIGHT(flight_no)
)
INSERT INTO airport (airport_code, city, a_state, a_name)
VALUES
('MCT', 'Muscat', 'Muscat', 'Muscat International'),
('SLL', 'Salalah', 'Dhofar', 'Salalah Airport'),
('BAH', 'Bahrain', 'Bahrain', 'Bahrain Airport')
select * from airport

INSERT INTO AIRPLANE_TYPE (type_name, company, max_seats)
VALUES
('Boeing737', 'Boeing', 180),
('AirbusA320', 'Airbus', 150);

select * from AIRPLANE_TYPE
INSERT INTO Airplane (total_seats, type_name)
VALUES
(180, 'Boeing737'),
(150, 'AirbusA320');

select * from Airplane

INSERT INTO FLIGHT (restrictions, airline, weekdays)
VALUES
('None', 'Oman Air', 'Mon,Wed,Fri'),
('None', 'Gulf Air', 'Tue,Thu,Sat')

select * from FLIGHT
INSERT INTO FLIGHT_LEG (flight_no, airport_code)
VALUES
(1, 'MCT'), -- departure
(1, 'SLL'), -- arrival
(2, 'SLL'), -- departure
(2, 'BAH'); -- arrival

select * from FLIGHT_LEG
INSERT INTO LEG_INSTANCE (L_date, Departure_time, NAS, Arrival_time, leg_no, airplane_id)
VALUES
('2025-12-20', '08:00', 0, '10:00', 1, 1),
('2025-12-21', '12:00', 0, '14:00', 2, 1),
('2025-12-22', '09:00', 0, '11:00', 3, 2),
('2025-12-23', '13:00', 0, '15:00', 4, 2);

select * from LEG_INSTANCE
INSERT INTO customer (customer_name, phone)
VALUES
('Ahmed Ali', '+96891234567'),
('Fatima Hassan', '+96892345678'),
('Mohammed Saleh', '+96893456789');
select * from customer
INSERT INTO RESERVATION (R_date, Seat_NO, customer_id)
VALUES
('2025-12-20', '1A', 1),
('2025-12-20', '1B', 2),
('2025-12-21', '2A', 3);

select * from RESERVATION
INSERT INTO fares (Code, Amount, flight_no)
VALUES
('F001', 150.000, 1),
('F002', 200.000, 2);

select * from fares


-- 1. Airports
SELECT * FROM airport;

-- 2. Airplane Types
SELECT * FROM AIRPLANE_TYPE;

-- 3. Airplanes
SELECT * FROM Airplane;

-- 4. Flights
SELECT * FROM FLIGHT;

-- 5. Flight Legs
SELECT * FROM FLIGHT_LEG;

-- 6. Leg Instances
SELECT * FROM LEG_INSTANCE;

-- 7. Customers
SELECT * FROM customer;

-- 8. Reservations
SELECT * FROM RESERVATION;

-- 9. Fares
SELECT * FROM fares;

--1. Display all flight leg records.
SELECT * FROM FLIGHT_LEG
--2. Display each flight leg ID, scheduled departure time, and arrival time.
SELECT 
    FL.leg_no AS Flight_Leg_ID,
    LI.Departure_time,
    LI.Arrival_time
FROM FLIGHT_LEG FL
JOIN LEG_INSTANCE LI
    ON FL.leg_no = LI.leg_no
	
--3. Display each airplane’s ID, type, and seat capacity
SELECT 
    A.airplane_id,
    A.type_name,
    AT.max_seats AS seat_capacity
FROM Airplane A
JOIN AIRPLANE_TYPE AT
    ON A.type_name = AT.type_name

--4. Display each flight leg’s ID and available seats as AvailableSeats.
SELECT 
    leg_no AS FlightLegID,
    NAS AS AvailableSeats
FROM LEG_INSTANCE

--5. List flight leg IDs with available seats greater than 100.
SELECT 
    leg_no AS FlightLegID,
    NAS AS AvailableSeats
FROM LEG_INSTANCE
WHERE NAS > 100

--6. List airplane IDs with seat capacity above 300
SELECT airplane_id
FROM Airplane
WHERE total_seats > 300

--7. Display airport codes and names where city = 'Cairo'
SELECT airport_code, a_name
FROM airport
WHERE city = 'Cairo'
--8 Display flight legs scheduled on 2025-06-10
SELECT * 
FROM LEG_INSTANCE
WHERE L_date = '2025-06-10'
--9. Display flight legs ordered by departure time.
SELECT * 
FROM LEG_INSTANCE
ORDER BY Departure_time

--10. Display the maximum, minimum, and average available seats.
SELECT 
    MAX(NAS) AS MaxAvailableSeats,
    MIN(NAS) AS MinAvailableSeats,
    AVG(NAS) AS AvgAvailableSeats
FROM LEG_INSTANCE

--11. Display total number of flight legs.
SELECT COUNT(*) AS TotalFlightLegs
FROM FLIGHT_LEG
--12. Display airplanes whose type contains 'Boeing'.
SELECT * 
FROM Airplane
WHERE type_name LIKE '%Boeing%'

--13. Insert a new flight leg departing from 'CAI' to 'DXB' on 2025-06-10.
INSERT INTO airport (airport_code, city, a_state, a_name)
VALUES ('CAI', 'Cairo', 'Cairo', 'Cairo Airport'),
       ('DXB', 'Dubai', 'Dubai', 'Dubai Airport');

-- Insert a new flight
INSERT INTO FLIGHT (restrictions, airline, weekdays)
VALUES ('None', 'Emirates', 'Tue,Thu');

-- Assume the new flight_no is 3 (or get the latest with IDENT_CURRENT)
INSERT INTO FLIGHT_LEG (flight_no, airport_code)
VALUES (3, 'CAI'), -- departure
       (3, 'DXB'); -- arrival

-- Insert LEG_INSTANCE for departure
INSERT INTO LEG_INSTANCE (L_date, Departure_time, NAS, Arrival_time, leg_no, airplane_id)
VALUES ('2025-06-10', '09:00', 180, '12:00', 5, 1),  -- departure leg
       ('2025-06-10', '09:00', 180, '12:00', 6, 1);  -- arrival leg
--14. Insert a customer with NULL contact number.
INSERT INTO customer (customer_name, phone)
VALUES ('Sara Ahmed', NULL)
--15. Reduce available seats of your inserted flight leg by 5.
UPDATE LEG_INSTANCE
SET NAS = NAS - 5
WHERE leg_no IN (5, 6)
--16. Increase available seats by 10 for all domestic flights.
UPDATE LEG_INSTANCE LI
SET NAS = NAS + 10
FROM LEG_INSTANCE LI
JOIN FLIGHT_LEG FL ON LI.leg_no = FL.leg_no
JOIN airport A ON FL.airport_code = A.airport_code
WHERE A.city IN ('Muscat', 'Salalah')
--17. Update airplane seat capacity by +20 where capacity < 150.
UPDATE Airplane
SET total_seats = total_seats + 20
WHERE total_seats < 150
--18. Delete canceled flight legs.
DELETE FROM LEG_INSTANCE
WHERE NAS = 0