CREATE OR REPLACE NONEDITIONABLE PACKAGE "USRDRC"."DERCORP_FLEXTAB_PKG" AS
  /* TODO enter package declarations (types, exceptions, methods etc) here */
  PROCEDURE INSERT_PR( PARAM_ID_EMPRESA VARCHAR2
                      ,PARAM_ID_FLEX_TAB VARCHAR2
                      ,NEW_ID           OUT INT
                      ,pinUserID        NUMBER);
  PROCEDURE DELETE_PR(PARAM_ID_META_ROW VARCHAR2);
  PROCEDURE POST_SAVE_PR( PARAM_ID_EMPRESA VARCHAR2
                         ,PARAM_ID_FLEX_TAB VARCHAR2
                         ,piinIdMetaRow    NUMBER
  );
  --ECM 28 AGOSTO 2015
  PROCEDURE SET_CAMPOS_CAPITAL_SOCIAL_PR(  PARAM_ID_EMPRESA VARCHAR2);
  --ECM 09 MARZO 2016
  PROCEDURE VERIFICAR_ESCRITURA_PR(P_ID_EMPRESA   IN INTEGER
                                  ,P_ID_FLEX_TAB  IN VARCHAR2
                                  ,P_ID_META_ROW  IN VARCHAR2
                                  ,P_OUT_MSG      OUT VARCHAR2);
  --ECM 26 MAYO 2016
  PROCEDURE GET_CHECK_CAP_FIJ_VAR_PR(pOutCapVar OUT INT
                                    ,pOutCapFij OUT INT
                                    ,pInIdEmp   IN INT
  );
END DERCORP_FLEXTAB_PKG;
/
CREATE OR REPLACE NONEDITIONABLE PACKAGE BODY "USRDRC"."DERCORP_FLEXTAB_PKG" AS
  --
  --
  --
  PROCEDURE INSERT_PR(  PARAM_ID_EMPRESA VARCHAR2
                       ,PARAM_ID_FLEX_TAB VARCHAR2
                       ,NEW_ID            OUT INT
                       ,pinUserID        NUMBER)
  AS
    var_seq number;
  BEGIN
    SELECT
      DERCORP_METATBL_SEQ.NEXTVAL INTO var_seq
    FROM
      DUAL;
    INSERT INTO DERCORP_METATBL_TAB
    (
      ID_META_ROW,
      ID_FLEX_TBL,
      ID_EMPRESA,
      NUM_CREATED_BY,
      FEC_CREATION_DATE
    )
    VALUES (
      var_seq,
      PARAM_ID_FLEX_TAB,
      PARAM_ID_EMPRESA,
      pinUserID,
      SYSDATE
    );
    NEW_ID := var_seq;
  END INSERT_PR;
  --
  --
  --
  PROCEDURE DELETE_PR(PARAM_ID_META_ROW VARCHAR2)
  AS
  BEGIN
      DELETE FROM DERCORP_METATBL_TAB
      WHERE
        ID_META_ROW = PARAM_ID_META_ROW;
  END DELETE_PR;
  --
  --
  --
  PROCEDURE POST_SAVE_PR(PARAM_ID_EMPRESA VARCHAR2
                        ,PARAM_ID_FLEX_TAB VARCHAR2
                        ,piinIdMetaRow    NUMBER
  )
  AS
    linIdRow       NUMBER;
    lstPreEscrt    VARCHAR2(3000);
    lstEscrt       VARCHAR2(3000);
  BEGIN
      -- Estructura de Capital Social
      IF PARAM_ID_FLEX_TAB = 7 THEN
          XXTV_CAPITAL_SOC_PKG.RECALCULAR_ESTRUCTURA_CS_PR(PARAM_ID_EMPRESA
                                                           ,piinIdMetaRow
          );
            --ECM 02 Septiembre 2015
          INSERT INTO DERCORP_ADD_CAMPO_VALOR_TAB(
                     ID_ADD_CAMPO
                    ,ID_EMPRESA
                    ,VAL_VALOR
          )
          SELECT  1033,PARAM_ID_EMPRESA,to_char(SYSDATE,'MM/DD/RRRR')
          FROM    DUAL
          WHERE   1=1
          AND
          NOT EXISTS(
                    SELECT  1
                    FROM    DERCORP_ADD_CAMPO_VALOR_TAB
                    WHERE   1=1
                    AND     ID_ADD_CAMPO  = 1033
                    AND     ID_EMPRESA    = PARAM_ID_EMPRESA
          )
          ;
         --ECM 03 Septiembre 2015 JJAQ se comenta porque no quieren que se actualize la fecha por si solo
         /* UPDATE  DERCORP_ADD_CAMPO_VALOR_TAB
          SET     VAL_VALOR = to_char(SYSDATE,'DD/MM/RRRR')
          WHERE   1=1
          AND     ID_ADD_CAMPO  = 1033
          AND     ID_EMPRESA    = PARAM_ID_EMPRESA
          ;*/
      END IF;
      --ICL 26012016 Poderes Generales y especiales
      IF ((PARAM_ID_FLEX_TAB = 17) OR (PARAM_ID_FLEX_TAB = 18))  THEN
        FOR i IN (SELECT *
                  FROM   DERCORP_METATBL_TAB
                  WHERE  ID_EMPRESA    = PARAM_ID_EMPRESA
                  AND    ID_FLEX_TBL   = PARAM_ID_FLEX_TAB)
        LOOP
          IF ((i.VAL_C8 IS NOT NULL) OR (i.VAL_C8 != '')) THEN
            UPDATE DERCORP_APODERADOS_TAB
            SET    DES_ESCRITURA = i.VAL_C8
            WHERE  ID_EMPRESA    = PARAM_ID_EMPRESA
            AND    TRIM(DES_ESCRITURA) =TRIM( (SELECT VAL_CAT_VAL FROM DERCORP_ADD_CAMPO_CAT_VAL_TAB WHERE ID_CATALOGO_VALOR = i.VAL_C1)||'-'||NVL(i.VAL_C3,'SF'));
          END IF;
        END LOOP;
        COMMIT;
      END IF;
      --IF PARAM_ID_FLEX_TAB
      /*
      IF( ( lrcdMetaInfo.VAL_C86 IS NULL)
          OR ( lrcdMetaInfo.VAL_C86 = '')
          OR ( lrcdMetaInfo.VAL_C86 = '0')) THEN  -- Escritura
        UPDATE DERCORP_METATBL_TAB SET VAL_C86 = 'N/A'
        WHERE  ID_EMPRESA   = pinIdEmpresa
        AND    ID_FLEX_TBL  = pinIdFlex
        AND    ID_META_ROW  = pstIdMetaRow;
      END IF;
*/
/*(PARAM_ID_EMPRESA VARCHAR2
                        ,PARAM_ID_FLEX_TAB VARCHAR2
                        ,piinIdMetaRow    NUMBER
             if((value.equals("")||value.equals(" ")) && (
															 (flexTabId.equals("17") && (param.equals("VAL_C9") || param.equals("VAL_C5")) ) ||
														     (flexTabId.equals("18") && (param.equals("VAL_C9") || param.equals("VAL_C5")) ) ||
														     (flexTabId.equals("23") && (param.equals("VAL_107")|| param.equals("VAL_C107")) ) ||
														     (param.equals("VAL_C87")) ||
														     (param.equals("VAL_C82"))
														    )){
					value = "N/A";
				}
        */
        --
        -- Requiere RPPC
        --
        UPDATE DERCORP_METATBL_TAB SET VAL_C5 = 'N/A'
        WHERE
          TRIM(VAL_C5) IN ('','No')
        AND
        ID_EMPRESA   = PARAM_ID_EMPRESA
        AND    ID_FLEX_TBL  = PARAM_ID_FLEX_TAB
        AND    ID_FLEX_TBL  IN (17,18) -- Todas las Flex de HistCorp en donde RPPC sea VAL_C5
        AND    ID_META_ROW  = piinIdMetaRow;
        --
        -- Requiere RPPC
        --
        UPDATE DERCORP_METATBL_TAB SET VAL_C102 = 'N/A'
        WHERE
          TRIM(VAL_C102) IN ('','No')
        AND
        ID_EMPRESA   = PARAM_ID_EMPRESA
        AND    ID_FLEX_TBL  = PARAM_ID_FLEX_TAB
        AND    ID_FLEX_TBL  IN (23) -- Todas las Flex de HistCorp en donde RPPC sea VAL_C102
        AND    ID_META_ROW  = piinIdMetaRow;
        --
        -- Requiere RPPC
        --
        UPDATE DERCORP_METATBL_TAB SET VAL_C82 = 'N/A'
        WHERE
          TRIM(VAL_C82) IN ('','No')
        AND
        ID_EMPRESA   = PARAM_ID_EMPRESA
        AND    ID_FLEX_TBL  = PARAM_ID_FLEX_TAB
        AND    ID_FLEX_TBL  IN (20,21,22,27,28,29,30,31,32,33,34,35,41) -- Todas las Flex de HistCorp en donde RPPC sea VAL_C82
        AND    ID_META_ROW  = piinIdMetaRow;
        --
        -- Fecha Escritura
        --
         UPDATE DERCORP_METATBL_TAB SET
            VAL_C87 = 'N/A'
        WHERE
          (VAL_C81 = 'No' OR VAL_C81='N/A')
        AND
          (TRIM(VAL_C87) = '' OR (VAL_C87 IS null) OR (VAL_C87='Pendiente'))
        AND
        ID_EMPRESA   = PARAM_ID_EMPRESA
        AND    ID_FLEX_TBL  = PARAM_ID_FLEX_TAB
        AND    ID_FLEX_TBL  IN (20,21,22,27,28,29,30,31,32,33,34,35,41) -- Todas las Flex de HistCorp en donde Fecha Escritura sea VAL_C87
        AND    ID_META_ROW  = piinIdMetaRow;
        --Setear Pendiente cuando este chequeado requiere protocolizacion
        UPDATE DERCORP_METATBL_TAB SET
            VAL_C87 = 'Pendiente'
        WHERE
          (VAL_C81 = 'Si')
        AND
          (TRIM(VAL_C87) = '' OR (VAL_C87 IS null) OR (VAL_C87='N/A'))
        AND
        ID_EMPRESA   = PARAM_ID_EMPRESA
        AND    ID_FLEX_TBL  = PARAM_ID_FLEX_TAB
        AND    ID_FLEX_TBL  IN (20,21,22,27,28,29,30,31,32,33,34,35,41) -- Todas las Flex de HistCorp en donde Fecha Escritura sea VAL_C87
        AND    ID_META_ROW  = piinIdMetaRow;
        --
        -- Fecha Escritura
        --
         UPDATE DERCORP_METATBL_TAB SET
            VAL_C9 = 'N/A'
        WHERE
          (TRIM(VAL_C9) = '' OR (VAL_C9 IS null))
        AND
        ID_EMPRESA   = PARAM_ID_EMPRESA
        AND    ID_FLEX_TBL  = PARAM_ID_FLEX_TAB
        AND    ID_FLEX_TBL  IN (17,18) -- Todas las Flex de HistCorp en donde Fecha Escritura sea VAL_C9
        AND    ID_META_ROW  = piinIdMetaRow;
        --
        -- Fecha Escritura
        --
         UPDATE DERCORP_METATBL_TAB SET
            VAL_C107 = 'N/A'
        WHERE
          (VAL_C101 = 'No' OR VAL_C101='N/A')
        AND
          (TRIM(VAL_C107) = '' OR (VAL_C107 IS null) OR (VAL_C107='Pendiente'))
        AND
        ID_EMPRESA   = PARAM_ID_EMPRESA
        AND    ID_FLEX_TBL  = PARAM_ID_FLEX_TAB
        AND    ID_FLEX_TBL  IN (23) -- Todas las Flex de HistCorp en donde Fecha Escritura sea VAL_C107
        AND    ID_META_ROW  = piinIdMetaRow;
        --Setear Pendiente cuando este chequeado requiere protocolizacion
        UPDATE DERCORP_METATBL_TAB SET
            VAL_C107 = 'Pendiente'
        WHERE
          (VAL_C101 = 'Si')
        AND
          (TRIM(VAL_C107) = '' OR (VAL_C107 IS null) OR (VAL_C107='N/A'))
        AND
        ID_EMPRESA   = PARAM_ID_EMPRESA
        AND    ID_FLEX_TBL  = PARAM_ID_FLEX_TAB
        AND    ID_FLEX_TBL  IN (23) -- Todas las Flex de HistCorp en donde Fecha Escritura sea VAL_C107
        AND    ID_META_ROW  = piinIdMetaRow;
  END POST_SAVE_PR;
  --ECM 28 AGOSTO 2015
  PROCEDURE SET_CAMPOS_CAPITAL_SOCIAL_PR(  PARAM_ID_EMPRESA VARCHAR2)
  IS
    lstACF    NUMBER  :=0;
    lstACV    NUMBER  :=0;
    linValNom NUMBER  :=0;
    linResLim NUMBER  :=0;
    linACS    NUMBER  :=0;
    liExpresNomin NUMBER;
    liExpresNominValTeoNom NUMBER;
    liValTeoNom   NUMBER;
    lioCapVar INT;
    lioCapFij INT;
    liIdValTeoNom NUMBER;
    BEGIN
      EXECUTE IMMEDIATE 'ALTER SESSION SET NLS_NUMERIC_CHARACTERS=''. ''';
      --Validar Responsabilidad Limitada----------------------------------------
      SELECT  COUNT(*)
      INTO    linResLim
      FROM    DERCORP_ADD_CAMPO_VALOR_TAB EMP
      INNER JOIN DERCORP_ADD_CAMPO_CAT_VAL_TAB CAT
      ON      TO_NUMBER(EMP.VAL_VALOR) = TO_NUMBER(CAT.ID_CATALOGO_VALOR)
      WHERE   1=1
      AND     EMP.ID_EMPRESA = PARAM_ID_EMPRESA
      AND     EMP.ID_ADD_CAMPO = 519
      AND     UPPER(CAT.NOM_CAT_VAL) LIKE '%RESPONSABILIDAD%LIMITADA%'
      ;
      IF linResLim = 0 THEN
        SELECT  COUNT(*) INTO liExpresNomin
        FROM    DERCORP_ADD_CAMPO_VALOR_TAB EMP
        INNER   JOIN DERCORP_ADD_CAMPO_CAT_VAL_TAB CAT
        ON      TO_NUMBER(EMP.VAL_VALOR) = TO_NUMBER(CAT.ID_CATALOGO_VALOR)
        WHERE   1=1
        AND     EMP.ID_EMPRESA = PARAM_ID_EMPRESA
        AND     EMP.ID_ADD_CAMPO = 519
        AND     (UPPER(CAT.NOM_CAT_VAL) LIKE '%SIN%EXPRES%NOMINAL'
                OR UPPER(CAT.NOM_CAT_VAL) LIKE '%VALOR%DESIGUAL%'
                )
        ;
        IF liExpresNomin = 0 THEN
            --Obtener Valor Nominal-----------------------------------------------
            BEGIN
                SELECT
                NVL((
                    SELECT  TO_NUMBER(REPLACE(REPLACE(VAL_CAT_VAL, '$', ''), ',', ''))
                    FROM    DERCORP_ADD_CAMPO_CAT_VAL_TAB
                    WHERE   1=1
                    AND     ID_CATALOGO = 9
                    AND     ID_CATALOGO_VALOR = VAL_VALOR
                ),0)INTO   linValNom
                FROM    DERCORP_ADD_CAMPO_VALOR_TAB
                WHERE   1=1
                AND     ID_EMPRESA = PARAM_ID_EMPRESA
                AND     ID_ADD_CAMPO = 519
                ;
            EXCEPTION
            WHEN NO_DATA_FOUND THEN
                linValNom := 0;
            WHEN OTHERS THEN
                linValNom := 0;
            END;
            --Obtener Id Teorico Nominal-----------------------------------------------
            BEGIN
                SELECT
                NVL((
                    SELECT  TO_NUMBER(REPLACE(REPLACE(VAL_CAT_VAL, '$', ''), ',', ''))
                    FROM    DERCORP_ADD_CAMPO_CAT_VAL_TAB
                    WHERE   1=1
                    AND     ID_CATALOGO = 9
                    AND     ID_CATALOGO_VALOR = VAL_VALOR
                ),0)INTO   liIdValTeoNom
                FROM    DERCORP_ADD_CAMPO_VALOR_TAB
                WHERE   1=1
                AND     ID_EMPRESA = PARAM_ID_EMPRESA
                AND     ID_ADD_CAMPO = 1076
                ;
            EXCEPTION
            WHEN NO_DATA_FOUND THEN
                liIdValTeoNom := 0;
            WHEN OTHERS THEN
                liIdValTeoNom := 0;
            END;
            IF linValNom = 0 THEN
                linValNom := liIdValTeoNom;
            END IF;
            --OBTENER TODAS LAS CANTIDADES----------------------------------------
            SELECT  SUM(TO_NUMBER(NVL(VAL_C3,0)))*linValNom
                   ,SUM(TO_NUMBER(NVL(VAL_C4,0)))*linValNom
            INTO    lstACF, lstACV
            FROM    DERCORP_METATBL_TAB
            WHERE   1=1
            AND     ID_FLEX_TBL = 7
            AND     ID_EMPRESA = PARAM_ID_EMPRESA
            ;
            DBMS_OUTPUT.PUT_LINE('Multiplicar capFijo y capVar:  '||lstACF||' | '||lstACV);
            GET_CHECK_CAP_FIJ_VAR_PR(lioCapVar, lioCapFij, TO_NUMBER(PARAM_ID_EMPRESA) );
            IF lioCapFij > 0 THEN
                UPDATE  DERCORP_ADD_CAMPO_VALOR_TAB
                SET     VAL_VALOR     = lstACF
                WHERE   1=1
                AND     ID_EMPRESA    = PARAM_ID_EMPRESA
                AND     ID_ADD_CAMPO  = 1028
                ;
            END IF;
            IF lioCapVar > 0 THEN
                UPDATE  DERCORP_ADD_CAMPO_VALOR_TAB
                SET     VAL_VALOR     = lstACV
                WHERE   1=1
                AND     ID_EMPRESA    = PARAM_ID_EMPRESA
                AND     ID_ADD_CAMPO  = 1029
                ;
            END IF;
            IF lioCapVar > 0 OR lioCapFij > 0 THEN
                linACS := (lstACF + lstACV);
                UPDATE  DERCORP_ADD_CAMPO_VALOR_TAB
                SET     VAL_VALOR     = linACS
                WHERE   1=1
                AND     ID_EMPRESA    = PARAM_ID_EMPRESA
                AND     ID_ADD_CAMPO  = 541
                ;
            END IF;
            COMMIT;
          ELSIF liExpresNomin > 0 THEN
                  SELECT  COUNT(*) INTO liExpresNominValTeoNom
                  FROM    DERCORP_ADD_CAMPO_VALOR_TAB EMP
                  INNER   JOIN DERCORP_ADD_CAMPO_CAT_VAL_TAB CAT
                  ON      TO_NUMBER(EMP.VAL_VALOR) = TO_NUMBER(CAT.ID_CATALOGO_VALOR)
                  WHERE   1=1
                  AND     EMP.ID_EMPRESA = PARAM_ID_EMPRESA
                  AND     EMP.ID_ADD_CAMPO = 1076
                  AND     (UPPER(CAT.NOM_CAT_VAL) LIKE '%SIN%EXPRES%NOMINAL'
                          OR UPPER(CAT.NOM_CAT_VAL) LIKE '%VALOR%DESIGUAL%'
                          )
                  ;
              IF liExpresNominValTeoNom = 0 THEN
                  --Obtener Valor Te??rico Nominal
                  SELECT    TO_NUMBER(REPLACE(REPLACE(VAL_CAT_VAL, '$', ''), ',', ''))
                  INTO      liValTeoNom
                  FROM      DERCORP_ADD_CAMPO_CAT_VAL_TAB
                  WHERE     1=1
                  AND       ID_CATALOGO = 9
                  AND       ID_CATALOGO_VALOR = (
                                    SELECT  VAL_VALOR
                                    FROM    DERCORP_ADD_CAMPO_VALOR_TAB
                                    WHERE   1=1
                                    AND     ID_ADD_CAMPO = 1076
                                    AND     ID_EMPRESA = PARAM_ID_EMPRESA
                  )
                  ;
                  --OBTENER TODAS LAS CANTIDADES----------------------------------------
                  SELECT  SUM(TO_NUMBER(VAL_C3))*liValTeoNom
                         ,SUM(TO_NUMBER(VAL_C4))*liValTeoNom
                  INTO    lstACF, lstACV
                  FROM    DERCORP_METATBL_TAB
                  WHERE   1=1
                  AND     ID_FLEX_TBL = 7
                  AND     ID_EMPRESA = PARAM_ID_EMPRESA
                  ;
                  GET_CHECK_CAP_FIJ_VAR_PR(lioCapVar, lioCapFij, TO_NUMBER(PARAM_ID_EMPRESA) );
                  IF lioCapFij > 0 THEN
                      UPDATE  DERCORP_ADD_CAMPO_VALOR_TAB
                      SET     VAL_VALOR     = lstACF
                      WHERE   1=1
                      AND     ID_EMPRESA    = PARAM_ID_EMPRESA
                      AND     ID_ADD_CAMPO  = 1028
                      ;
                  END IF;
                  IF lioCapVar > 0 THEN
                      UPDATE  DERCORP_ADD_CAMPO_VALOR_TAB
                      SET     VAL_VALOR     = lstACV
                      WHERE   1=1
                      AND     ID_EMPRESA    = PARAM_ID_EMPRESA
                      AND     ID_ADD_CAMPO  = 1029
                      ;
                  END IF;
                  IF lioCapFij > 0 OR lioCapVar > 0 THEN
                      linACS := (lstACF + lstACV);
                      UPDATE  DERCORP_ADD_CAMPO_VALOR_TAB
                      SET     VAL_VALOR     = linACS
                      WHERE   1=1
                      AND     ID_EMPRESA    = PARAM_ID_EMPRESA
                      AND     ID_ADD_CAMPO  = 541
                      ;
                  END IF;
                  COMMIT;
              ELSIF liExpresNominValTeoNom > 0 THEN
                  SELECT  SUM(TO_NUMBER(VAL_C3))
                         ,SUM(TO_NUMBER(VAL_C4))
                  INTO    lstACF, lstACV
                  FROM    DERCORP_METATBL_TAB
                  WHERE   1=1
                  AND     ID_FLEX_TBL = 7
                  AND     ID_EMPRESA = PARAM_ID_EMPRESA
                  ;
                  GET_CHECK_CAP_FIJ_VAR_PR(lioCapVar, lioCapFij, TO_NUMBER(PARAM_ID_EMPRESA) );
                  IF lioCapFij > 0 THEN
                      UPDATE  DERCORP_ADD_CAMPO_VALOR_TAB
                      SET     VAL_VALOR     = lstACF
                      WHERE   1=1
                      AND     ID_EMPRESA    = PARAM_ID_EMPRESA
                      AND     ID_ADD_CAMPO  = 1028
                      ;
                  END IF;
                  IF lioCapVar > 0 THEN
                      UPDATE  DERCORP_ADD_CAMPO_VALOR_TAB
                      SET     VAL_VALOR     = lstACV
                      WHERE   1=1
                      AND     ID_EMPRESA    = PARAM_ID_EMPRESA
                      AND     ID_ADD_CAMPO  = 1029
                      ;
                  END IF;
                  IF lioCapFij > 0 OR lioCapVar > 0 THEN
                      linACS := lstACF + lstACV;
                      UPDATE  DERCORP_ADD_CAMPO_VALOR_TAB
                      SET     VAL_VALOR     = linACS
                      WHERE   1=1
                      AND     ID_EMPRESA    = PARAM_ID_EMPRESA
                      AND     ID_ADD_CAMPO  = 541
                      ;
                  END IF;
                  COMMIT;
              END IF;
          END IF;
      ELSIF linResLim = 1 THEN
           --OBTENER LAS CANTIDADES-SIN VALOR NOMINAL----------------------------
          SELECT  SUM(TO_NUMBER(VAL_C3))
                 ,SUM(TO_NUMBER(VAL_C4))
          INTO    lstACF, lstACV
          FROM    DERCORP_METATBL_TAB
          WHERE   1=1
          AND     ID_FLEX_TBL = 7
          AND     ID_EMPRESA = PARAM_ID_EMPRESA
          ;
          DBMS_OUTPUT.PUT_LINE('Sin Valor Nominal capFijo y capVar:  '||lstACF||' | '||lstACV);
          GET_CHECK_CAP_FIJ_VAR_PR(lioCapVar, lioCapFij, TO_NUMBER(PARAM_ID_EMPRESA) );
          IF lioCapFij > 0 THEN
              UPDATE  DERCORP_ADD_CAMPO_VALOR_TAB
              SET     VAL_VALOR     = lstACF
              WHERE   1=1
              AND     ID_EMPRESA    = PARAM_ID_EMPRESA
              AND     ID_ADD_CAMPO  = 1028
              ;
          END IF;
          IF lioCapVar > 0 THEN
              UPDATE  DERCORP_ADD_CAMPO_VALOR_TAB
              SET     VAL_VALOR     = lstACV
              WHERE   1=1
              AND     ID_EMPRESA    = PARAM_ID_EMPRESA
              AND     ID_ADD_CAMPO  = 1029
              ;
          END IF;
          IF lioCapFij > 0 OR lioCapVar > 0 THEN
              --ECM 31 Agosto 2015
              linACS := lstACF + lstACV;
              UPDATE  DERCORP_ADD_CAMPO_VALOR_TAB
              SET     VAL_VALOR     = linACS
              WHERE   1=1
              AND     ID_EMPRESA    = PARAM_ID_EMPRESA
              AND     ID_ADD_CAMPO  = 541
              ;
          END IF;
          COMMIT;
      END IF;
--------------------------------------------------------------------------------
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('NO_DATA_FOUND');
  END SET_CAMPOS_CAPITAL_SOCIAL_PR;
  --ECM 09 MARZO 2016
  PROCEDURE VERIFICAR_ESCRITURA_PR(P_ID_EMPRESA INTEGER
                                  ,P_ID_FLEX_TAB VARCHAR2
                                  ,P_ID_META_ROW VARCHAR2
                                  ,P_OUT_MSG      OUT VARCHAR2)
  IS
      psiNumEscritura NUMBER :=0;
  BEGIN
      BEGIN
          SELECT  COUNT(1)
          INTO    psiNumEscritura
          FROM    DERCORP_APODERADOS_TAB
          WHERE   1=1
          AND     ID_EMPRESA = P_ID_EMPRESA
          AND     DES_ESCRITURA = (
                                    SELECT DECODE(VAL_C8,NULL,(SELECT VAL_CAT_VAL FROM DERCORP_ADD_CAMPO_CAT_VAL_TAB WHERE ID_CATALOGO_VALOR = VAL_C1)||'-'||NVL(VAL_C3,'SF'),'N/A',(SELECT VAL_CAT_VAL FROM DERCORP_ADD_CAMPO_CAT_VAL_TAB WHERE ID_CATALOGO_VALOR = VAL_C1)||'-'||NVL(VAL_C3,'SF'),VAL_C8)
                                    FROM   DERCORP_METATBL_TAB
                                    WHERE  1=1
                                    AND    ID_META_ROW = P_ID_META_ROW
                                    AND    ID_FLEX_TBL = P_ID_FLEX_TAB
                                    AND    ID_EMPRESA  = P_ID_EMPRESA
          )
          ;
      EXCEPTION
          WHEN NO_DATA_FOUND THEN
              psiNumEscritura := 0;
          WHEN OTHERS THEN
              psiNumEscritura := 0;
      END;
      IF psiNumEscritura > 0 THEN
          P_OUT_MSG := 'Existe la escritura en grupos y/o poderes en la pesta??a de Apoderados.';
      ELSE
          DELETE FROM DERCORP_METATBL_TAB WHERE 1=1 AND ID_META_ROW = P_ID_META_ROW;
          P_OUT_MSG := 'OK';
      END IF;
  END VERIFICAR_ESCRITURA_PR;
  --ECM 26 MAYO 2016
  PROCEDURE GET_CHECK_CAP_FIJ_VAR_PR(pOutCapVar OUT INT
                                    ,pOutCapFij OUT INT
                                    ,pInIdEmp   IN INT)
  IS
  BEGIN
      --CHECKBOX
      SELECT  COUNT(*) INTO  pOutCapFij
      FROM    DERCORP_ADD_CAMPO_VALOR_TAB
      WHERE   1=1
      AND     ID_EMPRESA = pInIdEmp
      AND     ID_ADD_CAMPO = 1030
      ;
      --CHECKBOX
      SELECT  COUNT(*) INTO  pOutCapVar
      FROM    DERCORP_ADD_CAMPO_VALOR_TAB
      WHERE   1=1
      AND     ID_EMPRESA = pInIdEmp
      AND     ID_ADD_CAMPO = 1031
      ;
  END GET_CHECK_CAP_FIJ_VAR_PR;
END DERCORP_FLEXTAB_PKG;
/;
