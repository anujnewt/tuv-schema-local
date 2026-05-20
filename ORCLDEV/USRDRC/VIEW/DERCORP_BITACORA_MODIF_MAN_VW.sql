CREATE OR REPLACE FORCE NONEDITIONABLE VIEW "USRDRC"."DERCORP_BITACORA_MODIF_MAN_VW" ("ID_EMPRESA", "NOM_EMPRESA", "CREADO_POR", "FEC_CREACION", "MODIFICADO_POR", "FEC_ULTIMA_MODIF") AS 
  SELECT empre.id_empresa,
       --empre.nom_empresa,
       (SELECT val_cat_val
          FROM USRDRC.dercorp_add_campo_cat_val_tab
          WHERE id_catalogo = 1
          AND   id_catalogo_valor = (SELECT val_valor
                                     FROM dercorp_add_campo_valor_tab
                                     WHERE id_empresa = empre.id_empresa
                                     AND id_add_campo = 500))AS nom_empresa,
       a.creado_por,
       a.fec_creacion,
       a.modificado_por,
       a.fec_ultima_modif
FROM   USRDRC.dercorp_empresa_tab empre,
(SELECT emp.id_empresa,
        (SELECT  nom_user_long_name
         FROM    USRDRC.ss_user_tab
         WHERE   id_user = cv.num_created_by) AS creado_por,
        cv.fec_creation_date AS fec_creacion,
        (SELECT  nom_user_long_name
         FROM    USRDRC.ss_user_tab
         WHERE   id_user = cv.num_last_updated_by) AS modificado_por,
        cv.fec_last_update_date AS fec_ultima_modif
FROM    USRDRC.dercorp_empresa_tab emp,
        USRDRC.dercorp_add_campo_valor_tab cv
WHERE   emp.id_empresa = cv.id_empresa
AND     cv.id_add_campo = 502) a
WHERE   empre.id_empresa = a.id_empresa
UNION ALL
select meta.id_empresa,
      (SELECT val_cat_val
          FROM USRDRC.dercorp_add_campo_cat_val_tab
          WHERE id_catalogo = 1
          AND   id_catalogo_valor = (SELECT val_valor
                                     FROM USRDRC.dercorp_add_campo_valor_tab
                                     WHERE id_empresa = meta.id_empresa
                                     AND id_add_campo = 500))AS nom_empresa,
        (SELECT  nom_user_long_name
         FROM    USRDRC.ss_user_tab
         WHERE   id_user = meta.num_created_by) AS creado_por,
         meta.fec_creation_date as fec_creacion,
         (SELECT  nom_user_long_name
         FROM    USRDRC.ss_user_tab
         WHERE   id_user = meta.NUM_LAST_UPDATED_BY) AS modificado_por,
         meta.FEC_LAST_UPDATE_DATE as fec_ultima_modif
from USRDRC.DERCORP_METATBL_TAB meta
UNION ALL
select pod.id_empresa,
(SELECT val_cat_val
          FROM USRDRC.dercorp_add_campo_cat_val_tab
          WHERE id_catalogo = 1
          AND   id_catalogo_valor = (SELECT val_valor
                                     FROM USRDRC.dercorp_add_campo_valor_tab
                                     WHERE id_empresa = pod.id_empresa
                                     AND id_add_campo = 500))AS nom_empresa,
(SELECT  nom_user_long_name
         FROM    USRDRC.ss_user_tab
         WHERE   id_user = pod.num_created_by) AS creado_por,
         pod.fec_creation_date as fec_creacion,
         (SELECT  nom_user_long_name
         FROM    USRDRC.ss_user_tab
         WHERE   id_user = pod.NUM_LAST_UPDATED_BY) AS modificado_por,
         pod.FEC_LAST_UPDATE_DATE as fec_ultima_modif
from PENDIUM_ESCRITURA_PODER_TAB pod
ORDER BY 2;
