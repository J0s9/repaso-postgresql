CREATE OR REPLACE FUNCTION public.func_delete_materia(id_materia integer)
 RETURNS void
 LANGUAGE plpgsql
AS $function$
BEGIN
    UPDATE materia
    SET "state" = FALSE
    WHERE materia.cod_materia = id_materia;
END;
$function$
;

CREATE OR REPLACE FUNCTION public.func_insert_materia(cod_sede integer, materia_name character varying, code character varying, hours numeric)
 RETURNS void
 LANGUAGE plpgsql
AS $function$
BEGIN
    INSERT INTO materia("cod_sede","materia_name","code","hours","create_at","state")
    VALUES ($1, UPPER($2), UPPER($3), $4, NOW(), true);
END;
$function$
;

CREATE OR REPLACE FUNCTION public.func_materia_id(id_materia integer)
 RETURNS TABLE(cod_materia integer, cod_sede integer, materia_name character varying, code character varying, hours numeric, create_at timestamp without time zone, state boolean)
 LANGUAGE plpgsql
AS $function$
BEGIN
    RETURN QUERY
    SELECT
        m.cod_materia,
        m.cod_sede,
        m.materia_name,
        m.code,
        m.hours,
        m.create_at,
        m."state"
    FROM public.materia m
    WHERE m.cod_materia = id_materia
    AND m."state"=TRUE;
END;
$function$
;

CREATE OR REPLACE FUNCTION public.func_materia_sede(id_sede integer)
 RETURNS TABLE(cod_materia integer, cod_sede integer, materia_name character varying, code character varying, hours numeric, create_at timestamp without time zone, state boolean)
 LANGUAGE plpgsql
AS $function$
BEGIN
    RETURN QUERY
    SELECT
        m.cod_materia,
        m.cod_sede,
        m.materia_name,
        m.code,
        m.hours,
        m.create_at,
        m."state"
    FROM public.materia m
    WHERE m.cod_sede = id_sede
    AND m."state"=TRUE;
END;
$function$
;

CREATE OR REPLACE FUNCTION public.func_update_materia(id_materia integer, id_sede integer, new_materia_name character varying, new_code character varying, hours numeric)
 RETURNS void
 LANGUAGE plpgsql
AS $function$
BEGIN
    UPDATE materia
    SET
    cod_materia = $1,
    cod_sede = $2,
    materia_name = UPPER($3),
    code = UPPER($4),
    hours = $5
    WHERE cod_materia = $1;
END;
$function$
;






