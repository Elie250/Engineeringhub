-- rpc_mobile_process_sale.sql
CREATE OR REPLACE FUNCTION public.rpc_mobile_process_sale(p_payload json)
RETURNS json LANGUAGE plpgsql SECURITY DEFINER AS $$
DECLARE
  actor_role text := (SELECT role FROM public.profiles WHERE id = auth.uid());
BEGIN
  IF actor_role IS NULL THEN
    RAISE EXCEPTION 'Unauthenticated';
  END IF;
  IF NOT (actor_role IN ('sales','student')) THEN
    RAISE EXCEPTION 'Mobile access forbidden for role: %', actor_role;
  END IF;

  -- Call an internal function to create the sale (implement in your DB)
  -- PERFORM public.create_sale_from_payload(p_payload, auth.uid());

  INSERT INTO public.access_logs(actor, actor_role, action, target_table)
    VALUES (auth.uid(), actor_role, 'rpc_mobile_process_sale', 'sales');

  RETURN json_build_object('status','ok');
END;
$$;

GRANT EXECUTE ON FUNCTION public.rpc_mobile_process_sale(json) TO authenticated;
