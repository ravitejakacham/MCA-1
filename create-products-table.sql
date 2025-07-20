-- Create the products table
CREATE TABLE IF NOT EXISTS products (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  product_name TEXT NOT NULL,
  mr_price DECIMAL(10, 2) NOT NULL,
  online_price DECIMAL(10, 2) NOT NULL,
  category TEXT,
  available_for TEXT[] NOT NULL,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Add some sample products
INSERT INTO products (product_name, mr_price, online_price, category, available_for)
VALUES 
  ('Veg Meals', 110, 110, 'Meals', ARRAY['mr_order', 'online_order']),
  ('Omlet', 20, 20, 'Sides', ARRAY['mr_order', 'online_order']),
  ('Water Bottle', 20, 20, 'Beverages', ARRAY['mr_order', 'online_order']),
  ('Chapati', 70, 70, 'Breads', ARRAY['mr_order', 'online_order']);
