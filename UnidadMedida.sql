CREATE OR REPLACE FUNCTION public.func_delete_unidad(eliminar integer)
 RETURNS void
 LANGUAGE plpgsql
AS $function$
BEGIN
    UPDATE unidad_medida
    SET "state" = FALSE
    WHERE unidad_medida.cod_unidad = eliminar;
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

CREATE OR REPLACE FUNCTION public.func_insert_unidad(cod_sede integer, unidad character varying)
 RETURNS void
 LANGUAGE plpgsql
AS $function$
BEGIN
    INSERT INTO unidad_medida("cod_sede", "unidad_name", "create_at", "state")
    VALUES (cod_sede, UPPER(unidad), NOW(), true);
END;
$function$
;

CREATE OR REPLACE FUNCTION public.func_unidad_id(id_unidad integer)
 RETURNS TABLE(cod_unidad integer, cod_sede integer, unidad_name character varying, create_at timestamp without time zone, state boolean)
 LANGUAGE plpgsql
AS $function$
BEGIN
    RETURN QUERY
    SELECT
        u.cod_unidad,
        u.cod_sede,
        u.unidad_name,
        u.create_at,
        u."state"
    FROM unidad_medida u
    WHERE u.cod_unidad = id_unidad
    AND u."state"=TRUE;
END;
$function$
;

CREATE OR REPLACE FUNCTION public.func_unidad_sede(id_sede integer)
 RETURNS TABLE(cod_unidad integer, cod_sede integer, unidad_name character varying, create_at timestamp without time zone, state boolean)
 LANGUAGE plpgsql
AS $function$
BEGIN
    RETURN QUERY
    SELECT
        u.cod_unidad,
        u.cod_sede,
        u.unidad_name,
        u.create_at,
        u."state"
    FROM public.unidad_medida u
    WHERE u.cod_sede = id_sede
    AND u."state"=TRUE;
END;
$function$
;

CREATE OR REPLACE FUNCTION public.func_update_unidad(id_unidad integer, id_sede integer, new_name character varying)
 RETURNS void
 LANGUAGE plpgsql
AS $function$
BEGIN
    UPDATE unidad_medida
    SET
    cod_unidad = id_unidad,
    cod_sede = id_sede,
    unidad_name = UPPER(new_name)
    WHERE cod_unidad = id_unidad;
END;

$function$
;







