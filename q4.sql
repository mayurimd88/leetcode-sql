create table players_location ( name varchar(20), city varchar(20) ); 
 insert into players_location values 
('Sachin','Mumbai'),('Virat','Delhi') , 
('Rahul','Bangalore'),('Rohit','Mumbai'),
('Mayank','Bangalore');
SELECT * FROM players_location;

SELECT
MAX(CASE WHEN city= 'Bangalore' THEN name END) AS Bangalore,
MAX(CASE WHEN city= 'Mumbai' THEN name END) AS Mumbai,
MAX(CASE WHEN city= 'Delhi' THEN name END) AS Delhi
FROM
(
	SELECT *,
    ROW_NUMBER() OVER(PARTITION BY city ORDER BY name ASC) AS player_group
    FROM players_location
) PL
GROUP BY player_group
ORDER BY player_group;