CREATE OR REPLACE FORCE NONEDITIONABLE VIEW "USRDRC"."DERCORP_REP_HIST_FUNC_VW" ("ID_FUNC", "ID_FLEX_TBL", "ID_EMPRESA", "TIPO_ADMON", "NUM_EMPRESA", "NOM_EMPRESA", "NOMBRE", "NOMBRE_PLANO", "CARGO", "CARGO_INGLES", "FECHA_DESIGNACION", "FECHA_BAJA", "SUPLENTE", "FECHA_DESIG_SUPLENTE", "FECHA_BAJA_SUPLENTE", "ID_ORDEN", "ACTIVO") AS 
  SELECT
        meta.val_c1 as id_func,
        meta.id_flex_tbl,
        meta.id_empresa,
        'Administrador Unico' as tipo_admon,
        (SELECT   val_cat_val
         FROM     dercorp_add_campo_cat_val_tab
         WHERE    id_catalogo_valor = (SELECT   val_valor
                                       FROM     dercorp_add_campo_valor_tab
                                       WHERE    id_empresa            =meta.id_empresa
                                       AND      id_add_campo          = 502))as num_empresa,
        /*(SELECT   nom_empresa
         FROM     dercorp_empresa_tab
         WHERE    id_empresa            = meta.id_empresa) AS nom_empresa,*/
         (SELECT val_cat_val
        FROM dercorp_add_campo_cat_val_tab
        WHERE id_catalogo = 1
        AND   id_catalogo_valor = (SELECT val_valor
                                   FROM dercorp_add_campo_valor_tab
                                   WHERE id_empresa = meta.id_empresa
                                   AND id_add_campo = 500))AS nom_empresa,--Argu
        (SELECT   val_cat_val
         FROM     dercorp_add_campo_cat_val_tab
         WHERE    id_catalogo           = 10
         AND      id_catalogo_valor     = meta.val_c1)AS nombre,
         UPPER(APP_COMMON_PKG.SIN_ACENTOS_FN((SELECT   val_cat_val
         FROM     dercorp_add_campo_cat_val_tab
         WHERE    id_catalogo           = 10
         AND      id_catalogo_valor     = meta.val_c1)))AS nombre_plano,
        (SELECT   val_cat_val
         FROM     dercorp_add_campo_cat_val_tab
         WHERE    id_catalogo           = 11
         AND      id_catalogo_valor     = meta.val_c2)AS cargo,
        (SELECT   atributo1
         FROM     dercorp_add_campo_cat_val_tab
         WHERE    id_catalogo           = 11
         AND      id_catalogo_valor     = meta.val_c2)AS cargo_ingles,
         meta.val_c3 AS fecha_designacion,
         meta.val_c4 AS fecha_baja,
         'N/A'          AS suplente,
         NULL          AS fecha_desig_suplente,
         NULL          AS fecha_baja_suplente,
        meta.val_c15 AS ID_ORDEN,
        meta.val_c14 AS ACTIVO
FROM    dercorp_metatbl_tab meta
WHERE   meta.id_flex_tbl = 8
UNION ALL
--Consejo de administracion
SELECT  meta.val_c1 as id_func,
        meta.id_flex_tbl,
        meta.id_empresa,
        'Consejo de Administracion' as tipo_admon,
        (SELECT   val_cat_val
         FROM     dercorp_add_campo_cat_val_tab
         WHERE    id_catalogo_valor = (SELECT   val_valor
                                       FROM     dercorp_add_campo_valor_tab
                                       WHERE    id_empresa            =meta.id_empresa
                                       AND      id_add_campo          = 502))as num_empresa,
        /*(SELECT   nom_empresa
         FROM     dercorp_empresa_tab
         WHERE    id_empresa            = meta.id_empresa) AS nom_empresa,*/
         (SELECT val_cat_val
          FROM dercorp_add_campo_cat_val_tab
          WHERE id_catalogo = 1
          AND   id_catalogo_valor = (SELECT val_valor
                                     FROM dercorp_add_campo_valor_tab
                                     WHERE id_empresa = meta.id_empresa
                                     AND id_add_campo = 500))AS nom_empresa,--Argu
        (SELECT   val_cat_val
         FROM     dercorp_add_campo_cat_val_tab
         WHERE    id_catalogo           = 10
         AND      id_catalogo_valor     = meta.val_c1)AS nombre,
         UPPER(APP_COMMON_PKG.SIN_ACENTOS_FN((SELECT   val_cat_val
         FROM     dercorp_add_campo_cat_val_tab
         WHERE    id_catalogo           = 10
         AND      id_catalogo_valor     = meta.val_c1)))AS nombre_plano,
        (SELECT   val_cat_val
         FROM     dercorp_add_campo_cat_val_tab
         WHERE    id_catalogo           = 11
         AND      id_catalogo_valor     = meta.val_c2)AS cargo,
        (SELECT   atributo1
         FROM     dercorp_add_campo_cat_val_tab
         WHERE    id_catalogo           = 11
         AND      id_catalogo_valor     = meta.val_c2)AS cargo_ingles,
         meta.val_c3 AS fecha_designacion,
         meta.val_c4 AS fecha_baja,
          (SELECT   val_cat_val
         FROM     dercorp_add_campo_cat_val_tab
         WHERE    id_catalogo           = 10
         AND      id_catalogo_valor     = meta.val_c5)AS suplente,
         meta.val_c6 AS fecha_desig_suplente,
         meta.val_c7 AS fecha_baja_suplente,
        meta.val_c15 AS ID_ORDEN,
        meta.val_c14 AS ACTIVO
FROM    dercorp_metatbl_tab meta
WHERE   meta.id_flex_tbl = 11
UNION ALL
--Consejo Directivo
SELECT  meta.val_c1 as id_func,
        meta.id_flex_tbl,
        meta.id_empresa,
        'Consejo Directivo' as tipo_admon,
        (SELECT   val_cat_val
         FROM     dercorp_add_campo_cat_val_tab
         WHERE    id_catalogo_valor = (SELECT   val_valor
                                       FROM     dercorp_add_campo_valor_tab
                                       WHERE    id_empresa            =meta.id_empresa
                                       AND      id_add_campo          = 502))as num_empresa,
        /*(SELECT   nom_empresa
         FROM     dercorp_empresa_tab
         WHERE    id_empresa            = meta.id_empresa) AS nom_empresa,*/
         (SELECT val_cat_val
          FROM dercorp_add_campo_cat_val_tab
          WHERE id_catalogo = 1
          AND   id_catalogo_valor = (SELECT val_valor
                                     FROM dercorp_add_campo_valor_tab
                                     WHERE id_empresa = meta.id_empresa
                                     AND id_add_campo = 500))AS nom_empresa,--Argu
        (SELECT   val_cat_val
         FROM     dercorp_add_campo_cat_val_tab
         WHERE    id_catalogo           = 10
         AND      id_catalogo_valor     = meta.val_c1)AS nombre,
         UPPER(APP_COMMON_PKG.SIN_ACENTOS_FN((SELECT   val_cat_val
         FROM     dercorp_add_campo_cat_val_tab
         WHERE    id_catalogo           = 10
         AND      id_catalogo_valor     = meta.val_c1)))AS nombre_plano,
        (SELECT   val_cat_val
         FROM     dercorp_add_campo_cat_val_tab
         WHERE    id_catalogo           = 11
         AND      id_catalogo_valor     = meta.val_c2)AS cargo,
        (SELECT   atributo1
         FROM     dercorp_add_campo_cat_val_tab
         WHERE    id_catalogo           = 11
         AND      id_catalogo_valor     = meta.val_c2)AS cargo_ingles,
         meta.val_c3 AS fecha_designacion,
         meta.val_c4 AS fecha_baja,
          (SELECT   val_cat_val
         FROM     dercorp_add_campo_cat_val_tab
         WHERE    id_catalogo           = 10
         AND      id_catalogo_valor     = meta.val_c5)AS suplente,
         meta.val_c6 AS fecha_desig_suplente,
         meta.val_c7 AS fecha_baja_suplente,
        meta.val_c15 AS ID_ORDEN,
        meta.val_c14 AS ACTIVO
FROM    dercorp_metatbl_tab meta
WHERE   meta.id_flex_tbl = 12
UNION ALL
--Consejo de Gerentes
SELECT  meta.val_c1 as id_func,
        meta.id_flex_tbl,
        meta.id_empresa,
        'Consejo de Gerentes' as tipo_admon,
        (SELECT   val_cat_val
         FROM     dercorp_add_campo_cat_val_tab
         WHERE    id_catalogo_valor = (SELECT   val_valor
                                       FROM     dercorp_add_campo_valor_tab
                                       WHERE    id_empresa            =meta.id_empresa
                                       AND      id_add_campo          = 502))as num_empresa,
        /*(SELECT   nom_empresa
         FROM     dercorp_empresa_tab
         WHERE    id_empresa            = meta.id_empresa) AS nom_empresa,*/
         (SELECT val_cat_val
          FROM dercorp_add_campo_cat_val_tab
          WHERE id_catalogo = 1
          AND   id_catalogo_valor = (SELECT val_valor
                                     FROM dercorp_add_campo_valor_tab
                                     WHERE id_empresa = meta.id_empresa
                                     AND id_add_campo = 500))AS nom_empresa,--Argu
        (SELECT   val_cat_val
         FROM     dercorp_add_campo_cat_val_tab
         WHERE    id_catalogo           = 10
         AND      id_catalogo_valor     = meta.val_c1)AS nombre,
         UPPER(APP_COMMON_PKG.SIN_ACENTOS_FN((SELECT   val_cat_val
         FROM     dercorp_add_campo_cat_val_tab
         WHERE    id_catalogo           = 10
         AND      id_catalogo_valor     = meta.val_c1)))AS nombre_plano,
        (SELECT   val_cat_val
         FROM     dercorp_add_campo_cat_val_tab
         WHERE    id_catalogo           = 11
         AND      id_catalogo_valor     = meta.val_c2)AS cargo,
        (SELECT   atributo1
         FROM     dercorp_add_campo_cat_val_tab
         WHERE    id_catalogo           = 11
         AND      id_catalogo_valor     = meta.val_c2)AS cargo_ingles,
         meta.val_c3 AS fecha_designacion,
         meta.val_c4 AS fecha_baja,
          (SELECT   val_cat_val
         FROM     dercorp_add_campo_cat_val_tab
         WHERE    id_catalogo           = 10
         AND      id_catalogo_valor     = meta.val_c5)AS suplente,
         meta.val_c6 AS fecha_desig_suplente,
         meta.val_c7 AS fecha_baja_suplente,
        meta.val_c15 AS ID_ORDEN,
        meta.val_c14 AS ACTIVO
FROM    dercorp_metatbl_tab meta
WHERE   meta.id_flex_tbl = 13
UNION ALL
--Directorio
SELECT  meta.val_c1 as id_func,
        meta.id_flex_tbl,
        meta.id_empresa,
        'Directorio' as tipo_admon,
        (SELECT   val_cat_val
         FROM     dercorp_add_campo_cat_val_tab
         WHERE    id_catalogo_valor = (SELECT   val_valor
                                       FROM     dercorp_add_campo_valor_tab
                                       WHERE    id_empresa            =meta.id_empresa
                                       AND      id_add_campo          = 502))as num_empresa,
        /*(SELECT   nom_empresa
         FROM     dercorp_empresa_tab
         WHERE    id_empresa            = meta.id_empresa) AS nom_empresa,*/
         (SELECT val_cat_val
        FROM dercorp_add_campo_cat_val_tab
        WHERE id_catalogo = 1
        AND   id_catalogo_valor = (SELECT val_valor
                                   FROM dercorp_add_campo_valor_tab
                                   WHERE id_empresa = meta.id_empresa
                                   AND id_add_campo = 500))AS nom_empresa,--Argu
        (SELECT   val_cat_val
         FROM     dercorp_add_campo_cat_val_tab
         WHERE    id_catalogo           = 10
         AND      id_catalogo_valor     = meta.val_c1)AS nombre,
         UPPER(APP_COMMON_PKG.SIN_ACENTOS_FN((SELECT   val_cat_val
         FROM     dercorp_add_campo_cat_val_tab
         WHERE    id_catalogo           = 10
         AND      id_catalogo_valor     = meta.val_c1)))AS nombre_plano,
        (SELECT   val_cat_val
         FROM     dercorp_add_campo_cat_val_tab
         WHERE    id_catalogo           = 11
         AND      id_catalogo_valor     = meta.val_c2)AS cargo,
        (SELECT   atributo1
         FROM     dercorp_add_campo_cat_val_tab
         WHERE    id_catalogo           = 11
         AND      id_catalogo_valor     = meta.val_c2)AS cargo_ingles,
         meta.val_c3 AS fecha_designacion,
         meta.val_c4 AS fecha_baja,
          (SELECT   val_cat_val
         FROM     dercorp_add_campo_cat_val_tab
         WHERE    id_catalogo           = 10
         AND      id_catalogo_valor     = meta.val_c5)AS suplente,
         meta.val_c6 AS fecha_desig_suplente,
         meta.val_c7 AS fecha_baja_suplente,
        meta.val_c15 AS ID_ORDEN,
        meta.val_c14 AS ACTIVO
FROM    dercorp_metatbl_tab meta
WHERE   meta.id_flex_tbl = 14
UNION ALL
--Junta directiva
SELECT  meta.val_c1 as id_func,
        meta.id_flex_tbl,
        meta.id_empresa,
        'Junta Directiva' as tipo_admon,
        (SELECT   val_cat_val
         FROM     dercorp_add_campo_cat_val_tab
         WHERE    id_catalogo_valor = (SELECT   val_valor
                                       FROM     dercorp_add_campo_valor_tab
                                       WHERE    id_empresa            =meta.id_empresa
                                       AND      id_add_campo          = 502))as num_empresa,
        /*(SELECT   nom_empresa
         FROM     dercorp_empresa_tab
         WHERE    id_empresa            = meta.id_empresa) AS nom_empresa,*/
         (SELECT val_cat_val
          FROM dercorp_add_campo_cat_val_tab
          WHERE id_catalogo = 1
          AND   id_catalogo_valor = (SELECT val_valor
                                     FROM dercorp_add_campo_valor_tab
                                     WHERE id_empresa = meta.id_empresa
                                     AND id_add_campo = 500))AS nom_empresa,
        (SELECT   val_cat_val
         FROM     dercorp_add_campo_cat_val_tab
         WHERE    id_catalogo           = 10
         AND      id_catalogo_valor     = meta.val_c1)AS nombre,
         UPPER(APP_COMMON_PKG.SIN_ACENTOS_FN((SELECT   val_cat_val
         FROM     dercorp_add_campo_cat_val_tab
         WHERE    id_catalogo           = 10
         AND      id_catalogo_valor     = meta.val_c1)))AS nombre_plano,
        (SELECT   val_cat_val
         FROM     dercorp_add_campo_cat_val_tab
         WHERE    id_catalogo           = 11
         AND      id_catalogo_valor     = meta.val_c2)AS cargo,
        (SELECT   atributo1
         FROM     dercorp_add_campo_cat_val_tab
         WHERE    id_catalogo           = 11
         AND      id_catalogo_valor     = meta.val_c2)AS cargo_ingles,
         meta.val_c3 AS fecha_designacion,
         meta.val_c4 AS fecha_baja,
          (SELECT   val_cat_val
         FROM     dercorp_add_campo_cat_val_tab
         WHERE    id_catalogo           = 10
         AND      id_catalogo_valor     = meta.val_c5)AS suplente,
         meta.val_c6 AS fecha_desig_suplente,
         meta.val_c7 AS fecha_baja_suplente,
        meta.val_c15 AS ID_ORDEN,
        meta.val_c14 AS ACTIVO
FROM    dercorp_metatbl_tab meta
WHERE   meta.id_flex_tbl = 15
UNION ALL
--Comite Ejecutivo
SELECT  meta.val_c1 as id_func,
        meta.id_flex_tbl,
        meta.id_empresa,
        'Comite Ejecutivo' as tipo_admon,
        (SELECT   val_cat_val
         FROM     dercorp_add_campo_cat_val_tab
         WHERE    id_catalogo_valor = (SELECT   val_valor
                                       FROM     dercorp_add_campo_valor_tab
                                       WHERE    id_empresa            =meta.id_empresa
                                       AND      id_add_campo          = 502))as num_empresa,
        /*(SELECT   nom_empresa
         FROM     dercorp_empresa_tab
         WHERE    id_empresa            = meta.id_empresa) AS nom_empresa,*/
         (SELECT val_cat_val
        FROM dercorp_add_campo_cat_val_tab
        WHERE id_catalogo = 1
        AND   id_catalogo_valor = (SELECT val_valor
                                   FROM dercorp_add_campo_valor_tab
                                   WHERE id_empresa = meta.id_empresa
                                   AND id_add_campo = 500))AS nom_empresa,--Argu
        (SELECT   val_cat_val
         FROM     dercorp_add_campo_cat_val_tab
         WHERE    id_catalogo           = 10
         AND      id_catalogo_valor     = meta.val_c1)AS nombre,
         UPPER(APP_COMMON_PKG.SIN_ACENTOS_FN((SELECT   val_cat_val
         FROM     dercorp_add_campo_cat_val_tab
         WHERE    id_catalogo           = 10
         AND      id_catalogo_valor     = meta.val_c1)))AS nombre_plano,
        (SELECT   val_cat_val
         FROM     dercorp_add_campo_cat_val_tab
         WHERE    id_catalogo           = 11
         AND      id_catalogo_valor     = meta.val_c2)AS cargo,
        (SELECT   atributo1
         FROM     dercorp_add_campo_cat_val_tab
         WHERE    id_catalogo           = 11
         AND      id_catalogo_valor     = meta.val_c2)AS cargo_ingles,
         meta.val_c3 AS fecha_designacion,
         meta.val_c4 AS fecha_baja,
          (SELECT   val_cat_val
         FROM     dercorp_add_campo_cat_val_tab
         WHERE    id_catalogo           = 10
         AND      id_catalogo_valor     = meta.val_c5)AS suplente,
         meta.val_c6 AS fecha_desig_suplente,
         meta.val_c7 AS fecha_baja_suplente,
        meta.val_c15 AS ID_ORDEN,
        meta.val_c14 AS ACTIVO
FROM    dercorp_metatbl_tab meta
WHERE   meta.id_flex_tbl = 16
UNION ALL
--Comite oPERATIVO JJAQ 26/04/2017 Se agrega nueva flex para el reporte
SELECT  meta.val_c1 as id_func,
        meta.id_flex_tbl,
        meta.id_empresa,
        'Comite Operativo' as tipo_admon,
        (SELECT   val_cat_val
         FROM     dercorp_add_campo_cat_val_tab
         WHERE    id_catalogo_valor = (SELECT   val_valor
                                       FROM     dercorp_add_campo_valor_tab
                                       WHERE    id_empresa            =meta.id_empresa
                                       AND      id_add_campo          = 502))as num_empresa,
        /*(SELECT   nom_empresa
         FROM     dercorp_empresa_tab
         WHERE    id_empresa            = meta.id_empresa) AS nom_empresa,*/
         (SELECT val_cat_val
        FROM dercorp_add_campo_cat_val_tab
        WHERE id_catalogo = 1
        AND   id_catalogo_valor = (SELECT val_valor
                                   FROM dercorp_add_campo_valor_tab
                                   WHERE id_empresa = meta.id_empresa
                                   AND id_add_campo = 500))AS nom_empresa,--Argu
        (SELECT   val_cat_val
         FROM     dercorp_add_campo_cat_val_tab
         WHERE    id_catalogo           = 10
         AND      id_catalogo_valor     = meta.val_c1)AS nombre,
         UPPER(APP_COMMON_PKG.SIN_ACENTOS_FN((SELECT   val_cat_val
         FROM     dercorp_add_campo_cat_val_tab
         WHERE    id_catalogo           = 10
         AND      id_catalogo_valor     = meta.val_c1)))AS nombre_plano,
        (SELECT   val_cat_val
         FROM     dercorp_add_campo_cat_val_tab
         WHERE    id_catalogo           = 11
         AND      id_catalogo_valor     = meta.val_c2)AS cargo,
        (SELECT   atributo1
         FROM     dercorp_add_campo_cat_val_tab
         WHERE    id_catalogo           = 11
         AND      id_catalogo_valor     = meta.val_c2)AS cargo_ingles,
         meta.val_c3 AS fecha_designacion,
         meta.val_c4 AS fecha_baja,
        /*  (SELECT   val_cat_val
         FROM     dercorp_add_campo_cat_val_tab
         WHERE    id_catalogo           = 10
         AND      id_catalogo_valor     = meta.val_c5)AS suplente,*/
         null AS suplente,
         meta.val_c6 AS fecha_desig_suplente,
         meta.val_c7 AS fecha_baja_suplente,
        meta.val_c15 AS ID_ORDEN,
        meta.val_c14 AS ACTIVO
FROM    dercorp_metatbl_tab meta
WHERE   meta.id_flex_tbl = 45
UNION ALL
--Comite de Practicas Societarias JJAQ 07/01/2019 Se agrega nueva flex para el reporte
SELECT  meta.val_c1 as id_func,
        meta.id_flex_tbl,
        meta.id_empresa,
        'Comite de Practicas Societarias' as tipo_admon,
        (SELECT   val_cat_val
         FROM     dercorp_add_campo_cat_val_tab
         WHERE    id_catalogo_valor = (SELECT   val_valor
                                       FROM     dercorp_add_campo_valor_tab
                                       WHERE    id_empresa            = meta.id_empresa
                                       AND      id_add_campo          = 502))as num_empresa,
        /*(SELECT   nom_empresa
         FROM     dercorp_empresa_tab
         WHERE    id_empresa            = meta.id_empresa) AS nom_empresa,*/
         (SELECT val_cat_val
        FROM dercorp_add_campo_cat_val_tab
        WHERE id_catalogo = 1
        AND   id_catalogo_valor = (SELECT val_valor
                                   FROM dercorp_add_campo_valor_tab
                                   WHERE id_empresa = meta.id_empresa
                                   AND id_add_campo = 500))AS nom_empresa,--Argu
        (SELECT   val_cat_val
         FROM     dercorp_add_campo_cat_val_tab
         WHERE    id_catalogo           = 10
         AND      id_catalogo_valor     = meta.val_c1)AS nombre,
         UPPER(APP_COMMON_PKG.SIN_ACENTOS_FN((SELECT   val_cat_val
         FROM     dercorp_add_campo_cat_val_tab
         WHERE    id_catalogo           = 10
         AND      id_catalogo_valor     = meta.val_c1)))AS nombre_plano,
        (SELECT   val_cat_val
         FROM     dercorp_add_campo_cat_val_tab
         WHERE    id_catalogo           = 11
         AND      id_catalogo_valor     = meta.val_c2)AS cargo,
        (SELECT   atributo1
         FROM     dercorp_add_campo_cat_val_tab
         WHERE    id_catalogo           = 11
         AND      id_catalogo_valor     = meta.val_c2)AS cargo_ingles,
         meta.val_c3 AS fecha_designacion,
         meta.val_c4 AS fecha_baja,
        /*  (SELECT   val_cat_val
         FROM     dercorp_add_campo_cat_val_tab
         WHERE    id_catalogo           = 10
         AND      id_catalogo_valor     = meta.val_c5)AS suplente,*/
         (SELECT   val_cat_val
         FROM     dercorp_add_campo_cat_val_tab
         WHERE    id_catalogo           = 10
         AND      id_catalogo_valor     = meta.val_c5)AS suplente,
         meta.val_c6 AS fecha_desig_suplente,
         meta.val_c7 AS fecha_baja_suplente,
        meta.val_c15 AS ID_ORDEN,
        meta.val_c14 AS ACTIVO
FROM    dercorp_metatbl_tab meta
WHERE   meta.id_flex_tbl = 46
UNION ALL
--Comite Directivo JJAQ se agrega la nueva 25/04/2017
SELECT  meta.val_c1 as id_func,
        meta.id_flex_tbl,
        meta.id_empresa,
        'Comite Directivo' as tipo_admon,
        (SELECT   val_cat_val
         FROM     dercorp_add_campo_cat_val_tab
         WHERE    id_catalogo_valor = (SELECT   val_valor
                                       FROM     dercorp_add_campo_valor_tab
                                       WHERE    id_empresa            =meta.id_empresa
                                       AND      id_add_campo          = 502))as num_empresa,
        /*(SELECT   nom_empresa
         FROM     dercorp_empresa_tab
         WHERE    id_empresa            = meta.id_empresa) AS nom_empresa,*/
         (SELECT val_cat_val
        FROM dercorp_add_campo_cat_val_tab
        WHERE id_catalogo = 1
        AND   id_catalogo_valor = (SELECT val_valor
                                   FROM dercorp_add_campo_valor_tab
                                   WHERE id_empresa = meta.id_empresa
                                   AND id_add_campo = 500))AS nom_empresa,--Argu
        (SELECT   val_cat_val
         FROM     dercorp_add_campo_cat_val_tab
         WHERE    id_catalogo           = 10
         AND      id_catalogo_valor     = meta.val_c1)AS nombre,
         UPPER(APP_COMMON_PKG.SIN_ACENTOS_FN((SELECT   val_cat_val
         FROM     dercorp_add_campo_cat_val_tab
         WHERE    id_catalogo           = 10
         AND      id_catalogo_valor     = meta.val_c1)))AS nombre_plano,
        (SELECT   val_cat_val
         FROM     dercorp_add_campo_cat_val_tab
         WHERE    id_catalogo           = 11
         AND      id_catalogo_valor     = meta.val_c2)AS cargo,
        (SELECT   atributo1
         FROM     dercorp_add_campo_cat_val_tab
         WHERE    id_catalogo           = 11
         AND      id_catalogo_valor     = meta.val_c2)AS cargo_ingles,
         meta.val_c3 AS fecha_designacion,
         meta.val_c4 AS fecha_baja,
         /* (SELECT   val_cat_val
         FROM     dercorp_add_campo_cat_val_tab
         WHERE    id_catalogo           = 10
         AND      id_catalogo_valor     = meta.val_c5)AS suplente,*/
         null AS suplente,
         meta.val_c6 AS fecha_desig_suplente,
         meta.val_c7 AS fecha_baja_suplente,
        meta.val_c15 AS ID_ORDEN,
        meta.val_c14 AS ACTIVO
FROM    dercorp_metatbl_tab meta
WHERE   meta.id_flex_tbl = 44
UNION ALL
--Funcionarios Asociacion
SELECT  meta.val_c1 as id_func,
        meta.id_flex_tbl,
        meta.id_empresa,
        'Funcionarios' as tipo_admon,
        (SELECT   val_cat_val
         FROM     dercorp_add_campo_cat_val_tab
         WHERE    id_catalogo_valor = (SELECT   val_valor
                                       FROM     dercorp_add_campo_valor_tab
                                       WHERE    id_empresa            =meta.id_empresa
                                       AND      id_add_campo          = 502))as num_empresa,
        /*(SELECT   nom_empresa
         FROM     dercorp_empresa_tab
         WHERE    id_empresa            = meta.id_empresa) AS nom_empresa,*/
         (SELECT val_cat_val
          FROM dercorp_add_campo_cat_val_tab
          WHERE id_catalogo = 1
          AND   id_catalogo_valor = (SELECT val_valor
                                     FROM dercorp_add_campo_valor_tab
                                     WHERE id_empresa = meta.id_empresa
                                     AND id_add_campo = 500))AS nom_empresa,--Argu
        (SELECT   val_cat_val
         FROM     dercorp_add_campo_cat_val_tab
         WHERE    id_catalogo           = 10
         AND      id_catalogo_valor     = meta.val_c1)AS nombre,
         UPPER(APP_COMMON_PKG.SIN_ACENTOS_FN((SELECT   val_cat_val
         FROM     dercorp_add_campo_cat_val_tab
         WHERE    id_catalogo           = 10
         AND      id_catalogo_valor     = meta.val_c1)))AS nombre_plano,
        (SELECT   val_cat_val
         FROM     dercorp_add_campo_cat_val_tab
         WHERE    id_catalogo           = 11
         AND      id_catalogo_valor     = meta.val_c2)AS cargo,
        (SELECT   atributo1
         FROM     dercorp_add_campo_cat_val_tab
         WHERE    id_catalogo           = 11
         AND      id_catalogo_valor     = meta.val_c2)AS cargo_ingles,
         meta.val_c3 AS fecha_designacion,
         meta.val_c4 AS fecha_baja,
          (SELECT   val_cat_val
         FROM     dercorp_add_campo_cat_val_tab
         WHERE    id_catalogo           = 10
         AND      id_catalogo_valor     = meta.val_c5)AS suplente,
         meta.val_c6 AS fecha_desig_suplente,
         meta.val_c7 AS fecha_baja_suplente,
        meta.val_c15 AS ID_ORDEN,
        meta.val_c14 AS ACTIVO
FROM    dercorp_metatbl_tab meta
WHERE   meta.id_flex_tbl = 25
UNION ALL
--Consejo Consultivo
SELECT  meta.val_c1 as id_func,
        meta.id_flex_tbl,
        meta.id_empresa,
        'Consejo Consultivo' as tipo_admon,
        (SELECT   val_cat_val
         FROM     dercorp_add_campo_cat_val_tab
         WHERE    id_catalogo_valor = (SELECT   val_valor
                                       FROM     dercorp_add_campo_valor_tab
                                       WHERE    id_empresa            =meta.id_empresa
                                       AND      id_add_campo          = 502))as num_empresa,
        /*(SELECT   nom_empresa
         FROM     dercorp_empresa_tab
         WHERE    id_empresa            = meta.id_empresa) AS nom_empresa,*/
        (SELECT val_cat_val
          FROM dercorp_add_campo_cat_val_tab
          WHERE id_catalogo = 1
          AND   id_catalogo_valor = (SELECT val_valor
                                     FROM dercorp_add_campo_valor_tab
                                     WHERE id_empresa = meta.id_empresa
                                     AND id_add_campo = 500))AS nom_empresa,--Argu
        (SELECT   val_cat_val
         FROM     dercorp_add_campo_cat_val_tab
         WHERE    id_catalogo           = 10
         AND      id_catalogo_valor     = meta.val_c1)AS nombre,
         UPPER(APP_COMMON_PKG.SIN_ACENTOS_FN((SELECT   val_cat_val
         FROM     dercorp_add_campo_cat_val_tab
         WHERE    id_catalogo           = 10
         AND      id_catalogo_valor     = meta.val_c1)))AS nombre_plano,
        (SELECT   val_cat_val
         FROM     dercorp_add_campo_cat_val_tab
         WHERE    id_catalogo           = 11
         AND      id_catalogo_valor     = meta.val_c2)AS cargo,
        (SELECT   atributo1
         FROM     dercorp_add_campo_cat_val_tab
         WHERE    id_catalogo           = 11
         AND      id_catalogo_valor     = meta.val_c2)AS cargo_ingles,
         meta.val_c3 AS fecha_designacion,
         meta.val_c4 AS fecha_baja,
          (SELECT   val_cat_val
         FROM     dercorp_add_campo_cat_val_tab
         WHERE    id_catalogo           = 10
         AND      id_catalogo_valor     = meta.val_c5)AS suplente,
         meta.val_c6 AS fecha_desig_suplente,
         meta.val_c7 AS fecha_baja_suplente,
        meta.val_c15 AS ID_ORDEN,
        meta.val_c14 AS ACTIVO
FROM    dercorp_metatbl_tab meta
WHERE   meta.id_flex_tbl = 26
UNION ALL
--ECM 26/Abril/2016
--Socio Administrador
SELECT  meta.val_c1 as id_func,
        meta.id_flex_tbl,
        meta.id_empresa,
        'Socio Administrador' as tipo_admon,
        (SELECT   val_cat_val
         FROM     dercorp_add_campo_cat_val_tab
         WHERE    id_catalogo_valor = (SELECT   val_valor
                                       FROM     dercorp_add_campo_valor_tab
                                       WHERE    id_empresa            =meta.id_empresa
                                       AND      id_add_campo          = 502))as num_empresa,
        /*(SELECT   nom_empresa
         FROM     dercorp_empresa_tab
         WHERE    id_empresa            = meta.id_empresa) AS nom_empresa,*/
        (SELECT val_cat_val
          FROM dercorp_add_campo_cat_val_tab
          WHERE id_catalogo = 1
          AND   id_catalogo_valor = (SELECT val_valor
                                     FROM dercorp_add_campo_valor_tab
                                     WHERE id_empresa = meta.id_empresa
                                     AND id_add_campo = 500))AS nom_empresa,--Argu
        (SELECT   val_cat_val
         FROM     dercorp_add_campo_cat_val_tab
         WHERE    id_catalogo           = 10
         AND      id_catalogo_valor     = meta.val_c1)AS nombre,
         UPPER(APP_COMMON_PKG.SIN_ACENTOS_FN((SELECT   val_cat_val
         FROM     dercorp_add_campo_cat_val_tab
         WHERE    id_catalogo           = 10
         AND      id_catalogo_valor     = meta.val_c1)))AS nombre_plano,
        (SELECT   val_cat_val
         FROM     dercorp_add_campo_cat_val_tab
         WHERE    id_catalogo           = 11
         AND      id_catalogo_valor     = meta.val_c2)AS cargo,
        (SELECT   atributo1
         FROM     dercorp_add_campo_cat_val_tab
         WHERE    id_catalogo           = 11
         AND      id_catalogo_valor     = meta.val_c2)AS cargo_ingles,
         meta.val_c3 AS fecha_designacion,
         meta.val_c4 AS fecha_baja,
          (SELECT   val_cat_val
         FROM     dercorp_add_campo_cat_val_tab
         WHERE    id_catalogo           = 10
         AND      id_catalogo_valor     = meta.val_c5)AS suplente,
         meta.val_c6 AS fecha_desig_suplente,
         meta.val_c7 AS fecha_baja_suplente,
        meta.val_c15 AS ID_ORDEN,
        meta.val_c14 AS ACTIVO
FROM    dercorp_metatbl_tab meta
WHERE   meta.id_flex_tbl = 39
UNION ALL
--Consejo de Socios Administradores
SELECT  meta.val_c1 as id_func,
        meta.id_flex_tbl,
        meta.id_empresa,
        'Consejo de Socios Administradores' as tipo_admon,
        (SELECT   val_cat_val
         FROM     dercorp_add_campo_cat_val_tab
         WHERE    id_catalogo_valor = (SELECT   val_valor
                                       FROM     dercorp_add_campo_valor_tab
                                       WHERE    id_empresa            =meta.id_empresa
                                       AND      id_add_campo          = 502))as num_empresa,
        /*(SELECT   nom_empresa
         FROM     dercorp_empresa_tab
         WHERE    id_empresa            = meta.id_empresa) AS nom_empresa,*/
         (SELECT val_cat_val
          FROM dercorp_add_campo_cat_val_tab
          WHERE id_catalogo = 1
          AND   id_catalogo_valor = (SELECT val_valor
                                     FROM dercorp_add_campo_valor_tab
                                     WHERE id_empresa = meta.id_empresa
                                     AND id_add_campo = 500))AS nom_empresa,--Argu
        (SELECT   val_cat_val
         FROM     dercorp_add_campo_cat_val_tab
         WHERE    id_catalogo           = 10
         AND      id_catalogo_valor     = meta.val_c1)AS nombre,
         UPPER(APP_COMMON_PKG.SIN_ACENTOS_FN((SELECT   val_cat_val
         FROM     dercorp_add_campo_cat_val_tab
         WHERE    id_catalogo           = 10
         AND      id_catalogo_valor     = meta.val_c1)))AS nombre_plano,
        (SELECT   val_cat_val
         FROM     dercorp_add_campo_cat_val_tab
         WHERE    id_catalogo           = 11
         AND      id_catalogo_valor     = meta.val_c2)AS cargo,
        (SELECT   atributo1
         FROM     dercorp_add_campo_cat_val_tab
         WHERE    id_catalogo           = 11
         AND      id_catalogo_valor     = meta.val_c2)AS cargo_ingles,
         meta.val_c3 AS fecha_designacion,
         meta.val_c4 AS fecha_baja,
          (SELECT   val_cat_val
         FROM     dercorp_add_campo_cat_val_tab
         WHERE    id_catalogo           = 10
         AND      id_catalogo_valor     = meta.val_c5)AS suplente,
         meta.val_c6 AS fecha_desig_suplente,
         meta.val_c7 AS fecha_baja_suplente,
        meta.val_c15 AS ID_ORDEN,
        meta.val_c14 AS ACTIVO
FROM    dercorp_metatbl_tab meta
WHERE   meta.id_flex_tbl = 40
UNION ALL
--Comite de Auditoria y Practicas Societarias
SELECT  meta.val_c1 as id_func,
        meta.id_flex_tbl,
        meta.id_empresa,
        'Comite de Auditoria' as tipo_admon,
        (SELECT   val_cat_val
         FROM     dercorp_add_campo_cat_val_tab
         WHERE    id_catalogo_valor = (SELECT   val_valor
                                       FROM     dercorp_add_campo_valor_tab
                                       WHERE    id_empresa            =meta.id_empresa
                                       AND      id_add_campo          = 502))as num_empresa,
        /*(SELECT   nom_empresa
         FROM     dercorp_empresa_tab
         WHERE    id_empresa            = meta.id_empresa) AS nom_empresa,*/
         (SELECT val_cat_val
          FROM dercorp_add_campo_cat_val_tab
          WHERE id_catalogo = 1
          AND   id_catalogo_valor = (SELECT val_valor
                                     FROM dercorp_add_campo_valor_tab
                                     WHERE id_empresa = meta.id_empresa
                                     AND id_add_campo = 500))AS nom_empresa,--Argu
        (SELECT   val_cat_val
         FROM     dercorp_add_campo_cat_val_tab
         WHERE    id_catalogo           = 10
         AND      id_catalogo_valor     = meta.val_c1)AS nombre,
         UPPER(APP_COMMON_PKG.SIN_ACENTOS_FN((SELECT   val_cat_val
         FROM     dercorp_add_campo_cat_val_tab
         WHERE    id_catalogo           = 10
         AND      id_catalogo_valor     = meta.val_c1)))AS nombre_plano,
        (SELECT   val_cat_val
         FROM     dercorp_add_campo_cat_val_tab
         WHERE    id_catalogo           = 11
         AND      id_catalogo_valor     = meta.val_c2)AS cargo,
        (SELECT   atributo1
         FROM     dercorp_add_campo_cat_val_tab
         WHERE    id_catalogo           = 11
         AND      id_catalogo_valor     = meta.val_c2)AS cargo_ingles,
         meta.val_c3 AS fecha_designacion,
         meta.val_c4 AS fecha_baja,
          (SELECT   val_cat_val
         FROM     dercorp_add_campo_cat_val_tab
         WHERE    id_catalogo           = 10
         AND      id_catalogo_valor     = meta.val_c5)AS suplente,
         meta.val_c6 AS fecha_desig_suplente,
         meta.val_c7 AS fecha_baja_suplente,
        meta.val_c15 AS ID_ORDEN,
        meta.val_c14 AS ACTIVO
FROM    dercorp_metatbl_tab meta
WHERE   meta.id_flex_tbl = 43
UNION ALL
--Vigilancia
SELECT  meta.val_c1 as id_func,
        meta.id_flex_tbl,
        meta.id_empresa,
        'Vigilancia' as tipo_admon,
        (SELECT   val_cat_val
         FROM     dercorp_add_campo_cat_val_tab
         WHERE    id_catalogo_valor = (SELECT   val_valor
                                       FROM     dercorp_add_campo_valor_tab
                                       WHERE    id_empresa            =meta.id_empresa
                                       AND      id_add_campo          = 502))as num_empresa,
        /*(SELECT   nom_empresa
         FROM     dercorp_empresa_tab
         WHERE    id_empresa            = meta.id_empresa) AS nom_empresa,*/
         (SELECT val_cat_val
          FROM dercorp_add_campo_cat_val_tab
          WHERE id_catalogo = 1
          AND   id_catalogo_valor = (SELECT val_valor
                                     FROM dercorp_add_campo_valor_tab
                                     WHERE id_empresa = meta.id_empresa
                                     AND id_add_campo = 500))AS nom_empresa,--Argu
        (SELECT   val_cat_val
         FROM     dercorp_add_campo_cat_val_tab
         WHERE    id_catalogo           = 10
         AND      id_catalogo_valor     = meta.val_c1)AS nombre,
         UPPER(APP_COMMON_PKG.SIN_ACENTOS_FN((SELECT   val_cat_val
         FROM     dercorp_add_campo_cat_val_tab
         WHERE    id_catalogo           = 10
         AND      id_catalogo_valor     = meta.val_c1)))AS nombre_plano,
        (SELECT   val_cat_val
         FROM     dercorp_add_campo_cat_val_tab
         WHERE    id_catalogo           = 11
         AND      id_catalogo_valor     = meta.val_c2)AS cargo,
        (SELECT   atributo1
         FROM     dercorp_add_campo_cat_val_tab
         WHERE    id_catalogo           = 11
         AND      id_catalogo_valor     = meta.val_c2)AS cargo_ingles,
         meta.val_c3 AS fecha_designacion,
         meta.val_c4 AS fecha_baja,
          (SELECT   val_cat_val
         FROM     dercorp_add_campo_cat_val_tab
         WHERE    id_catalogo           = 10
         AND      id_catalogo_valor     = meta.val_c5)AS suplente,
         meta.val_c6 AS fecha_desig_suplente,
         meta.val_c7 AS fecha_baja_suplente,
        meta.val_c15 AS ID_ORDEN,
        '1' AS ACTIVO
FROM    dercorp_metatbl_tab meta
WHERE   meta.id_flex_tbl = 9
UNION ALL
--Accionistas
SELECT  meta.val_c1 as id_func,
        meta.id_flex_tbl,
        meta.id_empresa,
        'Accionistas' as tipo_admon,
        (SELECT   val_cat_val
         FROM     dercorp_add_campo_cat_val_tab
         WHERE    id_catalogo_valor = (SELECT   val_valor
                                       FROM     dercorp_add_campo_valor_tab
                                       WHERE    id_empresa            =meta.id_empresa
                                       AND      id_add_campo          = 502))as num_empresa,
        /*(SELECT   nom_empresa
         FROM     dercorp_empresa_tab
         WHERE    id_empresa            = meta.id_empresa) AS nom_empresa,*/
         (SELECT val_cat_val
          FROM dercorp_add_campo_cat_val_tab
          WHERE id_catalogo = 1
          AND   id_catalogo_valor = (SELECT val_valor
                                     FROM dercorp_add_campo_valor_tab
                                     WHERE id_empresa = meta.id_empresa
                                     AND id_add_campo = 500))AS nom_empresa,--Argu
        (SELECT   TRIM(val_cat_val)
         FROM     dercorp_add_campo_cat_val_tab
         WHERE    id_catalogo           = 40
         AND      id_catalogo_valor     = meta.val_c1)AS nombre,
         UPPER(APP_COMMON_PKG.SIN_ACENTOS_FN((SELECT   val_cat_val
         FROM     dercorp_add_campo_cat_val_tab
         WHERE    id_catalogo           = 40
         AND      id_catalogo_valor     = meta.val_c1)))AS nombre_plano,
        'Accionista'AS cargo,
        'Shareholder'AS cargo_ingles,
         NULL AS fecha_designacion,
         NULL AS fecha_baja,
        'N/A' AS suplente,
         NULL AS fecha_desig_suplente,
         NULL AS fecha_baja_suplente,
        'N/A' AS ID_ORDEN,
        '1' AS ACTIVO
FROM    dercorp_metatbl_tab meta
WHERE   meta.id_flex_tbl = 7
UNION ALL
--Apoderados
SELECT  DISTINCT
        TO_CHAR(apo.id_catalogo_valor) as id_func,
        99 AS id_flex_tbl,
        apo.id_empresa,
        'Apoderados' as tipo_admon,
        (SELECT   val_cat_val
         FROM     dercorp_add_campo_cat_val_tab
         WHERE    id_catalogo_valor = (SELECT   val_valor
                                       FROM     dercorp_add_campo_valor_tab
                                       WHERE    id_empresa            =apo.id_empresa
                                       AND      id_add_campo          = 502))as num_empresa,
        /*(SELECT   nom_empresa
         FROM     dercorp_empresa_tab
         WHERE    id_empresa            = apo.id_empresa) AS nom_empresa,*/
         (SELECT val_cat_val
          FROM dercorp_add_campo_cat_val_tab
          WHERE id_catalogo = 1
          AND   id_catalogo_valor = (SELECT val_valor
                                     FROM dercorp_add_campo_valor_tab
                                     WHERE id_empresa = apo.id_empresa
                                     AND id_add_campo = 500))AS nom_empresa,--Argu
        (SELECT   val_cat_val
         FROM     dercorp_add_campo_cat_val_tab
         WHERE    id_catalogo           = 32
         AND      id_catalogo_valor     = apo.id_catalogo_valor)AS nombre,
         UPPER(APP_COMMON_PKG.SIN_ACENTOS_FN((SELECT   val_cat_val
         FROM     dercorp_add_campo_cat_val_tab
         WHERE    id_catalogo           = 32
         AND      id_catalogo_valor     = apo.id_catalogo_valor)))AS nombre_plano,
         apo.des_grupo AS cargo,
         'N/A' AS cargo_ingles,
         TO_CHAR(apo.fec_creation_date,'dd/mm/yyyy') AS fecha_designacion,
         TO_CHAR(apo.fec_fecha_baja,'dd/mm/yyyy') AS fecha_baja,
         'N/A' AS suplente,
         NULL AS fecha_desig_suplente,
         NULL AS fecha_baja_suplente,
        'N/A' AS ID_ORDEN,
        '1' AS ACTIVO
FROM    dercorp_apoderados_tab apo
WHERE   apo.id_catalogo = 32
UNION ALL
--Contactos
SELECT  meta.val_c1 as id_func,
        meta.id_flex_tbl,
        meta.id_empresa,
        'Contactos' as tipo_admon,
        (SELECT   val_cat_val
         FROM     dercorp_add_campo_cat_val_tab
         WHERE    id_catalogo_valor = (SELECT   val_valor
                                       FROM     dercorp_add_campo_valor_tab
                                       WHERE    id_empresa            =meta.id_empresa
                                       AND      id_add_campo          = 502))as num_empresa,
        /*(SELECT   nom_empresa
         FROM     dercorp_empresa_tab
         WHERE    id_empresa            = meta.id_empresa) AS nom_empresa,*/
         (SELECT val_cat_val
          FROM dercorp_add_campo_cat_val_tab
          WHERE id_catalogo = 1
          AND   id_catalogo_valor = (SELECT val_valor
                                     FROM dercorp_add_campo_valor_tab
                                     WHERE id_empresa = meta.id_empresa
                                     AND id_add_campo = 500))AS nom_empresa,--Argu
        (SELECT   val_cat_val
         FROM     dercorp_add_campo_cat_val_tab
         WHERE    id_catalogo           = 56
         AND      id_catalogo_valor     = meta.val_c1)AS nombre,
         UPPER(APP_COMMON_PKG.SIN_ACENTOS_FN((SELECT   val_cat_val
         FROM     dercorp_add_campo_cat_val_tab
         WHERE    id_catalogo           = 56
         AND      id_catalogo_valor     = meta.val_c1)))AS nombre_plano,
        meta.val_c2 AS cargo,
        'N/A' AS cargo_ingles,
         NULL AS fecha_designacion,
         NULL AS fecha_baja,
        'N/A' AS suplente,
         NULL AS fecha_desig_suplente,
         NULL AS fecha_baja_suplente,
        'N/A' AS ID_ORDEN,
        '1' AS ACTIVO
FROM    dercorp_metatbl_tab meta
WHERE   meta.id_flex_tbl = 1;
