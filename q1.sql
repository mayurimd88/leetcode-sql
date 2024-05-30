create table UserActivity ( username varchar(20) , activity varchar(20), startDate Date , endDate Date ); 
insert into UserActivity values 
('Alice','Travel','2020-02-12','2020-02-20') ,
('Alice','Dancing','2020-02-21','2020-02-23') ,
('Alice','Travel','2020-02-24','2020-02-28') ,
('Bob','Travel','2020-02-11','2020-02-18');
-- find second most recent activity of user
-- user having only one activity return as it is
WITH activity AS(
SELECT *,
COUNT(1) OVER(PARTITION BY username) AS total_activity,
RANK() OVER(PARTITION BY username ORDER BY startDate) AS rank_user
FROM useractivity
)
SELECT username, activity, startDate, endDate FROM activity
WHERE total_activity = 1 OR rank_user = 2;