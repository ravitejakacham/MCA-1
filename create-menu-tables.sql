-- Enable UUID extension if not already enabled
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- Create mr_menu table
CREATE TABLE IF NOT EXISTS mr_menu (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name TEXT NOT NULL,
  category TEXT,
  price NUMERIC NOT NULL,
  created_at TIMESTAMP DEFAULT NOW()
);

-- Create online_order_menu table
CREATE TABLE IF NOT EXISTS online_order_menu (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name TEXT NOT NULL,
  category TEXT,
  price NUMERIC NOT NULL,
  created_at TIMESTAMP DEFAULT NOW()
);

-- Enable Row Level Security
ALTER TABLE mr_menu ENABLE ROW LEVEL SECURITY;
ALTER TABLE online_order_menu ENABLE ROW LEVEL SECURITY;

-- Create policies for authenticated users
CREATE POLICY "Allow all operations for authenticated users" ON mr_menu
FOR ALL USING (true);

CREATE POLICY "Allow all operations for authenticated users" ON online_order_menu
FOR ALL USING (true);

-- Create policies for anonymous users (read-only)
CREATE POLICY "Allow read for anonymous users" ON mr_menu
FOR SELECT USING (true);

CREATE POLICY "Allow read for anonymous users" ON online_order_menu
FOR SELECT USING (true);

-- Insert sample data for mr_menu
INSERT INTO mr_menu (name, category, price) VALUES
('Veg Meals', 'Meals', 110),
('Omlet', 'Sides', 20),
('Chapati', 'Breads', 70),
('Water Bottle', 'Beverages', 20)
ON CONFLICT DO NOTHING;

-- Insert sample data for online_order_menu
INSERT INTO online_order_menu (name, category, price) VALUES
('Veg Meals', 'Meals', 120),
('Omlet', 'Sides', 25),
('Chapati', 'Breads', 75),
('Water Bottle', 'Beverages', 20)
ON CONFLICT DO NOTHING;
