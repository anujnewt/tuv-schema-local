CREATE OR REPLACE FORCE NONEDITIONABLE VIEW "USRDRC"."DERCORP_BUSQUEDA_VIEW" ("ID_EMPRESA", "DENOM_ACTUAL", "DENOM_ANTERIOR", "CLASIFICACION", "ID_CLASIFICACION", "PAIS", "ID_PAIS", "ATRIBUTO3") AS 
  SELECT  emp.id_empresa,
        (SELECT val_cat_val
        FROM dercorp_add_campo_cat_val_tab
        WHERE id_catalogo = 1
        AND   id_catalogo_valor = (SELECT val_valor
                                   FROM dercorp_add_campo_valor_tab
                                   WHERE id_empresa = emp.id_empresa
                                   AND id_add_campo = 500)
        )         AS denom_actual,
        mt.val_c1 AS denom_anterior,
        (SELECT val_cat_val
        FROM dercorp_add_campo_cat_val_tab ccv
        WHERE ccv.id_catalogo       = 6
        AND   ccv.id_catalogo_valor = (SELECT val_valor
                                       FROM dercorp_add_campo_valor_tab
                                       WHERE id_empresa = emp.id_empresa
                                       AND id_add_campo = 507)
       )          AS clasificacion,
       (SELECT val_valor
        FROM dercorp_add_campo_valor_tab
        WHERE id_empresa = emp.id_empresa
        AND id_add_campo = 507)  AS id_clasificacion,
       (SELECT val_cat_val
        FROM dercorp_add_campo_cat_val_tab ccv
        WHERE ccv.id_catalogo       = 7
        AND   ccv.id_catalogo_valor = (SELECT val_valor
                                       FROM dercorp_add_campo_valor_tab
                                       WHERE id_empresa = emp.id_empresa
                                       AND id_add_campo = 509)
       )          AS pais,
       (SELECT val_valor
        FROM dercorp_add_campo_valor_tab
        WHERE id_empresa = emp.id_empresa
        AND id_add_campo = 509) AS id_pais,
        (SELECT atributo3
        FROM dercorp_add_campo_cat_val_tab
        WHERE id_catalogo = 1
        AND   id_catalogo_valor = (SELECT val_valor
                                   FROM dercorp_add_campo_valor_tab
                                   WHERE id_empresa = emp.id_empresa
                                   AND id_add_campo = 500)
        )         AS ATRIBUTO3
FROM dercorp_empresa_tab emp
LEFT JOIN dercorp_metatbl_tab mt
ON  mt.id_empresa = emp.id_empresa
AND    mt.id_flex_tbl = 2;
