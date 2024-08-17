CREATE DATABASE IF NOT EXISTS products;

USE products;

CREATE TABLE IF NOT EXISTS Product (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    OriginalPrice DECIMAL(10, 2),
    DiscountRate DECIMAL(5, 2)  -- Discount rate as a percentage, e.g., 10% discount is represented as 10.
);

INSERT INTO Product(ProductID, ProductName, OriginalPrice, DiscountRate) VALUES
(1, 'Laptop', 1200.00, 15),
(2, 'Smartphone', 700.00, 10),
(3, 'Headphones', 150.00, 5),
(4, 'E-Reader', 200.00, 20);

CREATE TABLE IF NOT EXISTS Sales (
    SaleID INT PRIMARY KEY,
    ProductID INT,
    QuantitySold INT,
    SaleDate DATE
);


INSERT INTO Sales (SaleID, ProductID, QuantitySold, SaleDate) VALUES
(1, 1, 2, '2023-03-11'),
(2, 2, 3, '2023-03-12'),
(3, 3, 5, '2023-03-13'),
(4, 1, 1, '2023-03-14'),
(5, 4, 4, '2023-03-15'),
(6, 2, 2, '2023-03-16'),
(7, 3, 3, '2023-03-17'),
(8, 4, 2, '2023-03-18');

INSERT INTO Sales (SaleID, ProductID, QuantitySold, SaleDate) VALUES
(9, 1, 1, '2023-03-01'),
(10, 2, 2, '2023-03-02'),
(11, 3, 1, '2023-03-03'),
(12, 4, 1, '2023-03-04'),
(13, 1, 2, '2023-03-05'),
(14, 2, 1, '2023-03-06'),
(15, 3, 3, '2023-03-07'),
(16, 4, 2, '2023-03-08'),
(17, 2, 1, '2023-03-09');


-- Calculate the percentage increase in sales volume during the sale compared to a similar period before the sale.

SELECT (Quantity_Sold_During_Sale - Quantity_Sold_Before_Sale)/Quantity_Sold_Before_Sale*100 AS Percentage_Increase
FROM(
    SELECT
		SUM(CASE WHEN s.SaleDate BETWEEN '2023-03-11' AND '2023-03-18' THEN s.QuantitySold ELSE 0
        END) AS Quantity_Sold_During_Sale,
        SUM(CASE WHEN s.SaleDate BETWEEN '2023-03-01' AND '2023-03-09' THEN s.QuantitySold ELSE 0 
END) AS Quantity_Sold_Before_Sale
    FROM Sales s)
AS Qty;

