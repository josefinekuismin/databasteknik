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