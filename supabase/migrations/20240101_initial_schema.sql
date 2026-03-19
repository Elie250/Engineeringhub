
-- Create Roles and Profiles
CREATE TYPE user_role AS ENUM ('admin', 'instructor', 'student', 'sales');

CREATE TABLE profiles (
  id uuid REFERENCES auth.users ON DELETE CASCADE PRIMARY KEY,
  full_name text,
  role user_role DEFAULT 'student',
  updated_at timestamptz DEFAULT now()
);

-- Helper for RLS
CREATE OR REPLACE FUNCTION public.get_my_role()
RETURNS user_role AS $$
  SELECT role FROM public.profiles WHERE id = auth.uid();
$$ LANGUAGE sql STABLE;

-- Tables
CREATE TABLE products (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  name text NOT NULL,
  sku text UNIQUE,
  price numeric NOT NULL,
  stock int DEFAULT 0
);

CREATE TABLE sales (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  salesperson_id uuid REFERENCES profiles(id),
  total_amount numeric,
  created_at timestamptz DEFAULT now()
);

-- RLS
ALTER TABLE profiles ENABLE ROW LEVEL SECURITY;
ALTER TABLE products ENABLE ROW LEVEL SECURITY;
ALTER TABLE sales ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Public profiles are viewable by everyone" ON profiles FOR SELECT USING (true);
CREATE POLICY "Users can update own profile" ON profiles FOR UPDATE USING (auth.uid() = id);
CREATE POLICY "Admins can manage products" ON products ALL USING (get_my_role() = 'admin');
CREATE POLICY "Sales can view inventory" ON products FOR SELECT USING (get_my_role() IN ('sales', 'admin'));
