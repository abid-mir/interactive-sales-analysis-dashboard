/*Select Pizza Table*/
SELECT * FROM pizza_sales;
SELECT * FROM order_details
SELECT * FROM orders
SELECT * FROM pizza_types
SELECT * FROM pizzas

/* 1 Total Revenue*/
SELECT SUM(total_price) 
AS Total_Revenue
FROM pizza_sales;

/* ----*/
SELECT SUM(price * quantity)
AS Total_revenue
FROM pizzas
JOIN order_details ON pizzas.pizza_id = order_details.pizza_id

/*2 Average Order Value(avg amt spend per order)*/
SELECT SUM(total_price) / COUNT(DISTINCT order_id) 
AS Avg_Order_Value
FROM pizza_sales;

select count(distinct order_id)
from pizza_sales
/*--------*/
SELECT 
SUM(price * quantity) / (SELECT COUNT(DISTINCT order_id) AS total_orders FROM order_details)
AS Avg_Order_Value
FROM pizzas
JOIN order_details ON pizzas.pizza_id = order_details.pizza_id


/* 3 Total Pizza Sold*/
SELECT SUM(quantity) 
AS Total_Pizza_Sold
FROM pizza_sales;

/*-----*/
SELECT SUM(quantity)
AS Total_Pizza_Sold
FROM order_details

/* 4 Total Order Placed*/
SELECT COUNT(DISTINCT order_id) 
AS Total_Order_Placed
FROM pizza_sales;



SELECT COUNT(DISTINCT order_id)
AS Total_Order_Placed
FROM order_details


/* 5 Average Pizzas Per Order*/
SELECT ROUND(SUM(quantity) / COUNT(DISTINCT order_id), 3) 
AS Avg_Pizzas_Per_Order
FROM pizza_sales;



SELECT SUM(quantity) / COUNT(DISTINCT order_id)
AS Avg_Pizzas_Per_Order
FROM order_details

/* --------- */

/* --------- 6 Total Orders By Day*/
/* total orders by distinct days of the week to check daily trend of total orders (ie which day has max orders, etc)*/
SELECT DATENAME(WEEKDAY, order_date) AS order_day, COUNT(DISTINCT order_id) AS total_orders 
FROM pizza_sales 
GROUP BY DATENAME(WEEKDAY, order_date)
ORDER BY total_orders DESC



SELECT DATENAME(WEEKDAY, date) AS order_day, COUNT(DISTINCT orders.order_id) AS total_orders
FROM order_details
JOIN orders ON order_details.order_id = orders.order_id
GROUP BY DATENAME(WEEKDAY, date)
ORDER BY total_orders DESC


/* ------------   7 Total Orders By Month(Monthly Trends For Total Orders) */
SELECT DATENAME(MONTH, order_date) AS order_month, COUNT(DISTINCT order_id) AS total_orders
FROM pizza_sales
GROUP BY DATENAME(MONTH, order_date)
ORDER BY total_orders DESC



SELECT DATENAME(MONTH, date) AS order_month, COUNT(DISTINCT orders.order_id) AS total_orders
FROM order_details
JOIN orders ON order_details.order_id = orders.order_id
GROUP BY DATENAME(MONTH, date)
ORDER BY total_orders DESC


/* 8 Percentage of Sales By Pizza Category */
SELECT pizza_category, 
ROUND(SUM(total_price), 3) AS total_revenue, 
ROUND((SUM(total_price) / (SELECT SUM(total_price) FROM pizza_sales)) * 100, 3) AS percentage
FROM pizza_sales
GROUP BY pizza_category



SELECT 
	category AS pizza_category, 
	ROUND(SUM(price), 3) AS total_revenue, 
	ROUND(SUM(price) / (SELECT SUM(price) FROM pizzas JOIN order_details ON pizzas.pizza_id = order_details.pizza_id JOIN pizza_types ON pizzas.pizza_type_id = pizza_types.pizza_type_id ), 3) * 100 AS percentage
FROM pizzas
JOIN order_details ON pizzas.pizza_id = order_details.pizza_id
JOIN pizza_types ON pizzas.pizza_type_id = pizza_types.pizza_type_id
GROUP BY category



/* ---------- 9 Percentage of Sales By Pizza Size */
SELECT pizza_size, 
	ROUND(SUM(total_price), 3) AS total_revenue, 
	ROUND((SUM(total_price) / (SELECT SUM(total_price) FROM pizza_sales)) * 100, 3) AS percentage
FROM pizza_sales
GROUP BY pizza_size
ORDER BY total_revenue DESC



SELECT 
	size AS pizza_size, 
	ROUND(SUM(price), 3) AS total_revenue, 
	ROUND(SUM(price) / (SELECT SUM(price) FROM pizzas JOIN order_details ON pizzas.pizza_id = order_details.pizza_id JOIN pizza_types ON pizzas.pizza_type_id = pizza_types.pizza_type_id ), 3) * 100 AS percentage
FROM pizzas
JOIN order_details ON pizzas.pizza_id = order_details.pizza_id
JOIN pizza_types ON pizzas.pizza_type_id = pizza_types.pizza_type_id
GROUP BY size
ORDER BY total_revenue DESC


/* ----------- 10 Total Pizzas Sold by Pizza Category */
SELECT pizza_category AS pizza_category, COUNT(quantity) AS total_quantity_sold
FROM pizza_sales
GROUP BY pizza_category
ORDER BY total_quantity_sold DESC



SELECT category AS pizza_category, COUNT(quantity) AS total_quantity_sold
FROM pizzas
JOIN order_details ON pizzas.pizza_id = order_details.pizza_id
JOIN pizza_types ON pizzas.pizza_type_id = pizza_types.pizza_type_id
GROUP BY category
ORDER BY total_quantity_sold DESC

/* 11 Top 5 Pizza By Revenue*/
SELECT TOP 5 pizza_name, ROUND(SUM(total_price), 3) AS total_revenue
FROM pizza_sales
GROUP BY pizza_name
ORDER BY total_revenue DESC



SELECT TOP 5 name AS pizza_name, ROUND(SUM(price), 3) AS total_revenue
FROM pizzas
JOIN order_details ON pizzas.pizza_id = order_details.pizza_id
JOIN pizza_types ON pizzas.pizza_type_id = pizza_types.pizza_type_id
GROUP BY name
ORDER BY total_revenue DESC


/* 12 Bottom 5 Pizza By Revenue*/
SELECT TOP 5 pizza_name, ROUND(SUM(total_price), 3) AS total_revenue
FROM pizza_sales
GROUP BY pizza_name
ORDER BY total_revenue ASC



SELECT TOP 5 name AS pizza_name, ROUND(SUM(price), 3) AS total_revenue
FROM pizzas
JOIN order_details ON pizzas.pizza_id = order_details.pizza_id
JOIN pizza_types ON pizzas.pizza_type_id = pizza_types.pizza_type_id
GROUP BY name
ORDER BY total_revenue ASC


/* 13 Top 5 Pizza By Quantity*/
SELECT TOP 5 pizza_name, SUM(quantity) AS quantity
FROM pizza_sales
GROUP BY pizza_name
ORDER BY quantity DESC



SELECT TOP 5 name AS pizza_name, ROUND(SUM(quantity), 3) AS quantity
FROM pizzas
JOIN order_details ON pizzas.pizza_id = order_details.pizza_id
JOIN pizza_types ON pizzas.pizza_type_id = pizza_types.pizza_type_id
GROUP BY name
ORDER BY quantity DESC


/* 14 Bottom 5 Pizza By Quantity*/
SELECT TOP 5 pizza_name, SUM(quantity) AS quantity
FROM pizza_sales
GROUP BY pizza_name
ORDER BY quantity ASC



SELECT TOP 5 name AS pizza_name, ROUND(SUM(quantity), 3) AS quantity
FROM pizzas
JOIN order_details ON pizzas.pizza_id = order_details.pizza_id
JOIN pizza_types ON pizzas.pizza_type_id = pizza_types.pizza_type_id
GROUP BY name
ORDER BY quantity ASC


/* 15 Top 5 Pizza By Total Orders*/
SELECT TOP 5 pizza_name, COUNT(DISTINCT order_id) AS total_orders
FROM pizza_sales
GROUP BY pizza_name
ORDER BY total_orders DESC



SELECT TOP 5 name AS pizza_name, COUNT(DISTINCT order_id) AS total_orders
FROM pizzas
JOIN order_details ON pizzas.pizza_id = order_details.pizza_id
JOIN pizza_types ON pizzas.pizza_type_id = pizza_types.pizza_type_id
GROUP BY name
ORDER BY total_orders DESC

/* 16 Bottom 5 Pizza By Total Orders*/
SELECT TOP 5 pizza_name, COUNT(DISTINCT order_id) AS total_orders
FROM pizza_sales
GROUP BY pizza_name
ORDER BY total_orders ASC



SELECT TOP 5 name AS pizza_name, COUNT(DISTINCT order_id) AS total_orders
FROM pizzas
JOIN order_details ON pizzas.pizza_id = order_details.pizza_id
JOIN pizza_types ON pizzas.pizza_type_id = pizza_types.pizza_type_id
GROUP BY name
ORDER BY total_orders ASC