-- Uppgift 2.1
SELECT first_name, last_name
FROM employees;

-- Uppgift 2.2
SELECT home_phone
FROM employees
WHERE title = 'Vice President, Sales';

-- Uppgift 2.3
SELECT company_name, contact_name, contact_title
FROM suppliers
WHERE company_name = 'Svensk Sjöföda AB';

-- Uppgift 2.4
SELECT first_name, last_name, birth_date
FROM employees
ORDER BY birth_date DESC;

-- Uppgift 2.5
SELECT contact_name, country, city
FROM customers
ORDER BY country, city;

-- Uppgift 2.6
SELECT first_name, last_name
FROM employees
WHERE last_name LIKE '%an%';

-- Uppgift 2.7
SELECT *
FROM employees
WHERE title LIKE '%Vice%' 
    OR title LIKE '%President%' 
    OR title LIKE '%Manager%';

-- Uppgift 2.8
SELECT product_name, unit_price, unit_price * 1.07 AS new_price
FROM products;

-- Uppgift 2.9
SELECT product_name, unit_price * units_in_stock AS inventory_value
FROM products;

-- Uppgift 2.10
SELECT *
FROM products
WHERE units_in_stock < reorder_level;

-- Uppgift 2.11
SELECT *
FROM products
WHERE units_in_stock + units_on_order < reorder_level;

-- Uppgift 2.12
SELECT products.product_name AS product, categories.category_name AS category
FROM products
JOIN categories 
    ON products.category_id = categories.category_id
WHERE products.product_name = 'Lakkalikööri';

-- Uppgift 2.13
SELECT products.product_name AS product, suppliers.company_name as supplier
FROM products
JOIN suppliers 
    ON (suppliers.supplier_id = products.supplier_id)
WHERE products.product_name = 'Gravad lax';

-- Uppgift 2.14
SELECT products.product_name AS ordered_product, suppliers.company_name AS supplier
FROM order_details
JOIN products
    ON order_details.product_id = products.product_id
JOIN suppliers
    ON products.supplier_id = suppliers.supplier_id
WHERE order_details.order_id = 10249;

-- Uppgift 15
SELECT COUNT(*) AS amount
FROM employees
WHERE title = 'Sales Representative';

-- Uppgift 2.16

-- Få fram de beställningar som gjordes
SELECT *
FROM orders
WHERE order_date = '1996-12-12';

-- Få fram vilka produkter, pris per produkt och antal av varje produkt som såldes det datumet
SELECT orders.order_id, products.product_name, order_details.unit_price, order_details.quantity
FROM orders
JOIN order_details
    ON orders.order_id = order_details.order_id
JOIN products
    ON order_details.product_id = products.product_id
WHERE orders.order_date = '1996-12-12';

-- Summera värdet på produkterna som såldes det datumet
SELECT SUM(order_details.unit_price * order_details.quantity) AS total_value
FROM orders
JOIN order_details
    ON orders.order_id = order_details.order_id
WHERE orders.order_date = '1996-12-12';

-- Uppgift 2.17
SELECT products.product_name AS product, categories.category_name AS category, SUM(order_details.quantity) AS total_sold
FROM products
JOIN categories
    ON products.category_id = categories.category_id
JOIN order_details
    ON products.product_id = order_details.product_id
GROUP BY products.product_id, categories.category_name
-- Väljer att ordna de efter antal sålda för att få någon form av ordning på tabellen
ORDER BY total_sold DESC;

-- Uppgift 2.18
SELECT customer_id, company_name
FROM customers
WHERE customer_id IN (
    SELECT customer_id
    FROM customers
    EXCEPT
    SELECT customer_id
    FROM orders
);

-- Uppgift 2.19
SELECT product_name, unit_price
FROM products
WHERE category_id = 4;

UPDATE products
SET unit_price = unit_price * 1.20
WHERE category_id = 4;

SELECT product_name, unit_price AS updated_price
FROM products
WHERE category_id = 4;

-- Uppgift 2.20
SELECT products.product_name, products.unit_price, suppliers.company_name AS supplier
FROM products
JOIN suppliers
    ON products.supplier_id = suppliers.supplier_id
WHERE suppliers.company_name = 'Tokyo Traders' 
    OR suppliers.company_name = 'Svensk Sjöföda AB'
ORDER BY suppliers;

UPDATE products
SET unit_price = unit_price * 1.10
WHERE supplier_id IN (
    SELECT supplier_id
    FROM suppliers
    WHERE company_name = 'Tokyo Traders'
);

SELECT products.product_name, products.unit_price AS updated_unit_price, suppliers.company_name AS supplier
FROM products
JOIN suppliers
    ON products.supplier_id = suppliers.supplier_id
WHERE suppliers.company_name = 'Tokyo Traders' 
    OR suppliers.company_name = 'Svensk Sjöföda AB'
ORDER BY suppliers;