CREATE OR REPLACE FUNCTION public.func_delete_sede(id_sede integer)
 RETURNS void
 LANGUAGE plpgsql
AS $function$
BEGIN
    UPDATE sede
    SET "state" = false
    WHERE cod_sede = id_sede;
END;
$function$
;

CREATE OR REPLACE FUNCTION public.func_insert_sede(cod_inst integer, new_name character varying)
 RETURNS void
 LANGUAGE plpgsql
AS $function$
BEGIN
    INSERT INTO sede("cod_inst","sede_name", "create_at", "state")
    VALUES ($1, UPPER($2), NOW(), true);
END;
$function$
;

CREATE OR REPLACE FUNCTION public.func_list_sede_inst(id_inst integer)
 RETURNS TABLE(cod_sede integer, cod_inst integer, sede_name character varying, create_at timestamp without time zone, state boolean, inst_name character varying)
 LANGUAGE plpgsql
AS $function$
	BEGIN
	    RETURN QUERY
SELECT
    a.cod_sede,
    a.cod_inst,
    a.sede_name,
    a.create_at,
    a."state",
    instituto.inst_name
FROM
    sede a
INNER JOIN instituto ON a.cod_inst = instituto.cod_inst
WHERE
    a.cod_inst = id_inst
    AND
    a."state" = TRUE;

	END;
	$function$
;

CREATE OR REPLACE FUNCTION public.func_list_user_sede(id_sede integer)
 RETURNS TABLE(cod_user uuid, cod_sede integer, first_name character varying, last_name character varying, user_name character varying, password text, phone character varying, email character varying, rol integer, create_at timestamp without time zone, state boolean, rol_name character varying)
 LANGUAGE plpgsql
AS $function$
BEGIN
    RETURN QUERY
    SELECT
        usuario.cod_user,
        usuario.cod_sede,
        usuario.first_name,
        usuario.last_name,
        usuario.user_name,
        usuario."password",
        usuario.phone,
        usuario.email,
        usuario.rol,
        usuario.create_at,
        usuario."state",
        rol.rol_name
    FROM
        usuario
    INNER JOIN rol
    ON usuario.rol = rol.cod_rol
    INNER JOIN sede ON usuario.cod_sede = sede.cod_sede
    WHERE
        usuario.cod_sede = id_sede
        AND
        usuario."state" = TRUE;
END;
$function$
;

CREATE OR REPLACE FUNCTION public.func_update_sede(id_sede integer, id_inst integer, new_name character varying)
 RETURNS void
 LANGUAGE plpgsql
AS $function$
BEGIN
    UPDATE sede
    SET
    cod_sede = $1,
    cod_inst = $2,
    sede_name = UPPER($3)
    WHERE cod_sede = $1;
END;
$function$
;






