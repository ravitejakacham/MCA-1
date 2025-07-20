-- Create food_items table (shared between MR and Online orders)
CREATE TABLE IF NOT EXISTS food_items (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  item_name TEXT NOT NULL UNIQUE,
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
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  UNIQUE(food_item_id)
);

-- Create online_order_prices table
CREATE TABLE IF NOT EXISTS online_order_prices (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  food_item_id UUID NOT NULL REFERENCES food_items(id) ON DELETE CASCADE,
  price DECIMAL(10, 2) NOT NULL,
  is_available BOOLEAN DEFAULT true,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  UNIQUE(food_item_id)
);

-- Insert sample data if tables are empty
INSERT INTO food_items (item_name, category, is_available)
SELECT 'Veg Meals', 'Meals', true
WHERE NOT EXISTS (SELECT 1 FROM food_items WHERE item_name = 'Veg Meals');

INSERT INTO food_items (item_name, category, is_available)
SELECT 'Omlet', 'Sides', true
WHERE NOT EXISTS (SELECT 1 FROM food_items WHERE item_name = 'Omlet');

INSERT INTO food_items (item_name, category, is_available)
SELECT 'Chapati', 'Breads', true
WHERE NOT EXISTS (SELECT 1 FROM food_items WHERE item_name = 'Chapati');

INSERT INTO food_items (item_name, category, is_available)
SELECT 'Water Bottle', 'Beverages', true
WHERE NOT EXISTS (SELECT 1 FROM food_items WHERE item_name = 'Water Bottle');

-- Insert MR prices
INSERT INTO mr_order_prices (food_item_id, price, is_available)
SELECT id, 110, true FROM food_items WHERE item_name = 'Veg Meals'
AND NOT EXISTS (SELECT 1 FROM mr_order_prices WHERE food_item_id = (SELECT id FROM food_items WHERE item_name = 'Veg Meals'));

INSERT INTO mr_order_prices (food_item_id, price, is_available)
SELECT id, 20, true FROM food_items WHERE item_name = 'Omlet'
AND NOT EXISTS (SELECT 1 FROM mr_order_prices WHERE food_item_id = (SELECT id FROM food_items WHERE item_name = 'Omlet'));

INSERT INTO mr_order_prices (food_item_id, price, is_available)
SELECT id, 70, true FROM food_items WHERE item_name = 'Chapati'
AND NOT EXISTS (SELECT 1 FROM mr_order_prices WHERE food_item_id = (SELECT id FROM food_items WHERE item_name = 'Chapati'));

INSERT INTO mr_order_prices (food_item_id, price, is_available)
SELECT id, 20, true FROM food_items WHERE item_name = 'Water Bottle'
AND NOT EXISTS (SELECT 1 FROM mr_order_prices WHERE food_item_id = (SELECT id FROM food_items WHERE item_name = 'Water Bottle'));

-- Insert Online prices
INSERT INTO online_order_prices (food_item_id, price, is_available)
SELECT id, 120, true FROM food_items WHERE item_name = 'Veg Meals'
AND NOT EXISTS (SELECT 1 FROM online_order_prices WHERE food_item_id = (SELECT id FROM food_items WHERE item_name = 'Veg Meals'));

INSERT INTO online_order_prices (food_item_id, price, is_available)
SELECT id, 25, true FROM food_items WHERE item_name = 'Omlet'
AND NOT EXISTS (SELECT 1 FROM online_order_prices WHERE food_item_id = (SELECT id FROM food_items WHERE item_name = 'Omlet'));

INSERT INTO online_order_prices (food_item_id, price, is_available)
SELECT id, 75, true FROM food_items WHERE item_name = 'Chapati'
AND NOT EXISTS (SELECT 1 FROM online_order_prices WHERE food_item_id = (SELECT id FROM food_items WHERE item_name = 'Chapati'));

INSERT INTO online_order_prices (food_item_id, price, is_available)
SELECT id, 20, true FROM food_items WHERE item_name = 'Water Bottle'
AND NOT EXISTS (SELECT 1 FROM online_order_prices WHERE food_item_id = (SELECT id FROM food_items WHERE item_name = 'Water Bottle'));
