USE magist

#How many orders are there in the dataset? The orders table contains a row for each order, so this should be easy to find out!

SELECT count(*) AS orders_count
FROM orders;


#Are orders actually delivered? 

SELECT order_status, COUNT(*) AS orders
FROM orders
GROUP BY order_status;

#Is Magist having user growth?

SELECT 
    YEAR(order_purchase_timestamp) AS year_,
    MONTH(order_purchase_timestamp) AS month_,
    COUNT(customer_id)
FROM
    orders
GROUP BY year_ , month_
ORDER BY year_ , month_;

#How many products are there in the products table?

SELECT 
    COUNT(DISTINCT product_id) AS products_count
FROM
    products;
    
#Which are the categories with most products?

SELECT 
    product_category_name, 
    COUNT(DISTINCT product_id) AS n_products
FROM
    products
GROUP BY product_category_name
ORDER BY COUNT(product_id) DESC;

#How many of those products were present in actual transactions?

SELECT 
	count(DISTINCT product_id) AS n_products
FROM
	order_items;
    
#What’s the price for the most expensive and cheapest products?
SELECT 
    MIN(price) AS cheapest, 
    MAX(price) AS most_expensive
FROM 
	order_items;


#What categories of tech products does Magist have?


SELECT t.product_category_name_english, MAX(t.product_category_name) AS translated_name, MAX(p.product_category_name) AS product_name
FROM product_category_name_translation as t
LEFT JOIN products as p 
ON t.product_category_name = p.product_category_name
GROUP BY t.product_category_name_english;


SELECT t.product_category_name_english, ANY_VALUE(t.product_category_name) AS translated_name, ANY_VALUE(p.product_category_name) AS product_name
FROM products AS p
LEFT JOIN product_category_name_translation as t
ON p.product_category_name = t.product_category_name
GROUP BY t.product_category_name_english;



#How many products of these tech categories have been sold (within the time window of the database snapshot)? 

SELECT t.product_category_name_english, ANY_VALUE(t.product_category_name) AS translated_name, ANY_VALUE(p.product_category_name) AS product_name
FROM products AS p
LEFT JOIN product_category_name_translation as t
ON p.product_category_name = t.product_category_name
GROUP BY t.product_category_name_english;

