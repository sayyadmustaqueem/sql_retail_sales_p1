-- SQL Retail Analysis--
CREATE DATABASE sql_project_p2;


CREATE TABLE retail_sales
    ( 
    transactions_id INT PRIMARY KEY,
	sale_date DATE,
	sale_time TIME,
	customer_id INT,
	gender VARCHAR(15),
	age	INT,
	category VARCHAR(15),
	quantiy	INT,
	price_per_unit FLOAT,
	cogs FLOAT,
	total_sale FLOAT
);

SELECT * FROM retail_sales;

-- DATA Cleaning--
SELECT COUNT(*) FROM retail_sales;

SELECT * FROM retail_sales
WHERE transactions_id IS NULL;

SELECT * FROM retail_sales
WHERE sale_date IS NULL;

SELECT * FROM retail_sales
WHERE sale_time IS NULL;

SELECT * FROM retail_sales
WHERE 
	transactions_id IS NULL
	OR
	sale_date IS NULL
	OR 
	sale_time Is NULL
	OR 
	customer_id IS NULL
	OR
	gender IS NULL
	OR
	age IS NULL
	OR
	category IS NULL
	OR
	quantiy IS NULL
	OR
	price_per_unit IS NULL
	OR
	cogs IS NULL
	OR
	total_sale IS NULL

--DELETE RECORD --
DELETE FROM retail_sales
WHERE
	transactions_id IS NULL
	OR
	sale_date IS NULL
	OR 
	sale_time Is NULL
	OR 
	customer_id IS NULL
	OR
	gender IS NULL
	OR
	age IS NULL
	OR
	category IS NULL
	OR
	quantiy IS NULL
	OR
	price_per_unit IS NULL
	OR
	cogs IS NULL
	OR
	total_sale IS NULL;
--Data Exploration

-- how many sales we have?
SELECT COUNT(*) as total_sale FROM retail_sales;

-- how many uniuque customer we have?

SELECT COUNT(DISTINCT customer_id) as total_sale FROM retail_sales;

-- how many category we have?

SELECT COUNT(DISTINCT category) as total_sale FROM retail_sales;

SELECT DISTINCT category FROM retail_sales

-- Data Analysis and Business key problem 

-- Q.1 write a SQl qurey to retrieve all column for sale made on '2022-11-05'

SELECT * FROM retail_sales;

SELECT *
FROM retail_sales
WHERE sale_date = '2022-11-05';

--Q.2 Write a SQl to retrive all transection where the category is 'clothing' and 
--the quantity sold is more than 1 in the moth of nov-2022

SELECT *
FROM retail_sales
WHERE category = 'Clothing'
	AND
	TO_CHAR(sale_date, 'YYYY-MM') = '2022-11'
GROUP BY 1

-- Q.3 Write a SQL query to calculate the total sale (tital_sale) for each category.

SELECT 
	category,
	SUM(total_sale) as net_sale
FROM retail_sales
GROUP BY 1;

-- Q.4 WSQ to find the average age of customer who purchased items from the 'Beauty' category.

SELECT 
	ROUND(AVG(age), 2) as avg_age
FROM retail_sales
WHERE category = 'Beauty'

--Q.5 WSQ to find all transections where the total_sale is greater then 1000.

SELECT * FROM retail_sales
WHERE total_sale > 1000

-- Q.6 WSQ to find the total number of trancections (transection_id) made by each gender in each
--category.

SELECT 
	category,
	gender,
	COUNT(*) as total_trans
FROM retail_sales
GROUP 
	BY
	category,
	gender

-- Q.7 WSQ a to calculate the average sale for each month, Find out best selling month 
-- in each year.

SELECT 
	EXTRACT(YEAR FROM sale_date) as year,
	EXTRACT(MONTH FROM sale_date) as month,
	SUM(total_sale) as total_sale
FROM retail_sales
GROUP BY 1, 2
ORDER BY 1, 2

--Q.8 WSQ to find the top 5 customers based on the highest total sales
SELECT 
	customer_id,
	SUM(total_sale) as toatal_sales
FROM retail_sales
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5

-- Q.9 WSQ to find the number of unique customer who purchased items from each category,

SELECT
	category,
	COUNT (DISTINCT customer_id) as cnt_unique_cs
FROM retail_sales
GROUP BY category

-- Q.10 WSQ to create each shift and number of orders (Example Morning <=12 Afternoon 
--Between 12 & 17, Evening > 17)

WITH hourly_sale
AS
(
SELECT *,
	CASE
		WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
		WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Aftrnoon'
		ELSE 'Evening'
	END as shift
FROM retail_sales
)
SELECT 
	shift,
	COUNT(*) as total_orders
FROM hourly_sale
GROUP BY shift

-- End of project 