
-- Audit Logs
CREATE TABLE access_logs (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  actor uuid REFERENCES profiles(id),
  action text,
  platform text,
  created_at timestamptz DEFAULT now()
);

-- Mobile restricted RPC
CREATE OR REPLACE FUNCTION process_mobile_sale(product_id uuid, qty int)
RETURNS json AS $$
DECLARE
  u_role user_role := public.get_my_role();
BEGIN
  IF u_role NOT IN ('sales', 'student') THEN
    RAISE EXCEPTION 'Access Denied: Mobile operations restricted for %', u_role;
  END IF;

  -- Placeholder for sale logic
  INSERT INTO access_logs (actor, action, platform) 
  VALUES (auth.uid(), 'MOBILE_SALE_PROCESSED', 'mobile');

  RETURN json_build_object('status', 'success');
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;
