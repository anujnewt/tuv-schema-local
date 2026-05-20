CREATE OR REPLACE NONEDITIONABLE PACKAGE "USRDRC"."PENDIUM_REPORTES_PODERES_PKG" AS
  PROCEDURE   QUERY_APODERADOS_PG (porcRSResultado OUT SYS_REFCURSOR
                                  ,pstdes_empresas varchar2
                                  ,pstdes_tipopoder varchar2
                                  ,pstdes_apoderados varchar2
                                  ,pstdes_poder varchar2
                                  ,pstdes_escritura varchar2);
  PROCEDURE   QUERY_PODERES_POR_EMPRESA (porcRSResultado OUT SYS_REFCURSOR
                                  ,pstdes_empresas varchar2
                                  ,pstdes_tipopoder varchar2
                                  ,pstdes_apoderados varchar2
                                  ,pstdes_poder varchar2
                                  ,pstdes_escritura varchar2);
 PROCEDURE   QUERY_PODERES_POR_ESCRITURA_PG (porcRSResultado OUT SYS_REFCURSOR
                                  ,pstdes_empresas varchar2
                                  ,pstdes_tipopoder varchar2
                                  ,pstdes_apoderados varchar2
                                  ,pstdes_poder varchar2
                                  ,pstdes_escritura varchar2);
PROCEDURE   QUERY_PODERES_POR_ASUNTO (porcRSResultado OUT SYS_REFCURSOR
                                  ,pstdes_empresas varchar2
                                  ,pstdes_tipopoder varchar2
                                  ,pstdes_apoderados varchar2
                                  ,pstdes_grupoapoderados varchar2
                                  ,pstdes_poder varchar2
                                  ,pstdes_escritura varchar2);
 PROCEDURE   QUERY_ESCRITURAS (porcRSResultado OUT SYS_REFCURSOR
                                  ,pstdes_empresas varchar2
                                  ,pstdes_tipopoder varchar2
                                  ,pstdes_apoderados varchar2
                                  ,pstdes_poder varchar2
                                  ,pstdes_escritura varchar2);
 PROCEDURE   QUERY_REVOCACIONES (porcRSResultado OUT SYS_REFCURSOR
                                  ,pstin_id_opoder_fk varchar2);
PROCEDURE   QUERY_REVOCACIONES (porcRSResultado OUT SYS_REFCURSOR);
  PROCEDURE   QUERY_PODERES_POR_FACULTAD (porcRSResultado OUT SYS_REFCURSOR
                                  ,pstdes_empresas varchar2
                                  ,pstdes_tipopoder varchar2
                                  ,pstdes_apoderados varchar2
                                  ,pstdes_poder varchar2
                                  ,pstdes_escritura varchar2
                                  ,pstAD varchar2
                                  ,pstAA varchar2
                                  ,pstPC varchar2
                                  ,pstTC varchar2
                                  );
PROCEDURE QUERY_PODERES_POR_FACULTAD_ESP (porcRSResultado OUT SYS_REFCURSOR
                                  ,pstdes_empresas varchar2
                                  ,pstdes_tipopoder varchar2
                                  ,pstdes_apoderados varchar2
                                  ,pstdes_poder varchar2
                                  ,pstdes_escritura varchar2);
  PROCEDURE   QUERY_PODERES_TIPO_PODER (porcRSResultado OUT SYS_REFCURSOR
                                  ,pstdes_empresas varchar2
                                  ,pstdes_tipopoder varchar2
                                  ,pstdes_apoderados varchar2
                                  ,pstdes_poder varchar2
                                  ,pstdes_escritura varchar2);
  PROCEDURE   QUERY_PODERES_POR_VIGENCIA (porcRSResultado OUT SYS_REFCURSOR
                                  ,pstdes_empresas varchar2
                                  ,pstdes_fecha_desde varchar2
                                  ,pstdes_fecha_hasta varchar2
                                  ,pstdes_tipopoder varchar2
                                  ,pstdes_apoderados varchar2
                                  ,pstdes_poder varchar2
                                  ,pstdes_escritura varchar2);
  PROCEDURE QUERY_ESC_POR_EMP_ANIO_PR (pinid_empresa NUMBER
                                  ,pinanio NUMBER
                                  ,porcRSResultado OUT SYS_REFCURSOR);
END PENDIUM_REPORTES_PODERES_PKG;
/
CREATE OR REPLACE NONEDITIONABLE PACKAGE BODY "USRDRC"."PENDIUM_REPORTES_PODERES_PKG" AS
 PROCEDURE   QUERY_APODERADOS_PG (porcRSResultado OUT SYS_REFCURSOR
                                  ,pstdes_empresas varchar2
                                  ,pstdes_tipopoder varchar2
                                  ,pstdes_apoderados varchar2
                                  ,pstdes_poder varchar2
                                  ,pstdes_escritura varchar2)
          AS
          dinamicQuery CLOB;
          BEGIN
          --[fec_otorgamiento_instr, nom_empresa, des_podertipo, ind_tipo_escritura, desc_actosdominio, desc_pleitoscobranza, fec_vigenciafin]
          dinamicQuery := 'SELECT (CASE WHEN PENDIUM_ESCRITURA_PODER_TAB.IND_REQUIERE_PROTO=1 AND PENDIUM_ESCRITURA_PODER_TAB.DES_ESCRITURA IS NOT NULL THEN
                                    PENDIUM_ESCRITURA_PODER_TAB.DES_ESCRITURA ELSE ''N/A'' END) DES_ESCRITURA,
              (CASE WHEN PENDIUM_ESCRITURA_PODER_TAB.IND_REQUIERE_PROTO=1 AND PENDIUM_ESCRITURA_PODER_TAB.FEC_OTORGAMIENTO_INSTR IS NOT NULL THEN
                          PENDIUM_ESCRITURA_PODER_TAB.FEC_OTORGAMIENTO_INSTR ELSE PENDIUM_ESCRITURA_PODER_TAB.FEC_FECHA END) as FEC_OTORGAMIENTO_INSTR,
              NVL(PENDIUM_ESCRITURA_PODER_TAB.FEC_FECHA, '''') AS FEC_FECHA,
              (SELECT val_cat_val
               FROM usrdrc.dercorp_add_campo_cat_val_tab
               WHERE id_catalogo = 1
               AND id_catalogo_valor = (SELECT val_valor
                                     FROM usrdrc.dercorp_add_campo_valor_tab
                                     WHERE id_empresa = DERCORP_EMPRESA_TAB.ID_EMPRESA
                                     AND id_add_campo = 500)) AS NOM_EMPRESA,
              PENDIUM_OTORGAPODER_EP_TAB.DES_PODERTIPO,
              PENDIUM_ESCRITURA_PODER_TAB.IND_TIPO_ESCRITURA,
              nvl(PENDIUM_OTORGAPODER_EP_TAB.DES_PODER,'''') as DES_PODER,
              nvl(PENDIUM_OTORGAPODER_EP_TAB.DESC_ACTOSDOMINIO,'''') as DESC_ACTOSDOMINIO,
              nvl(PENDIUM_OTORGAPODER_EP_TAB.DESC_ACTOSADMON,'''') as DESC_ACTOSADMON,
              nvl(PENDIUM_OTORGAPODER_EP_TAB.DESC_PLEITOSCOBRANZA,'''') as DESC_PLEITOSCOBRANZA,
              nvl(PENDIUM_OTORGAPODER_EP_TAB.DESC_TITULOSCREDITO,'''') as DESC_TITULOSCREDITO,
              NVL(PE.DES_PODER,'''') AS DESC_PODER_ESPECIAL,
              PENDIUM_APODERADO_EP_TAB.DESC_NOM_EMPL,
              PENDIUM_APODERADO_EP_TAB.IND_APREVOCA,
              PENDIUM_APODERADO_EP_TAB.DESC_REVOCA,
              PENDIUM_ESCRITURA_PODER_TAB.IND_STATUS,
              DERCORP_EMPRESA_TAB.ID_EMPRESA AS ID_EMPRESA1,
              PENDIUM_APODERADO_EP_TAB.ID_EMPL_FK,
              nvl(PENDIUM_OTORGAPODER_EP_TAB.FEC_VIGENCIAFIN,'''') as FEC_VIGENCIAFIN
            FROM PENDIUM_APODERADO_EP_TAB
            INNER JOIN PENDIUM_OTORGAPODER_EP_TAB
            ON PENDIUM_OTORGAPODER_EP_TAB.ID_OPODER_EP_PK = PENDIUM_APODERADO_EP_TAB.ID_OPODER_EP_FK
            INNER JOIN PENDIUM_ESCRITURA_PODER_TAB
            ON PENDIUM_ESCRITURA_PODER_TAB.ID_EP_PK = PENDIUM_OTORGAPODER_EP_TAB.ID_EP_FK
            INNER JOIN DERCORP_EMPRESA_TAB
            ON DERCORP_EMPRESA_TAB.ID_EMPRESA = PENDIUM_ESCRITURA_PODER_TAB.ID_EMPRESA
            LEFT JOIN PENDIUM_OTORGAPODER_EP_TAB PE
              JOIN PENDIUM_ESCRITURA_PODER_TAB ESC_B ON (ESC_B.ID_EP_PK = PE.ID_EP_FK AND ESC_B.IND_TIPO_ESCRITURA = ''PE'' AND ESC_B.IND_STATUS = 1  AND PE.IND_STATUS = 1)
              ON TRIM(TO_CHAR(PENDIUM_OTORGAPODER_EP_TAB.DES_PODER)) = PE.DES_PODERTIPO AND ESC_B.ID_EMPRESA = PENDIUM_ESCRITURA_PODER_TAB.ID_EMPRESA AND PENDIUM_ESCRITURA_PODER_TAB.DES_ESCRITURA = ESC_B.DES_ESCRITURA
                AND PENDIUM_ESCRITURA_PODER_TAB.IND_DELEGADO_POR = ESC_B.IND_DELEGADO_POR AND NVL(PENDIUM_ESCRITURA_PODER_TAB.FEC_FECHA,'' '') = NVL(ESC_B.FEC_FECHA,'' '') AND NVL(PENDIUM_ESCRITURA_PODER_TAB.NUM_DOCUMENTUM_INSTR,'' '') = NVL(ESC_B.NUM_DOCUMENTUM_INSTR,'' '')
                AND NVL(PENDIUM_ESCRITURA_PODER_TAB.FEC_OTORGAMIENTO_INSTR,'' '') = NVL(ESC_B.FEC_OTORGAMIENTO_INSTR,'' '') AND PENDIUM_ESCRITURA_PODER_TAB.NUM_LICENCIADO = ESC_B.NUM_LICENCIADO AND NVL(PENDIUM_ESCRITURA_PODER_TAB.NUM_INSC_REGPUB,'' '') = NVL(ESC_B.NUM_INSC_REGPUB,'' '')
                AND NVL(PENDIUM_ESCRITURA_PODER_TAB.FEC_REGISTRO,'' '') = NVL(ESC_B.FEC_REGISTRO,'' '')
            WHERE
            PENDIUM_OTORGAPODER_EP_TAB.ID_OPODER_EP_PK NOT IN (SELECT PENDIUM_OTORGAPODER_EP_TAB.ID_OPODER_EP_PK
                  FROM PENDIUM_OTORGAPODER_EP_TAB
                  INNER JOIN PENDIUM_OTORGAPODER_EP_TAB PENDIUM_OTORGAPODER_EP_TAB1
                  ON PENDIUM_OTORGAPODER_EP_TAB.DES_PODERTIPO = TRIM(TO_CHAR(PENDIUM_OTORGAPODER_EP_TAB1.DES_PODER))
                  INNER JOIN PENDIUM_ESCRITURA_PODER_TAB
                  ON PENDIUM_ESCRITURA_PODER_TAB.ID_EP_PK = PENDIUM_OTORGAPODER_EP_TAB.ID_EP_FK
                  INNER JOIN PENDIUM_ESCRITURA_PODER_TAB PENDIUM_ESCRITURA_PODER_TAB1
                  ON PENDIUM_ESCRITURA_PODER_TAB1.ID_EP_PK         = PENDIUM_OTORGAPODER_EP_TAB1.ID_EP_FK
                  AND PENDIUM_ESCRITURA_PODER_TAB1.ID_EMPRESA      = PENDIUM_ESCRITURA_PODER_TAB.ID_EMPRESA
                  WHERE
                    PENDIUM_ESCRITURA_PODER_TAB1.DES_ESCRITURA = PENDIUM_ESCRITURA_PODER_TAB.DES_ESCRITURA
                    AND PENDIUM_ESCRITURA_PODER_TAB.IND_DELEGADO_POR = PENDIUM_ESCRITURA_PODER_TAB1.IND_DELEGADO_POR
                    AND NVL(PENDIUM_ESCRITURA_PODER_TAB.FEC_FECHA,'' '') = NVL(PENDIUM_ESCRITURA_PODER_TAB1.FEC_FECHA,'' '')
                    AND NVL(PENDIUM_ESCRITURA_PODER_TAB.NUM_DOCUMENTUM_INSTR,'' '') = NVL(PENDIUM_ESCRITURA_PODER_TAB1.NUM_DOCUMENTUM_INSTR,'' '')
                    AND NVL(PENDIUM_ESCRITURA_PODER_TAB.FEC_OTORGAMIENTO_INSTR,'' '') = NVL(PENDIUM_ESCRITURA_PODER_TAB1.FEC_OTORGAMIENTO_INSTR,'' '')
                    AND PENDIUM_ESCRITURA_PODER_TAB.NUM_LICENCIADO = PENDIUM_ESCRITURA_PODER_TAB1.NUM_LICENCIADO
                    AND NVL(PENDIUM_ESCRITURA_PODER_TAB.NUM_INSC_REGPUB,'' '') = NVL(PENDIUM_ESCRITURA_PODER_TAB1.NUM_INSC_REGPUB,'' '')
                    AND NVL(PENDIUM_ESCRITURA_PODER_TAB.FEC_REGISTRO,'' '') = NVL(PENDIUM_ESCRITURA_PODER_TAB1.FEC_REGISTRO,'' '')
                    AND PENDIUM_ESCRITURA_PODER_TAB1.IND_STATUS      = 1
                    AND PENDIUM_ESCRITURA_PODER_TAB.IND_STATUS       = 1
                    and PENDIUM_ESCRITURA_PODER_TAB.IND_TIPO_ESCRITURA = ''PE'' and PENDIUM_ESCRITURA_PODER_TAB1.IND_TIPO_ESCRITURA = ''PG'')
            AND PENDIUM_ESCRITURA_PODER_TAB.IND_STATUS = 1
            AND PENDIUM_APODERADO_EP_TAB.IND_TIPOAPODERADO=1
            AND PENDIUM_APODERADO_EP_TAB.IND_STATUS <> 0';
            IF pstdes_escritura IS NOT NULL THEN
              dinamicQuery := dinamicQuery || ' AND ( PENDIUM_ESCRITURA_PODER_TAB.DES_ESCRITURA LIKE '||pstdes_escritura||' )';
            END IF;
            IF pstdes_poder IS NOT NULL THEN
            dinamicQuery := dinamicQuery || ' AND (PENDIUM_OTORGAPODER_EP_TAB.NUM_PODERTIPO       IN ('||pstdes_poder||'))';
            END IF;
            IF pstdes_tipopoder IS NOT NULL THEN
            dinamicQuery := dinamicQuery || ' AND ( PENDIUM_ESCRITURA_PODER_TAB.IND_TIPO_ESCRITURA IN ('||pstdes_tipopoder||'))';
            END IF;
            IF pstdes_empresas IS NOT NULL THEN
            dinamicQuery := dinamicQuery || ' AND ( DERCORP_EMPRESA_TAB.ID_EMPRESA IN ('||pstdes_empresas||'))';
            END IF;
            IF pstdes_apoderados IS NOT NULL THEN
            dinamicQuery := dinamicQuery || ' AND ( PENDIUM_APODERADO_EP_TAB.ID_EMPL_FK IN ('||pstdes_apoderados||'))';
            END IF;
            dinamicQuery := dinamicQuery || ' order by PENDIUM_APODERADO_EP_TAB.DESC_NOM_EMPL,NOM_EMPRESA,PENDIUM_ESCRITURA_PODER_TAB.IND_TIPO_ESCRITURA desc,TO_DATE(FEC_OTORGAMIENTO_INSTR,''DD/MM/YYYY'') DESC,PENDIUM_OTORGAPODER_EP_TAB.ID_OPODER_EP_PK, PENDIUM_OTORGAPODER_EP_TAB.NUM_ORDER ASC';
           OPEN porcRSResultado for dinamicQuery;
          END QUERY_APODERADOS_PG;
  PROCEDURE   QUERY_PODERES_POR_EMPRESA (porcRSResultado OUT SYS_REFCURSOR
                                  ,pstdes_empresas varchar2
                                  ,pstdes_tipopoder varchar2
                                  ,pstdes_apoderados varchar2
                                  ,pstdes_poder varchar2
                                  ,pstdes_escritura varchar2)
  AS
          dinamicQuery CLOB;
          BEGIN
          dinamicQuery := 'SELECT PENDIUM_OTORGAPODER_EP_TAB.ID_OPODER_EP_PK,
              PENDIUM_ESCRITURA_PODER_TAB.ID_EP_PK,
              (CASE WHEN PENDIUM_ESCRITURA_PODER_TAB.IND_REQUIERE_PROTO=1 AND PENDIUM_ESCRITURA_PODER_TAB.DES_ESCRITURA IS NOT NULL THEN
                                    PENDIUM_ESCRITURA_PODER_TAB.DES_ESCRITURA ELSE ''N/A'' END) DES_ESCRITURA,
              (CASE WHEN PENDIUM_ESCRITURA_PODER_TAB.IND_REQUIERE_PROTO=1 AND PENDIUM_ESCRITURA_PODER_TAB.FEC_OTORGAMIENTO_INSTR IS NOT NULL THEN
                          PENDIUM_ESCRITURA_PODER_TAB.FEC_OTORGAMIENTO_INSTR ELSE PENDIUM_ESCRITURA_PODER_TAB.FEC_FECHA END) as FEC_OTORGAMIENTO_INSTR,
              NVL(PENDIUM_ESCRITURA_PODER_TAB.FEC_FECHA, '''') AS FEC_FECHA,
             (SELECT val_cat_val
               FROM usrdrc.dercorp_add_campo_cat_val_tab
               WHERE id_catalogo = 1
               AND id_catalogo_valor = (SELECT val_valor
                                     FROM usrdrc.dercorp_add_campo_valor_tab
                                     WHERE id_empresa = DERCORP_EMPRESA_TAB.ID_EMPRESA
                                     AND id_add_campo = 500)) AS NOM_EMPRESA,
              PENDIUM_OTORGAPODER_EP_TAB.DES_PODERTIPO,
              PENDIUM_ESCRITURA_PODER_TAB.IND_TIPO_ESCRITURA,
              NVL(PENDIUM_OTORGAPODER_EP_TAB.DES_PODER, '''')            AS DES_PODER,
              NVL(PENDIUM_OTORGAPODER_EP_TAB.DESC_ACTOSDOMINIO, '''')    AS DESC_ACTOSDOMINIO,
              NVL(PENDIUM_OTORGAPODER_EP_TAB.DESC_ACTOSADMON, '''')      AS DESC_ACTOSADMON,
              NVL(PENDIUM_OTORGAPODER_EP_TAB.DESC_PLEITOSCOBRANZA, '''') AS DESC_PLEITOSCOBRANZA,
              NVL(PENDIUM_OTORGAPODER_EP_TAB.DESC_TITULOSCREDITO, '''')  AS DESC_TITULOSCREDITO,
              NVL(PE.DES_PODER,'''') AS DESC_PODER_ESPECIAL,
              PENDIUM_ESCRITURA_PODER_TAB.IND_STATUS,
              PENDIUM_OTORGAPODER_EP_TAB.DESC_APODERADOS,
              PENDIUM_OTORGAPODER_EP_TAB.DESC_DESCRIPCION,
              nvl(PENDIUM_OTORGAPODER_EP_TAB.FEC_VIGENCIAFIN,'''') as FEC_VIGENCIAFIN
            FROM PENDIUM_OTORGAPODER_EP_TAB
              INNER JOIN PENDIUM_ESCRITURA_PODER_TAB
              ON PENDIUM_ESCRITURA_PODER_TAB.ID_EP_PK = PENDIUM_OTORGAPODER_EP_TAB.ID_EP_FK
              INNER JOIN DERCORP_EMPRESA_TAB
              ON DERCORP_EMPRESA_TAB.ID_EMPRESA = PENDIUM_ESCRITURA_PODER_TAB.ID_EMPRESA
               LEFT JOIN PENDIUM_OTORGAPODER_EP_TAB PE
              JOIN PENDIUM_ESCRITURA_PODER_TAB ESC_B ON (ESC_B.ID_EP_PK = PE.ID_EP_FK AND ESC_B.IND_TIPO_ESCRITURA = ''PE'' AND ESC_B.IND_STATUS = 1  AND PE.IND_STATUS = 1)
              ON TRIM(TO_CHAR(PENDIUM_OTORGAPODER_EP_TAB.DES_PODER)) = PE.DES_PODERTIPO AND ESC_B.ID_EMPRESA = PENDIUM_ESCRITURA_PODER_TAB.ID_EMPRESA AND PENDIUM_ESCRITURA_PODER_TAB.DES_ESCRITURA = ESC_B.DES_ESCRITURA
                AND PENDIUM_ESCRITURA_PODER_TAB.IND_DELEGADO_POR = ESC_B.IND_DELEGADO_POR AND NVL(PENDIUM_ESCRITURA_PODER_TAB.FEC_FECHA,'' '') = NVL(ESC_B.FEC_FECHA,'' '') AND NVL(PENDIUM_ESCRITURA_PODER_TAB.NUM_DOCUMENTUM_INSTR,'' '') = NVL(ESC_B.NUM_DOCUMENTUM_INSTR,'' '')
                AND NVL(PENDIUM_ESCRITURA_PODER_TAB.FEC_OTORGAMIENTO_INSTR,'' '') = NVL(ESC_B.FEC_OTORGAMIENTO_INSTR,'' '') AND PENDIUM_ESCRITURA_PODER_TAB.NUM_LICENCIADO = ESC_B.NUM_LICENCIADO AND NVL(PENDIUM_ESCRITURA_PODER_TAB.NUM_INSC_REGPUB,'' '') = NVL(ESC_B.NUM_INSC_REGPUB,'' '')
                AND NVL(PENDIUM_ESCRITURA_PODER_TAB.FEC_REGISTRO,'' '') = NVL(ESC_B.FEC_REGISTRO,'' '')
            WHERE
                PENDIUM_OTORGAPODER_EP_TAB.ID_OPODER_EP_PK NOT IN (SELECT PENDIUM_OTORGAPODER_EP_TAB.ID_OPODER_EP_PK
                  FROM PENDIUM_OTORGAPODER_EP_TAB
                  INNER JOIN PENDIUM_OTORGAPODER_EP_TAB PENDIUM_OTORGAPODER_EP_TAB1
                  ON PENDIUM_OTORGAPODER_EP_TAB.DES_PODERTIPO = TRIM(TO_CHAR(PENDIUM_OTORGAPODER_EP_TAB1.DES_PODER))
                  INNER JOIN PENDIUM_ESCRITURA_PODER_TAB
                  ON PENDIUM_ESCRITURA_PODER_TAB.ID_EP_PK = PENDIUM_OTORGAPODER_EP_TAB.ID_EP_FK
                  INNER JOIN PENDIUM_ESCRITURA_PODER_TAB PENDIUM_ESCRITURA_PODER_TAB1
                  ON PENDIUM_ESCRITURA_PODER_TAB1.ID_EP_PK         = PENDIUM_OTORGAPODER_EP_TAB1.ID_EP_FK
                  AND PENDIUM_ESCRITURA_PODER_TAB1.ID_EMPRESA      = PENDIUM_ESCRITURA_PODER_TAB.ID_EMPRESA
                  WHERE
                    PENDIUM_ESCRITURA_PODER_TAB1.DES_ESCRITURA = PENDIUM_ESCRITURA_PODER_TAB.DES_ESCRITURA
                    AND PENDIUM_ESCRITURA_PODER_TAB.IND_DELEGADO_POR = PENDIUM_ESCRITURA_PODER_TAB1.IND_DELEGADO_POR
                    AND NVL(PENDIUM_ESCRITURA_PODER_TAB.FEC_FECHA,'' '') = NVL(PENDIUM_ESCRITURA_PODER_TAB1.FEC_FECHA,'' '')
                    AND NVL(PENDIUM_ESCRITURA_PODER_TAB.NUM_DOCUMENTUM_INSTR,'' '') = NVL(PENDIUM_ESCRITURA_PODER_TAB1.NUM_DOCUMENTUM_INSTR,'' '')
                    AND NVL(PENDIUM_ESCRITURA_PODER_TAB.FEC_OTORGAMIENTO_INSTR,'' '') = NVL(PENDIUM_ESCRITURA_PODER_TAB1.FEC_OTORGAMIENTO_INSTR,'' '')
                    AND PENDIUM_ESCRITURA_PODER_TAB.NUM_LICENCIADO = PENDIUM_ESCRITURA_PODER_TAB1.NUM_LICENCIADO
                    AND NVL(PENDIUM_ESCRITURA_PODER_TAB.NUM_INSC_REGPUB,'' '') = NVL(PENDIUM_ESCRITURA_PODER_TAB1.NUM_INSC_REGPUB,'' '')
                    AND NVL(PENDIUM_ESCRITURA_PODER_TAB.FEC_REGISTRO,'' '') = NVL(PENDIUM_ESCRITURA_PODER_TAB1.FEC_REGISTRO,'' '')
                    AND PENDIUM_ESCRITURA_PODER_TAB1.IND_STATUS      = 1
                    AND PENDIUM_ESCRITURA_PODER_TAB.IND_STATUS       = 1
                    AND PENDIUM_ESCRITURA_PODER_TAB.IND_TIPO_ESCRITURA = ''PE'' and PENDIUM_ESCRITURA_PODER_TAB1.IND_TIPO_ESCRITURA = ''PG'')
                AND PENDIUM_ESCRITURA_PODER_TAB.IND_STATUS = 1 ';
            IF pstdes_escritura IS NOT NULL THEN
              dinamicQuery := dinamicQuery || ' AND ( PENDIUM_ESCRITURA_PODER_TAB.DES_ESCRITURA LIKE '||pstdes_escritura||' )';
            END IF;
            IF pstdes_poder IS NOT NULL THEN
            dinamicQuery := dinamicQuery || ' AND (PENDIUM_OTORGAPODER_EP_TAB.NUM_PODERTIPO       IN ('||pstdes_poder||'))';
            END IF;
            IF pstdes_tipopoder IS NOT NULL THEN
            dinamicQuery := dinamicQuery || ' AND ( PENDIUM_ESCRITURA_PODER_TAB.IND_TIPO_ESCRITURA IN ('||pstdes_tipopoder||'))';
            END IF;
            IF pstdes_empresas IS NOT NULL THEN
            dinamicQuery := dinamicQuery || ' AND ( DERCORP_EMPRESA_TAB.ID_EMPRESA IN ('||pstdes_empresas||'))';
            END IF;
            IF pstdes_apoderados IS NOT NULL THEN
            dinamicQuery := dinamicQuery || ' AND ( '||pstdes_apoderados||')';
            END IF;
            dinamicQuery := dinamicQuery || ' ORDER BY NOM_EMPRESA ASC,PENDIUM_ESCRITURA_PODER_TAB.IND_TIPO_ESCRITURA DESC, CASE WHEN PENDIUM_ESCRITURA_PODER_TAB.FEC_OTORGAMIENTO_INSTR IS NULL THEN TO_DATE(''31/12/2999'',''DD/MM/YYYY'') ELSE TO_DATE(FEC_OTORGAMIENTO_INSTR,''DD/MM/YYYY'') END DESC
              , CASE WHEN PENDIUM_ESCRITURA_PODER_TAB.DES_ESCRITURA IS NULL OR PENDIUM_ESCRITURA_PODER_TAB.DES_ESCRITURA=''N/A'' THEN 99999999 ELSE TO_NUMBER(REPLACE(PENDIUM_ESCRITURA_PODER_TAB.DES_ESCRITURA,'','','''')) END DESC, PENDIUM_OTORGAPODER_EP_TAB.ID_OPODER_EP_PK, PENDIUM_OTORGAPODER_EP_TAB.NUM_ORDER ASC';
             OPEN porcRSResultado FOR dinamicQuery;
          END QUERY_PODERES_POR_EMPRESA;
PROCEDURE   QUERY_PODERES_POR_ESCRITURA_PG (porcRSResultado OUT SYS_REFCURSOR
                                  ,pstdes_empresas varchar2
                                  ,pstdes_tipopoder varchar2
                                  ,pstdes_apoderados varchar2
                                  ,pstdes_poder varchar2
                                  ,pstdes_escritura varchar2)
  AS
          dinamicQuery CLOB;
          BEGIN
          dinamicQuery := 'SELECT PENDIUM_OTORGAPODER_EP_TAB.ID_OPODER_EP_PK,
              PENDIUM_ESCRITURA_PODER_TAB.ID_EP_PK,
              (CASE WHEN PENDIUM_ESCRITURA_PODER_TAB.IND_REQUIERE_PROTO=1 AND PENDIUM_ESCRITURA_PODER_TAB.DES_ESCRITURA IS NOT NULL THEN
                                    PENDIUM_ESCRITURA_PODER_TAB.DES_ESCRITURA ELSE ''N/A'' END) DES_ESCRITURA,
              (CASE WHEN PENDIUM_ESCRITURA_PODER_TAB.IND_REQUIERE_PROTO=1 AND PENDIUM_ESCRITURA_PODER_TAB.FEC_OTORGAMIENTO_INSTR IS NOT NULL THEN
                          PENDIUM_ESCRITURA_PODER_TAB.FEC_OTORGAMIENTO_INSTR ELSE PENDIUM_ESCRITURA_PODER_TAB.FEC_FECHA END) as FEC_OTORGAMIENTO_INSTR,
              NVL(PENDIUM_ESCRITURA_PODER_TAB.FEC_FECHA, '''') AS FEC_FECHA,
              (SELECT val_cat_val
               FROM usrdrc.dercorp_add_campo_cat_val_tab
               WHERE id_catalogo = 1
               AND id_catalogo_valor = (SELECT val_valor
                                     FROM usrdrc.dercorp_add_campo_valor_tab
                                     WHERE id_empresa = DERCORP_EMPRESA_TAB.ID_EMPRESA
                                     AND id_add_campo = 500)) AS NOM_EMPRESA,
              DEL.NOM_CAT_VAL AS DELEGADOPOR,
              PENDIUM_ESCRITURA_PODER_TAB.FEC_FECHA,
              PENDIUM_ESCRITURA_PODER_TAB.FEC_HORA,
              PENDIUM_ESCRITURA_PODER_TAB.ID_EMPRESA,
              (SELECT COUNT(DISTINCT ESC.IND_TIPO_ESCRITURA) FROM PENDIUM_ESCRITURA_PODER_TAB ESC INNER JOIN PENDIUM_OTORGAPODER_EP_TAB POD
                ON ESC.ID_EP_PK = POD.ID_EP_FK
                WHERE ESC.DES_ESCRITURA = PENDIUM_ESCRITURA_PODER_TAB.DES_ESCRITURA
                AND ESC.ID_EMPRESA=PENDIUM_ESCRITURA_PODER_TAB.ID_EMPRESA GROUP BY ESC.ID_EMPRESA)AS NUM_TIPO_ESC_DIFERENTES,
              PENDIUM_ESCRITURA_PODER_TAB.NUM_DOCUMENTUM_INSTR,
              PENDIUM_OTORGAPODER_EP_TAB.DES_PODERTIPO,
              PENDIUM_ESCRITURA_PODER_TAB.IND_TIPO_ESCRITURA,
              NVL(PENDIUM_OTORGAPODER_EP_TAB.DES_PODER, '''')            AS DES_PODER,
              NVL(PENDIUM_OTORGAPODER_EP_TAB.DESC_ACTOSDOMINIO, '''')    AS DESC_ACTOSDOMINIO,
              NVL(PENDIUM_OTORGAPODER_EP_TAB.DESC_ACTOSADMON, '''')      AS DESC_ACTOSADMON,
              NVL(PENDIUM_OTORGAPODER_EP_TAB.DESC_PLEITOSCOBRANZA, '''') AS DESC_PLEITOSCOBRANZA,
              NVL(PENDIUM_OTORGAPODER_EP_TAB.DESC_TITULOSCREDITO, '''')  AS DESC_TITULOSCREDITO,
              NVL(PE.DES_PODER,'''') AS DESC_PODER_ESPECIAL,
              PENDIUM_ESCRITURA_PODER_TAB.IND_STATUS,
              PENDIUM_OTORGAPODER_EP_TAB.DESC_APODERADOS,
              PENDIUM_OTORGAPODER_EP_TAB.DESC_DESCRIPCION,
              nvl(PENDIUM_OTORGAPODER_EP_TAB.FEC_VIGENCIAFIN,'''') as FEC_VIGENCIAFIN,
              PENDIUM_OTORGAPODER_EP_TAB.NUM_ORDER,
              PENDIUM_ESCRITURA_PODER_TAB.DES_SUPLENCIA_ASOCIADO ,
              PENDIUM_ESCRITURA_PODER_TAB.DES_INSC_REGPUB ,
              PENDIUM_ESCRITURA_PODER_TAB.FEC_REGISTRO ,
              PENDIUM_ESCRITURA_PODER_TAB.NUM_FOLIO_MERC ,
              PENDIUM_ESCRITURA_PODER_TAB.DES_OTROS_DATOS_REGISTRO ,
              PENDIUM_ESCRITURA_PODER_TAB.ID_SOL_DOC ,
              PENDIUM_ESCRITURA_PODER_TAB.DES_SOL_RESP ,
              PENDIUM_ESCRITURA_PODER_TAB.FEC_SOL ,
              PENDIUM_ESCRITURA_PODER_TAB.FEC_SOL_REC ,
              PENDIUM_ESCRITURA_PODER_TAB.DES_SOL_FOLIO ,
              PENDIUM_ESCRITURA_PODER_TAB.ID_ENT_DOC ,
              PENDIUM_ESCRITURA_PODER_TAB.FEC_ENT_DOC ,
              PENDIUM_ESCRITURA_PODER_TAB.FEC_ENT_REC,
              (SELECT NOM_CAT_VAL
              FROM DERCORP_ADD_CAMPO_CAT_VAL_TAB
              WHERE ID_CATALOGO = 12 AND ID_CATALOGO_VALOR = PENDIUM_ESCRITURA_PODER_TAB.NUM_LICENCIADO)
                AS NOM_LICENCIADO,
              (SELECT ATRIBUTO1
              FROM DERCORP_ADD_CAMPO_CAT_VAL_TAB
              WHERE ID_CATALOGO = 12 AND ID_CATALOGO_VALOR = PENDIUM_ESCRITURA_PODER_TAB.NUM_LICENCIADO)
                AS NUM_NOTARIO,
             (SELECT ATRIBUTO2
              FROM DERCORP_ADD_CAMPO_CAT_VAL_TAB
              WHERE ID_CATALOGO = 12 AND ID_CATALOGO_VALOR = PENDIUM_ESCRITURA_PODER_TAB.NUM_LICENCIADO)
                AS DE_NOTARIO,
              PENDIUM_ESCRITURA_PODER_TAB.ID_EP_PK,
              PENDIUM_ESCRITURA_PODER_TAB.IND_REQUIERE_PROTO,
              PENDIUM_ESCRITURA_PODER_TAB.IND_REQUIERE_INSCR_RPPC
            FROM PENDIUM_OTORGAPODER_EP_TAB
              INNER JOIN PENDIUM_ESCRITURA_PODER_TAB
                ON PENDIUM_ESCRITURA_PODER_TAB.ID_EP_PK = PENDIUM_OTORGAPODER_EP_TAB.ID_EP_FK
              INNER JOIN DERCORP_EMPRESA_TAB
                ON DERCORP_EMPRESA_TAB.ID_EMPRESA = PENDIUM_ESCRITURA_PODER_TAB.ID_EMPRESA
              LEFT JOIN DERCORP_ADD_CAMPO_CAT_VAL_TAB DEL
                ON DEL.ID_CATALOGO_VALOR = PENDIUM_ESCRITURA_PODER_TAB.IND_DELEGADO_POR
               LEFT JOIN PENDIUM_OTORGAPODER_EP_TAB PE
              JOIN PENDIUM_ESCRITURA_PODER_TAB ESC_B ON (ESC_B.ID_EP_PK = PE.ID_EP_FK AND ESC_B.IND_TIPO_ESCRITURA = ''PE'' AND ESC_B.IND_STATUS = 1  AND PE.IND_STATUS = 1)
              ON TRIM(TO_CHAR(PENDIUM_OTORGAPODER_EP_TAB.DES_PODER)) = PE.DES_PODERTIPO AND ESC_B.ID_EMPRESA = PENDIUM_ESCRITURA_PODER_TAB.ID_EMPRESA AND PENDIUM_ESCRITURA_PODER_TAB.DES_ESCRITURA = ESC_B.DES_ESCRITURA
                AND PENDIUM_ESCRITURA_PODER_TAB.IND_DELEGADO_POR = ESC_B.IND_DELEGADO_POR AND NVL(PENDIUM_ESCRITURA_PODER_TAB.FEC_FECHA,'' '') = NVL(ESC_B.FEC_FECHA,'' '') AND NVL(PENDIUM_ESCRITURA_PODER_TAB.NUM_DOCUMENTUM_INSTR,'' '') = NVL(ESC_B.NUM_DOCUMENTUM_INSTR,'' '')
                AND NVL(PENDIUM_ESCRITURA_PODER_TAB.FEC_OTORGAMIENTO_INSTR,'' '') = NVL(ESC_B.FEC_OTORGAMIENTO_INSTR,'' '') AND PENDIUM_ESCRITURA_PODER_TAB.NUM_LICENCIADO = ESC_B.NUM_LICENCIADO AND NVL(PENDIUM_ESCRITURA_PODER_TAB.NUM_INSC_REGPUB,'' '') = NVL(ESC_B.NUM_INSC_REGPUB,'' '')
                AND NVL(PENDIUM_ESCRITURA_PODER_TAB.FEC_REGISTRO,'' '') = NVL(ESC_B.FEC_REGISTRO,'' '')
            WHERE
                PENDIUM_OTORGAPODER_EP_TAB.ID_OPODER_EP_PK NOT IN (SELECT PENDIUM_OTORGAPODER_EP_TAB.ID_OPODER_EP_PK
                  FROM PENDIUM_OTORGAPODER_EP_TAB
                  INNER JOIN PENDIUM_OTORGAPODER_EP_TAB PENDIUM_OTORGAPODER_EP_TAB1
                  ON PENDIUM_OTORGAPODER_EP_TAB.DES_PODERTIPO = TRIM(TO_CHAR(PENDIUM_OTORGAPODER_EP_TAB1.DES_PODER))
                  INNER JOIN PENDIUM_ESCRITURA_PODER_TAB
                  ON PENDIUM_ESCRITURA_PODER_TAB.ID_EP_PK = PENDIUM_OTORGAPODER_EP_TAB.ID_EP_FK
                  INNER JOIN PENDIUM_ESCRITURA_PODER_TAB PENDIUM_ESCRITURA_PODER_TAB1
                  ON PENDIUM_ESCRITURA_PODER_TAB1.ID_EP_PK         = PENDIUM_OTORGAPODER_EP_TAB1.ID_EP_FK
                  AND PENDIUM_ESCRITURA_PODER_TAB1.ID_EMPRESA      = PENDIUM_ESCRITURA_PODER_TAB.ID_EMPRESA
                  WHERE
                    PENDIUM_ESCRITURA_PODER_TAB1.DES_ESCRITURA = PENDIUM_ESCRITURA_PODER_TAB.DES_ESCRITURA
                    AND PENDIUM_ESCRITURA_PODER_TAB.IND_DELEGADO_POR = PENDIUM_ESCRITURA_PODER_TAB1.IND_DELEGADO_POR
                    AND NVL(PENDIUM_ESCRITURA_PODER_TAB.FEC_FECHA,'' '') = NVL(PENDIUM_ESCRITURA_PODER_TAB1.FEC_FECHA,'' '')
                    AND NVL(PENDIUM_ESCRITURA_PODER_TAB.NUM_DOCUMENTUM_INSTR,'' '') = NVL(PENDIUM_ESCRITURA_PODER_TAB1.NUM_DOCUMENTUM_INSTR,'' '')
                    AND NVL(PENDIUM_ESCRITURA_PODER_TAB.FEC_OTORGAMIENTO_INSTR,'' '') = NVL(PENDIUM_ESCRITURA_PODER_TAB1.FEC_OTORGAMIENTO_INSTR,'' '')
                    AND PENDIUM_ESCRITURA_PODER_TAB.NUM_LICENCIADO = PENDIUM_ESCRITURA_PODER_TAB1.NUM_LICENCIADO
                    AND NVL(PENDIUM_ESCRITURA_PODER_TAB.NUM_INSC_REGPUB,'' '') = NVL(PENDIUM_ESCRITURA_PODER_TAB1.NUM_INSC_REGPUB,'' '')
                    AND NVL(PENDIUM_ESCRITURA_PODER_TAB.FEC_REGISTRO,'' '') = NVL(PENDIUM_ESCRITURA_PODER_TAB1.FEC_REGISTRO,'' '')
                    AND PENDIUM_ESCRITURA_PODER_TAB1.IND_STATUS      = 1
                    AND PENDIUM_ESCRITURA_PODER_TAB.IND_STATUS       = 1
                    and PENDIUM_ESCRITURA_PODER_TAB.IND_TIPO_ESCRITURA = ''PE'' and PENDIUM_ESCRITURA_PODER_TAB1.IND_TIPO_ESCRITURA = ''PG'')
              AND PENDIUM_ESCRITURA_PODER_TAB.IND_STATUS = 1 ';
            IF pstdes_escritura IS NOT NULL THEN
              dinamicQuery := dinamicQuery || ' AND ( PENDIUM_ESCRITURA_PODER_TAB.DES_ESCRITURA = '||pstdes_escritura||' )';
            END IF;
            IF pstdes_poder IS NOT NULL THEN
            dinamicQuery := dinamicQuery || ' AND (PENDIUM_OTORGAPODER_EP_TAB.NUM_PODERTIPO       IN ('||pstdes_poder||'))';
            END IF;
            IF pstdes_tipopoder IS NOT NULL THEN
            dinamicQuery := dinamicQuery || ' AND ( PENDIUM_ESCRITURA_PODER_TAB.IND_TIPO_ESCRITURA IN ('||pstdes_tipopoder||'))';
            END IF;
            IF pstdes_empresas IS NOT NULL THEN
            dinamicQuery := dinamicQuery || ' AND ( DERCORP_EMPRESA_TAB.ID_EMPRESA IN ('||pstdes_empresas||'))';
            END IF;
            IF pstdes_apoderados IS NOT NULL THEN
            dinamicQuery := dinamicQuery || ' AND ( '||pstdes_apoderados||')';
            END IF;
            dinamicQuery := dinamicQuery || ' ORDER BY NOM_EMPRESA ASC,PENDIUM_ESCRITURA_PODER_TAB.IND_TIPO_ESCRITURA DESC, PENDIUM_OTORGAPODER_EP_TAB.NUM_ORDER';
            OPEN porcRSResultado FOR dinamicQuery;
          END QUERY_PODERES_POR_ESCRITURA_PG;
PROCEDURE QUERY_PODERES_POR_ASUNTO (porcRSResultado OUT SYS_REFCURSOR
                                  ,pstdes_empresas varchar2
                                  ,pstdes_tipopoder varchar2
                                  ,pstdes_apoderados varchar2
                                  ,pstdes_grupoapoderados varchar2
                                  ,pstdes_poder varchar2
                                  ,pstdes_escritura varchar2)
          AS
          dinamicQuery CLOB;
          BEGIN
          dinamicQuery := 'SELECT PENDIUM_OTORGAPODER_EP_TAB.ID_OPODER_EP_PK,
              nvl(PENDIUM_ESCRITURA_PODER_TAB.DES_ESCRITURA, '''') as DES_ESCRITURA,
              PENDIUM_ESCRITURA_PODER_TAB.IND_REQUIERE_PROTO,
              (CASE WHEN PENDIUM_ESCRITURA_PODER_TAB.IND_REQUIERE_PROTO=1 AND PENDIUM_ESCRITURA_PODER_TAB.FEC_OTORGAMIENTO_INSTR IS NOT NULL THEN
                          PENDIUM_ESCRITURA_PODER_TAB.FEC_OTORGAMIENTO_INSTR ELSE PENDIUM_ESCRITURA_PODER_TAB.FEC_FECHA END) as FEC_OTORGAMIENTO_INSTR,
              NVL(PENDIUM_ESCRITURA_PODER_TAB.FEC_FECHA, '''') AS FEC_FECHA,
              (SELECT val_cat_val
               FROM usrdrc.dercorp_add_campo_cat_val_tab
               WHERE id_catalogo = 1
               AND id_catalogo_valor = (SELECT val_valor
                                     FROM usrdrc.dercorp_add_campo_valor_tab
                                     WHERE id_empresa = DERCORP_EMPRESA_TAB.ID_EMPRESA
                                     AND id_add_campo = 500)) AS NOM_EMPRESA,
              PENDIUM_OTORGAPODER_EP_TAB.DES_PODERTIPO,
              PENDIUM_ESCRITURA_PODER_TAB.IND_TIPO_ESCRITURA,
              nvl(PENDIUM_OTORGAPODER_EP_TAB.DES_PODER,'''') as DES_PODER,
              PENDIUM_OTORGAPODER_EP_TAB.DESC_APODERADOS,
              nvl(PENDIUM_OTORGAPODER_EP_TAB.DESC_ACTOSDOMINIO,'''') as DESC_ACTOSDOMINIO,
              nvl(PENDIUM_OTORGAPODER_EP_TAB.DESC_ACTOSADMON,'''') as DESC_ACTOSADMON,
              nvl(PENDIUM_OTORGAPODER_EP_TAB.DESC_PLEITOSCOBRANZA,'''') as DESC_PLEITOSCOBRANZA,
              nvl(PENDIUM_OTORGAPODER_EP_TAB.DESC_TITULOSCREDITO,'''') as DESC_TITULOSCREDITO,
              NVL(PE.DES_PODER,'''') AS DESC_PODER_ESPECIAL,
              PENDIUM_APODERADO_EP_TAB.DESC_NOM_EMPL,
              DERCORP_ADD_CAMPO_CAT_VAL_TAB.VAL_CAT_VAL AS NOM_GRUPO,
              PENDIUM_APODERADO_EP_TAB.IND_APREVOCA,
              PENDIUM_APODERADO_EP_TAB.DESC_REVOCA,
              nvl(PENDIUM_OTORGAPODER_EP_TAB.FEC_VIGENCIAFIN,'''') as FEC_VIGENCIAFIN
            FROM PENDIUM_APODERADO_EP_TAB
            INNER JOIN PENDIUM_OTORGAPODER_EP_TAB
            ON PENDIUM_OTORGAPODER_EP_TAB.ID_OPODER_EP_PK = PENDIUM_APODERADO_EP_TAB.ID_OPODER_EP_FK
            INNER JOIN PENDIUM_ESCRITURA_PODER_TAB
            ON PENDIUM_ESCRITURA_PODER_TAB.ID_EP_PK = PENDIUM_OTORGAPODER_EP_TAB.ID_EP_FK
            INNER JOIN DERCORP_ADD_CAMPO_CAT_VAL_TAB
            ON DERCORP_ADD_CAMPO_CAT_VAL_TAB.ID_CATALOGO_VALOR = PENDIUM_APODERADO_EP_TAB.ID_GRUPO_FK
            INNER JOIN DERCORP_EMPRESA_TAB
            ON DERCORP_EMPRESA_TAB.ID_EMPRESA = PENDIUM_ESCRITURA_PODER_TAB.ID_EMPRESA
            LEFT JOIN PENDIUM_OTORGAPODER_EP_TAB PE
              JOIN PENDIUM_ESCRITURA_PODER_TAB ESC_B ON (ESC_B.ID_EP_PK = PE.ID_EP_FK AND ESC_B.IND_TIPO_ESCRITURA = ''PE'' AND ESC_B.IND_STATUS = 1  AND PE.IND_STATUS = 1)
              ON TRIM(TO_CHAR(PENDIUM_OTORGAPODER_EP_TAB.DES_PODER)) = PE.DES_PODERTIPO AND ESC_B.ID_EMPRESA = PENDIUM_ESCRITURA_PODER_TAB.ID_EMPRESA AND PENDIUM_ESCRITURA_PODER_TAB.DES_ESCRITURA = ESC_B.DES_ESCRITURA
                AND PENDIUM_ESCRITURA_PODER_TAB.IND_DELEGADO_POR = ESC_B.IND_DELEGADO_POR AND NVL(PENDIUM_ESCRITURA_PODER_TAB.FEC_FECHA,'' '') = NVL(ESC_B.FEC_FECHA,'' '') AND NVL(PENDIUM_ESCRITURA_PODER_TAB.NUM_DOCUMENTUM_INSTR,'' '') = NVL(ESC_B.NUM_DOCUMENTUM_INSTR,'' '')
                AND NVL(PENDIUM_ESCRITURA_PODER_TAB.FEC_OTORGAMIENTO_INSTR,'' '') = NVL(ESC_B.FEC_OTORGAMIENTO_INSTR,'' '') AND PENDIUM_ESCRITURA_PODER_TAB.NUM_LICENCIADO = ESC_B.NUM_LICENCIADO AND NVL(PENDIUM_ESCRITURA_PODER_TAB.NUM_INSC_REGPUB,'' '') = NVL(ESC_B.NUM_INSC_REGPUB,'' '')
                AND NVL(PENDIUM_ESCRITURA_PODER_TAB.FEC_REGISTRO,'' '') = NVL(ESC_B.FEC_REGISTRO,'' '')
            WHERE
              PENDIUM_OTORGAPODER_EP_TAB.ID_OPODER_EP_PK NOT IN (SELECT PENDIUM_OTORGAPODER_EP_TAB.ID_OPODER_EP_PK
                  FROM PENDIUM_OTORGAPODER_EP_TAB
                  INNER JOIN PENDIUM_OTORGAPODER_EP_TAB PENDIUM_OTORGAPODER_EP_TAB1
                  ON PENDIUM_OTORGAPODER_EP_TAB.DES_PODERTIPO = TRIM(TO_CHAR(PENDIUM_OTORGAPODER_EP_TAB1.DES_PODER))
                  INNER JOIN PENDIUM_ESCRITURA_PODER_TAB
                  ON PENDIUM_ESCRITURA_PODER_TAB.ID_EP_PK = PENDIUM_OTORGAPODER_EP_TAB.ID_EP_FK
                  INNER JOIN PENDIUM_ESCRITURA_PODER_TAB PENDIUM_ESCRITURA_PODER_TAB1
                  ON PENDIUM_ESCRITURA_PODER_TAB1.ID_EP_PK         = PENDIUM_OTORGAPODER_EP_TAB1.ID_EP_FK
                  AND PENDIUM_ESCRITURA_PODER_TAB1.ID_EMPRESA      = PENDIUM_ESCRITURA_PODER_TAB.ID_EMPRESA
                  WHERE
                    PENDIUM_ESCRITURA_PODER_TAB1.DES_ESCRITURA = PENDIUM_ESCRITURA_PODER_TAB.DES_ESCRITURA
                     AND PENDIUM_ESCRITURA_PODER_TAB.IND_DELEGADO_POR = PENDIUM_ESCRITURA_PODER_TAB1.IND_DELEGADO_POR
                    AND NVL(PENDIUM_ESCRITURA_PODER_TAB.FEC_FECHA,'' '') = NVL(PENDIUM_ESCRITURA_PODER_TAB1.FEC_FECHA,'' '')
                    AND NVL(PENDIUM_ESCRITURA_PODER_TAB.NUM_DOCUMENTUM_INSTR,'' '') = NVL(PENDIUM_ESCRITURA_PODER_TAB1.NUM_DOCUMENTUM_INSTR,'' '')
                    AND NVL(PENDIUM_ESCRITURA_PODER_TAB.FEC_OTORGAMIENTO_INSTR,'' '') = NVL(PENDIUM_ESCRITURA_PODER_TAB1.FEC_OTORGAMIENTO_INSTR,'' '')
                    AND PENDIUM_ESCRITURA_PODER_TAB.NUM_LICENCIADO = PENDIUM_ESCRITURA_PODER_TAB1.NUM_LICENCIADO
                    AND NVL(PENDIUM_ESCRITURA_PODER_TAB.NUM_INSC_REGPUB,'' '') = NVL(PENDIUM_ESCRITURA_PODER_TAB1.NUM_INSC_REGPUB,'' '')
                    AND NVL(PENDIUM_ESCRITURA_PODER_TAB.FEC_REGISTRO,'' '') = NVL(PENDIUM_ESCRITURA_PODER_TAB1.FEC_REGISTRO,'' '')
                    AND PENDIUM_ESCRITURA_PODER_TAB1.IND_STATUS      = 1
                    AND PENDIUM_ESCRITURA_PODER_TAB.IND_STATUS       = 1
                    and PENDIUM_ESCRITURA_PODER_TAB.IND_TIPO_ESCRITURA = ''PE'' and PENDIUM_ESCRITURA_PODER_TAB1.IND_TIPO_ESCRITURA = ''PG'')
              AND PENDIUM_ESCRITURA_PODER_TAB.IND_STATUS = 1 ';
            IF pstdes_escritura IS NOT NULL THEN
              dinamicQuery := dinamicQuery || ' AND ( PENDIUM_ESCRITURA_PODER_TAB.DES_ESCRITURA LIKE '||pstdes_escritura||' )';
            END IF;
            IF pstdes_poder IS NOT NULL THEN
            dinamicQuery := dinamicQuery || ' AND (PENDIUM_OTORGAPODER_EP_TAB.NUM_PODERTIPO IN ('||pstdes_poder||'))';
            END IF;
            IF pstdes_tipopoder IS NOT NULL THEN
            dinamicQuery := dinamicQuery || ' AND ( PENDIUM_ESCRITURA_PODER_TAB.IND_TIPO_ESCRITURA IN ('||pstdes_tipopoder||'))';
            END IF;
            IF pstdes_empresas IS NOT NULL THEN
            dinamicQuery := dinamicQuery || ' AND ( DERCORP_EMPRESA_TAB.ID_EMPRESA IN ('||pstdes_empresas||'))';
            END IF;
            IF pstdes_apoderados IS NOT NULL THEN
            dinamicQuery := dinamicQuery || ' AND ( PENDIUM_APODERADO_EP_TAB.ID_EMPL_FK IN ('||pstdes_apoderados||'))';
            END IF;
            IF pstdes_grupoapoderados IS NOT NULL THEN
            dinamicQuery := dinamicQuery || ' AND ( PENDIUM_APODERADO_EP_TAB.ID_GRUPO_FK IN ('||pstdes_grupoapoderados||'))';
            END IF;
            dinamicQuery := dinamicQuery || ' ORDER BY DERCORP_ADD_CAMPO_CAT_VAL_TAB.VAL_CAT_VAL,NOM_EMPRESA,PENDIUM_ESCRITURA_PODER_TAB.IND_TIPO_ESCRITURA DESC,
            CASE WHEN PENDIUM_ESCRITURA_PODER_TAB.FEC_OTORGAMIENTO_INSTR IS NULL THEN TO_DATE(''31/12/2999'',''DD/MM/YYYY'') ELSE TO_DATE(FEC_OTORGAMIENTO_INSTR,''DD/MM/YYYY'') END DESC,
            CASE WHEN PENDIUM_ESCRITURA_PODER_TAB.DES_ESCRITURA IS NULL OR PENDIUM_ESCRITURA_PODER_TAB.DES_ESCRITURA=''N/A'' THEN 99999999 ELSE TO_NUMBER(REPLACE(PENDIUM_ESCRITURA_PODER_TAB.DES_ESCRITURA,'','','''')) END DESC, PENDIUM_OTORGAPODER_EP_TAB.ID_OPODER_EP_PK, PENDIUM_OTORGAPODER_EP_TAB.NUM_ORDER ASC';
           OPEN porcRSResultado for dinamicQuery;
          END QUERY_PODERES_POR_ASUNTO;
  PROCEDURE   QUERY_ESCRITURAS (porcRSResultado OUT SYS_REFCURSOR
                                  ,pstdes_empresas varchar2
                                  ,pstdes_tipopoder varchar2
                                  ,pstdes_apoderados varchar2
                                  ,pstdes_poder varchar2
                                  ,pstdes_escritura varchar2)
                                  AS
          dinamicQuery CLOB;
          BEGIN
          dinamicQuery := 'SELECT PENDIUM_OTORGAPODER_EP_TAB.ID_OPODER_EP_PK,
              (CASE WHEN PENDIUM_ESCRITURA_PODER_TAB.IND_REQUIERE_PROTO=1 AND PENDIUM_ESCRITURA_PODER_TAB.DES_ESCRITURA IS NOT NULL THEN
                                    PENDIUM_ESCRITURA_PODER_TAB.DES_ESCRITURA ELSE ''N/A'' END) DES_ESCRITURA,
              (CASE WHEN PENDIUM_ESCRITURA_PODER_TAB.IND_REQUIERE_PROTO=1 AND PENDIUM_ESCRITURA_PODER_TAB.FEC_OTORGAMIENTO_INSTR IS NOT NULL THEN
                          PENDIUM_ESCRITURA_PODER_TAB.FEC_OTORGAMIENTO_INSTR ELSE PENDIUM_ESCRITURA_PODER_TAB.FEC_FECHA END) as FEC_OTORGAMIENTO_INSTR,
              (SELECT val_cat_val
               FROM usrdrc.dercorp_add_campo_cat_val_tab
               WHERE id_catalogo = 1
               AND id_catalogo_valor = (SELECT val_valor
                                     FROM usrdrc.dercorp_add_campo_valor_tab
                                     WHERE id_empresa = DERCORP_EMPRESA_TAB.ID_EMPRESA
                                     AND id_add_campo = 500)) AS NOM_EMPRESA,
              DEL.NOM_CAT_VAL AS DELEGADOPOR,
              PENDIUM_ESCRITURA_PODER_TAB.FEC_FECHA,
              PENDIUM_ESCRITURA_PODER_TAB.FEC_HORA,
              PENDIUM_ESCRITURA_PODER_TAB.NUM_DOCUMENTUM_INSTR,
              PENDIUM_OTORGAPODER_EP_TAB.DES_PODERTIPO,
              PENDIUM_ESCRITURA_PODER_TAB.IND_TIPO_ESCRITURA,
              NVL(PENDIUM_OTORGAPODER_EP_TAB.DES_PODER, '''')            AS DES_PODER,
              NVL(PENDIUM_OTORGAPODER_EP_TAB.DESC_ACTOSDOMINIO, '''')    AS DESC_ACTOSDOMINIO,
              NVL(PENDIUM_OTORGAPODER_EP_TAB.DESC_ACTOSADMON, '''')      AS DESC_ACTOSADMON,
              NVL(PENDIUM_OTORGAPODER_EP_TAB.DESC_PLEITOSCOBRANZA, '''') AS DESC_PLEITOSCOBRANZA,
              NVL(PENDIUM_OTORGAPODER_EP_TAB.DESC_TITULOSCREDITO, '''')  AS DESC_TITULOSCREDITO,
              PENDIUM_ESCRITURA_PODER_TAB.IND_STATUS,
              PENDIUM_OTORGAPODER_EP_TAB.DESC_APODERADOS,
              PENDIUM_OTORGAPODER_EP_TAB.DESC_DESCRIPCION
            FROM PENDIUM_OTORGAPODER_EP_TAB
              INNER JOIN PENDIUM_ESCRITURA_PODER_TAB
                ON PENDIUM_ESCRITURA_PODER_TAB.ID_EP_PK = PENDIUM_OTORGAPODER_EP_TAB.ID_EP_FK
              INNER JOIN DERCORP_EMPRESA_TAB
                ON DERCORP_EMPRESA_TAB.ID_EMPRESA = PENDIUM_ESCRITURA_PODER_TAB.ID_EMPRESA
              LEFT JOIN DERCORP_ADD_CAMPO_CAT_VAL_TAB DEL
                ON DEL.ID_CATALOGO_VALOR = PENDIUM_ESCRITURA_PODER_TAB.IND_DELEGADO_POR
            WHERE
              PENDIUM_OTORGAPODER_EP_TAB.ID_OPODER_EP_PK NOT IN (SELECT PENDIUM_OTORGAPODER_EP_TAB.ID_OPODER_EP_PK
                  FROM PENDIUM_OTORGAPODER_EP_TAB
                  INNER JOIN PENDIUM_OTORGAPODER_EP_TAB PENDIUM_OTORGAPODER_EP_TAB1
                  ON PENDIUM_OTORGAPODER_EP_TAB.DES_PODERTIPO = TRIM(TO_CHAR(PENDIUM_OTORGAPODER_EP_TAB1.DES_PODER))
                  INNER JOIN PENDIUM_ESCRITURA_PODER_TAB
                  ON PENDIUM_ESCRITURA_PODER_TAB.ID_EP_PK = PENDIUM_OTORGAPODER_EP_TAB.ID_EP_FK
                  INNER JOIN PENDIUM_ESCRITURA_PODER_TAB PENDIUM_ESCRITURA_PODER_TAB1
                  ON PENDIUM_ESCRITURA_PODER_TAB1.ID_EP_PK         = PENDIUM_OTORGAPODER_EP_TAB1.ID_EP_FK
                  AND PENDIUM_ESCRITURA_PODER_TAB1.ID_EMPRESA      = PENDIUM_ESCRITURA_PODER_TAB.ID_EMPRESA
                  WHERE
                    PENDIUM_ESCRITURA_PODER_TAB1.DES_ESCRITURA = PENDIUM_ESCRITURA_PODER_TAB.DES_ESCRITURA
                    AND PENDIUM_ESCRITURA_PODER_TAB1.IND_STATUS      = 1
                    AND PENDIUM_ESCRITURA_PODER_TAB.IND_STATUS       = 1
                    and PENDIUM_ESCRITURA_PODER_TAB.IND_TIPO_ESCRITURA = ''PE'' and PENDIUM_ESCRITURA_PODER_TAB1.IND_TIPO_ESCRITURA = ''PG'')
              AND PENDIUM_ESCRITURA_PODER_TAB.IND_STATUS = 1
              AND PENDIUM_ESCRITURA_PODER_TAB.DES_ESCRITURA IS NOT NULL ';
            IF pstdes_escritura IS NOT NULL THEN
              dinamicQuery := dinamicQuery || ' AND ( PENDIUM_ESCRITURA_PODER_TAB.DES_ESCRITURA LIKE '||pstdes_escritura||' )';
            END IF;
            IF pstdes_poder IS NOT NULL THEN
            dinamicQuery := dinamicQuery || ' AND (PENDIUM_OTORGAPODER_EP_TAB.NUM_PODERTIPO       IN ('||pstdes_poder||'))';
            END IF;
            IF pstdes_tipopoder IS NOT NULL THEN
            dinamicQuery := dinamicQuery || ' AND ( PENDIUM_ESCRITURA_PODER_TAB.IND_TIPO_ESCRITURA IN ('||pstdes_tipopoder||'))';
            END IF;
            IF pstdes_empresas IS NOT NULL THEN
            dinamicQuery := dinamicQuery || ' AND ( DERCORP_EMPRESA_TAB.ID_EMPRESA IN ('||pstdes_empresas||'))';
            END IF;
            IF pstdes_apoderados IS NOT NULL THEN
            dinamicQuery := dinamicQuery || ' AND ( '||pstdes_apoderados||')';
            END IF;
            dinamicQuery := dinamicQuery || ' ORDER BY DES_ESCRITURA, NOM_EMPRESA ASC,PENDIUM_ESCRITURA_PODER_TAB.IND_TIPO_ESCRITURA DESC,'
            ||'PENDIUM_OTORGAPODER_EP_TAB.ID_OPODER_EP_PK, PENDIUM_OTORGAPODER_EP_TAB.NUM_ORDER ASC';
             OPEN porcRSResultado FOR dinamicQuery;
  END QUERY_ESCRITURAS;
PROCEDURE   QUERY_REVOCACIONES (porcRSResultado OUT SYS_REFCURSOR
                                  ,pstin_id_opoder_fk varchar2)
AS
    BEGIN
         OPEN porcRSResultado FOR
         SELECT PENDIUM_OTORGAPODER_EP_TAB.ID_OPODER_EP_PK,
                PENDIUM_APODERADO_EP_TAB.DESC_NOM_EMPL,
                PENDIUM_APODERADO_EP_TAB.DESC_REVOCA
         FROM   PENDIUM_APODERADO_EP_TAB
         INNER JOIN PENDIUM_OTORGAPODER_EP_TAB
         ON PENDIUM_OTORGAPODER_EP_TAB.ID_OPODER_EP_PK = PENDIUM_APODERADO_EP_TAB.ID_OPODER_EP_FK
         WHERE PENDIUM_OTORGAPODER_EP_TAB.IND_STATUS = 1 AND PENDIUM_APODERADO_EP_TAB.IND_STATUS=2
         AND PENDIUM_OTORGAPODER_EP_TAB.ID_OPODER_EP_PK = pstin_id_opoder_fk
         ORDER BY TO_NUMBER(PENDIUM_APODERADO_EP_TAB.IND_APREVOCA);
END QUERY_REVOCACIONES;
PROCEDURE   QUERY_REVOCACIONES (porcRSResultado OUT SYS_REFCURSOR)
AS
    BEGIN
         OPEN porcRSResultado FOR
         SELECT PENDIUM_OTORGAPODER_EP_TAB.ID_OPODER_EP_PK,
                PENDIUM_APODERADO_EP_TAB.DESC_NOM_EMPL,
                PENDIUM_APODERADO_EP_TAB.DESC_REVOCA
         FROM   PENDIUM_APODERADO_EP_TAB
         INNER JOIN PENDIUM_OTORGAPODER_EP_TAB
         ON PENDIUM_OTORGAPODER_EP_TAB.ID_OPODER_EP_PK = PENDIUM_APODERADO_EP_TAB.ID_OPODER_EP_FK
         WHERE PENDIUM_OTORGAPODER_EP_TAB.IND_STATUS = 1 AND PENDIUM_APODERADO_EP_TAB.IND_STATUS=2
          ORDER BY  TO_NUMBER(PENDIUM_APODERADO_EP_TAB.IND_APREVOCA);
END QUERY_REVOCACIONES;
PROCEDURE   QUERY_PODERES_POR_FACULTAD (porcRSResultado OUT SYS_REFCURSOR
                                  ,pstdes_empresas varchar2
                                  ,pstdes_tipopoder varchar2
                                  ,pstdes_apoderados varchar2
                                  ,pstdes_poder varchar2
                                  ,pstdes_escritura varchar2
                                  ,pstAD varchar2
                                  ,pstAA varchar2
                                  ,pstPC varchar2
                                  ,pstTC varchar2
                                  )
          AS
            dinamicQuery CLOB;
          BEGIN
              dinamicQuery := 'SELECT PENDIUM_OTORGAPODER_EP_TAB.ID_OPODER_EP_PK,
                 (CASE WHEN PENDIUM_ESCRITURA_PODER_TAB.IND_REQUIERE_PROTO=1 AND PENDIUM_ESCRITURA_PODER_TAB.DES_ESCRITURA IS NOT NULL THEN
                                    PENDIUM_ESCRITURA_PODER_TAB.DES_ESCRITURA ELSE ''N/A'' END) DES_ESCRITURA,
              (CASE WHEN PENDIUM_ESCRITURA_PODER_TAB.IND_REQUIERE_PROTO=1 AND PENDIUM_ESCRITURA_PODER_TAB.FEC_OTORGAMIENTO_INSTR IS NOT NULL THEN
                          PENDIUM_ESCRITURA_PODER_TAB.FEC_OTORGAMIENTO_INSTR ELSE PENDIUM_ESCRITURA_PODER_TAB.FEC_FECHA END) as FEC_OTORGAMIENTO_INSTR,
                  NVL(PENDIUM_ESCRITURA_PODER_TAB.FEC_FECHA, '''') AS FEC_FECHA,
                  (SELECT val_cat_val
                   FROM usrdrc.dercorp_add_campo_cat_val_tab
                   WHERE id_catalogo = 1
                   AND id_catalogo_valor = (SELECT val_valor
                                         FROM usrdrc.dercorp_add_campo_valor_tab
                                         WHERE id_empresa = DERCORP_EMPRESA_TAB.ID_EMPRESA
                                         AND id_add_campo = 500)) AS NOM_EMPRESA,
                  PENDIUM_ESCRITURA_PODER_TAB.ID_EMPRESA,
                  PENDIUM_ESCRITURA_PODER_TAB.IND_TIPO_ESCRITURA,
                  NVL(PENDIUM_OTORGAPODER_EP_TAB.DES_PODER, '''')            AS DES_PODER,
                  NVL(PENDIUM_OTORGAPODER_EP_TAB.DES_PODER, '''')            AS DES_PODERTIPO,
                  NVL(PENDIUM_OTORGAPODER_EP_TAB.DESC_ACTOSDOMINIO, '''')    AS DESC_ACTOSDOMINIO,
                  CASE TO_CHAR(NVL(PENDIUM_OTORGAPODER_EP_TAB.DESC_ACTOSDOMINIO,''NULL''))
                    WHEN ''No tiene'' THEN ''''
                    WHEN ''No Tiene'' THEN ''''
                    WHEN ''NULL'' THEN ''''
                    ELSE ''Actos de Dominio''
                  END AS ACTOSDOMINIO,
                  NVL(PENDIUM_OTORGAPODER_EP_TAB.DESC_ACTOSADMON, '''')      AS DESC_ACTOSADMON,
                  CASE TO_CHAR(NVL(PENDIUM_OTORGAPODER_EP_TAB.DESC_ACTOSADMON,''NULL''))
                    WHEN ''No tiene'' THEN ''''
                    WHEN ''No Tiene'' THEN ''''
                    WHEN ''NULL'' THEN ''''
                    ELSE ''Actos de Administraci??n''
                  END AS ACTOSADMON,
                  NVL(PENDIUM_OTORGAPODER_EP_TAB.DESC_PLEITOSCOBRANZA, '''') AS DESC_PLEITOSCOBRANZA,
                  CASE TO_CHAR(NVL(PENDIUM_OTORGAPODER_EP_TAB.DESC_PLEITOSCOBRANZA,''NULL''))
                    WHEN ''No tiene'' THEN ''''
                    WHEN ''No Tiene'' THEN ''''
                    WHEN ''NULL'' THEN ''''
                    ELSE ''Pleitos y Cobranzas''
                  END AS PLEITOSCOBRANZA,
                  NVL(PENDIUM_OTORGAPODER_EP_TAB.DESC_TITULOSCREDITO, '''')  AS DESC_TITULOSCREDITO,
                  CASE TO_CHAR(NVL(PENDIUM_OTORGAPODER_EP_TAB.DESC_TITULOSCREDITO,''NULL''))
                    WHEN ''No tiene'' THEN ''''
                    WHEN ''No Tiene'' THEN ''''
                    WHEN ''NULL'' THEN ''''
                    ELSE ''T?-tulos de Cr??dito''
                  END AS TITULOSCREDITO,
                  PENDIUM_ESCRITURA_PODER_TAB.IND_STATUS,
                  PENDIUM_OTORGAPODER_EP_TAB.DESC_APODERADOS,
                  PENDIUM_OTORGAPODER_EP_TAB.DESC_DESCRIPCION,
                  nvl(PENDIUM_OTORGAPODER_EP_TAB.FEC_VIGENCIAFIN,'''') as FEC_VIGENCIAFIN
                FROM PENDIUM_OTORGAPODER_EP_TAB
                  INNER JOIN PENDIUM_ESCRITURA_PODER_TAB
                  ON PENDIUM_ESCRITURA_PODER_TAB.ID_EP_PK = PENDIUM_OTORGAPODER_EP_TAB.ID_EP_FK
                  INNER JOIN DERCORP_EMPRESA_TAB
                  ON DERCORP_EMPRESA_TAB.ID_EMPRESA = PENDIUM_ESCRITURA_PODER_TAB.ID_EMPRESA
                WHERE PENDIUM_ESCRITURA_PODER_TAB.IND_STATUS = 1 AND PENDIUM_ESCRITURA_PODER_TAB.IND_TIPO_ESCRITURA=''PG'' ';
                IF pstdes_escritura IS NOT NULL THEN
                  dinamicQuery := dinamicQuery || ' AND ( PENDIUM_ESCRITURA_PODER_TAB.DES_ESCRITURA LIKE '||pstdes_escritura||' )';
                END IF;
                IF pstdes_poder IS NOT NULL THEN
                dinamicQuery := dinamicQuery || ' AND (PENDIUM_OTORGAPODER_EP_TAB.NUM_PODERTIPO       IN ('||pstdes_poder||'))';
                END IF;
                IF pstdes_tipopoder IS NOT NULL THEN
                dinamicQuery := dinamicQuery || ' AND ( PENDIUM_ESCRITURA_PODER_TAB.IND_TIPO_ESCRITURA IN ('||pstdes_tipopoder||'))';
                END IF;
                IF pstdes_empresas IS NOT NULL THEN
                dinamicQuery := dinamicQuery || ' AND ( DERCORP_EMPRESA_TAB.ID_EMPRESA IN ('||pstdes_empresas||'))';
                END IF;
                IF pstdes_apoderados IS NOT NULL THEN
                dinamicQuery := dinamicQuery || ' AND ( '||pstdes_apoderados||')';
                END IF;
                IF pstAD IS NOT NULL THEN
                dinamicQuery := dinamicQuery || ' and NOT(DESC_ACTOSDOMINIO LIKE ''%No tiene%'' or DESC_ACTOSDOMINIO LIKE ''%No Tiene%'' or DESC_ACTOSDOMINIO IS NULL)';
                END IF;
                IF pstAA IS NOT NULL THEN
                dinamicQuery := dinamicQuery || ' and NOT(DESC_ACTOSADMON LIKE ''%No tiene%'' or DESC_ACTOSADMON LIKE ''%No Tiene%'' or DESC_ACTOSADMON IS NULL)';
                END IF;
                IF pstPC IS NOT NULL THEN
                dinamicQuery := dinamicQuery || ' and NOT(DESC_PLEITOSCOBRANZA LIKE ''%No tiene%'' or DESC_PLEITOSCOBRANZA LIKE ''%No Tiene%'' or DESC_PLEITOSCOBRANZA IS NULL)';
                END IF;
                IF pstTC IS NOT NULL THEN
                dinamicQuery := dinamicQuery || ' and NOT(DESC_TITULOSCREDITO LIKE ''%No tiene%'' or DESC_TITULOSCREDITO LIKE ''%No Tiene%'' or DESC_PLEITOSCOBRANZA IS NULL)';
                END IF;
                dinamicQuery := dinamicQuery || ' ORDER BY NOM_EMPRESA ASC,PENDIUM_ESCRITURA_PODER_TAB.IND_TIPO_ESCRITURA DESC,   TO_DATE(FEC_OTORGAMIENTO_INSTR,''DD/MM/YYYY'') DESC,'
                ||'PENDIUM_OTORGAPODER_EP_TAB.ID_OPODER_EP_PK, PENDIUM_OTORGAPODER_EP_TAB.NUM_ORDER ASC';
             OPEN porcRSResultado FOR dinamicQuery;
          END QUERY_PODERES_POR_FACULTAD;
PROCEDURE QUERY_PODERES_POR_FACULTAD_ESP (porcRSResultado OUT SYS_REFCURSOR
                                  ,pstdes_empresas varchar2
                                  ,pstdes_tipopoder varchar2
                                  ,pstdes_apoderados varchar2
                                  ,pstdes_poder varchar2
                                  ,pstdes_escritura varchar2)
  AS
          dinamicQuery CLOB;
          BEGIN
          dinamicQuery := 'SELECT PENDIUM_OTORGAPODER_EP_TAB.ID_OPODER_EP_PK,
             (CASE WHEN PENDIUM_ESCRITURA_PODER_TAB.IND_REQUIERE_PROTO=1 AND PENDIUM_ESCRITURA_PODER_TAB.DES_ESCRITURA IS NOT NULL THEN
                                    PENDIUM_ESCRITURA_PODER_TAB.DES_ESCRITURA ELSE ''N/A'' END) DES_ESCRITURA,
              (CASE WHEN PENDIUM_ESCRITURA_PODER_TAB.IND_REQUIERE_PROTO=1 AND PENDIUM_ESCRITURA_PODER_TAB.FEC_OTORGAMIENTO_INSTR IS NOT NULL THEN
                          PENDIUM_ESCRITURA_PODER_TAB.FEC_OTORGAMIENTO_INSTR ELSE PENDIUM_ESCRITURA_PODER_TAB.FEC_FECHA END) as FEC_OTORGAMIENTO_INSTR,
              NVL(PENDIUM_ESCRITURA_PODER_TAB.FEC_FECHA, '''') AS FEC_FECHA,
              (SELECT val_cat_val
               FROM usrdrc.dercorp_add_campo_cat_val_tab
               WHERE id_catalogo = 1
               AND id_catalogo_valor = (SELECT val_valor
                                     FROM usrdrc.dercorp_add_campo_valor_tab
                                     WHERE id_empresa = DERCORP_EMPRESA_TAB.ID_EMPRESA
                                     AND id_add_campo = 500)) AS NOM_EMPRESA,
              PENDIUM_ESCRITURA_PODER_TAB.ID_EMPRESA,
              PENDIUM_OTORGAPODER_EP_TAB.DES_PODERTIPO,
              PENDIUM_ESCRITURA_PODER_TAB.IND_TIPO_ESCRITURA,
              NVL(PENDIUM_OTORGAPODER_EP_TAB.DES_PODER, '''')            AS DES_PODER,
              NVL(PENDIUM_OTORGAPODER_EP_TAB.DESC_ACTOSDOMINIO, '''')    AS DESC_ACTOSDOMINIO,
              NVL(PENDIUM_OTORGAPODER_EP_TAB.DESC_ACTOSADMON, '''')      AS DESC_ACTOSADMON,
              NVL(PENDIUM_OTORGAPODER_EP_TAB.DESC_PLEITOSCOBRANZA, '''') AS DESC_PLEITOSCOBRANZA,
              NVL(PENDIUM_OTORGAPODER_EP_TAB.DESC_TITULOSCREDITO, '''')  AS DESC_TITULOSCREDITO,
              PENDIUM_ESCRITURA_PODER_TAB.IND_STATUS,
              PENDIUM_OTORGAPODER_EP_TAB.DESC_APODERADOS,
              PENDIUM_OTORGAPODER_EP_TAB.DESC_DESCRIPCION,
              nvl(PENDIUM_OTORGAPODER_EP_TAB.FEC_VIGENCIAFIN,'''') as FEC_VIGENCIAFIN
            FROM PENDIUM_OTORGAPODER_EP_TAB
              INNER JOIN PENDIUM_ESCRITURA_PODER_TAB
              ON PENDIUM_ESCRITURA_PODER_TAB.ID_EP_PK = PENDIUM_OTORGAPODER_EP_TAB.ID_EP_FK
              INNER JOIN DERCORP_EMPRESA_TAB
              ON DERCORP_EMPRESA_TAB.ID_EMPRESA = PENDIUM_ESCRITURA_PODER_TAB.ID_EMPRESA
            WHERE PENDIUM_ESCRITURA_PODER_TAB.IND_STATUS = 1
            AND PENDIUM_ESCRITURA_PODER_TAB.DES_ESCRITURA IN (SELECT DISTINCT PENDIUM_ESCRITURA_PODER_TAB.DES_ESCRITURA
            FROM PENDIUM_ESCRITURA_PODER_TAB WHERE PENDIUM_ESCRITURA_PODER_TAB.IND_TIPO_ESCRITURA=''PG''
            AND PENDIUM_ESCRITURA_PODER_TAB.IND_STATUS = 1 AND PENDIUM_ESCRITURA_PODER_TAB.ID_EMPRESA='||pstdes_empresas||') ';
            IF pstdes_escritura IS NOT NULL THEN
              dinamicQuery := dinamicQuery || ' AND ( PENDIUM_ESCRITURA_PODER_TAB.DES_ESCRITURA LIKE '||pstdes_escritura||' )';
            END IF;
            IF pstdes_poder IS NOT NULL THEN
            dinamicQuery := dinamicQuery || ' AND (PENDIUM_OTORGAPODER_EP_TAB.NUM_PODERTIPO       IN ('||pstdes_poder||'))';
            END IF;
            IF pstdes_tipopoder IS NOT NULL THEN
            dinamicQuery := dinamicQuery || ' AND ( PENDIUM_ESCRITURA_PODER_TAB.IND_TIPO_ESCRITURA IN ('||pstdes_tipopoder||'))';
            END IF;
            IF pstdes_empresas IS NOT NULL THEN
            dinamicQuery := dinamicQuery || ' AND ( DERCORP_EMPRESA_TAB.ID_EMPRESA IN ('||pstdes_empresas||'))';
            END IF;
            IF pstdes_apoderados IS NOT NULL THEN
            dinamicQuery := dinamicQuery || ' AND ( '||pstdes_apoderados||')';
            END IF;
            dinamicQuery := dinamicQuery || ' ORDER BY NOM_EMPRESA ASC,PENDIUM_OTORGAPODER_EP_TAB.DES_PODERTIPO ASC,PENDIUM_ESCRITURA_PODER_TAB.IND_TIPO_ESCRITURA DESC,TO_DATE(FEC_OTORGAMIENTO_INSTR,''DD/MM/YYYY'') DESC,'
            ||'PENDIUM_OTORGAPODER_EP_TAB.ID_OPODER_EP_PK,PENDIUM_OTORGAPODER_EP_TAB.NUM_ORDER ASC';
            OPEN porcRSResultado FOR dinamicQuery;
END QUERY_PODERES_POR_FACULTAD_ESP;
PROCEDURE QUERY_PODERES_TIPO_PODER (porcRSResultado OUT SYS_REFCURSOR
                                  ,pstdes_empresas varchar2
                                  ,pstdes_tipopoder varchar2
                                  ,pstdes_apoderados varchar2
                                  ,pstdes_poder varchar2
                                  ,pstdes_escritura varchar2)
  AS
          dinamicQuery CLOB;
          BEGIN
          dinamicQuery := 'SELECT PENDIUM_OTORGAPODER_EP_TAB.ID_OPODER_EP_PK,
              (CASE WHEN PENDIUM_ESCRITURA_PODER_TAB.IND_REQUIERE_PROTO=1 AND PENDIUM_ESCRITURA_PODER_TAB.DES_ESCRITURA IS NOT NULL THEN
                                    PENDIUM_ESCRITURA_PODER_TAB.DES_ESCRITURA ELSE ''N/A'' END) DES_ESCRITURA,
              (CASE WHEN PENDIUM_ESCRITURA_PODER_TAB.IND_REQUIERE_PROTO=1 AND PENDIUM_ESCRITURA_PODER_TAB.FEC_OTORGAMIENTO_INSTR IS NOT NULL THEN
                          PENDIUM_ESCRITURA_PODER_TAB.FEC_OTORGAMIENTO_INSTR ELSE PENDIUM_ESCRITURA_PODER_TAB.FEC_FECHA END) as FEC_OTORGAMIENTO_INSTR,
              NVL(PENDIUM_ESCRITURA_PODER_TAB.FEC_FECHA, '''') AS FEC_FECHA,
              (SELECT val_cat_val
               FROM usrdrc.dercorp_add_campo_cat_val_tab
               WHERE id_catalogo = 1
               AND id_catalogo_valor = (SELECT val_valor
                                     FROM usrdrc.dercorp_add_campo_valor_tab
                                     WHERE id_empresa = DERCORP_EMPRESA_TAB.ID_EMPRESA
                                     AND id_add_campo = 500)) AS NOM_EMPRESA,
              PENDIUM_ESCRITURA_PODER_TAB.ID_EMPRESA,
              PENDIUM_OTORGAPODER_EP_TAB.DES_PODERTIPO,
              PENDIUM_ESCRITURA_PODER_TAB.IND_TIPO_ESCRITURA,
              NVL(PENDIUM_OTORGAPODER_EP_TAB.DES_PODER, '''')            AS DES_PODER,
              NVL(PENDIUM_OTORGAPODER_EP_TAB.DESC_ACTOSDOMINIO, '''')    AS DESC_ACTOSDOMINIO,
              NVL(PENDIUM_OTORGAPODER_EP_TAB.DESC_ACTOSADMON, '''')      AS DESC_ACTOSADMON,
              NVL(PENDIUM_OTORGAPODER_EP_TAB.DESC_PLEITOSCOBRANZA, '''') AS DESC_PLEITOSCOBRANZA,
              NVL(PENDIUM_OTORGAPODER_EP_TAB.DESC_TITULOSCREDITO, '''')  AS DESC_TITULOSCREDITO,
              NVL(PE.DES_PODER,'''') AS DESC_PODER_ESPECIAL,
              PENDIUM_ESCRITURA_PODER_TAB.IND_STATUS,
              PENDIUM_OTORGAPODER_EP_TAB.DESC_APODERADOS,
              PENDIUM_OTORGAPODER_EP_TAB.DESC_DESCRIPCION,
              nvl(PENDIUM_OTORGAPODER_EP_TAB.FEC_VIGENCIAFIN,'''') as FEC_VIGENCIAFIN
              FROM PENDIUM_OTORGAPODER_EP_TAB
              INNER JOIN PENDIUM_ESCRITURA_PODER_TAB
              ON PENDIUM_ESCRITURA_PODER_TAB.ID_EP_PK = PENDIUM_OTORGAPODER_EP_TAB.ID_EP_FK
              INNER JOIN DERCORP_EMPRESA_TAB
              ON DERCORP_EMPRESA_TAB.ID_EMPRESA = PENDIUM_ESCRITURA_PODER_TAB.ID_EMPRESA
               LEFT JOIN PENDIUM_OTORGAPODER_EP_TAB PE
              JOIN PENDIUM_ESCRITURA_PODER_TAB ESC_B ON (ESC_B.ID_EP_PK = PE.ID_EP_FK AND ESC_B.IND_TIPO_ESCRITURA = ''PE'' AND ESC_B.IND_STATUS = 1  AND PE.IND_STATUS = 1)
              ON TRIM(TO_CHAR(PENDIUM_OTORGAPODER_EP_TAB.DES_PODER)) = PE.DES_PODERTIPO AND ESC_B.ID_EMPRESA = PENDIUM_ESCRITURA_PODER_TAB.ID_EMPRESA AND PENDIUM_ESCRITURA_PODER_TAB.DES_ESCRITURA = ESC_B.DES_ESCRITURA
                AND PENDIUM_ESCRITURA_PODER_TAB.IND_DELEGADO_POR = ESC_B.IND_DELEGADO_POR AND NVL(PENDIUM_ESCRITURA_PODER_TAB.FEC_FECHA,'' '') = NVL(ESC_B.FEC_FECHA,'' '') AND NVL(PENDIUM_ESCRITURA_PODER_TAB.NUM_DOCUMENTUM_INSTR,'' '') = NVL(ESC_B.NUM_DOCUMENTUM_INSTR,'' '')
                AND NVL(PENDIUM_ESCRITURA_PODER_TAB.FEC_OTORGAMIENTO_INSTR,'' '') = NVL(ESC_B.FEC_OTORGAMIENTO_INSTR,'' '') AND PENDIUM_ESCRITURA_PODER_TAB.NUM_LICENCIADO = ESC_B.NUM_LICENCIADO AND NVL(PENDIUM_ESCRITURA_PODER_TAB.NUM_INSC_REGPUB,'' '') = NVL(ESC_B.NUM_INSC_REGPUB,'' '')
                AND NVL(PENDIUM_ESCRITURA_PODER_TAB.FEC_REGISTRO,'' '') = NVL(ESC_B.FEC_REGISTRO,'' '')
           WHERE PENDIUM_OTORGAPODER_EP_TAB.ID_OPODER_EP_PK NOT IN (SELECT PENDIUM_OTORGAPODER_EP_TAB.ID_OPODER_EP_PK
                  FROM PENDIUM_OTORGAPODER_EP_TAB
                  INNER JOIN PENDIUM_OTORGAPODER_EP_TAB PENDIUM_OTORGAPODER_EP_TAB1
                  ON PENDIUM_OTORGAPODER_EP_TAB.DES_PODERTIPO = TRIM(TO_CHAR(PENDIUM_OTORGAPODER_EP_TAB1.DES_PODER))
                  INNER JOIN PENDIUM_ESCRITURA_PODER_TAB
                  ON PENDIUM_ESCRITURA_PODER_TAB.ID_EP_PK = PENDIUM_OTORGAPODER_EP_TAB.ID_EP_FK
                  INNER JOIN PENDIUM_ESCRITURA_PODER_TAB PENDIUM_ESCRITURA_PODER_TAB1
                  ON PENDIUM_ESCRITURA_PODER_TAB1.ID_EP_PK         = PENDIUM_OTORGAPODER_EP_TAB1.ID_EP_FK
                  AND PENDIUM_ESCRITURA_PODER_TAB1.ID_EMPRESA      = PENDIUM_ESCRITURA_PODER_TAB.ID_EMPRESA
                  WHERE
                    PENDIUM_ESCRITURA_PODER_TAB1.DES_ESCRITURA = PENDIUM_ESCRITURA_PODER_TAB.DES_ESCRITURA
                    AND PENDIUM_ESCRITURA_PODER_TAB.IND_DELEGADO_POR = PENDIUM_ESCRITURA_PODER_TAB1.IND_DELEGADO_POR
                    AND NVL(PENDIUM_ESCRITURA_PODER_TAB.FEC_FECHA,'' '') = NVL(PENDIUM_ESCRITURA_PODER_TAB1.FEC_FECHA,'' '')
                    AND NVL(PENDIUM_ESCRITURA_PODER_TAB.NUM_DOCUMENTUM_INSTR,'' '') = NVL(PENDIUM_ESCRITURA_PODER_TAB1.NUM_DOCUMENTUM_INSTR,'' '')
                    AND NVL(PENDIUM_ESCRITURA_PODER_TAB.FEC_OTORGAMIENTO_INSTR,'' '') = NVL(PENDIUM_ESCRITURA_PODER_TAB1.FEC_OTORGAMIENTO_INSTR,'' '')
                    AND PENDIUM_ESCRITURA_PODER_TAB.NUM_LICENCIADO = PENDIUM_ESCRITURA_PODER_TAB1.NUM_LICENCIADO
                    AND NVL(PENDIUM_ESCRITURA_PODER_TAB.NUM_INSC_REGPUB,'' '') = NVL(PENDIUM_ESCRITURA_PODER_TAB1.NUM_INSC_REGPUB,'' '')
                    AND NVL(PENDIUM_ESCRITURA_PODER_TAB.FEC_REGISTRO,'' '') = NVL(PENDIUM_ESCRITURA_PODER_TAB1.FEC_REGISTRO,'' '')
                    AND PENDIUM_ESCRITURA_PODER_TAB1.IND_STATUS      = 1
                    AND PENDIUM_ESCRITURA_PODER_TAB.IND_STATUS       = 1
                    and PENDIUM_ESCRITURA_PODER_TAB.IND_TIPO_ESCRITURA = ''PE'' and PENDIUM_ESCRITURA_PODER_TAB1.IND_TIPO_ESCRITURA = ''PG'')
              AND PENDIUM_ESCRITURA_PODER_TAB.IND_STATUS = 1';
            IF pstdes_escritura IS NOT NULL THEN
              dinamicQuery := dinamicQuery || ' AND ( PENDIUM_ESCRITURA_PODER_TAB.DES_ESCRITURA LIKE '||pstdes_escritura||' )';
            END IF;
            IF pstdes_poder IS NOT NULL THEN
            dinamicQuery := dinamicQuery || ' AND (PENDIUM_OTORGAPODER_EP_TAB.NUM_PODERTIPO       IN ('||pstdes_poder||'))';
            END IF;
            IF pstdes_tipopoder IS NOT NULL THEN
            dinamicQuery := dinamicQuery || ' AND ( PENDIUM_ESCRITURA_PODER_TAB.IND_TIPO_ESCRITURA IN ('||pstdes_tipopoder||'))';
            END IF;
            IF pstdes_empresas IS NOT NULL THEN
            dinamicQuery := dinamicQuery || ' AND ( DERCORP_EMPRESA_TAB.ID_EMPRESA IN ('||pstdes_empresas||'))';
            END IF;
            IF pstdes_apoderados IS NOT NULL THEN
            dinamicQuery := dinamicQuery || ' AND ( '||pstdes_apoderados||')';
            END IF;
            dinamicQuery := dinamicQuery || ' ORDER BY NOM_EMPRESA ASC,PENDIUM_OTORGAPODER_EP_TAB.DES_PODERTIPO ASC,PENDIUM_ESCRITURA_PODER_TAB.IND_TIPO_ESCRITURA DESC,TO_DATE(FEC_OTORGAMIENTO_INSTR,''DD/MM/YYYY'') DESC,'
            ||'PENDIUM_OTORGAPODER_EP_TAB.ID_OPODER_EP_PK, PENDIUM_OTORGAPODER_EP_TAB.NUM_ORDER ASC';
            OPEN porcRSResultado FOR dinamicQuery;
          END QUERY_PODERES_TIPO_PODER;
PROCEDURE QUERY_PODERES_POR_VIGENCIA (porcRSResultado OUT SYS_REFCURSOR
                                  ,pstdes_empresas varchar2
                                  ,pstdes_fecha_desde varchar2
                                  ,pstdes_fecha_hasta varchar2
                                  ,pstdes_tipopoder varchar2
                                  ,pstdes_apoderados varchar2
                                  ,pstdes_poder varchar2
                                  ,pstdes_escritura varchar2)
  AS
          dinamicQuery CLOB;
          BEGIN
          dinamicQuery := 'SELECT PENDIUM_OTORGAPODER_EP_TAB.ID_OPODER_EP_PK,
              (CASE WHEN PENDIUM_ESCRITURA_PODER_TAB.IND_REQUIERE_PROTO=1 AND PENDIUM_ESCRITURA_PODER_TAB.DES_ESCRITURA IS NOT NULL THEN
                                    PENDIUM_ESCRITURA_PODER_TAB.DES_ESCRITURA ELSE ''N/A'' END) DES_ESCRITURA,
              nvl(PENDIUM_OTORGAPODER_EP_TAB.FEC_VIGENCIAFIN,'''') as FEC_VIGENCIAFIN,
              (SELECT val_cat_val
               FROM usrdrc.dercorp_add_campo_cat_val_tab
               WHERE id_catalogo = 1
               AND id_catalogo_valor = (SELECT val_valor
                                     FROM usrdrc.dercorp_add_campo_valor_tab
                                     WHERE id_empresa = DERCORP_EMPRESA_TAB.ID_EMPRESA
                                     AND id_add_campo = 500)) AS NOM_EMPRESA,
              PENDIUM_ESCRITURA_PODER_TAB.ID_EMPRESA,
              PENDIUM_OTORGAPODER_EP_TAB.DES_PODERTIPO,
              PENDIUM_ESCRITURA_PODER_TAB.IND_TIPO_ESCRITURA,
              NVL(PENDIUM_OTORGAPODER_EP_TAB.DES_PODER, '''')            AS DES_PODER,
              NVL(PENDIUM_OTORGAPODER_EP_TAB.DESC_ACTOSDOMINIO, '''')    AS DESC_ACTOSDOMINIO,
              NVL(PENDIUM_OTORGAPODER_EP_TAB.DESC_ACTOSADMON, '''')      AS DESC_ACTOSADMON,
              NVL(PENDIUM_OTORGAPODER_EP_TAB.DESC_PLEITOSCOBRANZA, '''') AS DESC_PLEITOSCOBRANZA,
              NVL(PENDIUM_OTORGAPODER_EP_TAB.DESC_TITULOSCREDITO, '''')  AS DESC_TITULOSCREDITO,
              NVL(PE.DES_PODER,'''') AS DESC_PODER_ESPECIAL,
              PENDIUM_ESCRITURA_PODER_TAB.IND_STATUS,
              PENDIUM_OTORGAPODER_EP_TAB.DESC_APODERADOS,
              PENDIUM_OTORGAPODER_EP_TAB.DESC_DESCRIPCION
              FROM PENDIUM_OTORGAPODER_EP_TAB
              INNER JOIN PENDIUM_ESCRITURA_PODER_TAB
              ON PENDIUM_ESCRITURA_PODER_TAB.ID_EP_PK = PENDIUM_OTORGAPODER_EP_TAB.ID_EP_FK
              INNER JOIN DERCORP_EMPRESA_TAB
              ON DERCORP_EMPRESA_TAB.ID_EMPRESA = PENDIUM_ESCRITURA_PODER_TAB.ID_EMPRESA
               LEFT JOIN PENDIUM_OTORGAPODER_EP_TAB PE
              JOIN PENDIUM_ESCRITURA_PODER_TAB ESC_B ON (ESC_B.ID_EP_PK = PE.ID_EP_FK AND ESC_B.IND_TIPO_ESCRITURA = ''PE'' AND ESC_B.IND_STATUS = 1  AND PE.IND_STATUS = 1)
              ON TRIM(TO_CHAR(PENDIUM_OTORGAPODER_EP_TAB.DES_PODER)) = PE.DES_PODERTIPO AND ESC_B.ID_EMPRESA = PENDIUM_ESCRITURA_PODER_TAB.ID_EMPRESA AND PENDIUM_ESCRITURA_PODER_TAB.DES_ESCRITURA = ESC_B.DES_ESCRITURA
                AND PENDIUM_ESCRITURA_PODER_TAB.IND_DELEGADO_POR = ESC_B.IND_DELEGADO_POR AND NVL(PENDIUM_ESCRITURA_PODER_TAB.FEC_FECHA,'' '') = NVL(ESC_B.FEC_FECHA,'' '') AND NVL(PENDIUM_ESCRITURA_PODER_TAB.NUM_DOCUMENTUM_INSTR,'' '') = NVL(ESC_B.NUM_DOCUMENTUM_INSTR,'' '')
                AND NVL(PENDIUM_ESCRITURA_PODER_TAB.FEC_OTORGAMIENTO_INSTR,'' '') = NVL(ESC_B.FEC_OTORGAMIENTO_INSTR,'' '') AND PENDIUM_ESCRITURA_PODER_TAB.NUM_LICENCIADO = ESC_B.NUM_LICENCIADO AND NVL(PENDIUM_ESCRITURA_PODER_TAB.NUM_INSC_REGPUB,'' '') = NVL(ESC_B.NUM_INSC_REGPUB,'' '')
                AND NVL(PENDIUM_ESCRITURA_PODER_TAB.FEC_REGISTRO,'' '') = NVL(ESC_B.FEC_REGISTRO,'' '')
           WHERE PENDIUM_OTORGAPODER_EP_TAB.ID_OPODER_EP_PK NOT IN (SELECT PENDIUM_OTORGAPODER_EP_TAB.ID_OPODER_EP_PK
                  FROM PENDIUM_OTORGAPODER_EP_TAB
                  INNER JOIN PENDIUM_OTORGAPODER_EP_TAB PENDIUM_OTORGAPODER_EP_TAB1
                  ON PENDIUM_OTORGAPODER_EP_TAB.DES_PODERTIPO = TRIM(TO_CHAR(PENDIUM_OTORGAPODER_EP_TAB1.DES_PODER))
                  INNER JOIN PENDIUM_ESCRITURA_PODER_TAB
                  ON PENDIUM_ESCRITURA_PODER_TAB.ID_EP_PK = PENDIUM_OTORGAPODER_EP_TAB.ID_EP_FK
                  INNER JOIN PENDIUM_ESCRITURA_PODER_TAB PENDIUM_ESCRITURA_PODER_TAB1
                  ON PENDIUM_ESCRITURA_PODER_TAB1.ID_EP_PK         = PENDIUM_OTORGAPODER_EP_TAB1.ID_EP_FK
                  AND PENDIUM_ESCRITURA_PODER_TAB1.ID_EMPRESA      = PENDIUM_ESCRITURA_PODER_TAB.ID_EMPRESA
                  WHERE
                    PENDIUM_ESCRITURA_PODER_TAB1.DES_ESCRITURA = PENDIUM_ESCRITURA_PODER_TAB.DES_ESCRITURA
                    AND PENDIUM_ESCRITURA_PODER_TAB.IND_DELEGADO_POR = PENDIUM_ESCRITURA_PODER_TAB1.IND_DELEGADO_POR
                    AND NVL(PENDIUM_ESCRITURA_PODER_TAB.FEC_FECHA,'' '') = NVL(PENDIUM_ESCRITURA_PODER_TAB1.FEC_FECHA,'' '')
                    AND NVL(PENDIUM_ESCRITURA_PODER_TAB.NUM_DOCUMENTUM_INSTR,'' '') = NVL(PENDIUM_ESCRITURA_PODER_TAB1.NUM_DOCUMENTUM_INSTR,'' '')
                    AND NVL(PENDIUM_ESCRITURA_PODER_TAB.FEC_OTORGAMIENTO_INSTR,'' '') = NVL(PENDIUM_ESCRITURA_PODER_TAB1.FEC_OTORGAMIENTO_INSTR,'' '')
                    AND PENDIUM_ESCRITURA_PODER_TAB.NUM_LICENCIADO = PENDIUM_ESCRITURA_PODER_TAB1.NUM_LICENCIADO
                    AND NVL(PENDIUM_ESCRITURA_PODER_TAB.NUM_INSC_REGPUB,'' '') = NVL(PENDIUM_ESCRITURA_PODER_TAB1.NUM_INSC_REGPUB,'' '')
                    AND NVL(PENDIUM_ESCRITURA_PODER_TAB.FEC_REGISTRO,'' '') = NVL(PENDIUM_ESCRITURA_PODER_TAB1.FEC_REGISTRO,'' '')
                    AND PENDIUM_ESCRITURA_PODER_TAB1.IND_STATUS      = 1
                    AND PENDIUM_ESCRITURA_PODER_TAB.IND_STATUS       = 1
                    and PENDIUM_ESCRITURA_PODER_TAB.IND_TIPO_ESCRITURA = ''PE'' and PENDIUM_ESCRITURA_PODER_TAB1.IND_TIPO_ESCRITURA = ''PG'')
              AND PENDIUM_ESCRITURA_PODER_TAB.IND_STATUS = 1';
             IF pstdes_fecha_desde IS NOT NULL THEN
              dinamicQuery := dinamicQuery || ' AND ( TO_DATE(PENDIUM_OTORGAPODER_EP_TAB.FEC_VIGENCIAFIN,''DD/MM/YYYY'') >= TO_DATE('''||pstdes_fecha_desde||''',''DD/MM/YYYY''))';
            END IF;
            IF pstdes_fecha_hasta IS NOT NULL THEN
              dinamicQuery := dinamicQuery || ' AND ( TO_DATE(PENDIUM_OTORGAPODER_EP_TAB.FEC_VIGENCIAFIN,''DD/MM/YYYY'') <= TO_DATE('''||pstdes_fecha_hasta||''',''DD/MM/YYYY''))';
            END IF;
            IF pstdes_escritura IS NOT NULL THEN
              dinamicQuery := dinamicQuery || ' AND ( PENDIUM_ESCRITURA_PODER_TAB.DES_ESCRITURA LIKE '||pstdes_escritura||' )';
            END IF;
            IF pstdes_poder IS NOT NULL THEN
            dinamicQuery := dinamicQuery || ' AND (PENDIUM_OTORGAPODER_EP_TAB.NUM_PODERTIPO IN ('||pstdes_poder||'))';
            END IF;
            IF pstdes_tipopoder IS NOT NULL THEN
            dinamicQuery := dinamicQuery || ' AND ( PENDIUM_ESCRITURA_PODER_TAB.IND_TIPO_ESCRITURA IN ('||pstdes_tipopoder||'))';
            END IF;
            IF pstdes_empresas IS NOT NULL THEN
            dinamicQuery := dinamicQuery || ' AND ( DERCORP_EMPRESA_TAB.ID_EMPRESA IN ('||pstdes_empresas||'))';
            END IF;
            IF pstdes_apoderados IS NOT NULL THEN
            dinamicQuery := dinamicQuery || ' AND ( '||pstdes_apoderados||')';
            END IF;
            dinamicQuery := dinamicQuery || ' ORDER BY NOM_EMPRESA ASC,PENDIUM_ESCRITURA_PODER_TAB.IND_TIPO_ESCRITURA DESC,TO_DATE(PENDIUM_OTORGAPODER_EP_TAB.FEC_VIGENCIAFIN,''DD/MM/YYYY'') DESC,'
            ||'CASE WHEN PENDIUM_ESCRITURA_PODER_TAB.DES_ESCRITURA IS NULL OR PENDIUM_ESCRITURA_PODER_TAB.DES_ESCRITURA=''N/A'' THEN 99999999 ELSE TO_NUMBER(REPLACE(PENDIUM_ESCRITURA_PODER_TAB.DES_ESCRITURA,'','','''')) END DESC,'
            ||'PENDIUM_OTORGAPODER_EP_TAB.ID_OPODER_EP_PK, PENDIUM_OTORGAPODER_EP_TAB.NUM_ORDER ASC';
            OPEN porcRSResultado FOR dinamicQuery;
END QUERY_PODERES_POR_VIGENCIA;
PROCEDURE QUERY_ESC_POR_EMP_ANIO_PR (pinid_empresa NUMBER
                                  ,pinanio NUMBER
                                  ,porcRSResultado OUT SYS_REFCURSOR) AS
  BEGIN
      OPEN   porcRSResultado FOR
       SELECT * FROM (
        SELECT DES_ESCRITURA,IND_TIPO_ESCRITURA,FEC_FECHA,VAL_CAT_VAL
        FROM PENDIUM_ESCRITURA_PODER_TAB INNER JOIN DERCORP_ADD_CAMPO_CAT_VAL_TAB
        ON IND_DELEGADO_POR=ID_CATALOGO_VALOR
        WHERE ID_EMPRESA=pinid_empresa AND EXTRACT(year from TO_DATE(FEC_FECHA))=pinanio
        AND VAL_CAT_VAL!='Apoderado'
        AND IND_STATUS=1
        AND IND_TIPO_ESCRITURA IN ('PG')
        AND (CASE PENDIUM_ESCRITURA_PODER_TAB.IND_TIPO_ESCRITURA WHEN 'ER' THEN 1
        ELSE (SELECT COUNT(DISTINCT ESC.IND_TIPO_ESCRITURA) FROM PENDIUM_ESCRITURA_PODER_TAB ESC INNER JOIN PENDIUM_OTORGAPODER_EP_TAB POD
                        ON ESC.ID_EP_PK = POD.ID_EP_FK
                        WHERE ESC.DES_ESCRITURA = PENDIUM_ESCRITURA_PODER_TAB.DES_ESCRITURA
                        AND ESC.ID_EMPRESA=PENDIUM_ESCRITURA_PODER_TAB.ID_EMPRESA GROUP BY ESC.ID_EMPRESA)END)=2
        UNION ALL
        SELECT DES_ESCRITURA,IND_TIPO_ESCRITURA,FEC_FECHA,VAL_CAT_VAL
        FROM PENDIUM_ESCRITURA_PODER_TAB INNER JOIN DERCORP_ADD_CAMPO_CAT_VAL_TAB
        ON IND_DELEGADO_POR=ID_CATALOGO_VALOR
        WHERE ID_EMPRESA=pinid_empresa AND EXTRACT(year from TO_DATE(FEC_FECHA))=pinanio
        AND VAL_CAT_VAL!='Apoderado'
        AND IND_STATUS=1
        AND IND_TIPO_ESCRITURA IN ('PG','PE','ER')
        AND (CASE PENDIUM_ESCRITURA_PODER_TAB.IND_TIPO_ESCRITURA WHEN 'ER' THEN 1
        ELSE (SELECT COUNT(DISTINCT ESC.IND_TIPO_ESCRITURA) FROM PENDIUM_ESCRITURA_PODER_TAB ESC INNER JOIN PENDIUM_OTORGAPODER_EP_TAB POD
                        ON ESC.ID_EP_PK = POD.ID_EP_FK
                        WHERE ESC.DES_ESCRITURA = PENDIUM_ESCRITURA_PODER_TAB.DES_ESCRITURA
                        AND ESC.ID_EMPRESA=PENDIUM_ESCRITURA_PODER_TAB.ID_EMPRESA GROUP BY ESC.ID_EMPRESA)END)=1
        ) ORDER BY TO_DATE(FEC_FECHA) DESC,IND_TIPO_ESCRITURA DESC;
END QUERY_ESC_POR_EMP_ANIO_PR;
END PENDIUM_REPORTES_PODERES_PKG;
/;
