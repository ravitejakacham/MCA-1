-- Create food_items table
CREATE TABLE IF NOT EXISTS food_items (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  item_name TEXT NOT NULL,
  category TEXT,
  is_available BOOLEAN DEFAULT true,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Create mr_order_prices table
CREATE TABLE IF NOT EXISTS mr_order_prices (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  food_item_id UUID NOT NULL REFERENCES food_items(id) ON DELETE CASCADE,
  price DECIMAL(10, 2) NOT NULL,
  is_available BOOLEAN DEFAULT true,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Create online_order_prices table
CREATE TABLE IF NOT EXISTS online_order_prices (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  food_item_id UUID NOT NULL REFERENCES food_items(id) ON DELETE CASCADE,
  price DECIMAL(10, 2) NOT NULL,
  is_available BOOLEAN DEFAULT true,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Add some sample data
INSERT INTO food_items (item_name, category, is_available)
VALUES 
  ('Veg Meals', 'Meals', true),
  ('Omlet', 'Sides', true),
  ('Chapati', 'Breads', true),
  ('Water Bottle', 'Beverages', true);

-- Get the IDs of the inserted items
WITH food_ids AS (
  SELECT id FROM food_items WHERE item_name IN ('Veg Meals', 'Omlet', 'Chapati', 'Water Bottle')
)
-- Insert MR prices
INSERT INTO mr_order_prices (food_item_id, price, is_available)
SELECT 
  id,
  CASE 
    WHEN item_name = 'Veg Meals' THEN 110
    WHEN item_name = 'Omlet' THEN 20
    WHEN item_name = 'Chapati' THEN 70
    WHEN item_name = 'Water Bottle' THEN 20
    ELSE 0
  END,
  true
FROM food_items
WHERE item_name IN ('Veg Meals', 'Omlet', 'Chapati', 'Water Bottle');

-- Insert Online prices
INSERT INTO online_order_prices (food_item_id, price, is_available)
SELECT 
  id,
  CASE 
    WHEN item_name = 'Veg Meals' THEN 120
    WHEN item_name = 'Omlet' THEN 25
    WHEN item_name = 'Chapati' THEN 75
    WHEN item_name = 'Water Bottle' THEN 20
    ELSE 0
  END,
  true
FROM food_items
WHERE item_name IN ('Veg Meals', 'Omlet', 'Chapati', 'Water Bottle');

-- Create RLS policies for these tables
ALTER TABLE food_items ENABLE ROW LEVEL SECURITY;
ALTER TABLE mr_order_prices ENABLE ROW LEVEL SECURITY;
ALTER TABLE online_order_prices ENABLE ROW LEVEL SECURITY;

-- Create policies that allow all operations for authenticated users
CREATE POLICY "Allow all operations for authenticated users" ON food_items
  FOR ALL USING (auth.role() = 'authenticated');

CREATE POLICY "Allow all operations for authenticated users" ON mr_order_prices
  FOR ALL USING (auth.role() = 'authenticated');

CREATE POLICY "Allow all operations for authenticated users" ON online_order_prices
  FOR ALL USING (auth.role() = 'authenticated');

-- Create policies that allow read operations for anonymous users
CREATE POLICY "Allow read for anonymous users" ON food_items
  FOR SELECT USING (true);

CREATE POLICY "Allow read for anonymous users" ON mr_order_prices
  FOR SELECT USING (true);

CREATE POLICY "Allow read for anonymous users" ON online_order_prices
  FOR SELECT USING (true);
