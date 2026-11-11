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