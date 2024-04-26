CREATE OR REPLACE FUNCTION public.func_delete_user(eliminar uuid)
 RETURNS void
 LANGUAGE plpgsql
AS $function$
BEGIN
    UPDATE usuario
    SET "state" = FALSE
    WHERE cod_user = eliminar;
END;
$function$
;

CREATE OR REPLACE FUNCTION public.func_insert_user(cod_sede integer, first_name character varying, last_name character varying, user_name character varying, phone character varying, email character varying, password text, rol integer)
 RETURNS void
 LANGUAGE plpgsql
AS $function$
BEGIN
    INSERT INTO usuario("cod_sede", "first_name", "last_name", "user_name", "password", "phone",  "email","create_at", "state", "rol")
    VALUES ($1, UPPER($2), UPPER($3), $4, crypt($7, gen_salt('bf')), $5, $6, NOW(), true, $8);
END;
$function$
;

CREATE OR REPLACE FUNCTION public.func_list_user_id(id_user uuid)
 RETURNS TABLE(cod_user uuid, cod_sede integer, first_name character varying, last_name character varying, user_name character varying, password text, phone character varying, email character varying, create_at timestamp without time zone, rol integer, state boolean)
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
        '' AS password,  -- Campo vacío
        usuario.phone,
        usuario.email,
        usuario.create_at,
        usuario.rol,
        usuario."state"
    FROM
        usuario
    WHERE
        usuario.cod_user = id_user;
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

CREATE OR REPLACE FUNCTION public.func_update_user(id_user uuid, id_sede integer, new_first_name character varying, new_last_name character varying, username character varying, phone character varying, new_password text, new_email character varying, new_rol integer)
 RETURNS void
 LANGUAGE plpgsql
AS $function$
DECLARE
    new_hashed_password text;
BEGIN
    -- Verifica si se proporcionó una nueva contraseña
    IF new_password IS NOT NULL THEN
        -- Genera un nuevo "salt" aleatorio y cifra la nueva contraseña
        new_hashed_password = crypt(new_password, gen_salt('bf'));
    END IF;

    -- Actualiza la tabla usuario
    UPDATE usuario
    SET
        cod_sede = $2,
        first_name = UPPER($3),
        last_name = UPPER($4),
        user_name = $5,
        phone = $6,
        password = CASE WHEN $7 IS NOT NULL THEN new_hashed_password ELSE password END,
        email = $8,
        rol = $9
    WHERE
        cod_user = $1;
END;
$function$
;

CREATE OR REPLACE FUNCTION public.func_update_user_pass(id_user uuid, new_pass text)
 RETURNS void
 LANGUAGE plpgsql
AS $function$
BEGIN
    UPDATE usuario
    SET
        password = crypt($2, gen_salt('bf'))
    WHERE
        cod_user = $1;
END;
$function$
;

CREATE OR REPLACE FUNCTION public.func_user_acceso(sede integer, name_user character varying, pass text)
 RETURNS TABLE(cod_user uuid, cod_sede integer, first_name character varying, last_name character varying, user_name character varying, user_password text, phone character varying, email character varying, create_at timestamp without time zone, state boolean, sede_name character varying, cod_inst integer, inst_name character varying, user_rol character varying, cod_rol integer)
 LANGUAGE plpgsql
AS $function$
BEGIN
    RETURN QUERY
    SELECT 
        a.cod_user,
        a.cod_sede,
        a.first_name,
        a.last_name,
        a.user_name,
        a."password" AS user_password,
        a.phone,
        a.email,
        a.create_at,
        a."state",
        b.sede_name,
        c.cod_inst,
        c.inst_name,
        rol.rol_name AS user_rol,
        rol.cod_rol
    FROM usuario a
    INNER JOIN sede b ON a.cod_sede = b.cod_sede
    INNER JOIN instituto c ON b.cod_inst = c.cod_inst
    INNER JOIN rol ON a.rol = rol.cod_rol
    WHERE a.user_name = name_user AND a."password" = crypt(pass, a."password") AND a."state" = TRUE;
END;
$function$
;








