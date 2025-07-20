-- Check if products table exists, if not create it
CREATE TABLE IF NOT EXISTS products (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  product_name TEXT NOT NULL,
  mr_price FLOAT NOT NULL,
  online_price FLOAT NOT NULL,
  category TEXT,
  available_for TEXT[] DEFAULT '{}',
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Insert some default products if the table is empty
INSERT INTO products (product_name, mr_price, online_price, category, available_for)
SELECT 'Veg Meals', 110, 120, 'Meals', ARRAY['mr_order', 'online_order']
WHERE NOT EXISTS (SELECT 1 FROM products WHERE product_name = 'Veg Meals');

INSERT INTO products (product_name, mr_price, online_price, category, available_for)
SELECT 'Omlet', 20, 25, 'Sides', ARRAY['mr_order', 'online_order']
WHERE NOT EXISTS (SELECT 1 FROM products WHERE product_name = 'Omlet');

INSERT INTO products (product_name, mr_price, online_price, category, available_for)
SELECT 'Chapati', 70, 75, 'Breads', ARRAY['mr_order', 'online_order']
WHERE NOT EXISTS (SELECT 1 FROM products WHERE product_name = 'Chapati');

INSERT INTO products (product_name, mr_price, online_price, category, available_for)
SELECT 'Water Bottle', 20, 20, 'Beverages', ARRAY['mr_order', 'online_order']
WHERE NOT EXISTS (SELECT 1 FROM products WHERE product_name = 'Water Bottle');
