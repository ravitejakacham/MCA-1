-- Create a function to create the products table
CREATE OR REPLACE FUNCTION create_products_table()
RETURNS void AS $$
BEGIN
  -- Check if the table already exists
  IF NOT EXISTS (
    SELECT FROM information_schema.tables 
    WHERE table_schema = 'public' 
    AND table_name = 'products'
  ) THEN
    -- Create the products table
    CREATE TABLE public.products (
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
      ('Water Bottle', 20, 20, 'Beverages', ARRAY['mr_order', 'online_order']),
      ('Special Thali', 150, 170, 'Meals', ARRAY['mr_order']),
      ('Family Pack', 250, 280, 'Meals', ARRAY['online_order']);
      
    -- Create index for faster queries on available_for
    CREATE INDEX idx_products_available_for ON products USING GIN (available_for);
  END IF;
END;
$$ LANGUAGE plpgsql;
