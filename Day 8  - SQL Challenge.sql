-- Repeat User Purchase

CREATE DATABASE stich_fix;

USE stich_fix;


CREATE TABLE purchases (
user_id INT,
product_id INT,
quantity INT,
purchase_date DATETIME
);	


INSERT INTO purchases
(user_id, product_id, quantity, purchase_date)
VALUES 
(536, 3223, 6, '2022-11-01 12:33:44'),
(827, 3585, 35, '2022-02-20 14:05:26'),
(536, 3223, 5, '2022-03-02 09:33:28'),
(536, 1435, 10, '2022-03-02 08:40:00'),
(827, 2452, 45, '2022-04-09 00:00:00'),
(333, 1122, 9, '2022-06-02 01:00:00'),
(333, 1122, 10, '2022-06-02 02:00:00'),
(333, 1122, 8, '2022-06-02 14:56:03');


/*You are given the information on user purchase. 
Write a query to obtain the number of users who purchased the same product on two or more different days.
Output the number of unique users*/


WITH repeat_purchase as (
SELECT user_id, product_id, COUNT(DISTINCT DATE(purchase_date)) as purchase_date
FROM purchases
GROUP BY user_id, product_id
HAVING COUNT(DISTINCT( DATE(purchase_date))) > 1
ORDER BY user_id
)
SELECT COUNT(1) as unique_user
FROM repeat_purchase;
