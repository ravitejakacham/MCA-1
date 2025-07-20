-- Run this SQL in the Supabase SQL Editor if the automatic initialization fails

-- Create products table
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
  ('Veg Meals', 110, 120, 'Meals', ARRAY['mr_order', 'online_order']),
  ('Omlet', 20, 25, 'Sides', ARRAY['mr_order', 'online_order']),
  ('Chapati', 70, 75, 'Breads', ARRAY['mr_order', 'online_order']),
  ('Water Bottle', 20, 20, 'Beverages', ARRAY['mr_order', 'online_order']);

-- Create index for faster queries on available_for
CREATE INDEX IF NOT EXISTS idx_products_available_for ON products USING GIN (available_for);
