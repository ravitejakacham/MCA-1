-- Create a new table for product prices
CREATE TABLE IF NOT EXISTS product_prices (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  food_status_id UUID NOT NULL,
  mr_price DECIMAL(10, 2) NOT NULL,
  online_price DECIMAL(10, 2) NOT NULL,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  
  -- Add a foreign key constraint to link to food_status table
  CONSTRAINT fk_food_status
    FOREIGN KEY (food_status_id)
    REFERENCES food_status(id)
    ON DELETE CASCADE
);

-- Add initial prices for existing food items
INSERT INTO product_prices (food_status_id, mr_price, online_price)
SELECT id, 
  CASE 
    WHEN item_name = 'Veg Meals' THEN 110
    WHEN item_name = 'Omlet' THEN 20
    WHEN item_name = 'Chapati' THEN 70
    WHEN item_name = 'Water Bottle' THEN 20
    ELSE 0
  END as mr_price,
  CASE 
    WHEN item_name = 'Veg Meals' THEN 120
    WHEN item_name = 'Omlet' THEN 25
    WHEN item_name = 'Chapati' THEN 75
    WHEN item_name = 'Water Bottle' THEN 20
    ELSE 0
  END as online_price
FROM food_status
ON CONFLICT (food_status_id) DO NOTHING;
