CREATE OR REPLACE FUNCTION public.func_delete_rol(id_rol integer)
 RETURNS void
 LANGUAGE plpgsql
AS $function$
BEGIN
    UPDATE rol
    SET "state" = false
    WHERE cod_rol= id_rol;
END;
$function$
;

CREATE OR REPLACE FUNCTION public.func_rol_id(rol integer)
 RETURNS TABLE(cod_rol integer, cod_sede integer, rol_name character varying, create_at timestamp without time zone, state boolean)
 LANGUAGE plpgsql
AS $function$
BEGIN
    RETURN QUERY
    SELECT
		 rol.cod_rol,
		 rol.cod_sede,
		 rol.rol_name,
		 rol.create_at,
		 rol."state"
    FROM rol
    WHERE rol.cod_rol = $1
    AND rol."state"=TRUE;
END;
$function$
;

CREATE OR REPLACE FUNCTION public.func_rol_sede(sede integer)
 RETURNS TABLE(cod_rol integer, cod_sede integer, rol_name character varying, create_at timestamp without time zone, state boolean)
 LANGUAGE plpgsql
AS $function$
BEGIN
    RETURN QUERY
    SELECT
		 rol.cod_rol,
		 rol.cod_sede,
		 rol.rol_name,
		 rol.create_at,
		 rol."state"
    FROM rol
    WHERE rol.cod_sede = $1
    AND rol."state"=TRUE;
END;
$function$
;

CREATE OR REPLACE FUNCTION public.func_update_rol(id_rol integer, id_sede integer, name character varying)
 RETURNS void
 LANGUAGE plpgsql
AS $function$
BEGIN
    UPDATE rol
    SET
    cod_sede = $2,
    rol_name = UPPER($3)
    WHERE cod_rol = $1;
END;
$function$
;

CREATE OR REPLACE FUNCTION public.rol_list_id(id_rol integer)
 RETURNS TABLE(cod_rol integer, cod_sede integer, rol_name character varying, create_at timestamp without time zone, state boolean)
 LANGUAGE plpgsql
AS $function$
BEGIN
RETURN QUERY
SELECT 
    a.cod_rol,
    a.cod_sede,
    a.rol_name,
    a.create_at,
    a."state"
FROM rol a
INNER JOIN sede b ON a.cod_sede = b.cod_sede
WHERE a.cod_rol = id_rol
AND a."state" = TRUE;
END;
$function$
;

CREATE OR REPLACE FUNCTION public.rol_list_sede(id_sede integer)
 RETURNS TABLE(cod_rol integer, cod_sede integer, rol_name character varying, create_at timestamp without time zone, state boolean)
 LANGUAGE plpgsql
AS $function$
BEGIN
    RETURN QUERY
    SELECT 
        rol.cod_rol,
        rol.cod_sede,
        rol.rol_name,
        rol.create_at,
        rol."state"
    FROM rol
    INNER JOIN sede ON rol.cod_sede = sede.cod_sede
    WHERE rol.cod_sede = id_sede
    AND rol."state" = TRUE;
END;
$function$
;







