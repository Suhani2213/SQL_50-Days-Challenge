CREATE DATABASE adobe;
USE adobe;

CREATE  TABLE  adobe_transactions (
customer_id int,
product VARCHAR(50),
revenue int
);

INSERT INTO adobe_transactions
(customer_id, product, revenue)
VALUES
(123, "Photoshop", 50),
(123, "Premier Pro", 100),
(123, "After Effects", 50),
(234, "Illustrator", 200),
(234, "Premier Pro", 100);

INSERT INTO adobe_transactions
(customer_id, product, revenue)
VALUES
(562, "Illustrator", 200),
(913, "Photoshop", 50),
(913, "Premier Pro", 100),
(913, "Illustrator", 200);




-- For every customer that bought photoshop, return a list of the customers, and the total spent on all products except for photoshop products.
-- Sert your oreder by cusomer id in ascending order

SELECT * FROM adobe_transactions;

-- Method 1
WITH cust_id as (
SELECT distinct customer_id as target_cust_id
FROM adobe_transactions
WHERE product = "Photoshop"
)
SELECT customer_id, SUM(revenue) as total_spent
FROM adobe_transactions at
INNER JOIN cust_id ci
ON at.customer_id = ci.target_cust_id	
WHERE product != 'Photoshop'
GROUP BY customer_id
ORDER BY customer_id;


-- Method 2
SELECT customer_id, SUM(revenue) as revenue
FROM adobe_transactions
WHERE customer_id IN (SELECT customer_id FROM adobe_transactions WHERE product = 'Photoshop')
AND 
product != 'Photoshop'
GROUP BY customer_id
ORDER BY customer_id;


