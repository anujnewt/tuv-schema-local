CREATE OR REPLACE NONEDITIONABLE PACKAGE "USRDRC"."PENDIUM_CON_PODERES_PKG" AS
  PROCEDURE CONSULTA_ESC_PODER_PR (porcRSResultado OUT SYS_REFCURSOR
                                  ,pinid_empresa NUMBER
                                  ,pstdesc_busqueda varchar2);
  PROCEDURE QUERY_PODERES_ESPECIALES_PR(porcRSResultado OUT SYS_REFCURSOR
                                  ,pstdesc_busqueda varchar2
                                  ,pinid_empresa NUMBER
                                  ,pstOuterror OUT varchar2);
  PROCEDURE QUERY_PODERES_CARTA_PODER_PR(porcRSResultado OUT SYS_REFCURSOR
                                  ,pstdesc_busqueda varchar2
                                  ,pinid_empresa NUMBER
                                  ,pstOuterror OUT varchar2);
  PROCEDURE QUERY_REVOCACIONES_PR(porcRSResultado OUT SYS_REFCURSOR
                                  ,pstdesc_busqueda varchar2
                                  ,pinid_empresa NUMBER
                                  ,pstOuterror OUT varchar2);
  PROCEDURE   QUERY_OTORGA_PODER_PG (porcRSResultado OUT SYS_REFCURSOR
                                  ,pinid_ep_fk NUMBER);
END PENDIUM_CON_PODERES_PKG;
/
CREATE OR REPLACE NONEDITIONABLE PACKAGE BODY "USRDRC"."PENDIUM_CON_PODERES_PKG" AS
  PROCEDURE CONSULTA_ESC_PODER_PR (porcRSResultado OUT SYS_REFCURSOR
                                  ,pinid_empresa NUMBER
                                  ,pstdesc_busqueda varchar2) AS
  BEGIN
      OPEN   porcRSResultado FOR
     SELECT  PODER.DES_PODERTIPO,
             (CASE WHEN ESC.IND_REQUIERE_PROTO=1 AND ESC.DES_ESCRITURA IS NOT NULL THEN
                          ESC.DES_ESCRITURA ELSE 'N/A' END) DES_ESCRITURA,
              ESC.ID_EP_PK,
              PODER.NUM_PODERTIPO,
              (CASE WHEN ESC.IND_REQUIERE_PROTO=1 AND ESC.FEC_OTORGAMIENTO_INSTR IS NOT NULL THEN
                          ESC.FEC_OTORGAMIENTO_INSTR ELSE ESC.FEC_FECHA END) as FEC_FECHA,
              ESC.FEC_OTORGAMIENTO_INSTR,
              ESC.IND_REQUIERE_INSCR_RPPC,
              ESC.FEC_REGISTRO,
              ESC.NUM_FOLIO_MERC,
              ESC.IND_REQUIERE_PROTO,
              ESC.NUM_DOCUMENTUM_INSTR,
              ESC.NUM_LICENCIADO,
              ESC.DESC_ASUNTO,
              PODER.DESC_APODERADOS,
              PODER.FEC_VIGENCIAFIN,
              PODER.DESC_ACTOSDOMINIO,
              PODER.DESC_PLEITOSCOBRANZA,
              PODER.DESC_ACTOSADMON,
              PODER.DESC_TITULOSCREDITO,
              NVL(PE.DES_PODER,'') AS DESC_PODER_ESPECIAL,
              ESC.IND_TIPO_ESCRITURA,
              PODER.ID_OPODER_EP_PK,
              PE.ID_OPODER_EP_PK AS PE_ID,
              ESC_B.IND_TIPO_ESCRITURA
      FROM PENDIUM_OTORGAPODER_EP_TAB PODER
      INNER JOIN PENDIUM_ESCRITURA_PODER_TAB ESC ON ESC.ID_EP_PK = PODER.ID_EP_FK  AND ESC.IND_STATUS = 1  AND PODER.IND_STATUS = 1
      LEFT JOIN PENDIUM_OTORGAPODER_EP_TAB PE
        JOIN PENDIUM_ESCRITURA_PODER_TAB ESC_B ON (ESC_B.ID_EP_PK = PE.ID_EP_FK AND ESC_B.IND_TIPO_ESCRITURA = 'PE' AND ESC_B.IND_STATUS = 1  AND PE.IND_STATUS = 1)
      ON TRIM(NVL(TO_CHAR(PODER.DES_PODER),' ')) = NVL(PE.DES_PODERTIPO,' ') AND ESC_B.ID_EMPRESA = ESC.ID_EMPRESA AND NVL(ESC.DES_ESCRITURA,' ') = NVL(ESC_B.DES_ESCRITURA,' ')
        AND ESC.IND_DELEGADO_POR = ESC_B.IND_DELEGADO_POR AND NVL(ESC.FEC_FECHA,' ') = NVL(ESC_B.FEC_FECHA,' ') AND NVL(ESC.NUM_DOCUMENTUM_INSTR,' ') = NVL(ESC_B.NUM_DOCUMENTUM_INSTR,' ')
        AND NVL(ESC.FEC_OTORGAMIENTO_INSTR,' ') = NVL(ESC_B.FEC_OTORGAMIENTO_INSTR,' ') AND ESC.NUM_LICENCIADO = ESC_B.NUM_LICENCIADO AND NVL(ESC.NUM_INSC_REGPUB,' ') = NVL(ESC_B.NUM_INSC_REGPUB,' ')
        AND NVL(ESC.FEC_REGISTRO,' ') = NVL(ESC_B.FEC_REGISTRO,' ')
      WHERE ESC.IND_TIPO_ESCRITURA = 'PG'
      AND ESC.IND_STATUS = 1
      AND ESC.ID_EMPRESA = pinid_empresa
      AND (ESC.DES_ESCRITURA         LIKE  '%' || pstdesc_busqueda ||'%'
      OR   REGEXP_REPLACE(LOWER(ESC.DESC_ASUNTO),'([[:digit:]])','')     LIKE  '%' || LOWER(pstdesc_busqueda) ||'%'
      OR   REGEXP_REPLACE(LOWER(PODER.DESC_APODERADOS),'([[:digit:]])','')     LIKE  '%' || LOWER(pstdesc_busqueda) || '%'
      OR   ESC.FEC_OTORGAMIENTO_INSTR              = pstdesc_busqueda )
      ORDER BY CASE WHEN ESC.FEC_FECHA IS NOT NULL THEN TO_DATE(FEC_FECHA,'DD/MM/YYYY') ELSE TO_DATE('31/12/2999','DD/MM/YYYY') END DESC
      ,CASE WHEN ESC.DES_ESCRITURA IS NULL OR DES_ESCRITURA='N/A' THEN 99999999 ELSE TO_NUMBER(REPLACE(ESC.DES_ESCRITURA,',','')) END DESC, ESC.ID_EP_PK, PODER.NUM_ORDER;
    END CONSULTA_ESC_PODER_PR;
PROCEDURE QUERY_PODERES_ESPECIALES_PR(porcRSResultado OUT SYS_REFCURSOR
                                  ,pstdesc_busqueda varchar2
                                  ,pinid_empresa NUMBER
                                  ,pstOuterror OUT varchar2)
           AS
           BEGIN
           OPEN porcRSResultado FOR
            SELECT *
            FROM (
            SELECT PENDIUM_ESCRITURA_PODER_TAB.ID_EP_PK,
                                      (CASE WHEN PENDIUM_ESCRITURA_PODER_TAB.IND_REQUIERE_PROTO=1 AND PENDIUM_ESCRITURA_PODER_TAB.DES_ESCRITURA IS NOT NULL THEN
                                        PENDIUM_ESCRITURA_PODER_TAB.DES_ESCRITURA ELSE 'N/A' END) DES_ESCRITURA,
                                      PENDIUM_ESCRITURA_PODER_TAB.IND_TIPO_ESCRITURA,
                                      (CASE WHEN PENDIUM_ESCRITURA_PODER_TAB.IND_REQUIERE_PROTO=1 AND PENDIUM_ESCRITURA_PODER_TAB.FEC_OTORGAMIENTO_INSTR IS NOT NULL THEN
                                        PENDIUM_ESCRITURA_PODER_TAB.FEC_OTORGAMIENTO_INSTR ELSE PENDIUM_ESCRITURA_PODER_TAB.FEC_FECHA END) as FEC_FECHA,
                                        PENDIUM_ESCRITURA_PODER_TAB.FEC_OTORGAMIENTO_INSTR,
                                      PENDIUM_OTORGAPODER_EP_TAB.DES_PODERTIPO,
                                      PENDIUM_OTORGAPODER_EP_TAB.FEC_VIGENCIAFIN,
                                      PENDIUM_OTORGAPODER_EP_TAB.DESC_APODERADOS,
                                      PENDIUM_OTORGAPODER_EP_TAB.DES_PODER,
                                      PENDIUM_ESCRITURA_PODER_TAB.IND_STATUS,
                                      PENDIUM_ESCRITURA_PODER_TAB.FEC_REGISTRO,
                                      PENDIUM_ESCRITURA_PODER_TAB.NUM_FOLIO_MERC,
                                      PENDIUM_ESCRITURA_PODER_TAB.IND_REQUIERE_PROTO,
                                      PENDIUM_ESCRITURA_PODER_TAB.NUM_DOCUMENTUM_INSTR,
                                      PENDIUM_ESCRITURA_PODER_TAB.IND_REQUIERE_INSCR_RPPC,
                                      PENDIUM_ESCRITURA_PODER_TAB.IND_STATUS_ESC,
                                      PENDIUM_ESCRITURA_PODER_TAB.NUM_LICENCIADO,
                                      PENDIUM_ESCRITURA_PODER_TAB.IND_STATUS_RPPC,
                                      PENDIUM_OTORGAPODER_EP_TAB.NUM_ORDER
                              FROM PENDIUM_ESCRITURA_PODER_TAB
                                INNER JOIN PENDIUM_OTORGAPODER_EP_TAB
                                  ON PENDIUM_ESCRITURA_PODER_TAB.ID_EP_PK              = PENDIUM_OTORGAPODER_EP_TAB.ID_EP_FK
                              WHERE PENDIUM_ESCRITURA_PODER_TAB.IND_TIPO_ESCRITURA = 'PE'
                                AND PENDIUM_ESCRITURA_PODER_TAB.IND_STATUS           = 1
                                AND PENDIUM_ESCRITURA_PODER_TAB.ID_EMPRESA           = pinid_empresa
                                AND PENDIUM_ESCRITURA_PODER_TAB.DES_ESCRITURA Not in ( SELECT EB.DES_ESCRITURA
                                                                                       FROM PENDIUM_ESCRITURA_PODER_TAB EB INNER JOIN PENDIUM_OTORGAPODER_EP_TAB POD
                                                                                       ON EB.ID_EP_PK = POD.ID_EP_FK
                                                                                       WHERE EB.DES_ESCRITURA = PENDIUM_ESCRITURA_PODER_TAB.DES_ESCRITURA
                                                                                       AND TO_CHAR(POD.DES_PODER) = PENDIUM_OTORGAPODER_EP_TAB.DES_PODERTIPO
                                                                                       AND EB.IND_DELEGADO_POR = PENDIUM_ESCRITURA_PODER_TAB.IND_DELEGADO_POR AND NVL(EB.FEC_FECHA,' ') = NVL(PENDIUM_ESCRITURA_PODER_TAB.FEC_FECHA,' ') AND NVL(EB.NUM_DOCUMENTUM_INSTR,' ') = NVL(PENDIUM_ESCRITURA_PODER_TAB.NUM_DOCUMENTUM_INSTR,' ')
                                                                                       AND NVL(EB.FEC_OTORGAMIENTO_INSTR,' ') = NVL(PENDIUM_ESCRITURA_PODER_TAB.FEC_OTORGAMIENTO_INSTR,' ') AND EB.NUM_LICENCIADO = PENDIUM_ESCRITURA_PODER_TAB.NUM_LICENCIADO AND NVL(EB.NUM_INSC_REGPUB,' ') = NVL(PENDIUM_ESCRITURA_PODER_TAB.NUM_INSC_REGPUB,' ')
                                                                                       AND NVL(EB.FEC_REGISTRO,' ') = NVL(PENDIUM_ESCRITURA_PODER_TAB.FEC_REGISTRO,' ')
                                                                                       AND EB.IND_TIPO_ESCRITURA = 'PG'
                                                                                       AND EB.IND_STATUS = 1
                                                                                       AND EB.ID_EMPRESA = PENDIUM_ESCRITURA_PODER_TAB.ID_EMPRESA)
            /*UNION ALL
            SELECT PENDIUM_ESCRITURA_PODER_TAB.ID_EP_PK,
                                      (CASE WHEN PENDIUM_ESCRITURA_PODER_TAB.IND_REQUIERE_PROTO=1 AND PENDIUM_ESCRITURA_PODER_TAB.DES_ESCRITURA IS NOT NULL THEN
                                        PENDIUM_ESCRITURA_PODER_TAB.DES_ESCRITURA ELSE 'N/A' END) DES_ESCRITURA,
                                      PENDIUM_ESCRITURA_PODER_TAB.IND_TIPO_ESCRITURA,
                                      (CASE WHEN PENDIUM_ESCRITURA_PODER_TAB.IND_REQUIERE_PROTO=1 AND PENDIUM_ESCRITURA_PODER_TAB.FEC_OTORGAMIENTO_INSTR IS NOT NULL THEN
                                        PENDIUM_ESCRITURA_PODER_TAB.FEC_OTORGAMIENTO_INSTR ELSE PENDIUM_ESCRITURA_PODER_TAB.FEC_FECHA END) as FEC_FECHA,
                                      PENDIUM_OTORGAPODER_EP_TAB.DES_PODERTIPO,
                                      PENDIUM_OTORGAPODER_EP_TAB.FEC_VIGENCIAFIN,
                                      PENDIUM_OTORGAPODER_EP_TAB.DESC_APODERADOS,
                                      PENDIUM_OTORGAPODER_EP_TAB.DES_PODER,
                                      PENDIUM_ESCRITURA_PODER_TAB.IND_STATUS,
                                      PENDIUM_ESCRITURA_PODER_TAB.FEC_REGISTRO,
                                      PENDIUM_ESCRITURA_PODER_TAB.NUM_FOLIO_MERC,
                                      PENDIUM_ESCRITURA_PODER_TAB.IND_REQUIERE_PROTO,
                                      PENDIUM_ESCRITURA_PODER_TAB.NUM_DOCUMENTUM_INSTR,
                                      PENDIUM_ESCRITURA_PODER_TAB.IND_REQUIERE_INSCR_RPPC,
                                      PENDIUM_ESCRITURA_PODER_TAB.IND_STATUS_ESC,
                                      PENDIUM_ESCRITURA_PODER_TAB.NUM_LICENCIADO,
                                      PENDIUM_ESCRITURA_PODER_TAB.IND_STATUS_RPPC,
                                      PENDIUM_OTORGAPODER_EP_TAB.NUM_ORDER
                              FROM PENDIUM_ESCRITURA_PODER_TAB
                                INNER JOIN PENDIUM_OTORGAPODER_EP_TAB
                                  ON PENDIUM_ESCRITURA_PODER_TAB.ID_EP_PK              = PENDIUM_OTORGAPODER_EP_TAB.ID_EP_FK
                              WHERE PENDIUM_ESCRITURA_PODER_TAB.IND_TIPO_ESCRITURA = 'PE'
                                AND PENDIUM_ESCRITURA_PODER_TAB.IND_STATUS           = 1
                                AND PENDIUM_ESCRITURA_PODER_TAB.ID_EMPRESA           = pinid_empresa
                                  AND PENDIUM_ESCRITURA_PODER_TAB.DES_ESCRITURA =  (SELECT DISTINCT EB.DES_ESCRITURA
                                                                                    FROM PENDIUM_ESCRITURA_PODER_TAB EB
                                                                                    WHERE EB.DES_ESCRITURA = PENDIUM_ESCRITURA_PODER_TAB.DES_ESCRITURA
                                                                                    AND EB.IND_TIPO_ESCRITURA = 'PG'
                                                                                    AND EB.IND_STATUS=1
                                                                                    AND EB.ID_EMPRESA           = PENDIUM_ESCRITURA_PODER_TAB.ID_EMPRESA)
                                AND PENDIUM_OTORGAPODER_EP_TAB.DES_PODERTIPO NOT IN (SELECT TRIM(TO_CHAR(op.DES_PODER))
                                                                                    FROM PENDIUM_ESCRITURA_PODER_TAB EB,
                                                                                         PENDIUM_OTORGAPODER_EP_TAB  op
                                                                                    where eb.ID_EP_PK = op.ID_EP_FK
                                                                                    and EB.DES_ESCRITURA = PENDIUM_ESCRITURA_PODER_TAB.DES_ESCRITURA
                                                                                    AND EB.IND_TIPO_ESCRITURA = 'PG'
                                                                                    AND EB.IND_STATUS=1
                                                                                    AND EB.ID_EMPRESA           = PENDIUM_ESCRITURA_PODER_TAB.ID_EMPRESA)*/
            ) temp
            WHERE  (pstdesc_busqueda IS NULL OR pstdesc_busqueda = '' or (temp.DES_ESCRITURA  LIKE  '%' || pstdesc_busqueda ||'%'
            OR REGEXP_REPLACE(LOWER(temp.DESC_APODERADOS),'([[:digit:]])','')        LIKE  '%' || LOWER(pstdesc_busqueda) || '%'))
            OR temp.FEC_FECHA = pstdesc_busqueda
            ORDER BY CASE WHEN temp.FEC_FECHA IS NULL THEN TO_DATE('31/12/2999','DD/MM/YYYY') ELSE TO_DATE(temp.FEC_FECHA,'DD/MM/YYYY') END DESC
              , CASE WHEN temp.DES_ESCRITURA IS NULL OR DES_ESCRITURA='N/A' THEN 99999999 ELSE TO_NUMBER(REPLACE(temp.DES_ESCRITURA,',','')) END DESC, temp.ID_EP_PK, temp.NUM_ORDER      ;
    EXCEPTION
    WHEN OTHERS THEN
        pstOuterror := SQLERRM;
  END;
PROCEDURE QUERY_PODERES_CARTA_PODER_PR(porcRSResultado OUT SYS_REFCURSOR
                                  ,pstdesc_busqueda varchar2
                                  ,pinid_empresa NUMBER
                                  ,pstOuterror OUT varchar2)
                                   AS
           BEGIN
            OPEN porcRSResultado FOR
           SELECT PENDIUM_ESCRITURA_PODER_TAB.ID_EP_PK,
                          PENDIUM_ESCRITURA_PODER_TAB.IND_TIPO_ESCRITURA,
                          PENDIUM_ESCRITURA_PODER_TAB.FEC_FECHA,
                          PENDIUM_ESCRITURA_PODER_TAB.FEC_OTORGAMIENTO_INSTR,
                          PENDIUM_OTORGAPODER_EP_TAB.DES_PODERTIPO,
                          PENDIUM_OTORGAPODER_EP_TAB.FEC_VIGENCIAFIN,
                          PENDIUM_OTORGAPODER_EP_TAB.DESC_APODERADOS,
                          PENDIUM_OTORGAPODER_EP_TAB.DES_PODER,
                          PENDIUM_ESCRITURA_PODER_TAB.IND_STATUS,
                          PENDIUM_ESCRITURA_PODER_TAB.IND_REQUIERE_PROTO,
                          PENDIUM_ESCRITURA_PODER_TAB.IND_REQUIERE_INSCR_RPPC,
                          PENDIUM_ESCRITURA_PODER_TAB.IND_STATUS_ESC,
                          PENDIUM_ESCRITURA_PODER_TAB.IND_STATUS_RPPC,
                          PENDIUM_ESCRITURA_PODER_TAB.DES_ESCRITURA
                  FROM PENDIUM_ESCRITURA_PODER_TAB
                    INNER JOIN PENDIUM_OTORGAPODER_EP_TAB
                      ON PENDIUM_ESCRITURA_PODER_TAB.ID_EP_PK              = PENDIUM_OTORGAPODER_EP_TAB.ID_EP_FK
                  WHERE PENDIUM_ESCRITURA_PODER_TAB.IND_TIPO_ESCRITURA = 'CP'
                    AND PENDIUM_ESCRITURA_PODER_TAB.IND_STATUS           = 1
                    AND PENDIUM_ESCRITURA_PODER_TAB.ID_EMPRESA           = pinid_empresa
                   AND (pstdesc_busqueda IS NULL OR pstdesc_busqueda = '' or (PENDIUM_ESCRITURA_PODER_TAB.FEC_FECHA            = pstdesc_busqueda  OR
                        REGEXP_REPLACE(LOWER(PENDIUM_OTORGAPODER_EP_TAB.DESC_APODERADOS),'([[:digit:]])','')      LIKE  '%' || LOWER(pstdesc_busqueda) || '%'
                      ))
                                  ORDER BY CASE WHEN PENDIUM_ESCRITURA_PODER_TAB.FEC_FECHA IS NULL THEN TO_DATE('31/12/2999','DD/MM/YYYY') ELSE TO_DATE(PENDIUM_ESCRITURA_PODER_TAB.FEC_FECHA,'DD/MM/YYYY') END DESC, PENDIUM_OTORGAPODER_EP_TAB.NUM_ORDER;
                                  EXCEPTION
    WHEN OTHERS THEN
        pstOuterror := SQLERRM;
  END;
PROCEDURE QUERY_REVOCACIONES_PR(porcRSResultado OUT SYS_REFCURSOR
                                  ,pstdesc_busqueda varchar2
                                  ,pinid_empresa NUMBER
                                  ,pstOuterror OUT varchar2)
                                   AS
           BEGIN
          OPEN porcRSResultado FOR
            SELECT        PENDIUM_ESCRITURA_PODER_TAB.ID_EP_PK,
                          PENDIUM_ESCRITURA_PODER_TAB.IND_TIPO_ESCRITURA,
                          (CASE WHEN PENDIUM_ESCRITURA_PODER_TAB.IND_REQUIERE_PROTO=1 AND PENDIUM_ESCRITURA_PODER_TAB.FEC_OTORGAMIENTO_INSTR IS NOT NULL THEN
                                        PENDIUM_ESCRITURA_PODER_TAB.FEC_OTORGAMIENTO_INSTR ELSE PENDIUM_ESCRITURA_PODER_TAB.FEC_FECHA END) FEC_FECHA,
                          (CASE WHEN IND_REQUIERE_PROTO=1 AND DES_ESCRITURA IS NOT NULL THEN
                                    DES_ESCRITURA ELSE 'N/A' END) DES_ESCRITURA,
                          (SELECT VAL_CAT_VAL FROM DERCORP_ADD_CAMPO_CAT_VAL_TAB
                            WHERE ID_CATALOGO_VALOR=PENDIUM_ESCRITURA_PODER_TAB.IND_DELEGADO_POR) DELEGADO_POR,
                          PENDIUM_ESCRITURA_PODER_TAB.FEC_OTORGAMIENTO_INSTR,
                          PENDIUM_ESCRITURA_PODER_TAB.IND_STATUS,
                          PENDIUM_ESCRITURA_PODER_TAB.IND_REQUIERE_PROTO,
                          PENDIUM_ESCRITURA_PODER_TAB.NUM_DOCUMENTUM_INSTR,
                          PENDIUM_ESCRITURA_PODER_TAB.NUM_LICENCIADO,
                          PENDIUM_ESCRITURA_PODER_TAB.IND_REQUIERE_INSCR_RPPC,
                          PENDIUM_ESCRITURA_PODER_TAB.FEC_REGISTRO,
                          PENDIUM_ESCRITURA_PODER_TAB.NUM_FOLIO_MERC,
                          PENDIUM_ESCRITURA_PODER_TAB.IND_STATUS_ESC,
                          PENDIUM_ESCRITURA_PODER_TAB.IND_STATUS_RPPC
                  FROM PENDIUM_ESCRITURA_PODER_TAB
                  WHERE PENDIUM_ESCRITURA_PODER_TAB.IND_TIPO_ESCRITURA = 'ER'
                    AND PENDIUM_ESCRITURA_PODER_TAB.IND_STATUS           = 1
                    AND PENDIUM_ESCRITURA_PODER_TAB.ID_EMPRESA           = pinid_empresa
                   AND (pstdesc_busqueda IS NULL OR pstdesc_busqueda = '' OR (DES_ESCRITURA  LIKE  '%' || pstdesc_busqueda ||'%'
                        OR (CASE WHEN PENDIUM_ESCRITURA_PODER_TAB.IND_REQUIERE_PROTO=1 AND PENDIUM_ESCRITURA_PODER_TAB.FEC_OTORGAMIENTO_INSTR IS NOT NULL THEN
                                        PENDIUM_ESCRITURA_PODER_TAB.FEC_OTORGAMIENTO_INSTR ELSE PENDIUM_ESCRITURA_PODER_TAB.FEC_FECHA END) = pstdesc_busqueda))
                   ORDER BY CASE WHEN FEC_FECHA IS NULL THEN TO_DATE('31/12/2999','DD/MM/YYYY') ELSE TO_DATE(FEC_FECHA,'DD/MM/YYYY') END DESC,
                   CASE WHEN DES_ESCRITURA IS NULL OR DES_ESCRITURA='N/A' THEN 99999999 ELSE TO_NUMBER(REPLACE(DES_ESCRITURA,',','')) END DESC;
                    EXCEPTION
    WHEN OTHERS THEN
        pstOuterror := SQLERRM;
  END;
PROCEDURE   QUERY_OTORGA_PODER_PG (porcRSResultado OUT SYS_REFCURSOR
                                  ,pinid_ep_fk NUMBER)
                                  AS
           BEGIN
            OPEN porcRSResultado FOR
              SELECT
              null AS "Apoderados"
              ,null AS "Facultades"
              ,null As "Mancomunados"
              ,PODER.ID_OPODER_EP_PK
              ,PODER.ID_EP_FK
              ,PODER.NUM_PODERTIPO
              ,PODER.DES_PODERTIPO
              ,PODER.NUM_VIGENCIATIPO
              ,PODER.DES_VIGENCIATIPO
              ,PODER.NUM_VIGENCIATIEMPO
              ,PODER.FEC_VIGENCIAINICIO
              ,PODER.FEC_VIGENCIAFIN
              ,PODER.DESC_CARACTERISTICAS
              ,PODER.DESC_ACTOSDOMINIO
              ,PODER.DESC_ACTOSADMON
              ,PODER.DESC_PLEITOSCOBRANZA
              ,PODER.DESC_REVOCADOS
              ,PODER.NUM_CREATED_BY
              ,PODER.FEC_CREATION_DATE
              ,PODER.NUM_LAST_UPDATED_BY
              ,PODER.FEC_LAST_UPDATE_DATE
              ,PODER.NUM_LAST_UPDATE_LOGIN
              ,PODER.ATRIBUTO1
              ,PODER.ATRIBUTO2
              ,PODER.ATRIBUTO3
              ,PODER.ATRIBUTO4
              ,PODER.ATRIBUTO5
              ,PODER.ATRIBUTO6
              ,PODER.ATRIBUTO7
              ,PODER.ATRIBUTO8
              ,PODER.ATRIBUTO9
              ,PODER.ATRIBUTO10
              ,PODER.ATRIBUTO11
              ,PODER.ATRIBUTO12
              ,PODER.ATRIBUTO13
              ,PODER.ATRIBUTO14
              ,PODER.ATRIBUTO15
              ,PODER.ATTRIBUTE_CATEGORY
              ,PODER.NUM_ORDER
              ,PODER.DESC_TITULOSCREDITO
              ,PODER.DESC_VIGENCIA
              ,PODER.IND_STATUS
              ,PODER.DESC_DESCRIPCION
              ,PODER.DES_PODER
              ,PODER.DESC_APODERADOS
              ,NVL(PE.DES_PODER,'') AS DESC_PODER_ESPECIAL
              FROM PENDIUM_OTORGAPODER_EP_TAB PODER
                  INNER JOIN PENDIUM_ESCRITURA_PODER_TAB ESC ON ESC.ID_EP_PK = PODER.ID_EP_FK
                  LEFT JOIN PENDIUM_OTORGAPODER_EP_TAB PE
                    JOIN PENDIUM_ESCRITURA_PODER_TAB ESC_B ON (ESC_B.ID_EP_PK = PE.ID_EP_FK AND ESC_B.IND_TIPO_ESCRITURA = 'PE' AND ESC_B.IND_STATUS = 1  AND PE.IND_STATUS = 1)
                  ON TRIM(NVL(TO_CHAR(PODER.DES_PODER),' ')) = NVL(PE.DES_PODERTIPO,' ') AND ESC_B.ID_EMPRESA = ESC.ID_EMPRESA AND NVL(ESC.DES_ESCRITURA,' ') = NVL(ESC_B.DES_ESCRITURA,' ')
                    AND ESC.IND_DELEGADO_POR = ESC_B.IND_DELEGADO_POR AND NVL(ESC.FEC_FECHA,' ') = NVL(ESC_B.FEC_FECHA,' ') AND NVL(ESC.NUM_DOCUMENTUM_INSTR,' ') = NVL(ESC_B.NUM_DOCUMENTUM_INSTR,' ')
                    AND NVL(ESC.FEC_OTORGAMIENTO_INSTR,' ') = NVL(ESC_B.FEC_OTORGAMIENTO_INSTR,' ') AND ESC.NUM_LICENCIADO = ESC_B.NUM_LICENCIADO AND NVL(ESC.NUM_INSC_REGPUB,' ') = NVL(ESC_B.NUM_INSC_REGPUB,' ')
                    AND NVL(ESC.FEC_REGISTRO,' ') = NVL(ESC_B.FEC_REGISTRO,' ')
                WHERE
                  PODER.ID_EP_FK  = pinid_ep_fk
                  AND PODER.IND_STATUS = 1
                  AND ESC.IND_STATUS = 1
              ORDER BY NUM_ORDER;
END QUERY_OTORGA_PODER_PG;
END PENDIUM_CON_PODERES_PKG;
/;
