SELECT * FROM pizza_sales;

ALTER TABLE pizza_sales
ALTER COLUMN unit_price FLOAT;

ALTER TABLE pizza_sales
ALTER COLUMN total_price FLOAT;


--TOTAL REVENUE
SELECT SUM(total_price) AS [Total_Revenue]
FROM pizza_sales;

--Average Order Value
SELECT (SUM(total_price) / COUNT(DISTINCT order_id))
AS [Avg_order_Value]
FROM pizza_sales;

--TOTAL PIZZAS SOLD
SELECT SUM(quantity) AS [Total Pizzas Sold]
FROM pizza_sales;

--TOTAL ORDERS
SELECT COUNT(DISTINCT(order_id)) AS [Total Orders]
FROM pizza_sales;

--AVERAGES PIZZAS PRE ORDERS
SELECT CAST(CAST(SUM(quantity) AS DECIMAL(10,2)) / 
CAST(COUNT(DISTINCT order_id) AS DECIMAL(10,2)) AS DECIMAL(10,2)) AS Avg_Pizzas_per_order
FROM pizza_sales;

-- Daily Trend for Total Orders
SELECT DATENAME(DW, order_date) AS order_day, COUNT(DISTINCT order_id) AS total_orders 
FROM pizza_sales
GROUP BY DATENAME(DW, order_date);

--Hourly Trend for Orders
SELECT DATENAME(HOUR, order_time) AS [Order Hour], 
COUNT(DISTINCT order_id) as [Total Orders]
FROM pizza_sales
GROUP BY DATENAME(HOUR, order_time)
ORDER BY DATENAME(HOUR, order_time);

--% of Sales by Pizza Category
SELECT pizza_category,
SUM(total_price) * 100 / (SELECT SUM(total_price)
FROM pizza_sales) AS [Pct Total sales]
FROM pizza_sales AS [Pct Total sales]
GROUP BY pizza_category;

--% of Sales by Pizza Size
SELECT pizza_size,
SUM(total_price) * 100 / (SELECT SUM(total_price)
FROM pizza_sales) AS [Pct Total sales]
FROM pizza_sales AS [Pct Total sales]
GROUP BY pizza_size;

--Total Pizzas Sold by Pizza Category
SELECT pizza_category, 
SUM(quantity) as [Total sales]
FROM pizza_sales
GROUP BY pizza_category;

--Top 5 Best Sellers by Total Pizzas Sold
SELECT TOP 5 pizza_name, 
SUM(quantity) AS [Pizzas Sold]
FROM pizza_sales
GROUP BY pizza_name
ORDER BY SUM(quantity) DESC;


-- Bottom 5 Best Sellers by Total Pizzas Sold
SELECT TOP 5 pizza_name, 
SUM(quantity) AS [Pizzas Sold]
FROM pizza_sales
GROUP BY pizza_name
ORDER BY SUM(quantity) ASC;