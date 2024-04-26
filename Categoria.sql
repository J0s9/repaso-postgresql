CREATE OR REPLACE FUNCTION public.func_categoria_id(id_cat integer)
 RETURNS TABLE(cod_cat integer, cod_sede integer, cat_name character varying, create_at timestamp without time zone, state boolean)
 LANGUAGE plpgsql
AS $function$
BEGIN
    RETURN QUERY
    SELECT
        ct.cod_cat,
        ct.cod_sede,
        ct.cat_name,
        ct.create_at,
        ct."state"
    FROM public.categoria ct
    WHERE ct.cod_cat = id_cat
    AND ct."state"=TRUE;
END;
$function$
;

CREATE OR REPLACE FUNCTION public.func_categoria_sede(id_sede integer)
 RETURNS TABLE(cod_cat integer, cod_sede integer, cat_name character varying, create_at timestamp without time zone, state boolean)
 LANGUAGE plpgsql
AS $function$
BEGIN
    RETURN QUERY
    SELECT
        ct.cod_cat,
        ct.cod_sede,
        ct.cat_name,
        ct.create_at,
        ct."state"
    FROM public.categoria ct
    WHERE ct.cod_sede = id_sede
    AND ct."state"=TRUE;
END;
$function$
;

CREATE OR REPLACE FUNCTION public.func_delete_categoria(eliminar integer)
 RETURNS void
 LANGUAGE plpgsql
AS $function$
BEGIN
    UPDATE categoria
    SET "state" = FALSE
    WHERE categoria.cod_cat = eliminar;
END;
$function$
;

CREATE OR REPLACE FUNCTION public.func_insert_categoria(cod_sede integer, categoria character varying)
 RETURNS void
 LANGUAGE plpgsql
AS $function$
BEGIN
    INSERT INTO categoria("cod_sede", "cat_name", "create_at", "state")
    VALUES (cod_sede, UPPER(categoria), NOW(), true);
END;
$function$
;

CREATE OR REPLACE FUNCTION public.func_update_categoria(id_cat integer, id_sede integer, new_name character varying)
 RETURNS void
 LANGUAGE plpgsql
AS $function$
BEGIN
    UPDATE categoria
    SET
    cod_cat = id_cat,
    cod_sede = id_sede,
    cat_name = UPPER(new_name)
    WHERE cod_cat = id_cat;
END;

$function$
;






