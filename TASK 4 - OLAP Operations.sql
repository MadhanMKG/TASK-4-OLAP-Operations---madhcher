-- 1. Create the database
CREATE DATABASE sales_olap_db;

-- create Table
CREATE TABLE sales_sample (
    Product_Id INTEGER,
    Region VARCHAR(50),
    Date DATE,
    Sales_Amount NUMERIC
);

-- 2. Data Creation
--Insert Data
INSERT INTO sales_sample (Product_Id, Region, Date, Sales_Amount) VALUES
(101, 'East', '2023-01-05', 1500.00),
(102, 'West', '2023-01-05', 2000.50),
(103, 'North', '2023-01-06', 1200.75),
(101, 'South', '2023-01-06', 1800.00),
(104, 'East', '2023-01-07', 2500.00),
(102, 'North', '2023-01-07', 900.25),
(105, 'West', '2023-01-08', 3000.00),
(103, 'East', '2023-01-08', 1100.00),
(104, 'South', '2023-01-09', 1600.50),
(101, 'West', '2023-01-09', 2200.00);

-- 4.Perform OLAP Operations
-- a) Drill Down:
-- Drill down from region to product level to understand sales performance. This query shows sales for each product within each region.
SELECT Region, Product_Id, SUM(Sales_Amount) AS Total_Sales
FROM sales_sample
GROUP BY Region, Product_Id
ORDER BY Region, Product_Id;

-- b) Rollup
-- Rollup from product to region level to view total sales by region. This query uses GROUPING SETS to show sales by product, sales by region, and overall total sales.
SELECT Region, Product_Id, SUM(Sales_Amount) AS Total_Sales
FROM sales_sample
GROUP BY ROLLUP(Region, Product_Id)
ORDER BY Region NULLS FIRST, Product_Id NULLS FIRST;

-- c) Cube
-- Explore sales data from different perspectives, such as product, region, and date. This query uses CUBE to generate subtotals for all possible combinations of the specified dimensions.
SELECT Product_Id, Region, Date, SUM(Sales_Amount) AS Total_Sales
FROM sales_sample
GROUP BY CUBE(Product_Id, Region, Date)
ORDER BY Product_Id NULLS FIRST, Region NULLS FIRST, Date NULLS FIRST;

-- d) Slice
-- Extract a subset of data based on specific criteria. This query slices the data to view sales for a particular region (e.g., 'East').
SELECT Product_Id, Region, Date, Sales_Amount
FROM sales_sample
WHERE Region = 'East';

-- e) Dice
-- Extract data based on multiple criteria. This query dices the data to view sales for specific products in a particular region and date range.
SELECT Product_Id, Region, Date, Sales_Amount
FROM sales_sample
WHERE Product_Id IN (101, 103) AND Region = 'West' AND Date BETWEEN '2023-01-05' AND '2023-01-09';