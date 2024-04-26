CREATE OR REPLACE FUNCTION public.func_cliente_id(id_cliente integer)
 RETURNS TABLE(cod_cliente integer, cod_inst integer, first_name character varying, last_name character varying, ruc character varying, phone character varying, email character varying, create_at timestamp without time zone, state boolean, direction character varying)
 LANGUAGE plpgsql
AS $function$
BEGIN
    RETURN QUERY
    SELECT
        cliente.cod_cliente,
        cliente.cod_inst,
        cliente.first_name,
        cliente.last_name,
        cliente.ruc,
        cliente.phone,
        cliente.email,
        cliente.create_at,
        cliente."state",
        cliente.direction
    FROM
       cliente
    WHERE
        cliente.cod_cliente = id_cliente;
END;
$function$
;

CREATE OR REPLACE FUNCTION public.func_cliente_instituto(id_inst integer)
 RETURNS TABLE(cod_cliente integer, cod_inst integer, first_name character varying, last_name character varying, ruc character varying, phone character varying, email character varying, create_at timestamp without time zone, direction character varying, state boolean)
 LANGUAGE plpgsql
AS $function$
BEGIN
    RETURN QUERY
    SELECT
        c.cod_cliente,
        c.cod_inst,
        c.first_name,
        c.last_name,
        c.ruc,
        c.phone,
        c.email,
        c.create_at,
        c.direction,
        c."state"
    FROM
        cliente c
    WHERE
        c.cod_inst = id_inst
        AND
        c."state" = TRUE;
END;
$function$
;

CREATE OR REPLACE FUNCTION public.func_delete_cliente(eliminar integer)
 RETURNS void
 LANGUAGE plpgsql
AS $function$
BEGIN
    UPDATE cliente
    SET "state" = FALSE
    WHERE cliente.cod_cliente = eliminar;
END;
$function$
;

CREATE OR REPLACE FUNCTION public.func_insert_cliente(cod_inst integer, first_name character varying, last_name character varying, ruc character varying, phone character varying, email character varying, direction character varying)
 RETURNS void
 LANGUAGE plpgsql
AS $function$
BEGIN
    INSERT INTO cliente("cod_inst","first_name","last_name","ruc","phone","email","direction","create_at","state")
    VALUES ($1, UPPER($2), UPPER($3), $4, $5, $6,UPPER($7), NOW(),true);
END;
$function$
;

CREATE OR REPLACE FUNCTION public.func_update_cliente(id_cliente integer, id_inst integer, new_first_name character varying, new_last_name character varying, ruc character varying, phone character varying, new_email character varying, new_direction character varying)
 RETURNS void
 LANGUAGE plpgsql
AS $function$
BEGIN
    UPDATE cliente
    SET
        cod_inst = $2,
        first_name = UPPER($3),
        last_name = UPPER($4),
        ruc = $5,
        phone = $6,
        email = $7,
        direction = UPPER($8)
    WHERE
        cod_cliente = $1;
END;
$function$
;






