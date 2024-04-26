CREATE OR REPLACE FUNCTION public.func_delete_inst(id_inst integer)
 RETURNS void
 LANGUAGE plpgsql
AS $function$
BEGIN
    UPDATE instituto
    SET "state" = false
    WHERE cod_inst = id_inst;
END;
$function$
;

CREATE OR REPLACE FUNCTION public.func_insert_inst(new_name character varying)
 RETURNS void
 LANGUAGE plpgsql
AS $function$
BEGIN
    INSERT INTO instituto("inst_name", "create_at", "state")
    VALUES (UPPER($1), NOW(), true);
END;
$function$
;

CREATE OR REPLACE FUNCTION public.func_list_inst_id(id_inst integer)
 RETURNS TABLE(cod_inst integer, name character varying, create_at timestamp without time zone, state boolean)
 LANGUAGE plpgsql
AS $function$
BEGIN
    RETURN QUERY
    SELECT
	instituto.cod_inst,
	instituto.inst_name,
	instituto.create_at,
	instituto."state"
    FROM
        instituto
    WHERE
    	instituto.cod_inst = id_inst;
END;
$function$
;

CREATE OR REPLACE FUNCTION public.func_list_inst_state()
 RETURNS TABLE(cod_inst integer, inst_name character varying, create_at timestamp without time zone, state boolean)
 LANGUAGE plpgsql
AS $function$
BEGIN
    RETURN QUERY
    SELECT
        instituto.cod_inst,
        instituto.inst_name,
        instituto.create_at,
        instituto."state"
    FROM
        instituto
    WHERE
        instituto."state" = TRUE;
END;
$function$
;

CREATE OR REPLACE FUNCTION public.func_update_inst(id_inst integer, new_name character varying)
 RETURNS void
 LANGUAGE plpgsql
AS $function$
BEGIN
    UPDATE instituto
    SET inst_name = UPPER(new_name)
    WHERE cod_inst = id_inst;
END;
$function$
;






