use leetcode;
create table sales ( product_id int, period_start date, period_end date, average_daily_sales int ); 
insert into sales values
(1,'2019-01-25','2019-02-28',100),
(2,'2018-12-01','2020-01-01',10),
(3,'2019-12-01','2020-01-31',1);
SELECT * FROM sales;

WITH RECURSIVE r_cte AS
(
	SELECT MIN(period_start) AS dates, MAX(period_end) AS max_dates FROM sales
    UNION ALL
    SELECT DATE_ADD(dates, INTERVAL 1 DAY) AS dates, max_dates FROM r_cte
    WHERE dates < max_dates
)
SELECT product_id, YEAR(dates) AS report_year, SUM(average_daily_sales) AS total_amount FROM r_cte
INNER JOIN sales ON dates BETWEEN period_start AND period_end
GROUP BY product_id, YEAR(dates)
ORDER BY product_id, YEAR(dates)
;