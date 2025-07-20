-- Create a function to create the menu_items table
CREATE OR REPLACE FUNCTION create_menu_items_table()
RETURNS void AS $$
BEGIN
  -- Check if the table already exists
  IF NOT EXISTS (
    SELECT FROM information_schema.tables 
    WHERE table_schema = 'public' 
    AND table_name = 'menu_items'
  ) THEN
    -- Create the menu_items table
    CREATE TABLE public.menu_items (
      id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
      name VARCHAR(255) NOT NULL UNIQUE,
      price DECIMAL(10, 2) NOT NULL,
      created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
    );
  END IF;
END;
$$ LANGUAGE plpgsql;

-- Create a function to insert default menu items
CREATE OR REPLACE FUNCTION insert_default_menu_items()
RETURNS void AS $$
BEGIN
  -- Insert default menu items if they don't exist
  INSERT INTO public.menu_items (name, price)
  VALUES 
    ('Veg Meals', 110),
    ('Omlet', 20),
    ('Chapati', 70),
    ('Water Bottle', 20)
  ON CONFLICT (name) DO NOTHING;
END;
$$ LANGUAGE plpgsql;
