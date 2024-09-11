create database sale;
use sale;

create table users (
 user_id         int     ,
 join_date       date    ,
 favorite_brand  varchar(50));

 create table orders (
 order_id       int     ,
 order_date     date    ,
 item_id        int     ,
 buyer_id       int     ,
 seller_id      int 
 );

 create table items
 (
 item_id        int     ,
 item_brand     varchar(50)
 );


 insert into users values (1,'2019-01-01','Lenovo'),(2,'2019-02-09','Samsung'),(3,'2019-01-19','LG'),(4,'2019-05-21','HP');

 insert into items values (1,'Samsung'),(2,'Lenovo'),(3,'LG'),(4,'HP');

 insert into orders values (1,'2019-08-01',4,1,2),(2,'2019-08-02',2,1,3),(3,'2019-08-03',3,2,3),(4,'2019-08-04',1,4,2)
 ,(5,'2019-08-04',1,3,4),(6,'2019-08-05',2,2,4);

/*
MARKET ANALYSIS: Write an SQL query to find for each seller, whether the brand of the second item (by date) they sold is their favor brand.
If a seller sold less than two items, report the answer for that seller as no.
------------------------------------
|seller id  |   2nd_item_fav_brand |
------------------------------------
|1          |   yes/no             |
|2          |   yes/no             |
------------------------------------

*/




select * from users;
select * from orders;
select * from items;


with rnk_order as(
	select *, dense_rank() OVER (partition by seller_id order by order_date) rnk
	from orders
	)
	select u.user_id as seller_id, -- s.*, u.favorite_brand,i.item_id, i.item_brand,
	       case when u.favorite_brand = i.item_brand then "yes" else "no" end as 2nd_iten_fav_brand
        from users u
	left join rnk_order s on u.user_id = s.seller_id and rnk  = 2
	left join items i on i.item_id  = s.item_id
