 create table stadium ( id int, visit_date date, no_of_people int ); 
 insert into stadium values 
 (1,'2017-07-01',10) ,(2,'2017-07-02',109) ,
 (3,'2017-07-03',150) ,(4,'2017-07-04',99) ,
 (5,'2017-07-05',145) ,(6,'2017-07-06',1455) ,
 (7,'2017-07-07',199) ,(8,'2017-07-08',188);
 
/* display the records which have 3 or more 
consecutive rows with the amount of people 
more than 100 each day */

SELECT * FROM stadium;

WITH grp_number AS (
	SELECT *,
    ROW_NUMBER() OVER(ORDER BY visit_date) AS rnk,
    id - ROW_NUMBER() OVER(ORDER BY visit_date) AS grp
    FROM stadium
    WHERE no_of_people >= 100
)
 SELECT id, visit_date, no_of_people 
 FROM grp_number
 WHERE grp IN 
(
SELECT grp FROM grp_number
GROUP BY grp
HAVING COUNT(1)>=3
);
















