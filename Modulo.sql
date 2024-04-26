CREATE OR REPLACE FUNCTION public.func_delete_modulo(id_modulo integer)
 RETURNS void
 LANGUAGE plpgsql
AS $function$
BEGIN
    UPDATE modulo_carrera
    SET "state" = false
    WHERE cod_modulo = id_modulo;
END;
$function$
;

CREATE OR REPLACE FUNCTION public.func_insert_modulo(id_sede integer, id_carrera integer, modulo_name character varying, start_date date, end_date date)
 RETURNS void
 LANGUAGE plpgsql
AS $function$
BEGIN
    INSERT INTO modulo_carrera("cod_sede", "cod_carrera", "modulo_name", "start_date", "end_date", "create_at", "state")
    VALUES ($1, $2, UPPER($3), $4, $5, NOW(), true);
END;
$function$
;

CREATE OR REPLACE FUNCTION public.func_modulo_id(id_modulo integer)
 RETURNS TABLE(cod_modulo integer, cod_sede integer, cod_carrera integer, modulo_name character varying, start_date date, end_date date, create_at timestamp without time zone, state boolean, carrera_name character varying)
 LANGUAGE plpgsql
AS $function$
BEGIN
    RETURN QUERY
    SELECT
        m.cod_modulo,
        m.cod_sede,
        m.cod_carrera,
        m.modulo_name,
        m.start_date,
        m.end_date,
        m.create_at,
        m."state",
        c.carrera_name
    FROM
        modulo_carrera m
    INNER JOIN carrera c ON m.cod_carrera = c.cod_carrera 
    WHERE
        m.cod_modulo = id_modulo
        AND m."state" = TRUE;
END;

$function$
;

CREATE OR REPLACE FUNCTION public.func_modulo_sede(id_sede integer)
 RETURNS TABLE(cod_modulo integer, cod_sede integer, cod_carrera integer, modulo_name character varying, start_date date, end_date date, create_at timestamp without time zone, state boolean, carrera_name character varying)
 LANGUAGE plpgsql
AS $function$
BEGIN
    RETURN QUERY
    SELECT
        m.cod_modulo,
        m.cod_sede,
        m.cod_carrera,
        m.modulo_name,
        m.start_date,
        m.end_date,
        m.create_at,
        m."state",
        c.carrera_name
    FROM
        modulo_carrera m
    INNER JOIN carrera c ON m.cod_carrera = c.cod_carrera
    INNER JOIN sede ON m.cod_sede = sede.cod_sede
    WHERE
        m.cod_sede = id_sede
        AND m."state" = TRUE;
END;
$function$
;

CREATE OR REPLACE FUNCTION public.func_update_modulo(id_modulo integer, id_sede integer, id_carrera integer, modulo_name character varying, start_date date, end_date date)
 RETURNS void
 LANGUAGE plpgsql
AS $function$
BEGIN
    UPDATE modulo_carrera
    SET
        cod_sede = $2,
        cod_carrera = $3, 
        modulo_name = UPPER($4),
        start_date = $5,
        end_date = $6
    WHERE
        cod_modulo = $1;
END;
$function$
;






