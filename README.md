# TASK-4-OLAP-Operations---madhcher
OLAP Operations to analyze sales data

**OLAP Operations on Sales Data**
This SQL script demonstrates various Online Analytical Processing (OLAP) operations (Drill Down, Rollup, Cube, Slice, Dice) on a sample sales dataset. It sets up a simple sales_sample table and then applies different analytical queries to explore sales performance from multiple dimensions.

**Database Schema**
The database contains one table:

**sales_sample**: Stores sales transaction data.

Product_Id (INTEGER)

Region (VARCHAR(50))

Date (DATE)

Sales_Amount (NUMERIC)

Script Sections
Database Creation:

CREATE DATABASE sales_olap_db;

Table Creation:

CREATE TABLE sales_sample (...)

Data Insertion:

INSERT INTO sales_sample VALUES (...)

Includes sample sales data across different products, regions, and dates.

**Perform OLAP Operations:**

a) Drill Down:

Description: Shows sales for each product within each region, allowing for a more detailed view from a higher level (region) to a lower level (product).

Query: SELECT Region, Product_Id, SUM(Sales_Amount) AS Total_Sales FROM sales_sample GROUP BY Region, Product_Id ORDER BY Region, Product_Id;

b) Rollup:

Description: Aggregates sales data from a detailed level (product) to a higher level (region), and then to an overall total. It uses ROLLUP to generate subtotals for specified hierarchies.

Query: SELECT Region, Product_Id, SUM(Sales_Amount) AS Total_Sales FROM sales_sample GROUP BY ROLLUP(Region, Product_Id) ORDER BY Region NULLS FIRST, Product_Id NULLS FIRST;

c) Cube:

Description: Explores sales data from all possible combinations of the specified dimensions (Product, Region, Date). It uses CUBE to generate subtotals for every combination, providing a comprehensive multi-dimensional analysis.

Query: SELECT Product_Id, Region, Date, SUM(Sales_Amount) AS Total_Sales FROM sales_sample GROUP BY CUBE(Product_Id, Region, Date) ORDER BY Product_Id NULLS FIRST, Region NULLS FIRST, Date NULLS FIRST;

d) Slice:

Description: Extracts a subset of data based on a single specific criterion. This query slices the data to view sales for a particular region (e.g., 'East').

Query: SELECT Product_Id, Region, Date, Sales_Amount FROM sales_sample WHERE Region = 'East';

e) Dice:

Description: Extracts data based on multiple criteria, effectively "dicing" the data cube. This query dices the data to view sales for specific products in a particular region and within a defined date range.

Query: SELECT Product_Id, Region, Date, Sales_Amount FROM sales_sample WHERE Product_Id IN (101, 103) AND Region = 'West' AND Date BETWEEN '2023-01-05' AND '2023-01-09';

**How to Use**
Execute the script: Run the TASK 4 - OLAP Operations.sql script in your SQL client. This will create the database, the sales_sample table, populate it with data, and then execute each of the OLAP queries.

Analyze the output: Observe the results of each query to understand how different OLAP operations provide various perspectives on the sales data.

**Prerequisites**
An SQL database system that supports ROLLUP and CUBE functions (e.g., PostgreSQL, MySQL 8.0+, SQL Server, Oracle).

A SQL client to execute the script.
