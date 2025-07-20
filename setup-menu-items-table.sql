-- Create menu_items table if it doesn't exist
CREATE TABLE IF NOT EXISTS menu_items (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  name VARCHAR(255) NOT NULL UNIQUE,
  price DECIMAL(10, 2) NOT NULL,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Insert default menu items if they don't exist
INSERT INTO menu_items (name, price)
VALUES 
  ('Veg Meals', 110),
  ('Omlet', 20),
  ('Chapati', 70),
  ('Water Bottle', 20)
ON CONFLICT (name) DO NOTHING;
