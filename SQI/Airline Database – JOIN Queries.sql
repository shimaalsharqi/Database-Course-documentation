--Display each flight leg's ID, schedule, and the name of the airplane assigned to it
select
f.leg_no,s.L_date,a.type_name,s.Arrival_time,Departure_time
from  FLIGHT_LEG f
join LEG_INSTANCE s
ON f.leg_no=s.leg_no
join Airplane a
ON a.airplane_id=s.airplane_id
--Display all flight numbers and the names of the departure and arrival airports. 
SELECT
    f.flight_no,
    a1.a_name AS DepartureAirport,
    a2.a_name AS ArrivalAirport
FROM Flight f
JOIN Flight_Leg fl_dep
    ON f.flight_no = fl_dep.flight_no
JOIN Flight_Leg fl_arr
    ON f.flight_no = fl_arr.flight_no
JOIN Airport a1
    ON fl_dep.airport_code = a1.airport_code
JOIN Airport a2
    ON fl_arr.airport_code = a2.airport_code

--Display all reservation data with the name and phone of the customer who made each booking
select 
r.*,c.phone,c.customer_name
from RESERVATION r
join customer c
ON r.customer_id=c.customer_id

--Display IDs and locations of flights departing from 'CAI' or 'DXB'. 
SELECT 
    f.flight_no   AS FlightID,
    a.city        AS DepartureLocation
FROM Flight f
JOIN Flight_Leg fl
    ON f.flight_no = fl.flight_no
JOIN Airport a
    ON fl.airport_code = a.airport_code
	where fl.airport_code IN ('CAI', 'DXB')
--5. Display full data of flights whose airline start with 'O'. 
SELECT *
FROM Flight
WHERE airline LIKE 'O%'

--Find names of passengers whose booking was handled by agent "Ahmed Ali" ,,,Find names of passengers who have made a reservation(i will change the Q to match with my SQL)
SELECT c.customer_name
FROM customer c
JOIN RESERVATION r ON c.customer_id = r.customer_id
--For each flight departing from 'Cairo', display the flight number, departure time, and airline name dateFor each flight departing from 'Muscat', display the flight number, departure time, airline name, and flight date
--(i will change the Q to match with my SQL). 
SELECT f.flight_no, li.Departure_time, f.airline, li.L_date
FROM FLIGHT f
JOIN FLIGHT_LEG fl ON f.flight_no = fl.flight_no
JOIN LEG_INSTANCE li ON fl.leg_no = li.leg_no
JOIN airport a ON fl.airport_code = a.airport_code
WHERE a.city = 'Muscat'
--Display all staff members who are assigned as supervisors for flights..Display all passengers who have a reservation, even if some of them have not booked a seat yet.((change the Q to match with my SQL)
SELECT c.customer_name, r.RESERVATION_id, r.Seat_NO
FROM customer c
LEFT JOIN RESERVATION r ON c.customer_id = r.customer_id
--Display all bookings and their related passengers, even if some bookings are unpaid..Display all bookings and their related passengers, even if some bookings are unpaid(change the Q to match with my SQL)
SELECT r.RESERVATION_id, r.R_date, r.Seat_NO, c.customer_name
FROM RESERVATION r
LEFT JOIN customer c ON r.customer_id = c.customer_id