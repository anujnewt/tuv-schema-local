CREATE OR REPLACE FORCE NONEDITIONABLE VIEW "USRDRC"."PENDIUM_HIST_CORP_REPORTE_VW" ("ID_EMPRESA", "ID_META_ROW", "ID_FLEX_TBL", "NOM_FLEX", "SOLICITADO_POR", "FEC_PROG_ENTREGA", "FEC_EFECTIVA_ENTREGA", "VAL_C1", "VAL_C2", "VAL_C3", "VAL_C4", "VAL_C5", "VAL_C6", "VAL_C7", "VAL_C8", "VAL_C9", "VAL_C10", "NOM_RESPONSABLE", "RESPONSABLE") AS 
  SELECT
  META.ID_EMPRESA,
  META.ID_META_ROW,
  FLEX.ID_FLEX_TBL,
  FLEX.NOM_FLEX,
  CASE FLEX.ID_FLEX_TBL
    WHEN 23 THEN META.VAL_C91 --Aprobacion del ejericcio social
     WHEN 21 THEN META.VAL_C47 --Reforma parcial de estatutos
    WHEN 20 THEN META.VAL_C56 -- Reforma total de estatutos
    WHEN 22 THEN META.VAL_C54 --Transformacion
    /*WHEN 28 THEN META.VAL_C46 --Acta otros
    WHEN 30 THEN META.VAL_C30 --Contratos
    WHEN 27 THEN META.VAL_C47 --Escritura Otros
    WHEN 29 THEN META.VAL_C40 --Aumento de Capital
    WHEN 31 THEN META.VAL_C30 --Decreto de Dividendos
    WHEN 32 THEN META.VAL_C40 --Disminucion de capital
    WHEN 33 THEN META.VAL_C50 --Escicion
    WHEN 34 THEN META.VAL_C53 --Fusion
    WHEN 35 THEN META.VAL_C30 --Sesion de Consejo
    WHEN 41 THEN META.VAL_C30 --Comites
    */
    ELSE META.VAL_C119 END          AS SOLICITADO_POR,    --SOLICITADO POR
  CASE FLEX.ID_FLEX_TBL
      WHEN 23 THEN META.VAL_C67 --Aprobacion del ejericcio social
      WHEN 21 THEN META.VAL_C28 --Reforma parcial de estatutos
      WHEN 20 THEN META.VAL_C37 -- Reforma total de estatutos
      WHEN 22 THEN META.VAL_C35 --Transformacion
      ELSE META.VAL_C122 END          AS FEC_PROG_ENTREGA,    --FECHA PROGRAMADA DE ENTREGA
  CASE FLEX.ID_FLEX_TBL
  /*
      WHEN 30 THEN META.VAL_C32--Contratos
      WHEN 27 THEN META.VAL_C49 --Escritura Otros
      WHEN 28 THEN META.VAL_C45 --Acta otros
      WHEN 29 THEN META.VAL_C32 --Aumento de Capital
      WHEN 31 THEN META.VAL_C32 --Decreto de Dividendos
      WHEN 32 THEN META.VAL_C42 --Disminucion de capital
      WHEN 33 THEN META.VAL_C52 --Escicion
      WHEN 34 THEN META.VAL_C55 --Fusion
      WHEN 35 THEN META.VAL_C32 --Sesion de Consejo
      WHEN 41 THEN META.VAL_C32 --Comites
      */
      WHEN 23 THEN META.VAL_C59 --Aprobacion del ejericcio social
      WHEN 21 THEN META.VAL_C20 --Reforma parcial de estatutos
      WHEN 20 THEN META.VAL_C29 -- Reforma total de estatutos
      WHEN 22 THEN META.VAL_C27 --Transformacion
      ELSE META.VAL_C121 END          AS FEC_EFECTIVA_ENTREGA,
  CASE FLEX.ID_FLEX_TBL
      WHEN 30 THEN META.VAL_C4
      WHEN 27 THEN META.VAL_C18
      ELSE META.VAL_C3 END          AS VAL_C1,    --FECHA
  CASE FLEX.ID_FLEX_TBL
      WHEN 17 THEN DERCORP_CATALOGS_PKG.GET_ELEMENT_DESCRIP_FN(META.VAL_C1)
      WHEN 18 THEN DERCORP_CATALOGS_PKG.GET_ELEMENT_DESCRIP_FN(META.VAL_C1)
      WHEN 30 THEN DERCORP_CATALOGS_PKG.GET_ELEMENT_DESCRIP_FN(META.VAL_C3)
      ELSE DERCORP_CATALOGS_PKG.GET_ELEMENT_DESCRIP_FN(META.VAL_C2) END          AS VAL_C2,    -- TIPO de REUNION (TIPO CONTRATO)
    META.VAL_C149                   AS VAL_C3,                      --ASUNTO
  CASE FLEX.ID_FLEX_TBL
      WHEN 17 THEN META.VAL_C16
      WHEN 18 THEN META.VAL_C16
      ELSE META.VAL_C150 END         AS VAL_C4,    -- SEMAFORO
  CASE FLEX.ID_FLEX_TBL
      WHEN 17 THEN META.VAL_C8
      WHEN 18 THEN META.VAL_C8
      WHEN 23 THEN META.VAL_C106
      ELSE META.VAL_C86 END         AS VAL_C5,    -- ESCRITURA
  CASE FLEX.ID_FLEX_TBL
      WHEN 17 THEN META.VAL_C9
      WHEN 18 THEN META.VAL_C9
      WHEN 23 THEN META.VAL_C107
      ELSE META.VAL_C87 END         AS VAL_C6,    -- FECHA ESCRITURA
  CASE FLEX.ID_FLEX_TBL
      WHEN 17 THEN META.VAL_C5
      WHEN 18 THEN META.VAL_C5
      WHEN 23 THEN META.VAL_C107
      ELSE META.VAL_C82 END         AS VAL_C7,    -- RPPC
  CASE FLEX.ID_FLEX_TBL
      WHEN 17 THEN META.VAL_C19
      WHEN 18 THEN META.VAL_C19
      WHEN 23 THEN META.VAL_C115
      ELSE META.VAL_C95 END         AS VAL_C8,    -- FECHA RPPC
  CASE FLEX.ID_FLEX_TBL
      WHEN 17 THEN META.VAL_C150
      WHEN 18 THEN META.VAL_C150
      WHEN 23 THEN META.VAL_C103
      ELSE META.VAL_C83 END         AS VAL_C9,    -- SEMAFORO
  CASE FLEX.ID_FLEX_TBL
      WHEN 23 THEN META.VAL_C37--META.VAL_C116
      WHEN 30 THEN TO_CHAR(META.VAL_C23)
      WHEN 27 THEN META.VAL_C13
      WHEN 28 THEN META.VAL_C16
      WHEN 29 THEN META.VAL_C28
      WHEN 31 THEN META.VAL_C18
      WHEN 32 THEN META.VAL_C28
      WHEN 33 THEN META.VAL_C30
      WHEN 34 THEN META.VAL_C32
      WHEN 21 THEN META.VAL_C13 --Reforma Parcial de Estatutos
      WHEN 20 THEN TO_CHAR(META.VAL_C22) --Reforma Total de Estatutos
      WHEN 35 THEN META.VAL_C17
      WHEN 22 THEN TO_CHAR(META.VAL_C20)
      ELSE META.VAL_C96 END         AS VAL_C10,    -- Folio_Mercantil
  (SELECT (SELECT val_cat_val
                      FROM DERCORP_ADD_CAMPO_CAT_VAL_TAB
                      WHERE 1=1
                      AND id_catalogo = 59
                      AND id_catalogo_valor = TRIM(cv.atributo3))
        FROM dercorp_add_campo_cat_val_tab cv
        WHERE id_catalogo = 1
        AND   id_catalogo_valor = (SELECT val_valor
                                   FROM dercorp_add_campo_valor_tab
                                   WHERE id_empresa = META.ID_EMPRESA
                                   AND id_add_campo = 500))AS NOM_RESPONSABLE,
    (SELECT (SELECT ID_CATALOGO_VALOR
                      FROM DERCORP_ADD_CAMPO_CAT_VAL_TAB
                      WHERE 1=1
                      AND id_catalogo = 59
                      AND id_catalogo_valor = TRIM(cv.atributo3))
        FROM dercorp_add_campo_cat_val_tab cv
        WHERE id_catalogo = 1
        AND   id_catalogo_valor = (SELECT val_valor
                                   FROM dercorp_add_campo_valor_tab
                                   WHERE id_empresa = META.ID_EMPRESA
                                   AND id_add_campo = 500))AS RESPONSABLE
FROM
  DERCORP_METATBL_TAB META
  LEFT JOIN DERCORP_ADD_CAMPO_CAT_VAL_TAB CAT ON CAT.ID_CATALOGO_VALOR = META.VAL_C2
  LEFT JOIN DERCORP_FLEX_TBLS_TAB FLEX ON FLEX.ID_FLEX_TBL = META.ID_FLEX_TBL
WHERE
  --META.ID_FLEX_TBL IN (17,18, 20, 21, 22, 23, 28, 29, 31, 32, 33, 34, 35, 30, 27)
  FLEX.ATRIBUTO15 LIKE '%HIST_CORP%';
