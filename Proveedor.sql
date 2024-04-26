CREATE OR REPLACE FUNCTION public.func_delete_proveedor(eliminar integer)
 RETURNS void
 LANGUAGE plpgsql
AS $function$
BEGIN
    UPDATE proveedor
    SET "state" = FALSE
    WHERE proveedor.cod_prov = eliminar;
END;
$function$
;

CREATE OR REPLACE FUNCTION public.func_insert_proveedor(cod_inst integer, first_name character varying, last_name character varying, ruc character varying, phone character varying, email character varying, direction character varying)
 RETURNS void
 LANGUAGE plpgsql
AS $function$
BEGIN
    INSERT INTO proveedor("cod_inst","first_name","last_name","ruc","phone","email","direction","create_at","state")
    VALUES ($1, UPPER($2), UPPER($3), $4, $5, $6,UPPER($7), NOW(),true);
END;
$function$
;

CREATE OR REPLACE FUNCTION public.func_proveedor_id(id_prov integer)
 RETURNS TABLE(cod_prov integer, cod_inst integer, first_name character varying, last_name character varying, ruc character varying, phone character varying, email character varying, create_at timestamp without time zone, state boolean, direction character varying)
 LANGUAGE plpgsql
AS $function$
BEGIN
    RETURN QUERY
    SELECT
        proveedor.cod_prov,
        proveedor.cod_inst,
        proveedor.first_name,
        proveedor.last_name,
        proveedor.ruc,
        proveedor.phone,
        proveedor.email,
        proveedor.create_at,
        proveedor."state",
        proveedor.direction
    FROM
       proveedor
    WHERE
        proveedor.cod_prov = id_prov;
END;
$function$
;

CREATE OR REPLACE FUNCTION public.func_proveedor_instituto(id_inst integer)
 RETURNS TABLE(cod_prov integer, cod_inst integer, first_name character varying, last_name character varying, ruc character varying, phone character varying, email character varying, create_at timestamp without time zone, direction character varying, state boolean)
 LANGUAGE plpgsql
AS $function$
BEGIN
    RETURN QUERY
    SELECT
        proveedor.cod_prov,
        proveedor.cod_inst,
        proveedor.first_name,
        proveedor.last_name,
        proveedor.ruc,
        proveedor.phone,
        proveedor.email,
        proveedor.create_at,
        proveedor.direction,
        proveedor."state"
    FROM
        proveedor 
    WHERE
        proveedor.cod_inst = id_inst
        AND
        proveedor."state" = TRUE;
END;
$function$
;

CREATE OR REPLACE FUNCTION public.func_update_proveedor(id_prov integer, id_inst integer, new_first_name character varying, new_last_name character varying, ruc character varying, phone character varying, new_email character varying, new_direction character varying)
 RETURNS void
 LANGUAGE plpgsql
AS $function$
BEGIN
    UPDATE proveedor
    SET
        cod_inst = $2,
        first_name = UPPER($3),
        last_name = UPPER($4),
        ruc = $5,
        phone = $6,
        email = $7,
        direction = UPPER($8)
    WHERE
        cod_prov = $1;
END;
$function$
;






