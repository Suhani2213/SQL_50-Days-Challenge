create database customer;
use customer;


create table customer_orders (
order_id integer,
customer_id integer,
order_date date,
order_amount integer
);
insert into customer_orders values(1,100,cast('2022-01-01' as date),2000),(2,200,cast('2022-01-01' as date),2500),(3,300,cast('2022-01-01' as date),2100)
,(4,100,cast('2022-01-02' as date),2000),(5,400,cast('2022-01-02' as date),2200),(6,500,cast('2022-01-02' as date),2700)
,(7,100,cast('2022-01-03' as date),3000),(8,400,cast('2022-01-03' as date),1000),(9,600,cast('2022-01-03' as date),3000);

/*
write a quey to find out how many new customers and repeat custumers shopped per day

output:
---------------------------------------------------------------------
|order_date | no_of_new_customer_count | no_of_repeat_customer_count |
---------------------------------------------------------------------
|2022-01-01 |	3	                   | 0                           |
|2022-01-02 |	2	                   | 1                           |
|2022-01-03 |	1	                   | 2                           |
---------------------------------------------------------------------
*/


select * from customer_orders;



with cte1 as(
select * , row_number() over(partition by customer_id order by order_date) as rnk
from customer_orders
)
select order_date,
	   count(case when rnk = 1 then customer_id end) as no_of_new_customer_count,
       count(case when rnk > 1 then customer_id end) as no_of_repeat_customer_count
from cte1
group by order_date;




-- write a quey to find out  how many new customers and repeat custumers shopped per day with total amount spent each 
with cte1 as(
select * , row_number() over(partition by customer_id order by order_date) as rnk
from customer_orders
)
select order_date,
	   count(case when rnk = 1 then customer_id end) as no_of_new_customer,
       sum(case when rnk = 1 then order_amount end) as total_amount_of_new_customer,
       count(case when rnk > 1 then customer_id end) as no_of_repeat_customer,
       sum(case when rnk > 1 then order_amount end) as total_amount_of_repeat_customer
from cte1
group by order_date;