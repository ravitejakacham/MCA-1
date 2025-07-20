-- Update the online_price of "Veg Meals" to 120, keeping mr_price at 110
UPDATE products 
SET online_price = 120 
WHERE product_name = 'Veg Meals' OR name = 'Veg Meals';

-- If no rows were updated, it might be because the product doesn't exist yet or has a different name
-- Let's check if we need to insert it
DO $$
DECLARE
    product_exists BOOLEAN;
BEGIN
    SELECT EXISTS(SELECT 1 FROM products WHERE product_name = 'Veg Meals' OR name = 'Veg Meals') INTO product_exists;
    
    IF NOT product_exists THEN
        -- Insert the product with different prices for MR and online
        INSERT INTO products (product_name, mr_price, online_price, category, available_for)
        VALUES ('Veg Meals', 110, 120, 'Meals', ARRAY['mr_order', 'online_order']);
    END IF;
END $$;

-- Let's verify the update
SELECT * FROM products WHERE product_name = 'Veg Meals' OR name = 'Veg Meals';
