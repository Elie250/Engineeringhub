-- 03_platform_access.sql

-- helper to fetch role for current auth.uid()
CREATE OR REPLACE FUNCTION public.user_role()
RETURNS text LANGUAGE sql STABLE
AS $$
  SELECT role FROM public.profiles WHERE id = auth.uid();
$$;

-- access logs table for auditing
CREATE TABLE IF NOT EXISTS public.access_logs (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  actor uuid REFERENCES public.profiles(id),
  actor_role text,
  action text,
  target_table text,
  created_at timestamptz DEFAULT now()
);

-- Example: enable RLS on sales and restrict mobile RPCs
ALTER TABLE IF EXISTS public.sales ENABLE ROW LEVEL SECURITY;

-- Policy: allow creation of sales only by sales or student (mobile) or admin when request.platform='web'
CREATE POLICY IF NOT EXISTS sales_platform_policy ON public.sales
  FOR ALL
  USING (
    (
      (SELECT role FROM public.profiles WHERE id = auth.uid()) IN ('sales','student')
    )
    OR
    (
      current_setting('request.platform', true) = 'web'
      AND (SELECT role FROM public.profiles WHERE id = auth.uid()) IN ('admin')
    )
  )
  WITH CHECK (
    (
      (SELECT role FROM public.profiles WHERE id = auth.uid()) IN ('sales','student')
    )
    OR
    (
      current_setting('request.platform', true) = 'web'
      AND (SELECT role FROM public.profiles WHERE id = auth.uid()) IN ('admin')
    )
  );

-- Example RPC that enforces role checks for mobile sale processing
-- See supabase/functions/rpc_mobile_process_sale.sql
