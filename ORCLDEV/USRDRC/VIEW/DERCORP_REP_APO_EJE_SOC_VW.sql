CREATE OR REPLACE FORCE NONEDITIONABLE VIEW "USRDRC"."DERCORP_REP_APO_EJE_SOC_VW" ("ID_EMPRESA", "NOM_EMPRESA", "FEC_DICTAMEN_FISCAL", "FEC_DIC_FINAN", "FEC_INF_COMI", "FEC_CONSTANCIA", "FEC_ANUAL", "EJERCICIOSOCIAL") AS 
  SELECT "ID_EMPRESA","NOM_EMPRESA","FEC_DICTAMEN_FISCAL","FEC_DIC_FINAN","FEC_INF_COMI","FEC_CONSTANCIA","FEC_ANUAL","EJERCICIOSOCIAL" FROM (
    SELECT empre.id_empresa,
         --empre.nom_empresa,
         (SELECT val_cat_val
          FROM dercorp_add_campo_cat_val_tab
          WHERE id_catalogo = 1
          AND   id_catalogo_valor = (SELECT val_valor
                                     FROM dercorp_add_campo_valor_tab
                                     WHERE id_empresa = empre.id_empresa
                                     AND id_add_campo = 500))AS nom_empresa,
         a.fec_dictamen_fiscal,
         a.fec_dic_finan,
         a.fec_inf_comi,
         a.fec_constancia,
         a.fec_anual,
         a.EJERCICIOSOCIAL
  FROM   dercorp_empresa_tab empre,
  (SELECT emp.id_empresa,
          meta.val_c51 AS fec_dictamen_fiscal,
          meta.val_c46 AS fec_dic_finan,
          meta.val_c41 AS fec_inf_comi,
          meta.val_c88 AS fec_constancia,
          meta.val_c36 AS fec_anual,
          meta.val_c5  AS EJERCICIOSOCIAL
  FROM    dercorp_empresa_tab emp,
          dercorp_metatbl_tab meta
  WHERE   emp.id_empresa = meta.id_empresa
  AND     meta.id_flex_tbl = 23) a
  WHERE   empre.id_empresa = a.id_empresa(+)
  ORDER BY 2
  ) t
  WHERE   1=1
  AND     t.nom_empresa IS NOT NULL;
