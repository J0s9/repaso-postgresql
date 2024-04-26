CREATE OR REPLACE FUNCTION public.func_menudt_0(id_menudt integer)
 RETURNS void
 LANGUAGE plpgsql
AS $function$
BEGIN
    UPDATE menu_dt
    SET
    menu_acceso = FALSE
    WHERE
    cod_menudt = $1;
END;
$function$
;

CREATE OR REPLACE FUNCTION public.func_menudt_1(id_menudt integer)
 RETURNS void
 LANGUAGE plpgsql
AS $function$
BEGIN
    UPDATE menu_dt
    SET
    menu_acceso = TRUE
    WHERE
    cod_menudt = $1;
END;
$function$
;

CREATE OR REPLACE FUNCTION public.func_menudt_rol(tipo_rol integer)
 RETURNS TABLE(cod_menudt integer, cod_menu integer, cod_rol integer, menu_acceso boolean, create_at timestamp without time zone, state boolean, menu_name character varying, menu_ruta text, menu_grupo character varying)
 LANGUAGE plpgsql
AS $function$
BEGIN
    RETURN QUERY
    SELECT
        mt.cod_menudt,
        mt.cod_menu,
        mt.cod_rol,
        mt.menu_acceso,
        mt.create_at,
        mt.state,
        m.menu_name,
        m.menu_ruta,
        m.menu_grupo
    FROM menu_dt mt
    INNER JOIN menu m ON mt.cod_menu = m.cod_menu
    WHERE mt.cod_rol = tipo_rol;
END;
$function$
;




