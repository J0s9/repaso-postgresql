CREATE OR REPLACE FUNCTION public.func_compradt_compra(id_compra integer)
 RETURNS TABLE(cod_comdt integer, cat_name character varying, prod_name character varying, unidad_name character varying, compra numeric, cantidad integer, total numeric, cod_compra integer, cod_prod integer)
 LANGUAGE plpgsql
AS $function$
BEGIN
    RETURN QUERY
    SELECT
        dtcompra.cod_comdt,
        cat.cat_name,
        producto.prod_name,
        unidad_medida.unidad_name,
        dtcompra.dtc_compra,
        dtcompra.dtc_cantidad,
        dtcompra.dtc_total,
        dtcompra.cod_compra,
        dtcompra.cod_prod
    FROM
        compra_dt dtcompra
    INNER JOIN producto ON dtcompra.cod_prod = producto.cod_prod
    INNER JOIN categoria AS cat ON producto.cod_cat = cat.cod_cat
    INNER JOIN unidad_medida ON producto.cod_unidad = unidad_medida.cod_unidad
    WHERE dtcompra.cod_compra = id_compra AND dtcompra."state" = 1;
END;
$function$
;

CREATE OR REPLACE FUNCTION public.func_insert_compra_sede(id_sede integer, id_user uuid)
 RETURNS integer
 LANGUAGE plpgsql
AS $function$
DECLARE
    v_compra_id integer;
BEGIN
    -- Insertar un nuevo registro en la tabla "compra" y recuperar el valor de "cod_compra"
    INSERT INTO compra("cod_sede", "cod_user", "state")
    VALUES (id_sede, id_user, 3)
    RETURNING cod_compra INTO v_compra_id;
    
    RETURN v_compra_id;
END;
$function$
;

CREATE OR REPLACE FUNCTION public.func_insert_compradt(id_compra integer, id_prod integer, dtc_compra numeric, dtc_cantidad integer)
 RETURNS void
 LANGUAGE plpgsql
AS $function$
BEGIN
    INSERT INTO compra_dt("cod_compra","cod_prod","dtc_compra","dtc_cantidad","dtc_total","state")
    VALUES (id_compra, id_prod, dtc_compra, dtc_cantidad, dtc_compra * dtc_cantidad,1);
    RETURN;
END;
$function$
;




