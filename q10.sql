Create table Trips (id int, client_id int, driver_id int, city_id int, status varchar(50), request_at varchar(50)); 
Create table Users1 (users_id int, banned varchar(50), role varchar(50)); Truncate table Trips; 
insert into Trips values 
('1', '1', '10', '1', 'completed', '2013-10-01'), ('2', '2', '11', '1', 'cancelled_by_driver', '2013-10-01'),
('3', '3', '12', '6', 'completed', '2013-10-01'), ('4', '4', '13', '6', 'cancelled_by_client', '2013-10-01'), 
('5', '1', '10', '1', 'completed', '2013-10-02'), ('6', '2', '11', '6', 'completed', '2013-10-02'),
('7', '3', '12', '6', 'completed', '2013-10-02'), ('8', '2', '12', '12', 'completed', '2013-10-03'), 
('9', '3', '10', '12', 'completed', '2013-10-03'), ('10', '4', '13', '12', 'cancelled_by_driver', '2013-10-03');
insert into Users1 values 
('1', 'No', 'client'), ('2', 'Yes', 'client'), ('3', 'No', 'client'),
('4', 'No', 'client'), ('10', 'No', 'driver'), ('11', 'No', 'driver'), 
('12', 'No', 'driver'),  ('13', 'No', 'driver');

SELECT * FROM trips;
SELECT * FROM users1;

/* Find the cancellation rate of requests with unbanned users (both clients and driver must not be banned) each day between '2013-10-01' and '2013-10-03'. round cancellation rate to two decimal points.
the cancellation rate is computed by dividing the number of canceled (client/driver) requests with unbanned users by the total number of requests with unbanned users on that day. */

SELECT request_at, 
COUNT(CASE WHEN STATUS IN ('cancelled_by_client','cancelled_by_driver')
		THEN 1 ELSE NULL END) AS cancelled_trip_count,
COUNT(1) AS total_trips,
COUNT(CASE WHEN STATUS IN ('cancelled_by_client','cancelled_by_driver')
		THEN 1 ELSE NULL END) / COUNT(1)  AS cancelled_percent 
FROM trips t
INNER JOIN users1 u ON t.client_id = u.users_id -- banned users
INNER JOIN users1 us ON t.driver_id = us.users_id -- banned driver
WHERE u.banned = 'No' AND us.banned = 'No'
GROUP BY request_at
;


SELECT request_at AS Day, 
       ROUND( COUNT(CASE WHEN STATUS IN ('cancelled_by_client','cancelled_by_driver')
                        THEN 1 ELSE NULL END) / COUNT(1) , 2) AS 'Cancellation Rate' 
FROM trips t
INNER JOIN users u ON t.client_id = u.users_id -- banned users
INNER JOIN users us ON t.driver_id = us.users_id -- banned driver
WHERE u.banned = 'No' AND us.banned = 'No'
GROUP BY request_at;















