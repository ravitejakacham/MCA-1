-- Drop existing functions if they exist
DROP FUNCTION IF EXISTS create_menu_items_table();
DROP FUNCTION IF EXISTS insert_default_menu_items();

-- Create an updated function to create the menu_items table with new fields
CREATE OR REPLACE FUNCTION create_menu_items_table()
RETURNS void AS $$
BEGIN
  -- Check if the table already exists
  IF NOT EXISTS (
    SELECT FROM information_schema.tables 
    WHERE table_schema = 'public' 
    AND table_name = 'menu_items'
  ) THEN
    -- Create the menu_items table with enhanced fields
    CREATE TABLE public.menu_items (
      id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
      name VARCHAR(255) NOT NULL UNIQUE,
      mr_price DECIMAL(10, 2) NOT NULL,
      online_price DECIMAL(10, 2) NOT NULL,
      category VARCHAR(100),
      available_for VARCHAR(255) NOT NULL DEFAULT 'mr_order,online_order',
      created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
    );
  ELSE
    -- If table exists, check if we need to add the new columns
    IF NOT EXISTS (SELECT FROM information_schema.columns WHERE table_schema = 'public' AND table_name = 'menu_items' AND column_name = 'mr_price') THEN
      ALTER TABLE public.menu_items ADD COLUMN mr_price DECIMAL(10, 2);
      -- Copy existing price to mr_price
      UPDATE public.menu_items SET mr_price = price WHERE mr_price IS NULL;
    END IF;
    
    IF NOT EXISTS (SELECT FROM information_schema.columns WHERE table_schema = 'public' AND table_name = 'menu_items' AND column_name = 'online_price') THEN
      ALTER TABLE public.menu_items ADD COLUMN online_price DECIMAL(10, 2);
      -- Copy existing price to online_price
      UPDATE public.menu_items SET online_price = price WHERE online_price IS NULL;
    END IF;
    
    IF NOT EXISTS (SELECT FROM information_schema.columns WHERE table_schema = 'public' AND table_name = 'menu_items' AND column_name = 'category') THEN
      ALTER TABLE public.menu_items ADD COLUMN category VARCHAR(100);
    END IF;
    
    IF NOT EXISTS (SELECT FROM information_schema.columns WHERE table_schema = 'public' AND table_name = 'menu_items' AND column_name = 'available_for') THEN
      ALTER TABLE public.menu_items ADD COLUMN available_for VARCHAR(255) DEFAULT 'mr_order,online_order';
      -- Set default value for existing records
      UPDATE public.menu_items SET available_for = 'mr_order,online_order' WHERE available_for IS NULL;
    END IF;
  END IF;
END;
$$ LANGUAGE plpgsql;

-- Create an updated function to insert default menu items
CREATE OR REPLACE FUNCTION insert_default_menu_items()
RETURNS void AS $$
BEGIN
  -- Insert default menu items if they don't exist
  INSERT INTO public.menu_items (name, mr_price, online_price, category, available_for)
  VALUES 
    ('Veg Meals', 110, 110, 'Meals', 'mr_order,online_order'),
    ('Omlet', 20, 25, 'Add-ons', 'mr_order,online_order'),
    ('Chapati', 70, 75, 'Breads', 'mr_order,online_order'),
    ('Water Bottle', 20, 20, 'Beverages', 'mr_order,online_order')
  ON CONFLICT (name) DO UPDATE
  SET 
    mr_price = EXCLUDED.mr_price,
    online_price = EXCLUDED.online_price,
    category = EXCLUDED.category,
    available_for = EXCLUDED.available_for;
END;
$$ LANGUAGE plpgsql;
