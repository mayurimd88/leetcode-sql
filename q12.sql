create table phonelog( Callerid int, Recipientid int, Datecalled datetime ); 
insert into phonelog(Callerid, Recipientid, Datecalled) values
(1, 2, '2019-01-01 09:00:00.000'), (1, 3, '2019-01-01 17:00:00.000'), 
(1, 4, '2019-01-01 23:00:00.000'), (2, 5, '2019-07-05 09:00:00.000'), 
(2, 3, '2019-07-05 17:00:00.000'), (2, 3, '2019-07-05 17:20:00.000'), 
(2, 5, '2019-07-05 23:00:00.000'), (2, 3, '2019-08-01 09:00:00.000'), 
(2, 3, '2019-08-01 17:00:00.000'), (2, 5, '2019-08-01 19:30:00.000'), 
(2, 4, '2019-08-02 09:00:00.000'), (2, 5, '2019-08-02 10:00:00.000'), 
(2, 5, '2019-08-02 10:45:00.000'), (2, 4, '2019-08-02 11:00:00.000');

-- find out callers whose first and last call was to sameperson on given date

SELECT * FROM phonelog;

WITH calls AS
(
	SELECT callerid, CAST(datecalled AS DATE) AS called_date,
    MIN(datecalled) AS first_call, MAX(datecalled) AS last_call
    FROM phonelog
    GROUP BY callerid, CAST(datecalled AS DATE)
)
SELECT c.*, p1.recipientid -- AS first_rec, p2.recipientid AS last_rec 
FROM calls c
INNER JOIN phonelog p1 ON c.Callerid = p1.Callerid AND c.first_call = p1.datecalled
INNER JOIN phonelog p2 ON c.Callerid = p2.Callerid AND c.last_call = p2.datecalled
WHERE p1.Recipientid = p2.Recipientid;


























