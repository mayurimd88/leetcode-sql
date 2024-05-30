create table activity ( player_id int , device_id int , event_date date , games_played int );
insert into activity values 
(1,2,'2016-03-01',5 ),(1,2,'2016-03-02',6 ),
(2,3,'2017-06-25',1 ) ,(3,1,'2016-03-02',0 ),
(3,4,'2018-07-03',5 ); 

SELECT * FROM activity; 

-- q1: Write an SQL query that reports the first login date for each player 
SELECT player_id, MIN(event_date) AS firsttime_login
FROM activity
GROUP BY player_id;

-- q2: Write a SQL query that reports the device that is first logged in for each player 
SELECT player_id, device_id, event_date, games_played FROM 
(
	SELECT *,
    RANK() OVER(PARTITION BY player_id ORDER BY event_date) AS rn
    FROM activity
) a
WHERE rn = 1;

/* q3: Write an SQL query that reports for each player and date, how many games played so far by the player. 
 That is, the total number of games played by the player until that date. */
 SELECT *,
 SUM(games_played) OVER(PARTITION BY player_id ORDER BY event_date) AS total_played
 FROM activity;
 
/* q4: Write an SQL query that reports the fraction of players that 
logged in again on the day after the day they first logged in, 
rounded to 2 decimal places */
WITH min_date AS
(
	SELECT player_id, MIN(event_date) AS first_login
    FROM activity
    GROUP BY player_id
)
SELECT a.*, first_login
FROM activity a
INNER JOIN min_date md ON a.player_id = md.player_id
WHERE DATEDIFF(event_date, first_login) = 1;





