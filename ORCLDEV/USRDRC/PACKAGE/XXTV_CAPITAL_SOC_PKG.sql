CREATE OR REPLACE NONEDITIONABLE PACKAGE "USRDRC"."XXTV_CAPITAL_SOC_PKG" AS
  /* TODO enter package declarations (types, exceptions, methods etc) here */
  PROCEDURE RECALCULAR_ESTRUCTURA_CS_PR( PARAM_ID_EMPRESA VARCHAR2
                                        ,piinIdMetaRow    NUMBER
  );
  FUNCTION HABILITAR_VALOR_CAPTURA_FN(PARAM_ID_EMPRESA VARCHAR2) RETURN NUMBER;
  FUNCTION FORMULA_TOTAL_FN(PARAM_ID_EMPRESA VARCHAR2) RETURN VARCHAR2;
  PROCEDURE GET_VARIABLES_PR(PARAM_ID_EMPRESA       VARCHAR2,
                              APLICA_CAP_FIJO       OUT NUMBER,
                              APLICA_CAP_VARIABLE   OUT NUMBER,
                              FORMATO_CAMPOS        OUT VARCHAR2,
                              TEXTO_CAP_FIJO        OUT VARCHAR2,
                              TEXTO_CAP_VARIABLE    OUT VARCHAR2,
                              TEXTO_TOTAL           OUT VARCHAR2,
                              HABILITAR_VALOR_CAPTURA OUT NUMBER,
                              ACCIONISTA            OUT VARCHAR2
                              );
  FUNCTION GET_COLUMNS_FN(pstIdEmpresa  VARCHAR2)
  RETURN VARCHAR2;
  PROCEDURE REFRESH_ACCIONES_ESC_PR(PARAM_ID_EMPRESA NUMBER);
  FUNCTION GET_TIPO_SOCIEDAD_FN(PARAM_ID_EMPRESA NUMBER) RETURN NUMBER;
  FUNCTION SOCIEDAD_FN(PARAM_ID_EMPRESA NUMBER) RETURN VARCHAR2;
END XXTV_CAPITAL_SOC_PKG;
/
CREATE OR REPLACE NONEDITIONABLE PACKAGE BODY "USRDRC"."XXTV_CAPITAL_SOC_PKG" AS
  /* TODO enter package declarations (types, exceptions, methods etc) here */
  PROCEDURE RECALCULAR_ESTRUCTURA_CS_PR( PARAM_ID_EMPRESA VARCHAR2
                                         ,piinIdMetaRow    NUMBER
  )
  AS
    var_Tab7_totalValorAcciones   number;
    var_AplicaCapitalFijo         number;
    var_AplicaCapitalVariable     number;
    var_formula                   varchar2(50);
    liValNominal                  NUMBER;
    liValTeoNom                   NUMBER;
    --ECM 26 Septiembre 2016 Captura - Estructura Capital Social -
    --Agregar valor de porcentaje cuando sea valor teorico nominal.
    liIdNominal NUMBER;
    liIdTeoricoNominal NUMBER;
    liIdNominal2      NUMBER;
  BEGIN
      BEGIN
          SELECT  VAL_VALOR
          INTO    liIdNominal
          FROM    DERCORP_ADD_CAMPO_VALOR_TAB
          WHERE   1=1
          AND     ID_ADD_CAMPO = 519
          AND     ID_EMPRESA = PARAM_ID_EMPRESA
          ;
      EXCEPTION
      WHEN NO_DATA_FOUND THEN
          liIdNominal := 0;
      END;
      BEGIN
          SELECT  VAL_VALOR
          INTO    liIdTeoricoNominal
          FROM    DERCORP_ADD_CAMPO_VALOR_TAB
          WHERE   1=1
          AND     ID_ADD_CAMPO = 1076
          AND     ID_EMPRESA = PARAM_ID_EMPRESA
          ;
      EXCEPTION
      WHEN NO_DATA_FOUND THEN
          liIdTeoricoNominal := 0;
      END;
      EXECUTE IMMEDIATE 'ALTER SESSION SET NLS_NUMERIC_CHARACTERS=''.,''';
      --CHECKBOX
      SELECT
        count(*) INTO  var_AplicaCapitalFijo
      FROM
        DERCORP_ADD_CAMPO_VALOR_TAB
      WHERE
        ID_EMPRESA = PARAM_ID_EMPRESA
        AND
        ID_ADD_CAMPO = 1030
      ;
      --CHECKBOX
      SELECT
        count(*) INTO  var_AplicaCapitalVariable
      FROM
        DERCORP_ADD_CAMPO_VALOR_TAB
      WHERE
        ID_EMPRESA = PARAM_ID_EMPRESA
        AND
        ID_ADD_CAMPO = 1031
      ;
      --
      -- NAVA - Issue: 9 3Nov
      --
      UPDATE DERCORP_METATBL_TAB SET
          VAL_C3 = REPLACE(VAL_C3, ',',''),
          VAL_C4 = REPLACE(VAL_C4, ',','')
      WHERE
          ID_EMPRESA = PARAM_ID_EMPRESA
        AND
          ID_FLEX_TBL = 7;
      var_formula := FORMULA_TOTAL_FN(PARAM_ID_EMPRESA);
      IF var_formula = 'ACF_ACV_VN' THEN
          --ECM 26 Septiembre 2016
          IF liIdNominal > 0 THEN
                /*SELECT
              (
                    SELECT  TO_NUMBER(REPLACE(REPLACE(VAL_CAT_VAL, '$', ''), ',', ''))
                    FROM    DERCORP_ADD_CAMPO_CAT_VAL_TAB
                    WHERE   1=1
                    AND     ID_CATALOGO = 9
                    AND     ID_CATALOGO_VALOR = VAL_VALOR
              )INTO   liValNominal
              FROM    DERCORP_ADD_CAMPO_VALOR_TAB
              WHERE   1=1
              AND     ID_EMPRESA = PARAM_ID_EMPRESA
              AND     ID_ADD_CAMPO = 1076
              ;*/
              --08-03-2018 JJAQ Y JAMS SE PONE PORQUE SALIA ERROR CUANDO SELECCIONABA EN VALOR NOMINAL LA OPCION SIN VALOR NOMINAL
              BEGIN
                    SELECT  TO_NUMBER(REPLACE(REPLACE(VAL_CAT_VAL, '$', ''), ',', '')) INTO liIdNominal2
                    FROM    DERCORP_ADD_CAMPO_CAT_VAL_TAB
                    WHERE   1=1
                    AND     ID_CATALOGO = 9
                    AND     ID_CATALOGO_VALOR = 11111;
              EXCEPTION
              WHEN OTHERS THEN
                    liIdNominal2 := -1;
                    liValNominal := 1;
             END;
             IF liIdNominal2 <> -1
             THEN
                   SELECT
                  (
                        SELECT  TO_NUMBER(REPLACE(REPLACE(VAL_CAT_VAL, '$', ''), ',', ''))
                        FROM    DERCORP_ADD_CAMPO_CAT_VAL_TAB
                        WHERE   1=1
                        AND     ID_CATALOGO = 9
                        AND     ID_CATALOGO_VALOR = VAL_VALOR
                  )INTO   liValNominal
                  FROM    DERCORP_ADD_CAMPO_VALOR_TAB
                  WHERE   1=1
                  AND     ID_EMPRESA = PARAM_ID_EMPRESA
                  AND     ID_ADD_CAMPO = 519
                  ;
              END IF;
          ELSE
          liValNominal:=1;
                /*--ECM 27 Octubre 2015
                SELECT
              (
                    SELECT  TO_NUMBER(REPLACE(REPLACE(VAL_CAT_VAL, '$', ''), ',', ''))
                    FROM    DERCORP_ADD_CAMPO_CAT_VAL_TAB
                    WHERE   1=1
                    AND     ID_CATALOGO = 9
                    AND     ID_CATALOGO_VALOR = VAL_VALOR
              )INTO   liValNominal
              FROM    DERCORP_ADD_CAMPO_VALOR_TAB
              WHERE   1=1
              AND     ID_EMPRESA = PARAM_ID_EMPRESA
              AND     ID_ADD_CAMPO = 519
              ;*/
         END IF;
        --Valor Acciones
        --   = (Acciones Capital Fijo + Acciones Capital Variable) * Valor Nominal
        UPDATE DERCORP_METATBL_TAB
        SET    VAL_C6 =
        (TO_NUMBER(NVL(VAL_C3, 0)) + TO_NUMBER(NVL(VAL_C4, 0))) * liValNominal
        WHERE  1=1
        AND ID_EMPRESA = PARAM_ID_EMPRESA
        AND ID_FLEX_TBL = 7
        AND ID_META_ROW = piinIdMetaRow
        ;
      END IF;
      IF var_formula = 'ACF_ACV' THEN
          --Valor Acciones
          --   = (Acciones Capital Fijo + Acciones Capital Variable)
          UPDATE DERCORP_METATBL_TAB
          SET    VAL_C6 = (TO_NUMBER(NVL(VAL_C3, 0)) + TO_NUMBER(NVL(VAL_C4, 0)))
          WHERE  1=1
          AND    ID_EMPRESA = PARAM_ID_EMPRESA
          AND    ID_FLEX_TBL = 7
          AND    ID_META_ROW = piinIdMetaRow
          ;
      END IF;
      SELECT
        SUM(TO_NUMBER(VAL_C6)) INTO var_Tab7_totalValorAcciones
      FROM
        DERCORP_METATBL_TAB
      WHERE
        ID_EMPRESA = PARAM_ID_EMPRESA
      AND
        ID_FLEX_TBL = 7;
      -- %
      IF var_Tab7_totalValorAcciones <> 0 THEN
            UPDATE DERCORP_METATBL_TAB SET
                VAL_C5 =
                  ROUND((TO_NUMBER(VAL_C6) / var_Tab7_totalValorAcciones * 100),7)
            WHERE
              ID_EMPRESA = PARAM_ID_EMPRESA
            AND
              ID_FLEX_TBL = 7;
      ELSE
            UPDATE DERCORP_METATBL_TAB SET
                VAL_C5 = '0'
            WHERE
              ID_EMPRESA = PARAM_ID_EMPRESA
            AND
              ID_FLEX_TBL = 7;
      END IF;
  END RECALCULAR_ESTRUCTURA_CS_PR;
  FUNCTION HABILITAR_VALOR_CAPTURA_FN(PARAM_ID_EMPRESA VARCHAR2) RETURN NUMBER
  AS
    linCountRespLimitada    NUMBER;
    linSinExpresionNominal  NUMBER;
    linCountAplicaCapital   NUMBER;
  BEGIN
        /*
        SELECT
          COUNT(*) INTO linCountRespLimitada
        FROM
          DERCORP_ADD_CAMPO_VALOR_TAB EMP
          INNER JOIN DERCORP_ADD_CAMPO_CAT_VAL_TAB CAT
                ON TO_NUMBER(EMP.VAL_VALOR) = TO_NUMBER(CAT.ID_CATALOGO_VALOR)
        WHERE
          EMP.ID_EMPRESA = PARAM_ID_EMPRESA
          AND
          EMP.ID_ADD_CAMPO = 517
          AND
          UPPER(CAT.NOM_CAT_VAL) LIKE '%RESPONSABILIDAD%LIMITADA%';
        SELECT
          COUNT(*) INTO linSinExpresionNominal
        FROM
          DERCORP_ADD_CAMPO_VALOR_TAB EMP
          INNER JOIN DERCORP_ADD_CAMPO_CAT_VAL_TAB CAT
                ON TO_NUMBER(EMP.VAL_VALOR) = TO_NUMBER(CAT.ID_CATALOGO_VALOR)
        WHERE
          EMP.ID_EMPRESA = PARAM_ID_EMPRESA
          AND
          EMP.ID_ADD_CAMPO = 519
          AND
          UPPER(CAT.NOM_CAT_VAL) LIKE '%SIN%EXPRES%NOMINAL';
        */
        SELECT
          COUNT(*) INTO linCountAplicaCapital
        FROM DERCORP_ADD_CAMPO_VALOR_TAB
        WHERE
          ID_EMPRESA = PARAM_ID_EMPRESA
          AND
          (
            ID_ADD_CAMPO = 1030 -- Aplica Capital Fijo
            OR
            ID_ADD_CAMPO = 1031 -- Aplica Capital Variable
          );
        /*
        IF linCountRespLimitada <> 0 THEN
            RETURN 1;
        END IF;
        IF linSinExpresionNominal <> 0 THEN
            RETURN 1;
        END IF;
        */
         IF linCountAplicaCapital = 0 THEN
            RETURN 1;
        END IF;
        RETURN 0;
  END HABILITAR_VALOR_CAPTURA_FN;
  FUNCTION FORMULA_TOTAL_FN(PARAM_ID_EMPRESA VARCHAR2) RETURN VARCHAR2
  AS
    linCountRespLimitada    NUMBER;
    linSinExpresionNominal  NUMBER;
    linCountAplicaCapital   NUMBER;
  BEGIN
        SELECT
          COUNT(*) INTO linCountRespLimitada
        FROM
          DERCORP_ADD_CAMPO_VALOR_TAB EMP
          INNER JOIN DERCORP_ADD_CAMPO_CAT_VAL_TAB CAT
                ON TO_NUMBER(EMP.VAL_VALOR) = TO_NUMBER(CAT.ID_CATALOGO_VALOR)
        WHERE
          EMP.ID_EMPRESA = PARAM_ID_EMPRESA
          AND
          EMP.ID_ADD_CAMPO = 517
          AND
          UPPER(CAT.NOM_CAT_VAL) LIKE '%RESPONSABILIDAD%LIMITADA%';
        SELECT
          COUNT(*) INTO linSinExpresionNominal
        FROM
          DERCORP_ADD_CAMPO_VALOR_TAB EMP
          INNER JOIN DERCORP_ADD_CAMPO_CAT_VAL_TAB CAT
                ON TO_NUMBER(EMP.VAL_VALOR) = TO_NUMBER(CAT.ID_CATALOGO_VALOR)
        WHERE
          EMP.ID_EMPRESA = PARAM_ID_EMPRESA
          AND
          EMP.ID_ADD_CAMPO = 519
          AND
          (UPPER(CAT.NOM_CAT_VAL) LIKE '%SIN%EXPRES%NOMINAL'
          OR
          UPPER(CAT.NOM_CAT_VAL) LIKE '%VALOR%DESIGUAL%'
          OR
          UPPER(CAT.NOM_CAT_VAL) LIKE '%N/A%'
          )
          ;
        SELECT
          COUNT(*) INTO linCountAplicaCapital
        FROM DERCORP_ADD_CAMPO_VALOR_TAB
        WHERE
          ID_EMPRESA = PARAM_ID_EMPRESA
          AND
          (
            ID_ADD_CAMPO = 1030 -- Aplica Capital Fijo
            OR
            ID_ADD_CAMPO = 1031 -- Aplica Capital Variable
          );
         IF linCountAplicaCapital = 0 THEN
            RETURN 'NO_APLICA';
        END IF;
        IF linCountRespLimitada <> 0 THEN
            RETURN 'ACF_ACV';
        END IF;
        IF linSinExpresionNominal <> 0 THEN
            RETURN 'ACF_ACV';
            --RETURN 'ValorTeoricoNominal';
        END IF;
        RETURN 'ACF_ACV_VN';
  END FORMULA_TOTAL_FN;
  PROCEDURE GET_VARIABLES_PR(PARAM_ID_EMPRESA       VARCHAR2,
                              APLICA_CAP_FIJO       OUT NUMBER,
                              APLICA_CAP_VARIABLE   OUT NUMBER,
                              FORMATO_CAMPOS        OUT VARCHAR2,
                              TEXTO_CAP_FIJO        OUT VARCHAR2,
                              TEXTO_CAP_VARIABLE    OUT VARCHAR2,
                              TEXTO_TOTAL           OUT VARCHAR2,
                              HABILITAR_VALOR_CAPTURA OUT NUMBER,
                              ACCIONISTA            OUT VARCHAR2
                              )
  AS
    linCountRespLimitada       NUMBER;
    linSinExpresionNominal     NUMBER;
    linCountAplicaCapFijo      NUMBER;
    linCountAplicaCapVariab    NUMBER;
    linCountAsociacionCivil    NUMBER;
    liSociedadCivil            NUMBER;
    liAsociacionCivil          NUMBER;
    linCountRespLimitadaNvo    NUMBER;--JJAQ 20/02/2017 Se agrega nueva Sociedad
    linCountSA                 NUMBER;--JJAQ 20/02/2017 cAMBIAR NOMBRE COLUMNA DE LAS S.A
    linCountSAB                NUMBER;
    linCountSABdeCV            NUMBER;
    linCountLLC                NUMBER;
    linCountSLU                NUMBER;
    linCountLTD                NUMBER;
    linCountSAU                NUMBER;
    linCountNPC                NUMBER;
    linCountSL                 NUMBER;
    linCountSAC                NUMBER;
  BEGIN
        SELECT
          COUNT(*) INTO linCountRespLimitada
        FROM
          DERCORP_ADD_CAMPO_VALOR_TAB EMP
          INNER JOIN DERCORP_ADD_CAMPO_CAT_VAL_TAB CAT
                ON TO_NUMBER(EMP.VAL_VALOR) = TO_NUMBER(CAT.ID_CATALOGO_VALOR)
        WHERE
          EMP.ID_EMPRESA = PARAM_ID_EMPRESA
          AND
          EMP.ID_ADD_CAMPO = 517
          AND
          UPPER(CAT.NOM_CAT_VAL) LIKE '%RESPONSABILIDAD%LIMITADA%';
        SELECT
          COUNT(*) INTO linCountRespLimitadaNvo
        FROM
          DERCORP_ADD_CAMPO_VALOR_TAB EMP
          INNER JOIN DERCORP_ADD_CAMPO_CAT_VAL_TAB CAT
                ON TO_NUMBER(EMP.VAL_VALOR) = TO_NUMBER(CAT.ID_CATALOGO_VALOR)
        WHERE
          EMP.ID_EMPRESA = PARAM_ID_EMPRESA
          AND
          EMP.ID_ADD_CAMPO = 517
          AND
          UPPER(CAT.NOM_CAT_VAL) LIKE '%RESPONSABILIDAD%LIMITADA';
      SELECT
          COUNT(*)INTO liAsociacionCivil
        FROM
          DERCORP_ADD_CAMPO_VALOR_TAB EMP
          INNER JOIN DERCORP_ADD_CAMPO_CAT_VAL_TAB CAT
                ON TO_NUMBER(EMP.VAL_VALOR) = TO_NUMBER(CAT.ID_CATALOGO_VALOR)
        WHERE
          EMP.ID_EMPRESA = PARAM_ID_EMPRESA
          AND
          EMP.ID_ADD_CAMPO = 517
          AND
          UPPER(CAT.NOM_CAT_VAL) LIKE '%ASOCIACION%CIVIL%';
      SELECT
          COUNT(*)INTO linCountSA
        FROM
          DERCORP_ADD_CAMPO_VALOR_TAB EMP
          INNER JOIN DERCORP_ADD_CAMPO_CAT_VAL_TAB CAT
                ON TO_NUMBER(EMP.VAL_VALOR) = TO_NUMBER(CAT.ID_CATALOGO_VALOR)
        WHERE
          EMP.ID_EMPRESA = PARAM_ID_EMPRESA
          AND
          EMP.ID_ADD_CAMPO = 517
          AND
          UPPER(CAT.NOM_CAT_VAL) LIKE '%SOCIEDAD%ANONIMA';
          SELECT
          COUNT(*)INTO linCountSL
        FROM
          DERCORP_ADD_CAMPO_VALOR_TAB EMP
          INNER JOIN DERCORP_ADD_CAMPO_CAT_VAL_TAB CAT
                ON TO_NUMBER(EMP.VAL_VALOR) = TO_NUMBER(CAT.ID_CATALOGO_VALOR)
        WHERE
          EMP.ID_EMPRESA = PARAM_ID_EMPRESA
          AND
          EMP.ID_ADD_CAMPO = 517
          AND
          UPPER(CAT.NOM_CAT_VAL) LIKE '%SOCIEDA%LIMITADA';
        SELECT
          COUNT(*)INTO linCountSABdeCV
        FROM
          DERCORP_ADD_CAMPO_VALOR_TAB EMP
          INNER JOIN DERCORP_ADD_CAMPO_CAT_VAL_TAB CAT
                ON TO_NUMBER(EMP.VAL_VALOR) = TO_NUMBER(CAT.ID_CATALOGO_VALOR)
        WHERE
          EMP.ID_EMPRESA = PARAM_ID_EMPRESA
          AND
          EMP.ID_ADD_CAMPO = 517
          AND
          UPPER(CAT.NOM_CAT_VAL) LIKE '%SOCIEDAD%ANONIMA%BURSATIL%DE%CAPITAL%VARIABLE%';
        SELECT
          COUNT(*)INTO linCountSAB
        FROM
          DERCORP_ADD_CAMPO_VALOR_TAB EMP
          INNER JOIN DERCORP_ADD_CAMPO_CAT_VAL_TAB CAT
                ON TO_NUMBER(EMP.VAL_VALOR) = TO_NUMBER(CAT.ID_CATALOGO_VALOR)
        WHERE
          EMP.ID_EMPRESA = PARAM_ID_EMPRESA
          AND
          EMP.ID_ADD_CAMPO = 517
          AND
          UPPER(CAT.NOM_CAT_VAL) LIKE '%SOCIEDAD%ANONIMA%BURSATIL%';
        SELECT
          COUNT(*) INTO linSinExpresionNominal
        FROM
          DERCORP_ADD_CAMPO_VALOR_TAB EMP
          INNER JOIN DERCORP_ADD_CAMPO_CAT_VAL_TAB CAT
                ON TO_NUMBER(EMP.VAL_VALOR) = TO_NUMBER(CAT.ID_CATALOGO_VALOR)
        WHERE
          EMP.ID_EMPRESA = PARAM_ID_EMPRESA
          AND
          EMP.ID_ADD_CAMPO = 519
          AND
          (UPPER(CAT.NOM_CAT_VAL) LIKE '%SIN%EXPRES%NOMINAL'
          OR
          UPPER(CAT.NOM_CAT_VAL) LIKE '%VALOR%DESIGUAL%'
          OR
          UPPER(CAT.NOM_CAT_VAL) LIKE '%N/A'
          );
        SELECT
          COUNT(*) INTO linCountAplicaCapFijo
        FROM DERCORP_ADD_CAMPO_VALOR_TAB
        WHERE
          ID_EMPRESA = PARAM_ID_EMPRESA
          AND
          (
            ID_ADD_CAMPO = 1030 -- Aplica Capital Fijo
          );
        SELECT
          COUNT(*) INTO linCountAplicaCapVariab
        FROM DERCORP_ADD_CAMPO_VALOR_TAB
        WHERE
          ID_EMPRESA = PARAM_ID_EMPRESA
          AND
          (
            ID_ADD_CAMPO = 1031 -- Aplica Capital Variable
          );
        -- KAZ-NAVA-26Oct
        SELECT
          COUNT(*) INTO linCountAsociacionCivil
        FROM
          DERCORP_ADD_CAMPO_VALOR_TAB EMP
          INNER JOIN DERCORP_ADD_CAMPO_CAT_VAL_TAB CAT
                ON TO_NUMBER(EMP.VAL_VALOR) = TO_NUMBER(CAT.ID_CATALOGO_VALOR)
        WHERE
          EMP.ID_EMPRESA = PARAM_ID_EMPRESA
          AND
          EMP.ID_ADD_CAMPO = 517
          AND
          UPPER(CAT.NOM_CAT_VAL) LIKE '%ASOCIACI%CIVIL%';
          --ECM 26 MAYO 2016
        SELECT  COUNT(*) INTO liSociedadCivil
        FROM    DERCORP_ADD_CAMPO_VALOR_TAB EMP
                INNER JOIN DERCORP_ADD_CAMPO_CAT_VAL_TAB CAT
                ON TO_NUMBER(EMP.VAL_VALOR) = TO_NUMBER(CAT.ID_CATALOGO_VALOR)
        WHERE   1=1
        AND     EMP.ID_EMPRESA = PARAM_ID_EMPRESA
        AND     EMP.ID_ADD_CAMPO = 517
        AND     UPPER(CAT.NOM_CAT_VAL) LIKE '%SOCIEDAD%CIVIL%'
        ;
        SELECT  COUNT(*) INTO linCountLLC
        FROM    DERCORP_ADD_CAMPO_VALOR_TAB EMP
                INNER JOIN DERCORP_ADD_CAMPO_CAT_VAL_TAB CAT
                ON TO_NUMBER(EMP.VAL_VALOR) = TO_NUMBER(CAT.ID_CATALOGO_VALOR)
        WHERE   1=1
        AND     EMP.ID_EMPRESA = PARAM_ID_EMPRESA
        AND     EMP.ID_ADD_CAMPO = 517
        AND     UPPER(CAT.NOM_CAT_VAL) LIKE '%LIMITED%LIABILITY%COMPANY%'
        ;
        SELECT  COUNT(*) INTO linCountSLU
        FROM    DERCORP_ADD_CAMPO_VALOR_TAB EMP
                INNER JOIN DERCORP_ADD_CAMPO_CAT_VAL_TAB CAT
                ON TO_NUMBER(EMP.VAL_VALOR) = TO_NUMBER(CAT.ID_CATALOGO_VALOR)
        WHERE   1=1
        AND     EMP.ID_EMPRESA = PARAM_ID_EMPRESA
        AND     EMP.ID_ADD_CAMPO = 517
        AND     UPPER(CAT.NOM_CAT_VAL) LIKE '%SOCIEDAD%LIMITADA%UNIPERSONAL%'
        ;
        SELECT  COUNT(*) INTO linCountSAC
        FROM    DERCORP_ADD_CAMPO_VALOR_TAB EMP
                INNER JOIN DERCORP_ADD_CAMPO_CAT_VAL_TAB CAT
                ON TO_NUMBER(EMP.VAL_VALOR) = TO_NUMBER(CAT.ID_CATALOGO_VALOR)
        WHERE   1=1
        AND     EMP.ID_EMPRESA = PARAM_ID_EMPRESA
        AND     EMP.ID_ADD_CAMPO = 517
        AND     UPPER(CAT.NOM_CAT_VAL) LIKE '%SOCIEDAD%AN%CERRADA%'
        ;
        SELECT  COUNT(*) INTO linCountLTD
        FROM    DERCORP_ADD_CAMPO_VALOR_TAB EMP
                INNER JOIN DERCORP_ADD_CAMPO_CAT_VAL_TAB CAT
                ON TO_NUMBER(EMP.VAL_VALOR) = TO_NUMBER(CAT.ID_CATALOGO_VALOR)
        WHERE   1=1
        AND     EMP.ID_EMPRESA = PARAM_ID_EMPRESA
        AND     EMP.ID_ADD_CAMPO = 517
        AND     UPPER(CAT.NOM_CAT_VAL) LIKE '%LIMITED'
        ;
        SELECT  COUNT(*) INTO linCountSAU
        FROM    DERCORP_ADD_CAMPO_VALOR_TAB EMP
                INNER JOIN DERCORP_ADD_CAMPO_CAT_VAL_TAB CAT
                ON TO_NUMBER(EMP.VAL_VALOR) = TO_NUMBER(CAT.ID_CATALOGO_VALOR)
        WHERE   1=1
        AND     EMP.ID_EMPRESA = PARAM_ID_EMPRESA
        AND     EMP.ID_ADD_CAMPO = 517
        AND     UPPER(CAT.NOM_CAT_VAL) LIKE '%SOCIEDAD%AN%UNIPERSONAL%'
        ;
        SELECT  COUNT(*) INTO linCountNPC
        FROM    DERCORP_ADD_CAMPO_VALOR_TAB EMP
                INNER JOIN DERCORP_ADD_CAMPO_CAT_VAL_TAB CAT
                ON TO_NUMBER(EMP.VAL_VALOR) = TO_NUMBER(CAT.ID_CATALOGO_VALOR)
        WHERE   1=1
        AND     EMP.ID_EMPRESA = PARAM_ID_EMPRESA
        AND     EMP.ID_ADD_CAMPO = 517
        AND     UPPER(CAT.NOM_CAT_VAL) LIKE '%NOT%FOR%PROFIT%CORPORATION%'
        ;
        APLICA_CAP_FIJO     := linCountAplicaCapFijo;
        APLICA_CAP_VARIABLE := linCountAplicaCapVariab;
        IF linCountAplicaCapFijo = 0 AND linCountAplicaCapVariab = 0  THEN
            HABILITAR_VALOR_CAPTURA := 1;
        ELSE
            HABILITAR_VALOR_CAPTURA := 0;
        END IF;
        IF linCountRespLimitada <> 0 OR linSinExpresionNominal <> 0 THEN
          FORMATO_CAMPOS := 'NUMBER';
        ELSE
          FORMATO_CAMPOS := 'INTEGER';
        END IF;
        /*ECM 05 Junio 2016*/
        IF linCountRespLimitada <> 0 OR linSinExpresionNominal = 1 THEN
          FORMATO_CAMPOS := 'INTEGER';
        END IF;
        IF linCountRespLimitada <> 0  THEN
          TEXTO_CAP_FIJO     := 'Valor Acciones </br> Capital Fijo';
          TEXTO_CAP_VARIABLE := 'Valor Acciones </br> Capital Variable';
          TEXTO_TOTAL := 'Valor';
        ELSE
           IF linCountSA > 0
           THEN
              TEXTO_CAP_FIJO     := 'Acciones';
           ELSE
              TEXTO_CAP_FIJO     := 'Acciones </br> Capital Fijo';
           END IF;
          TEXTO_CAP_VARIABLE := 'Acciones </br> Capital Variable';
          TEXTO_TOTAL := 'Total';
        END IF;
        IF linSinExpresionNominal <> 0 THEN--JJAQ PARA NO MOSTRAR EN EMPRESAS AC
          IF linCountSA > 0 THEN
              TEXTO_CAP_FIJO     := 'Acciones';
           ELSIF linCountSAB > 0 THEN
              TEXTO_CAP_FIJO     := 'Acciones';
           ELSE
              TEXTO_CAP_FIJO     := 'Acciones </br> Capital Fijo';
           END IF;
          TEXTO_CAP_VARIABLE := 'Acciones </br> Capital Variable';
          TEXTO_TOTAL := 'Total';
        END IF;
        --ECM 31 AGOSTO 2015
        IF linCountRespLimitada = 0 AND linSinExpresionNominal = 0 THEN
            TEXTO_TOTAL := 'Valor';
        END IF;
        --ECM 01 Septiembre 2015
        IF linCountRespLimitada = 1 THEN
            ACCIONISTA          := 'Socios';
            --Se agrega IF para cambiar titulo en las sociedad de SRLCV y SRL nueva
            IF linCountRespLimitadaNvo > 0
            THEN
              --'Partes Sociales Capital Fijo';
              TEXTO_CAP_FIJO      := 'Valor Parte Social';
            ELSE
              TEXTO_CAP_FIJO      := 'Valor Parte Social Capital Fijo';
            END IF;
            TEXTO_CAP_VARIABLE  := 'Valor Parte Social Capital Variable';--'Partes Sociales Capital Variable';
            --TEXTO_TOTAL         := 'Total Partes Sociales';
            TEXTO_TOTAL         := 'Valor Total Partes Sociales';
            FORMATO_CAMPOS := 'AMOUNT'; -- KAZ-NAVA 26-Oct-15
        ELSE
        IF linCountRespLimitada = 0 THEN
              IF liSociedadCivil >= 1 -- VIRI 02/12/2016
                THEN
                     ACCIONISTA          := 'Socios';
                     FORMATO_CAMPOS := 'INTEGER';
                ELSE
                     ACCIONISTA          := 'Accionistas';
              END IF;
             -- FORMATO_CAMPOS := 'AMOUNT_SC';
        END IF;
      END IF;
        IF linCountAsociacionCivil = 1 THEN
          ACCIONISTA          := 'Asociados';
        END IF;
        --ECM 26 MAYO 2016
        --IF liSociedadCivil >= 1 AND linSinExpresionNominal >=1 THEN
        IF liSociedadCivil >= 1 THEN
            TEXTO_TOTAL         := 'Valor Total Partes Sociales';
        END IF;
        ----****INICIA Limited Liability Company LLC JJAQ 12/04/2017 Inicio ----
        IF linCountLLC > 0
        THEN
            IF linSinExpresionNominal >= 0
            THEN
              FORMATO_CAMPOS := 'INTEGER';
            END IF;
            TEXTO_TOTAL         := 'Participations';
            ACCIONISTA          := 'Members';
            TEXTO_CAP_FIJO      := 'Quota';
        END IF;
        --termina
        --****INICIA SOCIEDAD lIMITADA UNIPERSONAL JJAQ 12/04/2017
        IF linCountSLU > 0
            THEN
                IF linSinExpresionNominal >= 0
                THEN
                  FORMATO_CAMPOS := 'INTEGER';
                END IF;
                TEXTO_TOTAL         := 'Valor';
                ACCIONISTA          := 'Socios';
                TEXTO_CAP_FIJO      := 'Participaciones';
        END IF;
        --FIN
        --****INICIA SOCIEDAD ANONIMA CERRADA JJAQ 12/04/2017
        IF linCountSAC > 0
        THEN
            IF linSinExpresionNominal >= 0
            THEN
              FORMATO_CAMPOS := 'INTEGER';
            END IF;
            TEXTO_TOTAL         := 'Valor';
            ACCIONISTA          := 'Accionistas';
            TEXTO_CAP_FIJO      := 'Acciones';
        END IF;
        --****FIN
        --****INICIA SOCIEDAD ANONIMA UNIPERSONAL JJAQ 12/04/2017
        IF linCountLTD > 0
            THEN
                IF linSinExpresionNominal >= 0
                THEN
                  FORMATO_CAMPOS := 'INTEGER';
                END IF;
                TEXTO_TOTAL         := 'Value';
                ACCIONISTA          := 'Shareholders';
                TEXTO_CAP_FIJO      := 'Shares';
            END IF;
        --****FIN  JJAQ 12/04/2017
        --****INICIA SOCIEDAD ANONIMA UNIPERSONAL JJAQ 12/04/2017
        IF linCountSAU > 0
            THEN
                IF linSinExpresionNominal >= 0
                THEN
                  FORMATO_CAMPOS := 'INTEGER';
                END IF;
                TEXTO_TOTAL         := 'Valor';
                ACCIONISTA          := 'Accionista';
                TEXTO_CAP_FIJO      := 'Acciones';
            END IF;
        --****FIN  JJAQ 12/04/2017
        --****INICIA SOCIEDAD lIMITADA JJAQ 12/04/2017
        IF linCountSL > 0
            THEN
                IF linSinExpresionNominal >= 0
                THEN
                  FORMATO_CAMPOS := 'INTEGER';
                END IF;
                TEXTO_TOTAL         := 'Valor';
                ACCIONISTA          := 'Socios';
                TEXTO_CAP_FIJO      := 'Participaciones';
        END IF;
        --FIN
        IF linCountNPC > 0 THEN
          ACCIONISTA          := 'Members';
          --FORMATO_CAMPOS := 'AMOUNT';
        END IF;
  END GET_VARIABLES_PR;
  FUNCTION GET_COLUMNS_FN(pstIdEmpresa  VARCHAR2)
  RETURN VARCHAR2
  IS
    linCountRespLimitada    NUMBER;
    linSinExpresionNominal  NUMBER;
    linCountAplicaCapFijo   NUMBER;
    linCountAplicaCapVariab NUMBER;
    APLICA_CAP_FIJO         NUMBER;
    APLICA_CAP_VARIABLE     NUMBER;
    FORMATO_CAMPOS          VARCHAR2 (1000);
    TEXTO_CAP_FIJO          VARCHAR2 (1000);
    TEXTO_CAP_VARIABLE      VARCHAR2 (1000);
    TEXTO_TOTAL             VARCHAR2 (1000);
    HABILITAR_VALOR_CAPTURA NUMBER;
    ACCIONISTA              VARCHAR2 (1000);
    linCountSA              NUMBER;--JJAQ 20/02/2017 cAMBIAR NOMBRE COLUMNA DE LAS S.A
  BEGIN
    SELECT
          COUNT(*) INTO linCountRespLimitada
        FROM
          DERCORP_ADD_CAMPO_VALOR_TAB EMP
          INNER JOIN DERCORP_ADD_CAMPO_CAT_VAL_TAB CAT
                ON TO_NUMBER(EMP.VAL_VALOR) = TO_NUMBER(CAT.ID_CATALOGO_VALOR)
        WHERE
          EMP.ID_EMPRESA = pstIdEmpresa
          AND
          EMP.ID_ADD_CAMPO = 517
          AND
          UPPER(CAT.NOM_CAT_VAL) LIKE '%RESPONSABILIDAD%LIMITADA%';
     SELECT
          COUNT(*)INTO linCountSA
        FROM
          DERCORP_ADD_CAMPO_VALOR_TAB EMP
          INNER JOIN DERCORP_ADD_CAMPO_CAT_VAL_TAB CAT
                ON TO_NUMBER(EMP.VAL_VALOR) = TO_NUMBER(CAT.ID_CATALOGO_VALOR)
        WHERE
          EMP.ID_EMPRESA = pstIdEmpresa
          AND
          EMP.ID_ADD_CAMPO = 517
          AND
          UPPER(CAT.NOM_CAT_VAL) LIKE '%SOCIEDAD%ANONIMA';
        SELECT
          COUNT(*) INTO linSinExpresionNominal
        FROM
          DERCORP_ADD_CAMPO_VALOR_TAB EMP
          INNER JOIN DERCORP_ADD_CAMPO_CAT_VAL_TAB CAT
                ON TO_NUMBER(EMP.VAL_VALOR) = TO_NUMBER(CAT.ID_CATALOGO_VALOR)
        WHERE
          EMP.ID_EMPRESA = pstIdEmpresa
          AND
          EMP.ID_ADD_CAMPO = 519
          AND
          (UPPER(CAT.NOM_CAT_VAL) LIKE '%SIN%EXPRES%NOMINAL'
          OR
          UPPER(CAT.NOM_CAT_VAL) LIKE '%VALOR%DESIGUAL%'
          )
          ;
        SELECT
          COUNT(*) INTO linCountAplicaCapFijo
        FROM DERCORP_ADD_CAMPO_VALOR_TAB
        WHERE
          ID_EMPRESA = pstIdEmpresa
          AND
          (
            ID_ADD_CAMPO = 1030 -- Aplica Capital Fijo
          );
        SELECT
          COUNT(*) INTO linCountAplicaCapVariab
        FROM DERCORP_ADD_CAMPO_VALOR_TAB
        WHERE
          ID_EMPRESA = pstIdEmpresa
          AND
          (
            ID_ADD_CAMPO = 1031 -- Aplica Capital Variable
          );
        APLICA_CAP_FIJO     := linCountAplicaCapFijo;
        APLICA_CAP_VARIABLE := linCountAplicaCapVariab;
        IF linCountAplicaCapFijo = 0 AND linCountAplicaCapVariab = 0  THEN
            HABILITAR_VALOR_CAPTURA := 1;
        ELSE
            HABILITAR_VALOR_CAPTURA := 0;
        END IF;
        IF linCountRespLimitada <> 0 OR linSinExpresionNominal <> 0 THEN
          FORMATO_CAMPOS := 'NUMBER';
        ELSE
          FORMATO_CAMPOS := 'INTEGER';
        END IF;
        IF linCountRespLimitada <> 0  THEN
          TEXTO_CAP_FIJO     := 'Valor Acciones </br> Capital Fijo';
          TEXTO_CAP_VARIABLE := 'Valor Acciones </br> Capital Variable';
          TEXTO_TOTAL := 'Valor';
        ELSE
          IF linCountSA > 0
           THEN
              TEXTO_CAP_FIJO     := 'Acciones';
           ELSE
              TEXTO_CAP_FIJO     := 'Acciones </br> Capital Fijo';
           END IF;
          TEXTO_CAP_VARIABLE := 'Acciones </br> Capital Variable';
          TEXTO_TOTAL := 'Total';
        END IF;
        IF linSinExpresionNominal <> 0 THEN
          IF linCountSA > 0
           THEN
              TEXTO_CAP_FIJO     := 'Acciones';
           ELSE
              TEXTO_CAP_FIJO     := 'Acciones </br> Capital Fijo';
           END IF;
          TEXTO_CAP_VARIABLE := 'Acciones  </br> Capital Variable';
          TEXTO_TOTAL := 'Total';
        END IF;
        --ECM 31 AGOSTO 2015
        IF linCountRespLimitada = 0 AND linSinExpresionNominal = 0 THEN
            TEXTO_TOTAL := 'Valor';
        END IF;
        --ECM 01 Septiembre 2015
        IF linCountRespLimitada = 1 THEN
            ACCIONISTA          := 'Socios';
            TEXTO_CAP_FIJO      := 'Partes Sociales Capital Fijo';
            TEXTO_CAP_VARIABLE  := 'Partes Sociales Capital Variable';
            TEXTO_TOTAL         := 'Total Partes Sociales';
        ELSIF linCountRespLimitada = 0 THEN
            ACCIONISTA          := 'Accionistas';
        END IF;
    RETURN ACCIONISTA||'|'||TEXTO_CAP_FIJO||'|'||TEXTO_CAP_VARIABLE||'|'||TEXTO_TOTAL;
  END;
  PROCEDURE REFRESH_ACCIONES_ESC_PR(PARAM_ID_EMPRESA NUMBER)
  AS
  var_formula                   VARCHAR2(150);
  liValNominal                  NUMBER;
    liValTeoNom                   NUMBER;
  liIdNominal                   NUMBER;
  liIdTeoricoNominal            NUMBER;
  lstOutmsg                     VARCHAR2(4000);
  --Cursor para hacer la iteracion de cada fila
  CURSOR  GET_VAL_ROWS_CUR(PARAM_ID_EMPRESA_CR  NUMBER)
      IS
      SELECT OUTER_Q.*,
         (select count(*)
          FROM DERCORP_METATBL_TAB INNER_Q
          WHERE INNER_Q.ID_EMPRESA = OUTER_Q.ID_EMPRESA
          AND INNER_Q.ID_FLEX_TBL = OUTER_Q.ID_FLEX_TBL
          AND INNER_Q.VAL_C8 = OUTER_Q.VAL_C8) COUNT_GRP
      FROM DERCORP_METATBL_TAB OUTER_Q
      WHERE OUTER_Q.ID_EMPRESA = PARAM_ID_EMPRESA_CR
      AND OUTER_Q.ID_FLEX_TBL = 7
      ORDER BY OUTER_Q.VAL_C8, OUTER_Q.ID_META_ROW
      ;
      BEGIN
        BEGIN
                  SELECT  VAL_VALOR
                  INTO    liIdNominal
                  FROM    DERCORP_ADD_CAMPO_VALOR_TAB
                  WHERE   1=1
                  AND     ID_ADD_CAMPO = 519
                  AND     ID_EMPRESA = PARAM_ID_EMPRESA
                  ;
              EXCEPTION
              WHEN NO_DATA_FOUND THEN
                  liIdNominal := 0;
        END;
        BEGIN
                    /*SELECT  VAL_VALOR
                    INTO    liIdTeoricoNominal
                    FROM    DERCORP_ADD_CAMPO_VALOR_TAB
                    WHERE   1=1
                    AND     ID_ADD_CAMPO = 1076
                    AND     ID_EMPRESA = PARAM_ID_EMPRESA
                    ;
                EXCEPTION
                WHEN NO_DATA_FOUND THEN*/
                    liIdTeoricoNominal := 0;
        END;
    FOR i IN GET_VAL_ROWS_CUR(PARAM_ID_EMPRESA)
    LOOP
/*
          UPDATE DERCORP_METATBL_TAB SET
              VAL_C3 = REPLACE(VAL_C3, ',',''),
              VAL_C4 = REPLACE(VAL_C4, ',','')
          WHERE
              ID_EMPRESA = PARAM_ID_EMPRESA
            AND
              ID_FLEX_TBL = 7;
*/
        var_formula := FORMULA_TOTAL_FN(PARAM_ID_EMPRESA);
          IF var_formula = 'ACF_ACV_VN' THEN
              --ECM 26 Septiembre 2016
              IF liIdNominal > 0 THEN
                  /*  SELECT
                  (
                        SELECT  TO_NUMBER(REPLACE(REPLACE(VAL_CAT_VAL, '$', ''), ',', ''))
                        FROM    DERCORP_ADD_CAMPO_CAT_VAL_TAB
                        WHERE   1=1
                        AND     ID_CATALOGO = 9
                        AND     ID_CATALOGO_VALOR = VAL_VALOR
                  )INTO   liValNominal
                  FROM    DERCORP_ADD_CAMPO_VALOR_TAB
                  WHERE   1=1
                  AND     ID_EMPRESA = PARAM_ID_EMPRESA
                  AND     ID_ADD_CAMPO = 1076
                  ;*/
                BEGIN
                    SELECT
                    (
                          SELECT  TO_NUMBER(REPLACE(REPLACE(VAL_CAT_VAL, '$', ''), ',', ''))
                          FROM    DERCORP_ADD_CAMPO_CAT_VAL_TAB
                          WHERE   1=1
                          AND     ID_CATALOGO = 9
                          AND     ID_CATALOGO_VALOR = VAL_VALOR
                    )INTO   liValNominal
                    FROM    DERCORP_ADD_CAMPO_VALOR_TAB
                    WHERE   1=1
                    AND     ID_EMPRESA = PARAM_ID_EMPRESA
                    AND     ID_ADD_CAMPO = 519;
                EXCEPTION
                WHEN INVALID_NUMBER THEN
                  liValNominal:=1;
                  END;
              ELSE
            --ULR se asigno uno para cuando VN sea Sin exp, N/A y valor desigual no afectar el capital social
            liValNominal:=1;
                    --ECM 27 Octubre 2015
                    /*SELECT
                  (
                        SELECT  TO_NUMBER(REPLACE(REPLACE(VAL_CAT_VAL, '$', ''), ',', ''))
                        FROM    DERCORP_ADD_CAMPO_CAT_VAL_TAB
                        WHERE   1=1
                        AND     ID_CATALOGO = 9
                        AND     ID_CATALOGO_VALOR = VAL_VALOR
                  )INTO   liValNominal
                  FROM    DERCORP_ADD_CAMPO_VALOR_TAB
                  WHERE   1=1
                  AND     ID_EMPRESA = PARAM_ID_EMPRESA
                  AND     ID_ADD_CAMPO = 519
                  ;*/
             END IF;
            --Valor Acciones
            --   = (Acciones Capital Fijo + Acciones Capital Variable) * Valor Nominal
            UPDATE DERCORP_METATBL_TAB
            SET    VAL_C6 =
            (TO_NUMBER(NVL(VAL_C3, 0)) + TO_NUMBER(NVL(VAL_C4, 0))) * liValNominal
            WHERE  1=1
            AND ID_EMPRESA = PARAM_ID_EMPRESA
            AND ID_FLEX_TBL = 7
            AND ID_META_ROW = i.ID_META_ROW
            ;
          END IF;
          IF var_formula = 'ACF_ACV' THEN
              --Valor Acciones
              --   = (Acciones Capital Fijo + Acciones Capital Variable)
              UPDATE DERCORP_METATBL_TAB
              SET    VAL_C6 = (TO_NUMBER(NVL(VAL_C3, 0)) + TO_NUMBER(NVL(VAL_C4, 0)))
              WHERE  1=1
              AND    ID_EMPRESA = PARAM_ID_EMPRESA
              AND    ID_FLEX_TBL = 7
              AND    ID_META_ROW = i.ID_META_ROW
              ;
          END IF;
     END LOOP;
     DERCORP_CAPTURA_PKG.RECALCULAR_CAM_CAP_ECS_PR(PARAM_ID_EMPRESA,lstOutmsg);
  END;
FUNCTION GET_TIPO_SOCIEDAD_FN(PARAM_ID_EMPRESA NUMBER) RETURN NUMBER
AS
    linCountAsocCivil    NUMBER := 0;
  BEGIN
      SELECT
          COUNT(*) INTO linCountAsocCivil
        FROM
          DERCORP_ADD_CAMPO_VALOR_TAB EMP
          INNER JOIN DERCORP_ADD_CAMPO_CAT_VAL_TAB CAT
                ON TO_NUMBER(EMP.VAL_VALOR) = TO_NUMBER(CAT.ID_CATALOGO_VALOR)
        WHERE
          EMP.ID_EMPRESA = PARAM_ID_EMPRESA
          AND
          EMP.ID_ADD_CAMPO = 517
          AND
          (UPPER(CAT.NOM_CAT_VAL) LIKE '%ASOCIACION CIVIL%' OR UPPER(CAT.NOM_CAT_VAL) LIKE '%NOT%FOR%PROFIT%CORPORATION%');
  RETURN linCountAsocCivil;
END GET_TIPO_SOCIEDAD_FN;
FUNCTION SOCIEDAD_FN(PARAM_ID_EMPRESA NUMBER) RETURN VARCHAR2
AS
    linCountAsocCivil    NUMBER := 0;
    linCountSdeRL        NUMBER := 0;
    linCountSdeRLdeCV    NUMBER := 0;
    linCountSA           NUMBER := 0;
    linCountSAdeCV       NUMBER := 0;
    linCountSAB          NUMBER := 0;
    linCountSABdeCV      NUMBER := 0;
    linCountSC           NUMBER := 0;
    linCountLLC          NUMBER := 0;
    linCountSLU          NUMBER := 0;
    linCountSAC          NUMBER := 0;
    linCountSAU          NUMBER := 0;
    linCountLTD          NUMBER := 0;
    linCountSL           NUMBER := 0;
  BEGIN
      SELECT
          COUNT(*) INTO linCountAsocCivil
        FROM
          DERCORP_ADD_CAMPO_VALOR_TAB EMP
          INNER JOIN DERCORP_ADD_CAMPO_CAT_VAL_TAB CAT
                ON TO_NUMBER(EMP.VAL_VALOR) = TO_NUMBER(CAT.ID_CATALOGO_VALOR)
        WHERE
          EMP.ID_EMPRESA = PARAM_ID_EMPRESA
          AND
          EMP.ID_ADD_CAMPO = 517
          AND
          UPPER(CAT.NOM_CAT_VAL) LIKE '%ASOCIACION%CIVIL';
       SELECT
          COUNT(*) INTO linCountSLU
        FROM
          DERCORP_ADD_CAMPO_VALOR_TAB EMP
          INNER JOIN DERCORP_ADD_CAMPO_CAT_VAL_TAB CAT
                ON TO_NUMBER(EMP.VAL_VALOR) = TO_NUMBER(CAT.ID_CATALOGO_VALOR)
        WHERE
          EMP.ID_EMPRESA = PARAM_ID_EMPRESA
          AND
          EMP.ID_ADD_CAMPO = 517
          AND
          UPPER(CAT.NOM_CAT_VAL) LIKE '%SOCIEDAD%LIMITADA%UNIPERSONAL%';
        SELECT
          COUNT(*) INTO linCountSAC
        FROM
          DERCORP_ADD_CAMPO_VALOR_TAB EMP
          INNER JOIN DERCORP_ADD_CAMPO_CAT_VAL_TAB CAT
                ON TO_NUMBER(EMP.VAL_VALOR) = TO_NUMBER(CAT.ID_CATALOGO_VALOR)
        WHERE
          EMP.ID_EMPRESA = PARAM_ID_EMPRESA
          AND
          EMP.ID_ADD_CAMPO = 517
          AND
          UPPER(CAT.NOM_CAT_VAL) LIKE '%SOCIEDAD%AN%CERRADA%';
         SELECT
          COUNT(*) INTO linCountSAU
        FROM
          DERCORP_ADD_CAMPO_VALOR_TAB EMP
          INNER JOIN DERCORP_ADD_CAMPO_CAT_VAL_TAB CAT
                ON TO_NUMBER(EMP.VAL_VALOR) = TO_NUMBER(CAT.ID_CATALOGO_VALOR)
        WHERE
          EMP.ID_EMPRESA = PARAM_ID_EMPRESA
          AND
          EMP.ID_ADD_CAMPO = 517
          AND
          UPPER(CAT.NOM_CAT_VAL) LIKE '%SOCIEDAD%AN%UNIPERSONAL%';
          SELECT
          COUNT(*) INTO linCountLTD
        FROM
          DERCORP_ADD_CAMPO_VALOR_TAB EMP
          INNER JOIN DERCORP_ADD_CAMPO_CAT_VAL_TAB CAT
                ON TO_NUMBER(EMP.VAL_VALOR) = TO_NUMBER(CAT.ID_CATALOGO_VALOR)
        WHERE
          EMP.ID_EMPRESA = PARAM_ID_EMPRESA
          AND
          EMP.ID_ADD_CAMPO = 517
          AND
          UPPER(CAT.NOM_CAT_VAL) LIKE '%LIMITED';
      SELECT
          COUNT(*) INTO linCountSdeRLdeCV
        FROM
          DERCORP_ADD_CAMPO_VALOR_TAB EMP
          INNER JOIN DERCORP_ADD_CAMPO_CAT_VAL_TAB CAT
                ON TO_NUMBER(EMP.VAL_VALOR) = TO_NUMBER(CAT.ID_CATALOGO_VALOR)
        WHERE
          EMP.ID_EMPRESA = PARAM_ID_EMPRESA
          AND
          EMP.ID_ADD_CAMPO = 517
          AND
          UPPER(CAT.NOM_CAT_VAL) LIKE '%RESPONSABILIDAD%LIMITADA%DE%CAPITAL%VARIABLE%';
      SELECT
          COUNT(*) INTO linCountSdeRL
        FROM
          DERCORP_ADD_CAMPO_VALOR_TAB EMP
          INNER JOIN DERCORP_ADD_CAMPO_CAT_VAL_TAB CAT
                ON TO_NUMBER(EMP.VAL_VALOR) = TO_NUMBER(CAT.ID_CATALOGO_VALOR)
        WHERE
          EMP.ID_EMPRESA = PARAM_ID_EMPRESA
          AND
          EMP.ID_ADD_CAMPO = 517
          AND
          UPPER(CAT.NOM_CAT_VAL) LIKE '%RESPONSABILIDAD%LIMITADA';
      SELECT
          COUNT(*) INTO linCountSAdeCV
        FROM
          DERCORP_ADD_CAMPO_VALOR_TAB EMP
          INNER JOIN DERCORP_ADD_CAMPO_CAT_VAL_TAB CAT
                ON TO_NUMBER(EMP.VAL_VALOR) = TO_NUMBER(CAT.ID_CATALOGO_VALOR)
        WHERE
          EMP.ID_EMPRESA = PARAM_ID_EMPRESA
          AND
          EMP.ID_ADD_CAMPO = 517
          AND
          UPPER(CAT.NOM_CAT_VAL) LIKE '%SOCIEDAD%ANONIMA%DE%CAPITAL%VARIABLE%';
      SELECT
          COUNT(*) INTO linCountSA
        FROM
          DERCORP_ADD_CAMPO_VALOR_TAB EMP
          INNER JOIN DERCORP_ADD_CAMPO_CAT_VAL_TAB CAT
                ON TO_NUMBER(EMP.VAL_VALOR) = TO_NUMBER(CAT.ID_CATALOGO_VALOR)
        WHERE
          EMP.ID_EMPRESA = PARAM_ID_EMPRESA
          AND
          EMP.ID_ADD_CAMPO = 517
          AND
          UPPER(CAT.NOM_CAT_VAL) LIKE '%SOCIEDAD%ANONIMA';
      SELECT
          COUNT(*) INTO linCountSABdeCV
        FROM
          DERCORP_ADD_CAMPO_VALOR_TAB EMP
          INNER JOIN DERCORP_ADD_CAMPO_CAT_VAL_TAB CAT
                ON TO_NUMBER(EMP.VAL_VALOR) = TO_NUMBER(CAT.ID_CATALOGO_VALOR)
        WHERE
          EMP.ID_EMPRESA = PARAM_ID_EMPRESA
          AND
          EMP.ID_ADD_CAMPO = 517
          AND
          UPPER(CAT.NOM_CAT_VAL) LIKE '%SOCIEDAD%ANONIMA%BURSATIL%DE%CAPITAL%VARIABLE%';
      SELECT
          COUNT(*) INTO linCountSAB
        FROM
          DERCORP_ADD_CAMPO_VALOR_TAB EMP
          INNER JOIN DERCORP_ADD_CAMPO_CAT_VAL_TAB CAT
                ON TO_NUMBER(EMP.VAL_VALOR) = TO_NUMBER(CAT.ID_CATALOGO_VALOR)
        WHERE
          EMP.ID_EMPRESA = PARAM_ID_EMPRESA
          AND
          EMP.ID_ADD_CAMPO = 517
          AND
          UPPER(CAT.NOM_CAT_VAL) LIKE '%SOCIEDAD%ANONIMA%BURSATIL';
      SELECT
          COUNT(*) INTO linCountSC
        FROM
          DERCORP_ADD_CAMPO_VALOR_TAB EMP
          INNER JOIN DERCORP_ADD_CAMPO_CAT_VAL_TAB CAT
                ON TO_NUMBER(EMP.VAL_VALOR) = TO_NUMBER(CAT.ID_CATALOGO_VALOR)
        WHERE
          EMP.ID_EMPRESA = PARAM_ID_EMPRESA
          AND
          EMP.ID_ADD_CAMPO = 517
          AND
          UPPER(CAT.NOM_CAT_VAL) LIKE '%SOCIEDAD%CIVIL';
  --JJAQ se agrega la llc para que no muestre capital fijo o minimo y capital variable
    SELECT
          COUNT(*) INTO linCountLLC
        FROM
          DERCORP_ADD_CAMPO_VALOR_TAB EMP
          INNER JOIN DERCORP_ADD_CAMPO_CAT_VAL_TAB CAT
                ON TO_NUMBER(EMP.VAL_VALOR) = TO_NUMBER(CAT.ID_CATALOGO_VALOR)
        WHERE
          EMP.ID_EMPRESA = PARAM_ID_EMPRESA
          AND
          EMP.ID_ADD_CAMPO = 517
          AND
          UPPER(CAT.NOM_CAT_VAL) LIKE '%LIMITED%LIABILITY%COMPANY%';
    SELECT
          COUNT(*)INTO linCountSL
        FROM
          DERCORP_ADD_CAMPO_VALOR_TAB EMP
          INNER JOIN DERCORP_ADD_CAMPO_CAT_VAL_TAB CAT
                ON TO_NUMBER(EMP.VAL_VALOR) = TO_NUMBER(CAT.ID_CATALOGO_VALOR)
        WHERE
          EMP.ID_EMPRESA = PARAM_ID_EMPRESA
          AND
          EMP.ID_ADD_CAMPO = 517
          AND
          UPPER(CAT.NOM_CAT_VAL) LIKE '%SOCIEDA%LIMITADA';
      IF linCountAsocCivil      <> 0 THEN
        RETURN 'isAC';
      ELSIF linCountSdeRLdeCV   <> 0 THEN
        RETURN 'isSdeRLdeCV';
      ELSIF linCountSdeRL       <> 0 THEN
        RETURN 'isSdeRL';
      ELSIF linCountSAdeCV      <> 0 THEN
        RETURN 'isSAdeCV';
      ELSIF linCountSA          <> 0 THEN
        RETURN 'isSA';
      ELSIF linCountSABdeCV     <> 0 THEN
        RETURN 'isSABdeCV';
      ELSIF linCountSAB         <> 0 THEN
        RETURN 'isSAB';
      ELSIF linCountSC          <> 0 THEN
        RETURN 'isSC';
      ELSIF linCountLLC         <> 0 THEN
        RETURN 'isLLC';
      ELSIF linCountSLU         <> 0 THEN
        RETURN 'isSLU';
      ELSIF linCountSAC         <> 0 THEN
        RETURN 'isSAC';
      ELSIF linCountSAU         <> 0 THEN
        RETURN 'isSAU';
      ELSIF linCountLTD         <> 0 THEN
        RETURN 'isLTD';
      ELSIF linCountSL          <> 0 THEN
        RETURN 'isSL';
      ELSE
        RETURN 'NoAplica';
      END IF;
END SOCIEDAD_FN;
END XXTV_CAPITAL_SOC_PKG;
/;
