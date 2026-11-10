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