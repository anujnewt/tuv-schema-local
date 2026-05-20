CREATE OR REPLACE FORCE NONEDITIONABLE VIEW "USRDRC"."DERCORP_REP_ESTCAPSOC_VW" ("ID_EMPRESA", "DENOM_ACTUAL") AS 
  SELECT  emp.id_empresa,
        (SELECT val_cat_val
        FROM dercorp_add_campo_cat_val_tab
        WHERE id_catalogo = 1
        AND   id_catalogo_valor = (SELECT val_valor
                                   FROM dercorp_add_campo_valor_tab
                                   WHERE id_empresa = emp.id_empresa
                                   AND id_add_campo = 500)
        )         AS denom_actual
FROM dercorp_empresa_tab emp;
