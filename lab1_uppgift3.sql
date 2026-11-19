-- Uppgift 3.1

-- Kolla priserna från början
SELECT product_name, unit_price
FROM products
ORDER BY product_id;

-- Skapa en procedur
CREATE PROCEDURE increase_all_prices()
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE products
    SET unit_price = unit_price * 1.05;
END;
$$;

-- Köra proceduren
CALL increase_all_prices();

-- Kolla de uppdaterade priserna
SELECT product_name, unit_price
FROM products
ORDER BY product_id;

-- Uppgift 3.2
-- Kollar alla priser för kategori med id 1
SELECT product_name, category_id, unit_price
FROM products
WHERE category_id = '1';
ORDER BY product_id;

-- Kollar alla priser för kategori med id 2
SELECT product_name, category_id, unit_price
FROM products
WHERE category_id = '2';
ORDER BY product_id;

-- Skapar en procedur som ändrar priset med +5% för alla produkter i kategori 1
CREATE PROCEDURE increase_prices_by_category(p_category_id INTEGER)
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE products
    SET unit_price = unit_price * 1.05
    WHERE category_id = p_category_id;
END;
$$;

-- Testar köra proceduren från kategorin med id 1
CALL increase_prices_by_category(1);

-- Kollar alla priser för kategori med id 1 efter prishöjningen
SELECT product_name, category_id, unit_price
FROM products
WHERE category_id = '1';
ORDER BY product_id;

-- Kollar att alla priser för kategori med id 2 är oförändrade
SELECT product_name, category_id, unit_price
FROM products
WHERE category_id = '2';
ORDER BY product_id;

-- Upgift 3.3
-- Hämta all information från product och categories
SELECT
    products.product_name,
    categories.category_name,
    products.unit_price
FROM products
JOIN categories
    ON products.category_id = categories.category_id
ORDER BY product_name;

-- Skapa vyn
CREATE VIEW product_overview AS
SELECT
    products.product_name,
    categories.category_name,
    products.unit_price
FROM products
JOIN categories
    ON products.category_id = categories.category_id;

-- Kolla att den nya vyn visar samma information som min sql-fråga i början av uppgiften
SELECT *
FROM product_overview
ORDER BY product_name;

-- Uppgift 3.4
-- Skapa vyn med svenska kronor
CREATE VIEW product_overview_and_sek AS
SELECT
    products.product_name,
    categories.category_name,
    products.unit_price,
    ROUND((products.unit_price * 10)::NUMERIC, 2) AS price_in_sek
FROM products
JOIN categories
    ON products.category_id = categories.category_id;

-- Visar alla produkter från vyn med priser i SEK (sorterade i bokstavsordning)
SELECT *
FROM product_overview_and_sek
ORDER BY product_name;

-- Uppgift 3.5
-- Testa en fungerande transaktion

-- Kontrollera produkternas (med id 1 och 2) ursprungliga priser
SELECT product_id, product_name, unit_price
FROM products
WHERE product_id IN (1, 2);

-- Starta transaktionen
BEGIN;

-- Höj priset på produkt 1 med 10 %
UPDATE products
SET unit_price = unit_price * 1.10
WHERE product_id = 1;

-- Höj priset på produkt 2 med 4,5 enheter
UPDATE products
SET unit_price = unit_price + 4.5
WHERE product_id = 2;

-- Kontrollera priserna under transaktionen
SELECT product_id, product_name, unit_price
FROM products
WHERE product_id IN (1, 2);

-- Ångra alla ändringar i transaktionen
ROLLBACK;

-- Kontrollera priserna efter ROLLBACK
SELECT product_id, product_name, unit_price
FROM products
WHERE product_id IN (1, 2);