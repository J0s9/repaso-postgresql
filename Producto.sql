CREATE OR REPLACE FUNCTION public.func_delete_producto(eliminar integer)
 RETURNS void
 LANGUAGE plpgsql
AS $function$
BEGIN
    UPDATE producto
    SET "state" = FALSE
    WHERE cod_prod = eliminar;

END;
$function$
;

CREATE OR REPLACE FUNCTION public.func_insert_producto(sede integer, cat integer, prod_name character varying, descrip text, unidad integer, moneda integer, compra numeric, venta numeric, stock numeric, expiration date, image text)
 RETURNS void
 LANGUAGE plpgsql
AS $function$
BEGIN
    INSERT INTO producto("cod_sede","cod_cat","prod_name","prod_descrip",
        "cod_unidad","cod_moneda","compra","venta","stock","expiration","image","create_at","state")
    VALUES ($1, $2, UPPER($3), $4, $5, $6, $7, $8, $9, $10, $11, NOW(), true);
END;
$function$
;

CREATE OR REPLACE FUNCTION public.func_producto_categoria(cat integer)
 RETURNS TABLE(cod_prod integer, cod_sede integer, cod_cat integer, prod_name character varying, prod_descrip text, cod_unidad integer, cod_moneda integer, compra numeric, venta numeric, stock numeric, expiration date, image text, create_at timestamp without time zone, state boolean, cat_name character varying, unidad_name character varying, moneda_name character varying)
 LANGUAGE plpgsql
AS $function$
BEGIN
    RETURN QUERY
    SELECT
        prod.cod_prod,
        prod.cod_sede,
        prod.cod_cat,
        prod.prod_name,
        prod.prod_descrip,
        prod.cod_unidad,
        prod.cod_moneda,
        prod.compra,
        prod.venta,
        prod.stock,
        prod.expiration,
        prod.image,
        prod.create_at,
        prod."state",
        ct.cat_name,
        um.unidad_name,
        m.moneda_name
    FROM producto prod
    INNER JOIN categoria ct ON prod.cod_cat = ct.cod_cat
    INNER JOIN unidad_medida um ON prod.cod_unidad = um.cod_unidad
    INNER JOIN moneda m ON prod.cod_moneda = m.cod_moneda
    WHERE prod.cod_cat = cat
    AND prod."state"=TRUE;
END;
$function$
;

CREATE OR REPLACE FUNCTION public.func_producto_id(id_prod integer)
 RETURNS TABLE(cod_prod integer, cod_sede integer, cod_cat integer, prod_name character varying, prod_descrip text, cod_unidad integer, cod_moneda integer, compra numeric, venta numeric, stock numeric, expiration date, image text, create_at timestamp without time zone, state boolean, cat_name character varying, unidad_name character varying, moneda_name character varying)
 LANGUAGE plpgsql
AS $function$
BEGIN
    RETURN QUERY
    SELECT
        prod.cod_prod,
        prod.cod_sede,
        prod.cod_cat,
        prod.prod_name,
        prod.prod_descrip,
        prod.cod_unidad,
        prod.cod_moneda,
        prod.compra,
        prod.venta,
        prod.stock,
        prod.expiration,
        prod.image,
        prod.create_at,
        prod."state",
        ct.cat_name,
        um.unidad_name,
        m.moneda_name
    FROM producto prod
    INNER JOIN categoria ct ON prod.cod_cat = ct.cod_cat
    INNER JOIN unidad_medida um ON prod.cod_unidad = um.cod_unidad
    INNER JOIN moneda m ON prod.cod_moneda = m.cod_moneda
    WHERE prod.cod_prod = id_prod
    AND prod."state"=TRUE;
END;
$function$
;

CREATE OR REPLACE FUNCTION public.func_producto_sede(id_sede integer)
 RETURNS TABLE(cod_prod integer, cod_sede integer, cod_cat integer, prod_name character varying, prod_descrip text, cod_unidad integer, cod_moneda integer, compra numeric, venta numeric, stock numeric, expiration date, image text, create_at timestamp without time zone, state boolean, cat_name character varying, unidad_name character varying, moneda_name character varying)
 LANGUAGE plpgsql
AS $function$
BEGIN
    RETURN QUERY
    SELECT
        prod.cod_prod,
        prod.cod_sede,
        prod.cod_cat,
        prod.prod_name,
        prod.prod_descrip,
        prod.cod_unidad,
        prod.cod_moneda,
        prod.compra,
        prod.venta,
        prod.stock,
        prod.expiration,
        prod.image,
        prod.create_at,
        prod."state",
        ct.cat_name,
        um.unidad_name,
        m.moneda_name
    FROM producto prod
    INNER JOIN categoria ct ON prod.cod_cat = ct.cod_cat
    INNER JOIN unidad_medida um ON prod.cod_unidad = um.cod_unidad
    INNER JOIN moneda m ON prod.cod_moneda = m.cod_moneda
    WHERE prod.cod_sede = id_sede
    AND prod."state"=TRUE;
END;
$function$
;

CREATE OR REPLACE FUNCTION public.func_update_producto(producto integer, sede integer, cat integer, prod_name character varying, descrip text, unidad integer, moneda integer, compra numeric, venta numeric, stock numeric, expiration date, image text)
 RETURNS void
 LANGUAGE plpgsql
AS $function$
BEGIN
    UPDATE producto SET
         cod_sede = $2,
        cod_cat = $3,
        prod_name = UPPER($4),
        prod_descrip = $5,
        cod_unidad = $6,
        cod_moneda = $7,
        compra = $8,
        venta = $9,
        stock = $10,
        expiration = $11,
        image = $12
    WHERE cod_prod = $1;
END;
$function$
;







