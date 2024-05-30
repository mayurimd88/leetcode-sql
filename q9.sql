create table users ( user_id int , join_date date , favorite_brand varchar(50)); 
create table orders ( order_id int , order_date date , item_id int , buyer_id int , seller_id int ); 
create table items ( item_id int , item_brand varchar(50) ); 
insert into users values (1,'2019-01-01','Lenovo'),(2,'2019-02-09','Samsung'),(3,'2019-01-19','LG'),(4,'2019-05-21','HP'); 
insert into items values (1,'Samsung'),(2,'Lenovo'),(3,'LG'),(4,'HP'); 
insert into orders values 
(1,'2019-08-01',4,1,2),(2,'2019-08-02',2,1,3),
(3,'2019-08-03',3,2,3),(4,'2019-08-04',1,4,2) ,
(5,'2019-08-04',1,3,4),(6,'2019-08-05',2,2,4);

SELECT * FROM users;
SELECT * FROM items;
SELECT * FROM orders;

/* Find each seller, whether the brand of the second item(by date) 
they sold, is their favourite brand?
if a seller solds less than 2 items, report the answer for that seller as no
o/p:-- seller-id | 2nd-item-favourite
		1			yes/no
		2			yes/no
*/

WITH rnk_orders AS
(
	SELECT *,
    RANK() OVER(PARTITION BY seller_id ORDER BY order_date ASC) AS rn
    FROM orders
)
SELECT u.user_id AS seller_id, 
	CASE WHEN i.item_brand = u.favorite_brand
		THEN 'Yes' ELSE 'No'
        END AS seconditem_favbrand
FROM users u
LEFT JOIN rnk_orders ro ON ro.seller_id = u.user_id AND rn = 2
LEFT JOIN items i ON i.item_id = ro.item_id
;































