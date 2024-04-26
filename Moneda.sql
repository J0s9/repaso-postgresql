CREATE OR REPLACE FUNCTION public.func_delete_moneda(eliminar integer)
 RETURNS void
 LANGUAGE plpgsql
AS $function$
BEGIN
    UPDATE moneda
    SET "state" = FALSE
    WHERE moneda.cod_moneda = eliminar;
END;
$function$
;

CREATE OR REPLACE FUNCTION public.func_insert_moneda(cod_sede integer, moneda character varying)
 RETURNS void
 LANGUAGE plpgsql
AS $function$
BEGIN
    INSERT INTO moneda("cod_sede", "moneda_name", "create_at", "state")
    VALUES (cod_sede, UPPER(moneda), NOW(), true);
END;
$function$
;

CREATE OR REPLACE FUNCTION public.func_moneda_id(id_moneda integer)
 RETURNS TABLE(cod_moneda integer, cod_sede integer, moneda_name character varying, create_at timestamp without time zone, state boolean)
 LANGUAGE plpgsql
AS $function$
BEGIN
    RETURN QUERY
    SELECT
        moneda.cod_moneda,
        moneda.cod_sede,
        moneda.moneda_name,
        moneda.create_at,
        moneda."state"
    FROM public.moneda
    WHERE moneda.cod_moneda = id_moneda
    AND moneda."state"=TRUE;
END;
$function$
;

CREATE OR REPLACE FUNCTION public.func_moneda_sede(id_sede integer)
 RETURNS TABLE(cod_moneda integer, cod_sede integer, moneda_name character varying, create_at timestamp without time zone, state boolean)
 LANGUAGE plpgsql
AS $function$
BEGIN
    RETURN QUERY
    SELECT
        moneda.cod_moneda,
        moneda.cod_sede,
        moneda.moneda_name,
        moneda.create_at,
        moneda."state"
    FROM public.moneda
    WHERE moneda.cod_sede = id_sede
    AND moneda."state"=TRUE;
END;
$function$
;

CREATE OR REPLACE FUNCTION public.func_update_moneda(id_moneda integer, id_sede integer, new_name character varying)
 RETURNS void
 LANGUAGE plpgsql
AS $function$
BEGIN
    UPDATE moneda
    SET
    cod_moneda = id_moneda,
    cod_sede = id_sede,
    moneda_name = UPPER(new_name)
    WHERE cod_moneda = id_moneda;
END;

$function$
;






