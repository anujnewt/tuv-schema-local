CREATE OR REPLACE FORCE NONEDITIONABLE VIEW "USRDRC"."PENDIUM_DIVIDENDOS_REP_VW" ("ID_EMPRESA", "NOM_EMPRESA", "ASUNTO", "CHECK_DIVIDENDOS", "DECRETO_DIVIDENDOS", "DIVIDENDOS", "FECHA", "TIPO_FLEX") AS 
  SELECT  id_empresa,
             /* (SELECT nom_empresa
              FROM dercorp_empresa_tab
              WHERE id_empresa = mtbl.id_empresa)AS nom_empresa,*/
              (SELECT val_cat_val
                FROM dercorp_add_campo_cat_val_tab
                WHERE id_catalogo = 1
                AND   id_catalogo_valor = (SELECT val_valor
                                           FROM dercorp_add_campo_valor_tab
                                           WHERE id_empresa = mtbl.id_empresa
                                           AND id_add_campo = 500))AS nom_empresa,--Argu
              mtbl.val_c149 AS Asunto,
              mtbl.val_c92 AS check_dividendos,
              CASE mtbl.val_c92
                WHEN 'No' THEN ''
                WHEN 'Si' THEN '/Decreto de Dividendos'
                ELSE
                ''
                END AS decreto_dividendos,
                mtbl.val_c19 AS dividendos,
                mtbl.val_c3 AS fecha,
                'APROBACION_EJERCICIO_SOCIAL'AS TIPO_FLEX
      FROM DERCORP_METATBL_TAB mtbl
      WHERE ID_FLEX_TBL = 23
      AND    mtbl.val_c92 = 'Si'
      UNION ALL
      SELECT  id_empresa,
       /*       (SELECT nom_empresa
              FROM dercorp_empresa_tab
              WHERE id_empresa = mtbl.id_empresa)AS nom_empresa,*/
              (SELECT val_cat_val
                FROM dercorp_add_campo_cat_val_tab
                WHERE id_catalogo = 1
                AND   id_catalogo_valor = (SELECT val_valor
                                           FROM dercorp_add_campo_valor_tab
                                           WHERE id_empresa = mtbl.id_empresa
                                           AND id_add_campo = 500))AS nom_empresa,--Argu
              mtbl.val_c149 AS Asunto,
              null AS check_dividendos,
              null AS decreto_dividendos,
              mtbl.val_c5 AS dividendos,
              mtbl.val_c3 AS fecha,
              'DECRETO_DIVIDENDOS'AS TIPO_FLEX
      FROM DERCORP_METATBL_TAB mtbl
      WHERE ID_FLEX_TBL = 31;
