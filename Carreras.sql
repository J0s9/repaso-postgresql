-- This script only contains the table creation statements and does not fully represent the table in the database. It's still missing: indices, triggers. Do not use it as a backup.

-- Table Definition
CREATE TABLE "public"."carrera" (
    "cod_carrera" int4 NOT NULL,
    "cod_sede" int4,
    "carrera_name" varchar(30),
    "create_at" timestamp DEFAULT now(),
    "state" bool,
    CONSTRAINT "carrera_cod_sede_fkey" FOREIGN KEY ("cod_sede") REFERENCES "public"."sede"("cod_sede"),
    PRIMARY KEY ("cod_carrera")
);

CREATE OR REPLACE FUNCTION public.func_carrera_id(id_carrera integer)
 RETURNS TABLE(cod_carrera integer, cod_sede integer, carrera_name character varying, create_at timestamp without time zone, state boolean)
 LANGUAGE plpgsql
AS $function$
BEGIN
    RETURN QUERY
    SELECT
        carrera.cod_carrera,
        carrera.cod_sede,
        carrera.carrera_name,
        carrera.create_at,
        carrera."state"
    FROM public.carrera
    WHERE carrera.cod_carrera = id_carrera
    AND carrera."state"=TRUE;
END;
$function$
;

CREATE OR REPLACE FUNCTION public.func_carrera_sede(id_sede integer)
 RETURNS TABLE(cod_carrera integer, cod_sede integer, carrera_name character varying, create_at timestamp without time zone, state boolean)
 LANGUAGE plpgsql
AS $function$
BEGIN
    RETURN QUERY
    SELECT
        carrera.cod_carrera,
        carrera.cod_sede,
        carrera.carrera_name,
        carrera.create_at,
        carrera."state"
    FROM public.carrera
    WHERE carrera.cod_sede = id_sede
    AND carrera."state"=TRUE;
END;
$function$
;

CREATE OR REPLACE FUNCTION public.func_delete_carrera(eliminar integer)
 RETURNS void
 LANGUAGE plpgsql
AS $function$
BEGIN
    UPDATE carrera
    SET "state" = FALSE
    WHERE carrera.cod_carrera = eliminar;
END;
$function$
;

CREATE OR REPLACE FUNCTION public.func_insert_carrera(cod_sede integer, carrera character varying)
 RETURNS void
 LANGUAGE plpgsql
AS $function$
BEGIN
    INSERT INTO carrera("cod_sede", "carrera_name", "create_at", "state")
    VALUES (cod_sede, UPPER(carrera), NOW(), true);
END;
$function$
;

CREATE OR REPLACE FUNCTION public.func_update_carrera(id_carrera integer, id_sede integer, new_name character varying)
 RETURNS void
 LANGUAGE plpgsql
AS $function$
BEGIN
    UPDATE carrera
    SET
    cod_carrera = id_carrera,
    cod_sede = id_sede,
    carrera_name = UPPER(new_name)
    WHERE cod_carrera = id_carrera;
END;

$function$
;

INSERT INTO "public"."carrera" ("cod_carrera", "cod_sede", "carrera_name", "create_at", "state") VALUES
(93, NULL, NULL, '2023-10-30 15:32:41.549604', 't');
INSERT INTO "public"."carrera" ("cod_carrera", "cod_sede", "carrera_name", "create_at", "state") VALUES
(94, NULL, NULL, '2023-10-30 15:32:41.867279', 't');
INSERT INTO "public"."carrera" ("cod_carrera", "cod_sede", "carrera_name", "create_at", "state") VALUES
(95, NULL, NULL, '2023-10-30 15:32:42.222686', 't');
INSERT INTO "public"."carrera" ("cod_carrera", "cod_sede", "carrera_name", "create_at", "state") VALUES
(96, NULL, NULL, '2023-10-30 15:32:42.542501', 't'),
(97, NULL, NULL, '2023-10-30 15:32:43.120185', 't'),
(98, NULL, NULL, '2023-10-30 15:32:43.462131', 't'),
(99, 2, 'pruebaa', '2023-10-30 18:11:48.055141', 't'),
(92, 1, 'uuu', '2023-10-30 15:32:07.254148', 'f'),
(71, 1, 'Ingeniería Informática', '2023-10-27 00:00:00', 'f'),
(91, 1, 'TESTO', '2023-10-30 15:32:00.186203', 'f'),
(100, 3, 'uuuuiiii', '2023-10-31 04:17:04.646828', 't'),
(84, 1, 'Sociale', '2023-10-29 00:00:00', 'f'),
(82, 1, 'u_O', '2023-10-29 00:00:00', 'f'),
(101, 1, 'Prueba', '2023-11-03 15:10:37.061978', 'f'),
(103, 1, 'Nueva carrera', '2023-11-04 05:46:33.076808', 'f'),
(102, 1, 'jose', '2023-11-04 05:45:33.036128', 'f'),
(88, 1, 'MÚSICA', '2023-10-29 00:00:00', 't'),
(72, 1, 'MEDICINA', '2023-10-29 00:00:00', 't'),
(79, 1, 'HISTORIA', '2023-10-27 00:00:00', 't'),
(86, 1, 'GEOLOGÍA', '2023-10-29 00:00:00', 't'),
(81, 1, 'FÍSICA', '2023-10-27 00:00:00', 't'),
(85, 1, 'FILOSOFÍA', '2023-10-27 00:00:00', 't'),
(90, 1, 'ENFERMERÍA', '2023-10-29 00:00:00', 't'),
(89, 1, 'EDUCACIÓN FÍSICA', '2023-10-27 00:00:00', 't'),
(80, 1, 'MATEMÁTICAS', '2023-10-29 00:00:00', 't'),
(76, 1, 'ECONOMÍA', '2023-10-29 00:00:00', 't'),
(77, 1, 'CIENCIAS POLÍTICAS', '2023-10-27 00:00:00', 't'),
(74, 1, 'PSICOLOGÍA', '2023-10-29 00:00:00', 't'),
(104, 1, 'VETERINARIA', '2023-11-04 05:51:43.192951', 't'),
(75, 1, 'ING-ARQUITECTURA', '2023-10-27 00:00:00', 't'),
(87, 1, 'LIC-ARTE', '2023-10-27 00:00:00', 't'),
(83, 1, 'DOC-LITERATURA', '2023-10-27 00:00:00', 't'),
(73, 1, 'LIC-DERECHO', '2023-10-27 00:00:00', 't'),
(78, 1, 'LIC-BIOLOGÍA', '2023-10-29 00:00:00', 't'),
(105, 1, 'NUEVAS CARRERAS', '2023-11-04 06:27:31.428671', 't'),
(106, 1, 'OOO', '2023-11-04 10:32:43.988423', 'f');





