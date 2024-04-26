CREATE OR REPLACE FUNCTION public.func_listar_pagos()
 RETURNS TABLE(cod_pago integer, pago_name character varying, create_at timestamp without time zone, state boolean)
 LANGUAGE plpgsql
AS $function$
BEGIN
    RETURN QUERY
    SELECT 
        p.cod_pago,
        p.pago_name,
        p.create_at,
        p.state
    FROM
        public.pago p
    WHERE
        p.state = true;
END;
$function$
;

