CREATE OR REPLACE NONEDITIONABLE PACKAGE "USRDRC"."DERCORP_REPORT_REFORMA_PKG" AS
/******************************************************************************
   NAME:       DERCORP_REPORT_REFORMA
   PURPOSE:
   REVISIONS:
   Ver        Date        Author           Description
   ---------  ----------  ---------------  ------------------------------------
   1.0        12/04/2016      Jesus Argumedo       1. Reporte de Reformas.
******************************************************************************/
  PROCEDURE creaReporteReforma_pr;
END DERCORP_REPORT_REFORMA_PKG;
/
CREATE OR REPLACE NONEDITIONABLE PACKAGE BODY "USRDRC"."DERCORP_REPORT_REFORMA_PKG" AS
/******************************************************************************
   NAME:       DERCORP_REPORT_REFORMA
   PURPOSE:
   REVISIONS:
   Ver        Date        Author           Description
   ---------  ----------  ---------------  ------------------------------------
   1.0        12/04/2016      Jesus Argumedo       1. Reporte de Reformas.
******************************************************************************/
  PROCEDURE creaReporteReforma_pr AS
  linSecuencia      NUMBER := 0;
  lstStatus         VARCHAR2(150);
  lstFecStatus      VARCHAR2(150);
  lstFolloup        VARCHAR2(150);
  lstResponsable    VARCHAR2(150);
  lstDescripcion    VARCHAR2(4000);
  CURSOR REFORMAS_TOTAL_CUR
    IS
        SELECT
           /* (SELECT nom_empresa
                FROM DERCORP_EMPRESA_TAB
                WHERE id_empresa = meta.id_empresa) AS empresa,*/
          (SELECT val_cat_val
            FROM dercorp_add_campo_cat_val_tab
            WHERE id_catalogo = 1
            AND   id_catalogo_valor = (SELECT val_valor
                                       FROM dercorp_add_campo_valor_tab
                                       WHERE id_empresa = meta.id_empresa
                                       AND id_add_campo = 500))AS empresa ,
            CASE FLEX.ID_FLEX_TBL
                WHEN 30 THEN META.VAL_C4
                WHEN 27 THEN META.VAL_C18
            ELSE META.VAL_C3 END          AS fecha_solicitud,    --FECHA
            CASE FLEX.ID_FLEX_TBL
                WHEN 17 THEN DERCORP_CATALOGS_PKG.GET_ELEMENT_DESCRIP_FN(META.VAL_C1)
                WHEN 18 THEN DERCORP_CATALOGS_PKG.GET_ELEMENT_DESCRIP_FN(META.VAL_C1)
                WHEN 30 THEN DERCORP_CATALOGS_PKG.GET_ELEMENT_DESCRIP_FN(META.VAL_C3)
            ELSE DERCORP_CATALOGS_PKG.GET_ELEMENT_DESCRIP_FN(META.VAL_C2) END          AS tipo_reunion,    -- TIPO de REUNION (TIPO CONTRATO)
            META.VAL_C149                   AS asunto,                      --ASUNTO
            CASE FLEX.ID_FLEX_TBL
                WHEN 17 THEN META.VAL_C16
                WHEN 18 THEN META.VAL_C16
            ELSE META.VAL_C150 END         AS semaforo,    -- SEMAFORO
            CASE FLEX.ID_FLEX_TBL
                WHEN 17 THEN META.VAL_C8
                WHEN 18 THEN META.VAL_C8
                WHEN 23 THEN META.VAL_C106
            ELSE META.VAL_C86 END         AS escritura,    -- ESCRITURA
            CASE FLEX.ID_FLEX_TBL
                WHEN 17 THEN META.VAL_C9
                WHEN 18 THEN META.VAL_C9
                WHEN 23 THEN META.VAL_C107
            ELSE META.VAL_C87 END         AS fecha_escritura,    -- FECHA ESCRITURA
            CASE FLEX.ID_FLEX_TBL
                WHEN 17 THEN META.VAL_C5
                WHEN 18 THEN META.VAL_C5
                WHEN 23 THEN META.VAL_C107
            ELSE META.VAL_C82 END         AS rrpc,    -- RPPC
            CASE FLEX.ID_FLEX_TBL
                WHEN 17 THEN META.VAL_C19
                WHEN 18 THEN META.VAL_C19
                WHEN 23 THEN META.VAL_C115
            ELSE META.VAL_C95 END         AS fecha_rrpc,    -- FECHA RPPC
            CASE FLEX.ID_FLEX_TBL
                WHEN 17 THEN META.VAL_C150
                WHEN 18 THEN META.VAL_C150
                WHEN 23 THEN META.VAL_C103
            ELSE META.VAL_C83 END         AS semaforo2,    -- SEMAFORO
            META.*
        FROM
            DERCORP_METATBL_TAB META
            LEFT JOIN DERCORP_ADD_CAMPO_CAT_VAL_TAB CAT ON CAT.ID_CATALOGO_VALOR = META.VAL_C2
            LEFT JOIN DERCORP_FLEX_TBLS_TAB FLEX ON FLEX.ID_FLEX_TBL = META.ID_FLEX_TBL
            WHERE
            FLEX.ATRIBUTO15 LIKE '%HIST_CORP%';
            --AND id_empresa IN (numEmpresa);
  BEGIN
        DELETE FROM USRDRC.DERCORP_REP_REFORMAS_TMP;
        FOR i IN REFORMAS_TOTAL_CUR
        LOOP
            SELECT MAX(ID_REP_REFORMA) INTO linSecuencia
            FROM DERCORP_REP_REFORMAS_TMP;
            IF linSecuencia IS NULL OR linSecuencia = ''
            THEN
                linSecuencia := 1;
            ELSE
                linSecuencia := linSecuencia + 1;
            END IF;
            --INICIALIZACION
            lstStatus       := NULL;
            lstFecStatus    := NULL;
            lstFolloup      := NULL;
            lstResponsable  := NULL;
            lstDescripcion  := NULL;
            --ENTRARA SOLO AQUELLAS QUE TIENEN EL CHECKBOX DE STATUS ACTIVO
            IF (i.id_flex_tbl = 20 AND i.val_C59 = 'Si') OR (i.id_flex_tbl = 21 AND i.val_C49 = 'Si')OR
                (i.id_flex_tbl = 22 AND i.val_C55 = 'Si') OR (i.id_flex_tbl = 23 AND i.val_C98 = 'Si') OR
                (i.id_flex_tbl = 28 AND i.val_C26 = 'Si') OR (i.id_flex_tbl = 29 AND i.val_C45 = 'Si') OR
                (i.id_flex_tbl = 31 AND i.val_C25 = 'Si') OR (i.id_flex_tbl = 32 AND i.val_C45 = 'Si') OR
                (i.id_flex_tbl = 33 AND i.val_C47 = 'Si') OR (i.id_flex_tbl = 34 AND i.val_C68 = 'Si') OR
                (i.id_flex_tbl = 35 AND i.val_C25 = 'Si') OR (i.id_flex_tbl = 41 AND i.val_C25 = 'Si')
            THEN
                 --REDACTADA
                IF (i.id_flex_tbl = 20 AND i.val_C38 = 'Si') OR (i.id_flex_tbl = 21 AND i.VAL_C29 = 'Si')   OR
                   (i.id_flex_tbl = 22 AND i.VAL_C36 = 'Si') OR (i.id_flex_tbl = 23 AND i.VAL_C68 = 'Si')   OR
                   (i.id_flex_tbl = 28 AND i.val_C123 = 'Si') OR (i.id_flex_tbl = 29 AND i.val_C123 = 'Si') OR
                   (i.id_flex_tbl = 31 AND i.val_C123 = 'Si') OR (i.id_flex_tbl = 32 AND i.val_C123 = 'Si') OR
                   (i.id_flex_tbl = 33 AND i.val_C123 = 'Si') OR (i.id_flex_tbl = 34 AND i.val_C123 = 'Si') OR
                   (i.id_flex_tbl = 35 AND i.val_C123 = 'Si') OR (i.id_flex_tbl = 41 AND i.val_C123 = 'Si')
                THEN
                    lstStatus := 'Redactada';
                     IF i.id_flex_tbl = 20 AND i.val_C38 = 'Si'
                     THEN
                        lstFecStatus    := i.val_c38;
                        lstFolloup      := i.val_c37;
                        lstResponsable  := i.val_c39;
                        lstDescripcion  := i.val_c6;
                     END IF;
                     IF i.id_flex_tbl = 21 AND i.val_C29 = 'Si'
                     THEN
                        lstFecStatus    := i.val_c31;
                        lstFolloup      := i.val_c28;
                        lstResponsable  := i.val_c30;
                        lstDescripcion  := i.val_c8;
                     END IF;
                     IF i.id_flex_tbl = 22 AND i.val_C36 = 'Si'
                     THEN
                        lstFecStatus    := i.val_c38;
                        lstFolloup      := i.val_c35;
                        lstResponsable  := i.val_c37;
                        lstDescripcion  := i.val_c7;
                     END IF;
                     IF i.id_flex_tbl = 23 AND i.val_C68 = 'Si'
                     THEN
                        lstFecStatus    := i.val_c70;
                        lstFolloup      := i.val_c67;
                        lstResponsable  := i.val_c69;
                        lstDescripcion  := i.val_c32;
                     END IF;
                END IF;
                --JJAQ 25/04/2017 Se agregan porque se estandarizo status y referencia documentum
                 IF i.id_flex_tbl = 28 AND i.VAL_C26 = 'Si'
                    THEN
                        lstFecStatus    := i.VAL_C125;
                        lstFolloup      := i.VAL_C122;
                        lstResponsable  := i.VAL_C124;
                        --lstDescripcion  := i.;
                    END IF;
                    IF i.id_flex_tbl = 29 AND i.VAL_C26 = 'Si'
                    THEN
                        lstFecStatus    := i.VAL_C125;
                        lstFolloup      := i.VAL_C122;
                        lstResponsable  := i.VAL_C124;
                        --lstDescripcion  := i.;
                    END IF;
                    IF i.id_flex_tbl = 31 AND i.VAL_C26 = 'Si'
                    THEN
                        lstFecStatus    := i.VAL_C125;
                        lstFolloup      := i.VAL_C122;
                        lstResponsable  := i.VAL_C124;
                        --lstDescripcion  := i.;
                    END IF;
                    IF i.id_flex_tbl = 32 AND i.VAL_C26 = 'Si'
                    THEN
                        lstFecStatus    := i.VAL_C125;
                        lstFolloup      := i.VAL_C122;
                        lstResponsable  := i.VAL_C124;
                        --lstDescripcion  := i.;
                    END IF;
                    IF i.id_flex_tbl = 33 AND i.VAL_C26 = 'Si'
                    THEN
                        lstFecStatus    := i.VAL_C125;
                        lstFolloup      := i.VAL_C122;
                        lstResponsable  := i.VAL_C124;
                       -- lstDescripcion  := i.;
                    END IF;
                    IF i.id_flex_tbl = 34 AND i.VAL_C26 = 'Si'
                    THEN
                        lstFecStatus    := i.VAL_C125;
                        lstFolloup      := i.VAL_C122;
                        lstResponsable  := i.VAL_C124;
                        --lstDescripcion  := i.;
                    END IF;
                    IF i.id_flex_tbl = 35 AND i.VAL_C26 = 'Si'
                    THEN
                        lstFecStatus    := i.VAL_C125;
                        lstFolloup      := i.VAL_C122;
                        lstResponsable  := i.VAL_C124;
                        --lstDescripcion  := i.;
                    END IF;
                    IF i.id_flex_tbl = 41 AND i.VAL_C26 = 'Si'
                    THEN
                        lstFecStatus    := i.VAL_C125;
                        lstFolloup      := i.VAL_C122;
                        lstResponsable  := i.VAL_C124;
                        --lstDescripcion  := i.;
                    END IF;
                IF (i.id_flex_tbl = 20 AND i.val_C47 = 'Si') OR (i.id_flex_tbl = 21 AND i.VAL_C32 = 'Si')OR
                   (i.id_flex_tbl = 22 AND i.VAL_C39 = 'Si') OR (i.id_flex_tbl = 23 AND i.VAL_C71 = 'Si')OR
                   (i.id_flex_tbl = 28 AND i.VAL_C126 = 'Si') OR (i.id_flex_tbl = 29 AND i.VAL_C126 = 'Si') OR
                   (i.id_flex_tbl = 31 AND i.VAL_C126 = 'Si') OR (i.id_flex_tbl = 32 AND i.VAL_C126 = 'Si') OR
                   (i.id_flex_tbl = 33 AND i.VAL_C126 = 'Si') OR (i.id_flex_tbl = 34 AND i.VAL_C126 = 'Si') OR
                   (i.id_flex_tbl = 35 AND i.VAL_C126 = 'Si') OR (i.id_flex_tbl = 41 AND i.VAL_C126 = 'Si')
                THEN
                    lstStatus  := 'Revisin Gerente';
                    IF i.id_flex_tbl = 20 AND i.val_C47 = 'Si'
                     THEN
                        lstFecStatus    := i.val_c49;
                        lstFolloup      := i.val_c37;
                        lstResponsable  := i.val_c48;
                        lstDescripcion  := i.val_c6;
                     END IF;
                     IF i.id_flex_tbl = 21 AND i.val_C32 = 'Si'
                     THEN
                        lstFecStatus    := i.val_c34;
                        lstFolloup      := i.val_c28;
                        lstResponsable  := i.val_c33;
                        lstDescripcion  := i.val_c8;
                     END IF;
                     IF i.id_flex_tbl = 22 AND i.val_C39 = 'Si'
                     THEN
                        lstFecStatus    := i.val_c41;
                        lstFolloup      := i.val_c35;
                        lstResponsable  := i.val_c40;
                        lstDescripcion  := i.val_c7;
                     END IF;
                     IF i.id_flex_tbl = 23 AND i.val_C71 = 'Si'
                     THEN
                        lstFecStatus    := i.val_c73;
                        lstFolloup      := i.val_c67;
                        lstResponsable  := i.val_c72;
                        lstDescripcion  := i.val_c32;
                     END IF;
                      --JJAQ 25/04/2017 Se agregan porque se estandarizo status y referencia documentum
                 IF i.id_flex_tbl = 28 AND i.VAL_C126 = 'Si'
                    THEN
                        lstFecStatus    := i.VAL_C8;
                        lstFolloup      := i.VAL_C122;
                        lstResponsable  := i.VAL_C127;
                        --lstDescripcion  := i.;
                    END IF;
                    IF i.id_flex_tbl = 29 AND i.VAL_C126 = 'Si'
                    THEN
                        lstFecStatus    := i.VAL_C20;
                        lstFolloup      := i.VAL_C122;
                        lstResponsable  := i.VAL_C127;
                        --lstDescripcion  := i.;
                    END IF;
                    IF i.id_flex_tbl = 31 AND i.VAL_C126 = 'Si'
                    THEN
                        lstFecStatus    := i.VAL_C10;
                        lstFolloup      := i.VAL_C122;
                        lstResponsable  := i.VAL_C127;
                        --lstDescripcion  := i.;
                    END IF;
                    IF i.id_flex_tbl = 32 AND i.VAL_C126 = 'Si'
                    THEN
                        lstFecStatus    := i.VAL_C20;
                        lstFolloup      := i.VAL_C122;
                        lstResponsable  := i.VAL_C127;
                        --lstDescripcion  := i.;
                    END IF;
                    IF i.id_flex_tbl = 33 AND i.VAL_C126 = 'Si'
                    THEN
                        lstFecStatus    := i.VAL_C22;
                        lstFolloup      := i.VAL_C122;
                        lstResponsable  := i.VAL_C127;
                       -- lstDescripcion  := i.;
                    END IF;
                    IF i.id_flex_tbl = 34 AND i.VAL_C126 = 'Si'
                    THEN
                        lstFecStatus    := i.VAL_C24;
                        lstFolloup      := i.VAL_C122;
                        lstResponsable  := i.VAL_C127;
                        --lstDescripcion  := i.;
                    END IF;
                    IF i.id_flex_tbl = 35 AND i.VAL_C126 = 'Si'
                    THEN
                        lstFecStatus    := i.VAL_C9;
                        lstFolloup      := i.VAL_C122;
                        lstResponsable  := i.VAL_C127;
                        --lstDescripcion  := i.;
                    END IF;
                    IF i.id_flex_tbl = 41 AND i.VAL_C126 = 'Si'
                    THEN
                        lstFecStatus    := i.VAL_C9;
                        lstFolloup      := i.VAL_C122;
                        lstResponsable  := i.VAL_C127;
                        --lstDescripcion  := i.;
                    END IF;
                END IF;
                 IF (i.id_flex_tbl = 20 AND i.val_C41 = 'Si') OR (i.id_flex_tbl = 21 AND i.VAL_C35 = 'Si')OR
                   (i.id_flex_tbl = 22 AND i.VAL_C42 = 'Si') OR (i.id_flex_tbl = 23 AND i.VAL_C74 = 'Si') OR
                   (i.id_flex_tbl = 28 AND i.VAL_C128 = 'Si') OR (i.id_flex_tbl = 29 AND i.VAL_C128 = 'Si') OR
                   (i.id_flex_tbl = 31 AND i.VAL_C128 = 'Si') OR (i.id_flex_tbl = 32 AND i.VAL_C128 = 'Si') OR
                   (i.id_flex_tbl = 33 AND i.VAL_C128 = 'Si') OR (i.id_flex_tbl = 34 AND i.VAL_C128 = 'Si') OR
                   (i.id_flex_tbl = 35 AND i.VAL_C128 = 'Si') OR (i.id_flex_tbl = 41 AND i.VAL_C128 = 'Si')
                THEN
                    lstStatus := 'Correcciones';
                    IF i.id_flex_tbl = 20 AND i.val_C41 = 'Si'
                    THEN
                        lstFecStatus    := i.VAL_C43;
                        lstFolloup      := i.val_c37;
                        lstResponsable  := i.val_c42;
                        lstDescripcion  := i.val_c6;
                    END IF;
                    IF i.id_flex_tbl = 21 AND i.VAL_C35 = 'Si'
                    THEN
                        lstFecStatus    := i.VAL_C37;
                        lstFolloup      := i.val_c28;
                        lstResponsable  := i.val_c36;
                        lstDescripcion  := i.val_c8;
                    END IF;
                    IF i.id_flex_tbl = 22 AND i.VAL_C42 = 'Si'
                    THEN
                        lstFecStatus    := i.VAL_C44;
                        lstFolloup      := i.val_c35;
                        lstResponsable  := i.val_c43;
                        lstDescripcion  := i.val_c7;
                    END IF;
                    IF i.id_flex_tbl = 23 AND i.VAL_C74 = 'Si'
                    THEN
                        lstFecStatus    := i.VAL_C76;
                        lstFolloup      := i.val_c67;
                        lstResponsable  := i.val_c75;
                        lstDescripcion  := i.val_c32;
                    END IF;
                      --JJAQ 25/04/2017 Se agregan porque se estandarizo status y referencia documentum
                 IF i.id_flex_tbl = 28 AND i.VAL_C128 = 'Si'
                    THEN
                        lstFecStatus    := i.VAL_C130;
                        lstFolloup      := i.VAL_C122;
                        lstResponsable  := i.VAL_C129;
                        --lstDescripcion  := i.;
                    END IF;
                    IF i.id_flex_tbl = 29 AND i.VAL_C128 = 'Si'
                    THEN
                        lstFecStatus    := i.VAL_C130;
                        lstFolloup      := i.VAL_C122;
                        lstResponsable  := i.VAL_C129;
                        --lstDescripcion  := i.;
                    END IF;
                    IF i.id_flex_tbl = 31 AND i.VAL_C128 = 'Si'
                    THEN
                        lstFecStatus    := i.VAL_C130;
                        lstFolloup      := i.VAL_C122;
                        lstResponsable  := i.VAL_C129;
                        --lstDescripcion  := i.;
                    END IF;
                    IF i.id_flex_tbl = 32 AND i.VAL_C128 = 'Si'
                    THEN
                        lstFecStatus    := i.VAL_C130;
                        lstFolloup      := i.VAL_C122;
                        lstResponsable  := i.VAL_C129;
                        --lstDescripcion  := i.;
                    END IF;
                    IF i.id_flex_tbl = 33 AND i.VAL_C128 = 'Si'
                    THEN
                        lstFecStatus    := i.VAL_C130;
                        lstFolloup      := i.VAL_C122;
                        lstResponsable  := i.VAL_C129;
                        --lstDescripcion  := i.;
                    END IF;
                    IF i.id_flex_tbl = 34 AND i.VAL_C128 = 'Si'
                    THEN
                        lstFecStatus    := i.VAL_C130;
                        lstFolloup      := i.VAL_C122;
                        lstResponsable  := i.VAL_C129;
                        --lstDescripcion  := i.;
                    END IF;
                    IF i.id_flex_tbl = 35 AND i.VAL_C128 = 'Si'
                    THEN
                        lstFecStatus    := i.VAL_C130;
                        lstFolloup      := i.VAL_C122;
                        lstResponsable  := i.VAL_C129;
                        --lstDescripcion  := i.;
                    END IF;
                    IF i.id_flex_tbl = 41 AND i.VAL_C128 = 'Si'
                    THEN
                        lstFecStatus    := i.VAL_C130;
                        lstFolloup      := i.VAL_C122;
                        lstResponsable  := i.VAL_C129;
                        --lstDescripcion  := i.;
                    END IF;
                END IF;
                IF (i.id_flex_tbl = 20 AND i.val_C50 = 'Si') OR (i.id_flex_tbl = 21 AND i.VAL_C38 = 'Si')OR
                   (i.id_flex_tbl = 22 AND i.VAL_C45 = 'Si') OR (i.id_flex_tbl = 23 AND i.VAL_C77 = 'Si') OR
                   (i.id_flex_tbl = 28 AND i.VAL_C131 = 'Si') OR (i.id_flex_tbl = 29 AND i.VAL_C131 = 'Si') OR
                   (i.id_flex_tbl = 31 AND i.VAL_C131 = 'Si') OR (i.id_flex_tbl = 32 AND i.VAL_C131 = 'Si') OR
                   (i.id_flex_tbl = 33 AND i.VAL_C131 = 'Si') OR (i.id_flex_tbl = 34 AND i.VAL_C131 = 'Si') OR
                   (i.id_flex_tbl = 35 AND i.VAL_C131 = 'Si') OR (i.id_flex_tbl = 41 AND i.VAL_C131 = 'Si')
                THEN
                    lstStatus := 'Aut. Direccin';
                    IF i.id_flex_tbl = 20 AND i.val_C50 = 'Si'
                    THEN
                        lstFecStatus    := i.VAL_C52;
                        lstFolloup      := i.val_c37;
                        lstResponsable  := i.val_c51;
                        lstDescripcion  := i.val_c6;
                    END IF;
                    IF i.id_flex_tbl = 21 AND i.VAL_C38 = 'Si'
                    THEN
                        lstFecStatus    := i.VAL_C40;
                        lstFolloup      := i.val_c28;
                        lstResponsable  := i.val_c39;
                        lstDescripcion  := i.val_c8;
                    END IF;
                    IF i.id_flex_tbl = 22 AND i.VAL_C45 = 'Si'
                    THEN
                        lstFecStatus    := i.VAL_C47;
                        lstFolloup      := i.val_c35;
                        lstResponsable  := i.val_c46;
                        lstDescripcion  := i.val_c7;
                    END IF;
                    IF i.id_flex_tbl = 23 AND i.VAL_C77 = 'Si'
                    THEN
                        lstFecStatus    := i.VAL_C79;
                        lstFolloup      := i.val_c67;
                        lstResponsable  := i.val_c78;
                        lstDescripcion  := i.val_c32;
                    END IF;
                   --JJAQ 25/04/2017 Se agregan porque se estandarizo status y referencia documentum
                 IF i.id_flex_tbl = 28 AND i.VAL_C131 = 'Si'
                    THEN
                        lstFecStatus    := i.VAL_C9;
                        lstFolloup      := i.VAL_C122;
                        lstResponsable  := i.VAL_C132;
                        --lstDescripcion  := i.;
                    END IF;
                    IF i.id_flex_tbl = 29 AND i.VAL_C131 = 'Si'
                    THEN
                        lstFecStatus    := i.VAL_C21;
                        lstFolloup      := i.VAL_C122;
                        lstResponsable  := i.VAL_C132;
                        --lstDescripcion  := i.;
                    END IF;
                    IF i.id_flex_tbl = 31 AND i.VAL_C131 = 'Si'
                    THEN
                        lstFecStatus    := i.VAL_C11;
                        lstFolloup      := i.VAL_C122;
                        lstResponsable  := i.VAL_C132;
                        --lstDescripcion  := i.;
                    END IF;
                    IF i.id_flex_tbl = 32 AND i.VAL_C131 = 'Si'
                    THEN
                        lstFecStatus    := i.VAL_C21;
                        lstFolloup      := i.VAL_C122;
                        lstResponsable  := i.VAL_C132;
                        --lstDescripcion  := i.;
                    END IF;
                    IF i.id_flex_tbl = 33 AND i.VAL_C131 = 'Si'
                    THEN
                        lstFecStatus    := i.VAL_C23;
                        lstFolloup      := i.VAL_C122;
                        lstResponsable  := i.VAL_C132;
                        --lstDescripcion  := i.;
                    END IF;
                    IF i.id_flex_tbl = 34 AND i.VAL_C131 = 'Si'
                    THEN
                        lstFecStatus    := i.VAL_C25;
                        lstFolloup      := i.VAL_C122;
                        lstResponsable  := i.VAL_C132;
                        --lstDescripcion  := i.;
                    END IF;
                    IF i.id_flex_tbl = 35 AND i.VAL_C131 = 'Si'
                    THEN
                        lstFecStatus    := i.VAL_C10;
                        lstFolloup      := i.VAL_C122;
                        lstResponsable  := i.VAL_C132;
                        --lstDescripcion  := i.;
                    END IF;
                    IF i.id_flex_tbl = 41 AND i.VAL_C131 = 'Si'
                    THEN
                        lstFecStatus    := i.VAL_C10;
                        lstFolloup      := i.VAL_C122;
                        lstResponsable  := i.VAL_C132;
                        --lstDescripcion  := i.;
                    END IF;
                END IF;
                IF (i.id_flex_tbl = 20 AND i.val_C44 = 'Si') OR (i.id_flex_tbl = 21 AND i.VAL_C41 = 'Si')   OR
                   (i.id_flex_tbl = 22 AND i.VAL_C48 = 'Si') OR (i.id_flex_tbl = 23 AND i.VAL_C80 = 'Si')   OR
                   (i.id_flex_tbl = 28 AND i.VAL_C134 = 'Si') OR (i.id_flex_tbl = 29 AND i.VAL_C134 = 'Si') OR
                   (i.id_flex_tbl = 31 AND i.VAL_C134 = 'Si') OR (i.id_flex_tbl = 32 AND i.VAL_C134 = 'Si') OR
                   (i.id_flex_tbl = 33 AND i.VAL_C134 = 'Si') OR (i.id_flex_tbl = 34 AND i.VAL_C134 = 'Si') OR
                   (i.id_flex_tbl = 35 AND i.VAL_C134 = 'Si') OR (i.id_flex_tbl = 41 AND i.VAL_C134 = 'Si')
                THEN
                    lstStatus := 'En firmas';
                    lstFolloup := i.val_c37;
                    IF i.id_flex_tbl = 20 AND i.val_C44 = 'Si'
                    THEN
                        lstFecStatus    := i.VAL_C46;
                        lstFolloup      := i.val_c37;
                        lstResponsable  := i.val_c45;
                        lstDescripcion  := i.val_c6;
                    END IF;
                    IF i.id_flex_tbl = 21 AND i.VAL_C41 = 'Si'
                    THEN
                        lstFecStatus    := i.VAL_C43;
                        lstFolloup      := i.val_c28;
                        lstResponsable  := i.val_c42;
                        lstDescripcion  := i.val_c8;
                    END IF;
                    IF i.id_flex_tbl = 22 AND i.VAL_C48 = 'Si'
                    THEN
                        lstFecStatus    := i.VAL_C50;
                        lstFolloup      := i.val_c35;
                        lstResponsable  := i.val_c49;
                        lstDescripcion  := i.val_c7;
                    END IF;
                    IF i.id_flex_tbl = 23 AND i.VAL_C80 = 'Si'
                    THEN
                        lstFecStatus    := i.VAL_C82;
                        lstFolloup      := i.val_c67;
                        lstResponsable  := i.val_c81;
                        lstDescripcion  := i.val_c32;
                    END IF;
                    --JJAQ 25/04/2017 Se agregan porque se estandarizo status y referencia documentum
                 IF i.id_flex_tbl = 28 AND i.VAL_C134 = 'Si'
                    THEN
                        lstFecStatus    := i.VAL_C10;
                        lstFolloup      := i.VAL_C122;
                        lstResponsable  := i.VAL_C135;
                        --lstDescripcion  := i.;
                    END IF;
                    IF i.id_flex_tbl = 29 AND i.VAL_C134 = 'Si'
                    THEN
                        lstFecStatus    := i.VAL_C22;
                        lstFolloup      := i.VAL_C122;
                        lstResponsable  := i.VAL_C135;
                        --lstDescripcion  := i.;
                    END IF;
                    IF i.id_flex_tbl = 31 AND i.VAL_C134 = 'Si'
                    THEN
                        lstFecStatus    := i.VAL_C12;
                        lstFolloup      := i.VAL_C122;
                        lstResponsable  := i.VAL_C135;
                        --lstDescripcion  := i.;
                    END IF;
                    IF i.id_flex_tbl = 32 AND i.VAL_C134 = 'Si'
                    THEN
                        lstFecStatus    := i.VAL_C22;
                        lstFolloup      := i.VAL_C122;
                        lstResponsable  := i.VAL_C135;
                        --lstDescripcion  := i.;
                    END IF;
                    IF i.id_flex_tbl = 33 AND i.VAL_C134 = 'Si'
                    THEN
                        lstFecStatus    := i.VAL_C24;
                        lstFolloup      := i.VAL_C122;
                        lstResponsable  := i.VAL_C135;
                        --lstDescripcion  := i.;
                    END IF;
                    IF i.id_flex_tbl = 34 AND i.VAL_C134 = 'Si'
                    THEN
                        lstFecStatus    := i.VAL_C26;
                        lstFolloup      := i.VAL_C122;
                        lstResponsable  := i.VAL_C135;
                        --lstDescripcion  := i.;
                    END IF;
                    IF i.id_flex_tbl = 35 AND i.VAL_C134 = 'Si'
                    THEN
                        lstFecStatus    := i.VAL_C11;
                        lstFolloup      := i.VAL_C122;
                        lstResponsable  := i.VAL_C135;
                        --lstDescripcion  := i.;
                    END IF;
                    IF i.id_flex_tbl = 41 AND i.VAL_C134 = 'Si'
                    THEN
                        lstFecStatus    := i.VAL_C11;
                        lstFolloup      := i.VAL_C122;
                        lstResponsable  := i.VAL_C135;
                        --lstDescripcion  := i.;
                    END IF;
                END IF;
                IF (i.id_flex_tbl = 20 AND i.val_C53 = 'Si') OR (i.id_flex_tbl = 21 AND i.VAL_C44 = 'Si')OR
                   (i.id_flex_tbl = 22 AND i.VAL_C51 = 'Si') OR (i.id_flex_tbl = 23 AND i.VAL_C83 = 'Si')OR
                   (i.id_flex_tbl = 28 AND i.VAL_C136 = 'Si') OR (i.id_flex_tbl = 29 AND i.VAL_C136 = 'Si') OR
                   (i.id_flex_tbl = 31 AND i.VAL_C136 = 'Si') OR (i.id_flex_tbl = 32 AND i.VAL_C136 = 'Si') OR
                   (i.id_flex_tbl = 33 AND i.VAL_C136 = 'Si') OR (i.id_flex_tbl = 34 AND i.VAL_C136 = 'Si') OR
                   (i.id_flex_tbl = 35 AND i.VAL_C136 = 'Si') OR (i.id_flex_tbl = 41 AND i.VAL_C136 = 'Si')
                THEN
                    lstStatus := 'Entregada';
                    IF i.id_flex_tbl = 20 AND i.val_C53 = 'Si'
                    THEN
                        lstFecStatus    := i.VAL_C55;
                        lstFolloup      := i.val_c37;
                        lstResponsable  := i.val_c54;
                        lstDescripcion  := i.val_c6;
                    END IF;
                    IF i.id_flex_tbl = 21 AND i.VAL_C44 = 'Si'
                    THEN
                        lstFecStatus    := i.VAL_C46;
                        lstFolloup      := i.val_c28;
                        lstResponsable  := i.val_c45;
                        lstDescripcion  := i.val_c8;
                    END IF;
                    IF i.id_flex_tbl = 22 AND i.VAL_C51 = 'Si'
                    THEN
                        lstFecStatus     := i.VAL_C53;
                        lstFolloup      := i.val_c35;
                        lstResponsable  := i.val_c52;
                        lstDescripcion  := i.val_c7;
                    END IF;
                    IF i.id_flex_tbl = 23 AND i.VAL_C83 = 'Si'
                    THEN
                        lstFecStatus    := i.VAL_C85;
                        lstFolloup      := i.val_c67;
                        lstResponsable  := i.val_c84;
                        lstDescripcion  := i.val_c32;
                    END IF;
                     --JJAQ 25/04/2017 Se agregan porque se estandarizo status y referencia documentum
                 IF i.id_flex_tbl = 28 AND i.VAL_C136 = 'Si'
                    THEN
                        lstFecStatus    := i.VAL_C11;
                        lstFolloup      := i.VAL_C122;
                        lstResponsable  := i.VAL_C137;
                        --lstDescripcion  := i.;
                    END IF;
                    IF i.id_flex_tbl = 29 AND i.VAL_C136 = 'Si'
                    THEN
                        lstFecStatus    := i.VAL_C23;
                        lstFolloup      := i.VAL_C122;
                        lstResponsable  := i.VAL_C137;
                        --lstDescripcion  := i.;
                    END IF;
                    IF i.id_flex_tbl = 31 AND i.VAL_C136 = 'Si'
                    THEN
                        lstFecStatus    := i.VAL_C13;
                        lstFolloup      := i.VAL_C122;
                        lstResponsable  := i.VAL_C137;
                        --lstDescripcion  := i.;
                    END IF;
                    IF i.id_flex_tbl = 32 AND i.VAL_C136 = 'Si'
                    THEN
                        lstFecStatus    := i.VAL_C23;
                        lstFolloup      := i.VAL_C122;
                        lstResponsable  := i.VAL_C137;
                        --lstDescripcion  := i.;
                    END IF;
                    IF i.id_flex_tbl = 33 AND i.VAL_C136 = 'Si'
                    THEN
                        lstFecStatus    := i.VAL_C25;
                        lstFolloup      := i.VAL_C122;
                        lstResponsable  := i.VAL_C137;
                        --lstDescripcion  := i.;
                    END IF;
                    IF i.id_flex_tbl = 34 AND i.VAL_C136 = 'Si'
                    THEN
                        lstFecStatus    := i.VAL_C27;
                        lstFolloup      := i.VAL_C122;
                        lstResponsable  := i.VAL_C137;
                        --lstDescripcion  := i.;
                    END IF;
                    IF i.id_flex_tbl = 35 AND i.VAL_C136 = 'Si'
                    THEN
                        lstFecStatus    := i.VAL_C12;
                        lstFolloup      := i.VAL_C122;
                        lstResponsable  := i.VAL_C137;
                        --lstDescripcion  := i.;
                    END IF;
                    IF i.id_flex_tbl = 41 AND i.VAL_C136 = 'Si'
                    THEN
                        lstFecStatus    := i.VAL_C12;
                        lstFolloup      := i.VAL_C122;
                        lstResponsable  := i.VAL_C137;
                        --lstDescripcion  := i.;
                    END IF;
                END IF;
            END IF;
            --PARA LAS PESTANAS QUE SON DIFERENTES QUE NO TIENEN ESTATUS CON CHECK BOX SI NO CON FECHAS
 /*           IF (i.id_flex_tbl = 28 AND i.VAL_C26 = 'Si' OR i.id_flex_tbl = 29 AND i.VAL_C45 = 'Si' OR
                i.id_flex_tbl = 31 AND i.VAL_C25 = 'Si' OR i.id_flex_tbl = 32 AND i.VAL_C45 = 'Si' OR
                i.id_flex_tbl = 33 AND i.VAL_C47 = 'Si' OR i.id_flex_tbl = 34 AND i.VAL_C68 = 'Si' OR
                i.id_flex_tbl = 35 AND i.VAL_C25 = 'Si')
            THEN
                --REDACTADA
                IF(i.id_flex_tbl  = 28 AND i.VAL_C7  IS NOT NULL)
                OR (i.id_flex_tbl = 29 AND i.VAL_C19 IS NOT NULL)
                OR (i.id_flex_tbl = 31 AND i.VAL_C9  IS NOT NULL)
                OR (i.id_flex_tbl = 32 AND i.VAL_C19 IS NOT NULL)
                OR (i.id_flex_tbl = 33 AND i.VAL_C21 IS NOT NULL)
                OR (i.id_flex_tbl = 34 AND i.VAL_C23 IS NOT NULL)
                OR (i.id_flex_tbl = 35 AND i.VAL_C8  IS NOT NULL)
                THEN
                    lstStatus := 'Redactada';
                    IF i.id_flex_tbl  = 28 AND i.VAL_C7  IS NOT NULL
                    THEN
                        lstFecStatus := i.VAL_C7;
                    END IF;
                    IF i.id_flex_tbl = 29 AND i.VAL_C19 IS NOT NULL
                    THEN
                        lstFecStatus := i.VAL_C19;
                    END IF;
                    IF i.id_flex_tbl = 31 AND i.VAL_C9  IS NOT NULL
                    THEN
                        lstFecStatus := i.VAL_C9;
                    END IF;
                    IF i.id_flex_tbl = 32 AND i.VAL_C19 IS NOT NULL
                    THEN
                        lstFecStatus := i.VAL_C19;
                    END IF;
                    IF i.id_flex_tbl = 33 AND i.VAL_C21 IS NOT NULL
                    THEN
                        lstFecStatus := i.VAL_C21;
                    END IF;
                    IF i.id_flex_tbl = 34 AND i.VAL_C23 IS NOT NULL
                    THEN
                        lstFecStatus := i.VAL_C23;
                    END IF;
                    IF i.id_flex_tbl = 35 AND i.VAL_C8  IS NOT NULL
                    THEN
                        lstFecStatus := i.VAL_C8;
                    END IF;
                END IF;
                --REVISADA
                IF    (i.id_flex_tbl = 28 AND i.VAL_C8  IS NOT NULL)
                    OR (i.id_flex_tbl = 29 AND i.VAL_C20 IS NOT NULL)
                    OR (i.id_flex_tbl = 31 AND i.VAL_C10  IS NOT NULL)
                    OR (i.id_flex_tbl = 32 AND i.VAL_C20 IS NOT NULL)
                    OR (i.id_flex_tbl = 33 AND i.VAL_C22 IS NOT NULL)
                    OR (i.id_flex_tbl = 34 AND i.VAL_C24  IS NOT NULL)
                    OR (i.id_flex_tbl = 35 AND i.VAL_C9  IS NOT NULL)
                THEN
                    lstStatus := 'Revisada';
                    IF i.id_flex_tbl = 28 AND i.VAL_C8  IS NOT NULL
                    THEN
                        lstFecStatus := i.VAL_C8;
                    END IF;
                    IF i.id_flex_tbl = 29 AND i.VAL_C20 IS NOT NULL
                    THEN
                        lstFecStatus := i.VAL_C20;
                    END IF;
                    IF i.id_flex_tbl = 31 AND i.VAL_C10  IS NOT NULL
                    THEN
                        lstFecStatus := i.VAL_C10;
                    END IF;
                    IF i.id_flex_tbl = 32 AND i.VAL_C20 IS NOT NULL
                    THEN
                        lstFecStatus := i.VAL_C20;
                    END IF;
                    IF i.id_flex_tbl = 33 AND i.VAL_C22 IS NOT NULL
                    THEN
                        lstFecStatus := i.VAL_C22;
                    END IF;
                    IF i.id_flex_tbl = 34 AND i.VAL_C24  IS NOT NULL
                    THEN
                        lstFecStatus := i.VAL_C24;
                    END IF;
                    IF i.id_flex_tbl = 35 AND i.VAL_C9  IS NOT NULL
                    THEN
                        lstFecStatus := i.VAL_C9;
                    END IF;
                END IF;
                --AUTORIZACION DIR
                IF    (i.id_flex_tbl = 28 AND i.VAL_C9  IS NOT NULL)
                    OR (i.id_flex_tbl = 29 AND i.VAL_C21 IS NOT NULL)
                    OR (i.id_flex_tbl = 31 AND i.VAL_C11  IS NOT NULL)
                    OR (i.id_flex_tbl = 32 AND i.VAL_C21 IS NOT NULL)
                    OR (i.id_flex_tbl = 33 AND i.VAL_C23 IS NOT NULL)
                    OR (i.id_flex_tbl = 34 AND i.VAL_C24  IS NOT NULL)
                    OR (i.id_flex_tbl = 35 AND i.VAL_C10  IS NOT NULL)
                THEN
                    lstStatus := 'Autorizacin Dir';
                    IF i.id_flex_tbl = 28 AND i.VAL_C9  IS NOT NULL
                    THEN
                        lstFecStatus := i.VAL_C9;
                    END IF;
                    IF i.id_flex_tbl = 29 AND i.VAL_C21 IS NOT NULL
                    THEN
                        lstFecStatus := i.VAL_C21;
                    END IF;
                    IF i.id_flex_tbl = 31 AND i.VAL_C11  IS NOT NULL
                    THEN
                        lstFecStatus := i.VAL_C11;
                    END IF;
                    IF i.id_flex_tbl = 32 AND i.VAL_C21 IS NOT NULL
                    THEN
                        lstFecStatus := i.VAL_C21;
                    END IF;
                    IF i.id_flex_tbl = 33 AND i.VAL_C23 IS NOT NULL
                    THEN
                        lstFecStatus := i.VAL_C23;
                    END IF;
                    IF i.id_flex_tbl = 34 AND i.VAL_C24  IS NOT NULL
                    THEN
                        lstFecStatus := i.VAL_C24;
                    END IF;
                    IF i.id_flex_tbl = 35 AND i.VAL_C10  IS NOT NULL
                    THEN
                        lstFecStatus := i.VAL_C10;
                    END IF;
                END IF;
                --FIRMAS
                IF(     i.id_flex_tbl = 28 AND i.VAL_C10  IS NOT NULL)
                    OR (i.id_flex_tbl = 29 AND i.VAL_C22 IS NOT NULL)
                    OR (i.id_flex_tbl = 31 AND i.VAL_C12  IS NOT NULL)
                    OR (i.id_flex_tbl = 32 AND i.VAL_C22 IS NOT NULL)
                    OR (i.id_flex_tbl = 33 AND i.VAL_C24 IS NOT NULL)
                    OR (i.id_flex_tbl = 34 AND i.VAL_C26  IS NOT NULL)
                    OR (i.id_flex_tbl = 35 AND i.VAL_C11  IS NOT NULL)
                THEN
                    lstStatus := 'En firmas';
                    IF i.id_flex_tbl = 28 AND i.VAL_C10  IS NOT NULL
                    THEN
                        lstFecStatus := i.VAL_C10;
                    END IF;
                    IF i.id_flex_tbl = 29 AND i.VAL_C22 IS NOT NULL
                    THEN
                        lstFecStatus := i.VAL_C22;
                    END IF;
                    IF i.id_flex_tbl = 31 AND i.VAL_C12  IS NOT NULL
                    THEN
                        lstFecStatus := i.VAL_C12;
                    END IF;
                    IF i.id_flex_tbl = 32 AND i.VAL_C22 IS NOT NULL
                    THEN
                        lstFecStatus := i.VAL_C22;
                    END IF;
                    IF i.id_flex_tbl = 33 AND i.VAL_C24 IS NOT NULL
                    THEN
                        lstFecStatus := i.VAL_C24;
                    END IF;
                    IF i.id_flex_tbl = 34 AND i.VAL_C26  IS NOT NULL
                    THEN
                        lstFecStatus := i.VAL_C26;
                    END IF;
                    IF i.id_flex_tbl = 35 AND i.VAL_C11  IS NOT NULL
                    THEN
                        lstFecStatus := i.VAL_C11;
                    END IF;
                END IF;
                --ENTREGADA
                IF    (i.id_flex_tbl = 28 AND i.VAL_C11  IS NOT NULL)
                    OR (i.id_flex_tbl = 29 AND i.VAL_C23 IS NOT NULL)
                    OR (i.id_flex_tbl = 31 AND i.VAL_C13  IS NOT NULL)
                    OR (i.id_flex_tbl = 32 AND i.VAL_C23 IS NOT NULL)
                    OR (i.id_flex_tbl = 33 AND i.VAL_C25 IS NOT NULL)
                    OR (i.id_flex_tbl = 34 AND i.VAL_C27  IS NOT NULL)
                    OR (i.id_flex_tbl = 35 AND i.VAL_C12  IS NOT NULL)
                THEN
                    lstStatus := 'Entregada';
                    IF i.id_flex_tbl = 28 AND i.VAL_C11  IS NOT NULL
                    THEN
                        lstFecStatus := i.VAL_C11;
                    END IF;
                    IF i.id_flex_tbl = 29 AND i.VAL_C23 IS NOT NULL
                    THEN
                        lstFecStatus := i.VAL_C23;
                    END IF;
                    IF i.id_flex_tbl = 31 AND i.VAL_C13  IS NOT NULL
                    THEN
                        lstFecStatus := i.VAL_C13;
                    END IF;
                    IF i.id_flex_tbl = 32 AND i.VAL_C23 IS NOT NULL
                    THEN
                        lstFecStatus := i.VAL_C23;
                    END IF;
                    IF i.id_flex_tbl = 33 AND i.VAL_C25 IS NOT NULL
                    THEN
                        lstFecStatus := i.VAL_C25;
                    END IF;
                    IF i.id_flex_tbl = 34 AND i.VAL_C27  IS NOT NULL
                    THEN
                        lstFecStatus := i.VAL_C27;
                    END IF;
                    IF i.id_flex_tbl = 35 AND i.VAL_C12  IS NOT NULL
                    THEN
                        lstFecStatus := i.VAL_C12;
                    END IF;
                END IF;
            END IF;
          */
        BEGIN
           INSERT INTO USRDRC.DERCORP_REP_REFORMAS_TMP(  ID_REP_REFORMA,
                                                          ID_EMPRESA,
                                                          NOM_EMPRESA,
                                                          DES_ASUNTO,
                                                          FEC_SOLICITUD,
                                                          DES_STATUS,
                                                          FEC_STATUS,
                                                          DES_FOLLOW_UP,
                                                          NOM_RESPONSABLE,
                                                          DES_DESCRIPCION)
            VALUES( linSecuencia,
                    i.id_empresa,
                    i.empresa,
                    i.asunto,
                    i.fecha_solicitud,
                    lstStatus,
                    lstFecStatus,
                    lstFolloup,
                    (SELECT VAL_CAT_VAL
                        FROM DERCORP_ADD_CAMPO_CAT_VAL_TAB
                        WHERE 1=1
                        AND id_catalogo = 59
                        AND id_catalogo_valor = (
                                                SELECT atributo3
                                                FROM dercorp_add_campo_cat_val_tab
                                                WHERE id_catalogo = 1
                                                AND   id_catalogo_valor = (SELECT val_valor
                                                                            FROM dercorp_add_campo_valor_tab
                                                                            WHERE id_empresa = i.id_empresa --JAMS
                                                                            AND id_add_campo = 500)
                        )),
                    lstDescripcion);
        EXCEPTION WHEN OTHERS
         THEN
            DBMS_OUTPUT.PUT_LINE('Error Al insertar en la tabla '||SQLERRM);
         END;
        END LOOP;
  END;
END DERCORP_REPORT_REFORMA_PKG;
/;
