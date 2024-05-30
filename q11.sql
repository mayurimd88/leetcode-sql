create table students ( student_id int, student_name varchar(20) ); 
insert into students values 
(1,'Daniel'),(2,'Jade'),(3,'Stella'),(4,'Jonathan'),(5,'Will');
create table exams ( exam_id int, student_id int, score int); 
insert into exams values 
(10,1,70),(10,2,80),(10,3,90),
(20,1,80),(30,1,70),(30,3,80),
(30,4,90),(40,1,60) ,(40,2,70),(40,4,80);


/* Write an SQL query to report the stidents (id, name) being 'quiet' in all exams.
A 'quiet' student is the one who took at least one exam and didn't score 
neither the high score nor the low score in any of the exam.
Dont return the student who has never taken any exam.a
Return the result table ordered by student_id */

SELECT * FROM students;
SELECT * FROM exams;
--- 1
WITH all_scores AS
(
	SELECT exam_id, MIN(score) AS min_score, MAX(score) AS max_score
    FROM exams
    GROUP BY exam_id
)
SELECT exams.student_id ,
MAX(CASE WHEN score = min_score OR 
		score = max_score THEN 1 ELSE 0 END) AS red_flag
FROM exams
INNER JOIN all_scores ON exams.exam_id = all_scores.exam_id
GROUP BY student_id
;

--- 2
WITH all_scores AS
(
	SELECT exam_id, MIN(score) AS min_score, MAX(score) AS max_score
    FROM exams
    GROUP BY exam_id
)
SELECT exams.student_id
FROM exams
INNER JOIN all_scores ON exams.exam_id = all_scores.exam_id
GROUP BY student_id
HAVING MAX(CASE WHEN score = min_score OR 
		score = max_score THEN 1 ELSE 0 END) = 0

















