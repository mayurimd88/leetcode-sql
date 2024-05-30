create table employee ( emp_id int, company varchar(10), salary int ); 
insert into employee values 
(1,'A',2341) ,(2,'A',341) , (3,'A',15) ,
(4,'A',15314), (5,'A',451) ,(6,'A',513) ,
(7,'B',15), (8,'B',13), (9,'B',1154) ,
(10,'B',1345), (11,'B',1221), (12,'B',234), 
(13,'C',2345), (14,'C',2645), (15,'C',2645), 
(16,'C',2652), (17,'C',65);

-- find median salary of each company

SELECT * FROM employee;

SELECT company, AVG(salary) AS cmp_salary
FROM
(
	SELECT *,
    ROW_NUMBER() OVER(PARTITION BY company ORDER BY salary) AS rn,
    COUNT(1) OVER (PARTITION BY company) AS total_cnt
    FROM employee
) emp
WHERE rn BETWEEN total_cnt*1.0/2 AND total_cnt*1.0/2+1
GROUP BY company;