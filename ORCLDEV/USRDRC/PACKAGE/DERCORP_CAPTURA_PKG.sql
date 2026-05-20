CREATE OR REPLACE NONEDITIONABLE PACKAGE "USRDRC"."DERCORP_CAPTURA_PKG" AS
  /* TODO enter package declarations (types, exceptions, methods etc) here */
  PROCEDURE SAVE_INFO_PR( PARAM_ID_EMPRESA int
                         ,PARAM_FIELD_CODE varchar
                         ,PARAM_FIELD_VALUE varchar
                         ,pinUserId         NUMBER);
  PROCEDURE DELETE_CHECKBOX_INFO_PR(PARAM_ID_EMPRESA int, PARAM_ID_SECCION INT);
  PROCEDURE DELETE_CHECKBOX_ADM_VIG_PR(PARAM_ID_EMPRESA int);
  PROCEDURE DELETE_CHECKBOX_ESCRITURA_PR(PARAM_ID_EMPRESA int);
  PROCEDURE DELETE_ONE_CHECKBOX_INFO_PR(PARAM_ID_EMPRESA int, PARAM_CODE_CAMPO VARCHAR2);
  /*
  * ECM 15 Julio 2015
  * Quitar formato a los campos numeric.
  */
  PROCEDURE UNFORMAT_VAL_CAMPO_NUMERIC_PR(PSTEMPRESA VARCHAR2);
  /*
  ECM 27 Octubre 2015
  Recalcular con nuevo Valor Nominal los campos Capitales de
  Estructuta del Capital Social
  */
  PROCEDURE RECALCULAR_CAM_CAP_ECS_PR(PIIN_ID_EMPRESA IN NUMBER
                                      ,PSOU_MENSAJE OUT VARCHAR2);
  PROCEDURE SAVE_MONEDA_PR(PARAM_ID_EMPRESA INT);
  /*
  * ECM 26 Febrero 2016
  *
  */
  PROCEDURE SAVE_SEMAFORO_PR(PARAM_ID_EMPRESA INT);
  --
  -- NAVA - Abr21
  --
  FUNCTION GET_VALOR_TEORICO_NOMINAL_FN(PARAM_ID_EMPRESA INT) RETURN VARCHAR;
  --
  -- NAVA - May17
  --
  FUNCTION GET_DENOM_ACTUAL_FN(PARAM_ID_EMPRESA INT) RETURN VARCHAR;
  --
  -- NAVA - Abr27
  --
  FUNCTION GET_MONEDA_ECS_FN(PARAM_ID_EMPRESA INT) RETURN VARCHAR;
  --ECM 05 MAYO 2016 - CAPTURA - RESUMEN GENERAL - NOMBRE CORTO
  PROCEDURE CAMBIAR_NOMBRE_CORTO_PR(PARAM_ID_EMPRESA INT);
  --ECM 11 Mayo 2016 - Captura - Administracion y Vig - Borrar registros en flex que no se muestran.
  PROCEDURE BORRAR_REG_FLEX_ADM_PR(LI_ID_EMPRESA INT);
  /*
  ECM 13 Mayo 2016
  Captura - Resumen General - Capital Social
  Borrar porcentaje de participacion cuando Socio Externo es 'No'
  */
  PROCEDURE BORRAR_PORCENTAJE_PAR_PR(LI_ID_EMPRESA INT);
  PROCEDURE GET_MONEDA_PR(PIIN_ID_EMPRESA IN NUMBER, PSTO_MONEDA OUT VARCHAR2);
  /*
      ECM 20 Septiembre 2016
      Captura - Resumen General - Informacion General
      Obtener telefono del Domicilio Comercial
  */
  PROCEDURE GET_TEL_COMERCIAL_PR(piinIdDomCom IN INT
                                ,postTelefono OUT VARCHAR2
  );
END DERCORP_CAPTURA_PKG;
/
CREATE OR REPLACE NONEDITIONABLE PACKAGE BODY "USRDRC"."DERCORP_CAPTURA_PKG" AS
  --
  --
  --
  PROCEDURE SAVE_INFO_PR( PARAM_ID_EMPRESA int
                         ,PARAM_FIELD_CODE varchar
                         ,PARAM_FIELD_VALUE varchar
                         ,pinUserId         NUMBER) AS
    VAR_ID_CATALOGO NUMBER;
    LSTACTVALUE     VARCHAR2(2000);
    LSTACTID        VARCHAR2(2000);
    LSTNEWVALUE     VARCHAR2(2000);
    --ECM 21 JULIO 2015
    LSTSEMACT   VARCHAR2(2000);
    LSTFECMOD   VARCHAR2(2000);
    --ECM 27 Octubre 2015
    LSTMENSAJE     VARCHAR2(2000);
    linCountEC     NUMBER;
    linCountTNEC   NUMBER;
  BEGIN
  --ICL-- 15/07/2015
  --Se agrega procedimiento para guardar la informacion de Denominaciones Anteriores cuando
  --  se cambie el campo de Denominacion Actual
    IF PARAM_FIELD_CODE = 'C1' THEN
      BEGIN
        SELECT CV.VAL_VALOR  INTO LSTACTID
        FROM   DERCORP_ADD_CAMPO_VALOR_TAB CV
        WHERE  CV.ID_EMPRESA = PARAM_ID_EMPRESA
        AND    CV.ID_ADD_CAMPO = (SELECT AC.ID_ADD_CAMPO
                                  FROM   DERCORP_ADD_CAMPO_TAB AC
                                  WHERE  AC.COD_CAMPO = PARAM_FIELD_CODE);
        SELECT  CATV.VAL_CAT_VAL  INTO  LSTACTVALUE
        FROM    DERCORP_ADD_CAMPO_CAT_VAL_TAB CATV
        WHERE   CATV.ID_CATALOGO          = 1
        AND     CATV.ID_CATALOGO_VALOR    = LSTACTID;
        SELECT  CATV.VAL_CAT_VAL  INTO  LSTNEWVALUE
        FROM    DERCORP_ADD_CAMPO_CAT_VAL_TAB CATV
        WHERE   CATV.ID_CATALOGO          = 1
        AND     CATV.ID_CATALOGO_VALOR    = PARAM_FIELD_VALUE;
      EXCEPTION
        WHEN OTHERS THEN
          LSTACTID := '';
          LSTACTVALUE := '';
          LSTNEWVALUE := '';
      END;
      IF LSTACTVALUE<>LSTNEWVALUE THEN
        INSERT INTO DERCORP_METATBL_TAB(
                                        ID_META_ROW,
                                        ID_FLEX_TBL,
                                        ID_EMPRESA,
                                        VAL_C1,
                                        NUM_CREATED_BY,
                                        FEC_CREATION_DATE
                                        )
        VALUES(
              DERCORP_METATBL_SEQ.NEXTVAL,
              2,
              PARAM_ID_EMPRESA,
              LSTACTVALUE,
              pinUserId,
              SYSDATE
              );
      END IF;
    END IF;
    --ECM 21 Julio 2015
      IF PARAM_FIELD_CODE = 'C47' THEN
          --Query qe regresa el semaforo por empresa.
          BEGIN
              SELECT  VAL_VALOR
              INTO    LSTSEMACT
              FROM    DERCORP_ADD_CAMPO_VALOR_TAB
              WHERE   1=1
              AND     ID_ADD_CAMPO  = 546
              AND     ID_EMPRESA    = PARAM_ID_EMPRESA
              ;
              --Obtener FechaActual
              SELECT  TO_CHAR(SYSDATE,'DD/MM/RRRR')
              INTO    LSTFECMOD
              FROM    DUAL
              WHERE 1=1;
          EXCEPTION
            WHEN OTHERS THEN
                LSTSEMACT := '';
          END;
          IF LSTSEMACT <> PARAM_FIELD_VALUE THEN
              INSERT INTO DERCORP_ADD_CAMPO_VALOR_TAB(ID_ADD_CAMPO,
                                                      ID_EMPRESA,
                                                      NUM_CREATED_BY,
                                                      FEC_CREATION_DATE)
              SELECT
                DA_CAMPO.ID_ADD_CAMPO, PARAM_ID_EMPRESA, pinUserId, SYSDATE
              FROM
                DERCORP_ADD_CAMPO_TAB DA_CAMPO
              WHERE
                DA_CAMPO.COD_CAMPO = PARAM_FIELD_CODE
              AND
                  NOT EXISTS (SELECT 1
                              FROM DERCORP_ADD_CAMPO_VALOR_TAB
                              WHERE
                              ID_ADD_CAMPO = DA_CAMPO.ID_ADD_CAMPO
                              AND
                              ID_EMPRESA = PARAM_ID_EMPRESA
                              )
              ;
              UPDATE  DERCORP_ADD_CAMPO_VALOR_TAB
              SET     --VAL_VALOR = LSTFECMOD, --se comenta para que no actualice la fecha de tramite en estructura de capital ULR 28/02/2017
                      NUM_LAST_UPDATED_BY  = pinUserId,
                      FEC_LAST_UPDATE_DATE = SYSDATE
              WHERE   1=1
              AND     ID_EMPRESA = PARAM_ID_EMPRESA
              AND     ID_ADD_CAMPO = 1022
              ;
          END IF;
      END IF;
    --END ECM
    INSERT INTO DERCORP_ADD_CAMPO_VALOR_TAB (ID_ADD_CAMPO,
                                             ID_EMPRESA,
                                             NUM_CREATED_BY,
                                             FEC_CREATION_DATE)
    SELECT
      DA_CAMPO.ID_ADD_CAMPO, PARAM_ID_EMPRESA, pinUserId, SYSDATE
    FROM
      DERCORP_ADD_CAMPO_TAB DA_CAMPO
    WHERE
      DA_CAMPO.COD_CAMPO = PARAM_FIELD_CODE
      AND
      NOT EXISTS (SELECT 1
                  FROM DERCORP_ADD_CAMPO_VALOR_TAB
                  WHERE
                    ID_ADD_CAMPO = DA_CAMPO.ID_ADD_CAMPO
                    AND
                    ID_EMPRESA = PARAM_ID_EMPRESA);
    UPDATE DERCORP_ADD_CAMPO_VALOR_TAB SET
      VAL_VALOR = PARAM_FIELD_VALUE,
      NUM_LAST_UPDATED_BY  = pinUserId,
      FEC_LAST_UPDATE_DATE = SYSDATE
    WHERE
      ID_EMPRESA = PARAM_ID_EMPRESA
      AND
      ID_ADD_CAMPO IN ( SELECT ID_ADD_CAMPO
                        FROM DERCORP_ADD_CAMPO_TAB
                        WHERE
                          COD_CAMPO = PARAM_FIELD_CODE);
  END SAVE_INFO_PR;
  PROCEDURE DELETE_CHECKBOX_INFO_PR(PARAM_ID_EMPRESA int, PARAM_ID_SECCION INT) IS
  BEGIN
  --NULL;
    DELETE FROM DERCORP_ADD_CAMPO_VALOR_TAB
    WHERE       ID_EMPRESA = PARAM_ID_EMPRESA
    AND         ID_ADD_CAMPO IN (SELECT ID_ADD_CAMPO
                                 FROM   DERCORP_ADD_CAMPO_TAB
                                 WHERE  DES_TIPO_CAMPO IN ('CHECKBOX_D', 'CHECKBOX')
                                 AND ID_SECCION = PARAM_ID_SECCION
                                 );
    COMMIT;
  END;
  PROCEDURE DELETE_CHECKBOX_ADM_VIG_PR(PARAM_ID_EMPRESA int) IS
  BEGIN
    DELETE FROM DERCORP_ADD_CAMPO_VALOR_TAB
    WHERE       ID_EMPRESA = PARAM_ID_EMPRESA
    AND         ID_ADD_CAMPO IN (SELECT ID_ADD_CAMPO
                                 FROM   DERCORP_ADD_CAMPO_TAB
                                 WHERE  DES_TIPO_CAMPO IN ('CHECKBOX_A'));
    COMMIT;
  END;
  PROCEDURE DELETE_CHECKBOX_ESCRITURA_PR(PARAM_ID_EMPRESA int) IS
  BEGIN
    DELETE FROM DERCORP_ADD_CAMPO_VALOR_TAB
    WHERE       ID_EMPRESA = PARAM_ID_EMPRESA
    AND         ID_ADD_CAMPO IN (SELECT ID_ADD_CAMPO
                                 FROM   DERCORP_ADD_CAMPO_TAB
                                 WHERE  DES_TIPO_CAMPO IN ('CHECKBOX_E'));
    COMMIT;
  END;
  PROCEDURE DELETE_ONE_CHECKBOX_INFO_PR(PARAM_ID_EMPRESA int, PARAM_CODE_CAMPO VARCHAR2) IS
  BEGIN
    DELETE FROM DERCORP_ADD_CAMPO_VALOR_TAB
    WHERE       ID_EMPRESA = PARAM_ID_EMPRESA
    AND         ID_ADD_CAMPO IN (SELECT ID_ADD_CAMPO
                                 FROM   DERCORP_ADD_CAMPO_TAB
                                 WHERE  COD_CAMPO = PARAM_CODE_CAMPO);
  END;
  PROCEDURE UNFORMAT_VAL_CAMPO_NUMERIC_PR(PSTEMPRESA VARCHAR2)
  IS
    VAR_VAL_VALOR   VARCHAR2(254);
    CURSOR   DERCORP_ADD_CAMPO_CUR
    IS
    SELECT   CV.VAL_VALOR
             ,CV.ID_ADD_CAMPO
    FROM     DERCORP_ADD_CAMPO_TAB        C
            ,DERCORP_ADD_CAMPO_VALOR_TAB  CV
    WHERE    1=1
    AND      CV.ID_ADD_CAMPO = C.ID_ADD_CAMPO
    AND      C.DES_TIPO_CAMPO = 'NUMERIC'
    AND      CV.ID_EMPRESA = PSTEMPRESA
    ;
  BEGIN
      FOR i IN DERCORP_ADD_CAMPO_CUR
      LOOP
        VAR_VAL_VALOR := REPLACE(i.VAL_VALOR, '$', ',');
        VAR_VAL_VALOR := REPLACE(VAR_VAL_VALOR, ',', '');
        UPDATE  DERCORP_ADD_CAMPO_VALOR_TAB
        SET     VAL_VALOR    = VAR_VAL_VALOR
        WHERE   1=1
        AND     ID_EMPRESA = PSTEMPRESA
        AND     ID_ADD_CAMPO = i.ID_ADD_CAMPO
        ;
      END LOOP;
  END;
  PROCEDURE RECALCULAR_CAM_CAP_ECS_PR(PIIN_ID_EMPRESA IN NUMBER
                                      ,PSOU_MENSAJE OUT VARCHAR2)
  IS
      liValC3               NUMBER := 0;
      liValC4               NUMBER := 0;
      liValNominal          NUMBER := 0;
      liValAcciones         NUMBER;
      liExpresNomin         NUMBER;
      liValAccMtb           NUMBER;
      liValC5Por            NUMBER;
      liValTeoNom           NUMBER;
      linCountRespLimitada  NUMBER;
      loCapVar INT;
      loCapFij INT;
     --ECM 16 Agosto 2016
     lstValorNominal  VARCHAR2(2000);
     lstValorTeoNomi  VARCHAR2(2000);
      CURSOR ValoresNominalesCur(tiIdEmpresa NUMBER)
      IS
      SELECT  VAL_C3
             ,VAL_C4
      FROM    DERCORP_METATBL_TAB
      WHERE   1=1
      AND     ID_FLEX_TBL = 7
      AND     ID_EMPRESA  = tiIdEmpresa
      ;
      CURSOR ValAccMtbCur(tiIdEmpresa NUMBER)
      IS
      SELECT  ID_META_ROW
              ,VAL_C3
              ,VAL_C4
      FROM    DERCORP_METATBL_TAB
      WHERE   1=1
      AND     ID_FLEX_TBL = 7
      AND     ID_EMPRESA  = tiIdEmpresa
      ;
  BEGIN
      /*
      ECM 27 Octubre 2015
      Recalcular con nuevo Valor Nominal los campos Capitales de
      Estructuta del Capital Social
      ECM 16 Agosto 2016
      Permitir capturar valores en los campos de
      */
      BEGIN
        SELECT  VAL_CAT_VAL
        INTO    lstValorNominal
        FROM    DERCORP_ADD_CAMPO_CAT_VAL_TAB
        WHERE   1=1
        AND     ID_CATALOGO = 9
        AND     ID_CATALOGO_VALOR = (
                                    SELECT  VAL_VALOR
                                    FROM    DERCORP_ADD_CAMPO_VALOR_TAB
                                    WHERE   1=1
                                    AND     ID_EMPRESA = PIIN_ID_EMPRESA
                                    AND     ID_ADD_CAMPO = (
                                                            SELECT ID_ADD_CAMPO
                                                            FROM   DERCORP_ADD_CAMPO_TAB
                                                            WHERE  1=1
                                                            AND    COD_CAMPO = 'C20'
                                    )
        )
        ;
      EXCEPTION
        WHEN NO_DATA_FOUND THEN
          lstValorNominal := NULL;
      END;
/*JJAQ 16/02/2017 Se comenta porque se quito valor teorico Nominal
      BEGIN
        SELECT  VAL_CAT_VAL
        INTO    lstValorTeoNomi
        FROM    DERCORP_ADD_CAMPO_CAT_VAL_TAB
        WHERE   1=1
        AND     ID_CATALOGO = 9
        AND     ID_CATALOGO_VALOR = (
                                    SELECT  VAL_VALOR
                                    FROM    DERCORP_ADD_CAMPO_VALOR_TAB
                                    WHERE   1=1
                                    AND     ID_EMPRESA = PIIN_ID_EMPRESA
                                    AND     ID_ADD_CAMPO = (
                                                            SELECT ID_ADD_CAMPO
                                                            FROM   DERCORP_ADD_CAMPO_TAB
                                                            WHERE  1=1
                                                            AND    COD_CAMPO = 'C1076'
                                    )
        )
        ;
      EXCEPTION
        WHEN NO_DATA_FOUND THEN
          lstValorTeoNomi := NULL;
      END;
*/
      BEGIN
        SELECT
            COUNT(*) INTO linCountRespLimitada
          FROM
            DERCORP_ADD_CAMPO_VALOR_TAB EMP
            INNER JOIN DERCORP_ADD_CAMPO_CAT_VAL_TAB CAT
                  ON TO_NUMBER(EMP.VAL_VALOR) = TO_NUMBER(CAT.ID_CATALOGO_VALOR)
          WHERE
            EMP.ID_EMPRESA = PIIN_ID_EMPRESA
            AND
            EMP.ID_ADD_CAMPO = 517
            AND
            UPPER(CAT.NOM_CAT_VAL) LIKE '%RESPONSABILIDAD%LIMITADA%';
        EXCEPTION
        WHEN NO_DATA_FOUND THEN
          linCountRespLimitada := 0;
      END;
        IF (lstValorNominal IS NULL OR
            UPPER(lstValorNominal) LIKE '%SIN%EXPRES%NOMINAL' OR
            lstValorNominal = 'Valor Desigual'        OR
            lstValorNominal = 'N/A'
            )/*AND ( Se comenta porque ya no hay valor teorico nominal
            lstValorTeoNomi IS NULL                   OR
            lstValorTeoNomi = 'Sin Expresion Nominal' OR
            lstValorTeoNomi = 'Valor Desigual'        OR
            lstValorTeoNomi = 'N/A'
            )*/
            THEN
                NULL;
        ELSE
            SELECT
              COUNT(*) INTO liExpresNomin
            FROM
              DERCORP_ADD_CAMPO_VALOR_TAB EMP
              LEFT JOIN DERCORP_ADD_CAMPO_CAT_VAL_TAB CAT
                    ON TO_NUMBER(EMP.VAL_VALOR) = TO_NUMBER(CAT.ID_CATALOGO_VALOR)
            WHERE
              EMP.ID_EMPRESA = PIIN_ID_EMPRESA
              AND
              EMP.ID_ADD_CAMPO = 519
              AND
              (UPPER(CAT.NOM_CAT_VAL) LIKE '%SIN%EXPRES%NOMINAL'
              OR
              UPPER(CAT.NOM_CAT_VAL) LIKE '%VALOR%DESIGUAL%'
              OR
              UPPER(CAT.NOM_CAT_VAL) LIKE '%N/A%'
              OR
              CAT.NOM_CAT_VAL IS NULL
              )
            ;
          --VALIDAR QUE NO SEA 'SIN EXPRESION NOMINAL'. y que no sea S. De R.L.
          IF liExpresNomin = 0 AND linCountRespLimitada = 0 THEN
              --Obtener valores Capital Fijo y Capital Variable
              FOR i IN ValoresNominalesCur(PIIN_ID_EMPRESA)
              LOOP
                  liValC3 := liValC3 + TO_NUMBER(NVL(i.VAL_C3, '0'));
                  liValC4 := liValC4 + TO_NUMBER(NVL(i.VAL_C4, '0'));
              END LOOP;
              --Obtener ValorNominal
              SELECT  (
                      SELECT  TO_NUMBER(REPLACE(REPLACE(VAL_CAT_VAL, '$', ''), ',', ''))
                      FROM    DERCORP_ADD_CAMPO_CAT_VAL_TAB
                      WHERE   1=1
                      AND     ID_CATALOGO = 9
                      AND     ID_CATALOGO_VALOR = VAL_VALOR
                      )
              INTO    liValNominal
              FROM    DERCORP_ADD_CAMPO_VALOR_TAB
              WHERE   1=1
              AND     ID_ADD_CAMPO = 519
              AND     ID_EMPRESA = PIIN_ID_EMPRESA
              ;
              --Actualizar campos con valor nominal nuevo.
              liValC3 := liValC3 * liValNominal;
              liValC4 := liValC4 * liValNominal;
              liValAcciones := liValC3 + liValC4;
              DBMS_OUTPUT.PUT_LINE(liValC3||' '||liValC4||' '||liValAcciones);
              DERCORP_FLEXTAB_PKG.GET_CHECK_CAP_FIJ_VAR_PR(loCapVar, loCapFij, TO_NUMBER(PIIN_ID_EMPRESA));
        --Actualiza el campo Capital Fijo o Minimo
              IF loCapFij > 0 THEN
                  UPDATE  DERCORP_ADD_CAMPO_VALOR_TAB
                  SET     VAL_VALOR = liValC3
                  WHERE   1=1
                  AND     ID_ADD_CAMPO = 1028
                  AND     ID_EMPRESA = PIIN_ID_EMPRESA
                  ;
              END IF;
    --Actualiza el campo Capital Variable
              IF loCapVar > 0 THEN
                  UPDATE  DERCORP_ADD_CAMPO_VALOR_TAB
                  SET     VAL_VALOR = liValC4
                  WHERE   1=1
                  AND     ID_ADD_CAMPO = 1029
                  AND     ID_EMPRESA = PIIN_ID_EMPRESA
                  ;
              END IF;
    --Suma campo Capital Fijo o Minimo + Capital Variable
              IF loCapFij > 0 OR loCapVar > 0 THEN
                  UPDATE  DERCORP_ADD_CAMPO_VALOR_TAB
                  SET     VAL_VALOR = liValAcciones
                  WHERE   1=1
                  AND     ID_ADD_CAMPO = 541
                  AND     ID_EMPRESA = PIIN_ID_EMPRESA
                  ;
              END IF;
              FOR j IN ValAccMtbCur(PIIN_ID_EMPRESA)
              LOOP
               --   IF ( (j.VAL_C3 IS NOT NULL) AND (j.VAL_C4 IS NOT NULL) ) THEN
                --    liValAccMtb := TO_NUMBER(j.VAL_C3)*liValNominal + TO_NUMBER(j.VAL_C4)*liValNominal;
                -- JAMS se comenta el if y se agrega un NVL a la suma de la multiplicacion al valor nominal 10/07/2018
                liValAccMtb := TO_NUMBER( NVL(j.VAL_C3, '0'))*liValNominal + TO_NUMBER( NVL(j.VAL_C4, '0'))*liValNominal;
                    UPDATE DERCORP_METATBL_TAB
                    SET    VAL_C6 = liValAccMtb
                    WHERE  1=1
                    AND    ID_META_ROW = j.ID_META_ROW
                    ;
               --   END IF;
              END LOOP;
 /*
        --Valor Teorico Nominal Campo 1076
          ELSIF liExpresNomin > 0 THEN
              --Obtener valores Capital Fijo y Capital Variable
              FOR i IN ValoresNominalesCur(PIIN_ID_EMPRESA)
              LOOP
                  liValC3 := liValC3 + TO_NUMBER(NVL(i.VAL_C3, '0'));
                  liValC4 := liValC4 + TO_NUMBER(NVL(i.VAL_C4, '0'));
              END LOOP;
              liValTeoNom := 0;
              BEGIN
                    --Obtener Valor Teorico Nominal
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
                                    AND     ID_EMPRESA = PIIN_ID_EMPRESA
                  )
                  ;
              EXCEPTION
                WHEN OTHERS THEN
                liValTeoNom := 0;
              END;
              --Actualizar campos con valor toerico nominal nuevo.
              liValC3 := liValC3 * TO_NUMBER(NVL(liValTeoNom, '0'));
              liValC4 := liValC4 * TO_NUMBER(NVL(liValTeoNom, '0'));
              liValAcciones := liValC3 + liValC4;
              UPDATE  DERCORP_ADD_CAMPO_VALOR_TAB
              SET     VAL_VALOR = liValC3
              WHERE   1=1
              AND     ID_ADD_CAMPO = 1028
              AND     ID_EMPRESA = PIIN_ID_EMPRESA
              ;
              UPDATE  DERCORP_ADD_CAMPO_VALOR_TAB
              SET     VAL_VALOR = liValC4
              WHERE   1=1
              AND     ID_ADD_CAMPO = 1029
              AND     ID_EMPRESA = PIIN_ID_EMPRESA
              ;
              UPDATE  DERCORP_ADD_CAMPO_VALOR_TAB
              SET     VAL_VALOR = liValAcciones
              WHERE   1=1
              AND     ID_ADD_CAMPO = 541
              AND     ID_EMPRESA = PIIN_ID_EMPRESA
              ;
              --Actulizar la Metatable.
              FOR j IN ValAccMtbCur(PIIN_ID_EMPRESA)
              LOOP
                  IF( (j.VAL_C3 IS NOT NULL) AND (j.VAL_C4 IS NOT NULL)
                       AND (liValTeoNom > 0) )THEN
                    liValAccMtb := TO_NUMBER(j.VAL_C3)*liValTeoNom + TO_NUMBER(j.VAL_C4)*liValTeoNom;
                    UPDATE DERCORP_METATBL_TAB
                    SET    VAL_C6 = liValAccMtb
                    WHERE  1=1
                    AND    ID_META_ROW = j.ID_META_ROW
                    ;
                  END IF;
              END LOOP;
   */
          ELSE
--Se repite de lo que hay arriba para que recalcule con valor nominal a 1 cuando no sea numero
            liValNominal := 1;
            --Actualizar campos con valor nominal nuevo.
              liValC3 := liValC3 * liValNominal;
              liValC4 := liValC4 * liValNominal;
              liValAcciones := liValC3 + liValC4;
              DBMS_OUTPUT.PUT_LINE(liValC3||' '||liValC4||' '||liValAcciones);
              DERCORP_FLEXTAB_PKG.GET_CHECK_CAP_FIJ_VAR_PR(loCapVar, loCapFij, TO_NUMBER(PIIN_ID_EMPRESA));
        --Actualiza el campo Capital Fijo o Minimo
              IF loCapFij > 0 THEN
                  UPDATE  DERCORP_ADD_CAMPO_VALOR_TAB
                  SET     VAL_VALOR = liValC3
                  WHERE   1=1
                  AND     ID_ADD_CAMPO = 1028
                  AND     ID_EMPRESA = PIIN_ID_EMPRESA
                  ;
              END IF;
    --Actualiza el campo Capital Variable
              IF loCapVar > 0 THEN
                  UPDATE  DERCORP_ADD_CAMPO_VALOR_TAB
                  SET     VAL_VALOR = liValC4
                  WHERE   1=1
                  AND     ID_ADD_CAMPO = 1029
                  AND     ID_EMPRESA = PIIN_ID_EMPRESA
                  ;
              END IF;
    --Suma campo Capital Fijo o Minimo + Capital Variable
              IF loCapFij > 0 OR loCapVar > 0 THEN
                  UPDATE  DERCORP_ADD_CAMPO_VALOR_TAB
                  SET     VAL_VALOR = liValAcciones
                  WHERE   1=1
                  AND     ID_ADD_CAMPO = 541
                  AND     ID_EMPRESA = PIIN_ID_EMPRESA
                  ;
              END IF;
              FOR j IN ValAccMtbCur(PIIN_ID_EMPRESA)
              LOOP
                --  IF ( (j.VAL_C3 IS NOT NULL) AND (j.VAL_C4 IS NOT NULL) ) THEN
                    liValAccMtb := TO_NUMBER( NVL(j.VAL_C3, '0'))*liValNominal + TO_NUMBER( NVL(j.VAL_C4, '0'))*liValNominal;
             -- JAMS se comenta el if y se agrega un NVL a la suma de la multiplicacion al valor nominal 10/07/2018
                    UPDATE DERCORP_METATBL_TAB
                    SET    VAL_C6 = liValAccMtb
                    WHERE  1=1
                    AND    ID_META_ROW = j.ID_META_ROW
                    ;
              --    END IF;
              END LOOP;
          END IF;
          COMMIT;
    END IF;
  EXCEPTION
      WHEN NO_DATA_FOUND THEN
          DBMS_OUTPUT.PUT_LINE('No encontro datos con la empresa: '||PIIN_ID_EMPRESA);
          DBMS_OUTPUT.PUT_LINE('ORA-ERROR: '||SQLCODE);
          DBMS_OUTPUT.PUT_LINE(SQLERRM);
          PSOU_MENSAJE := SQLERRM||' '||SQLCODE;
      WHEN OTHERS THEN
          DBMS_OUTPUT.PUT_LINE('ORA-ERROR: '||SQLCODE);
          DBMS_OUTPUT.PUT_LINE(SQLERRM);
          PSOU_MENSAJE := SQLERRM||' '||SQLCODE;
  END RECALCULAR_CAM_CAP_ECS_PR;
    --ECM 18 Noviembre 2015
    PROCEDURE SAVE_MONEDA_PR( PARAM_ID_EMPRESA INT)
    IS
    LSVAL_VALOR VARCHAR2(2000);
    BEGIN
    --Se comenta para que ya no se actualize la moneda en escritura constitutiva.
  /*      SELECT  VAL_VALOR
        INTO    LSVAL_VALOR
        FROM    DERCORP_ADD_CAMPO_VALOR_TAB
        WHERE   1=1
        AND     ID_ADD_CAMPO = 520
        AND     ID_EMPRESA = PARAM_ID_EMPRESA
        ;
          INSERT INTO DERCORP_ADD_CAMPO_VALOR_TAB(ID_ADD_CAMPO, ID_EMPRESA, VAL_VALOR)
              SELECT  ID_ADD_CAMPO
                      ,PARAM_ID_EMPRESA
                      ,LSVAL_VALOR
              FROM    DERCORP_ADD_CAMPO_TAB CAM
              WHERE   1=1
              AND     COD_CAMPO = 'C65'
              AND NOT EXISTS(
                            SELECT  VAL_VALOR
                            FROM    DERCORP_ADD_CAMPO_VALOR_TAB
                            WHERE   1=1
                            AND     ID_ADD_CAMPO = CAM.ID_ADD_CAMPO
                            AND     ID_EMPRESA = PARAM_ID_EMPRESA
              )
              ;
          UPDATE DERCORP_ADD_CAMPO_VALOR_TAB
          SET    VAL_VALOR = LSVAL_VALOR
          WHERE  1=1
          AND    ID_ADD_CAMPO IN ( SELECT  ID_ADD_CAMPO
                                   FROM    DERCORP_ADD_CAMPO_TAB
                                   WHERE   1=1
                                   AND     COD_CAMPO = 'C65'
                                  );
          INSERT INTO DERCORP_ADD_CAMPO_VALOR_TAB(ID_ADD_CAMPO, ID_EMPRESA, VAL_VALOR)
              SELECT  ID_ADD_CAMPO
                      ,PARAM_ID_EMPRESA
                      ,LSVAL_VALOR
              FROM    DERCORP_ADD_CAMPO_TAB CAM
              WHERE   1=1
              AND     COD_CAMPO = 'C1051'
              AND NOT EXISTS(
                            SELECT  VAL_VALOR
                            FROM    DERCORP_ADD_CAMPO_VALOR_TAB
                            WHERE   1=1
                            AND     ID_ADD_CAMPO = CAM.ID_ADD_CAMPO
                            AND     ID_EMPRESA = PARAM_ID_EMPRESA
              )
              ;
          UPDATE DERCORP_ADD_CAMPO_VALOR_TAB
          SET    VAL_VALOR = LSVAL_VALOR
          WHERE  1=1
          AND    ID_ADD_CAMPO IN ( SELECT  ID_ADD_CAMPO
                                   FROM    DERCORP_ADD_CAMPO_TAB
                                   WHERE   1=1
                                   AND     COD_CAMPO = 'C1051'
          );
*/
            null;
    EXCEPTION
    WHEN OTHERS THEN
       NULL;
    END SAVE_MONEDA_PR;
    PROCEDURE SAVE_SEMAFORO_PR(PARAM_ID_EMPRESA INT)
    IS
        lstSemaStat  VARCHAR2(100) := '';
        lstIdAddCampo VARCHAR2(100) := '';
        lstVVAplica  VARCHAR2(100);
        lstVVCheck   VARCHAR2(100);
        lstVVSelect  VARCHAR2(100);
        lstVVFecha   VARCHAR2(100);
    BEGIN
        BEGIN
            SELECT VAL_VALOR
            INTO   lstVVCheck
            FROM   DERCORP_ADD_CAMPO_VALOR_TAB
            WHERE  1=1
            AND    ID_EMPRESA   = PARAM_ID_EMPRESA
            AND    ID_ADD_CAMPO  = '1160'
            ;
        EXCEPTION
          WHEN NO_DATA_FOUND THEN
               lstVVCheck := NULL;
        END;
        BEGIN
            SELECT TRIM(VAL_VALOR)
            INTO   lstVVSelect
            FROM   DERCORP_ADD_CAMPO_VALOR_TAB
            WHERE  1=1
            AND    ID_EMPRESA   = PARAM_ID_EMPRESA
            AND    ID_ADD_CAMPO  = '1162'
            ;
        EXCEPTION
          WHEN NO_DATA_FOUND THEN
              lstVVSelect := 0;
        END;
        BEGIN
            SELECT VAL_VALOR
            INTO   lstVVFecha
            FROM   DERCORP_ADD_CAMPO_VALOR_TAB
            WHERE  1=1
            AND    ID_EMPRESA   = PARAM_ID_EMPRESA
            AND    ID_ADD_CAMPO  = '1163'
            ;
        EXCEPTION
          WHEN NO_DATA_FOUND THEN
            lstVVFecha := NULL;
        END;
        -- Aplica
        BEGIN
          SELECT VAL_VALOR
          INTO   lstVVAplica
          FROM   DERCORP_ADD_CAMPO_VALOR_TAB
          WHERE  1=1
          AND    ID_EMPRESA   = PARAM_ID_EMPRESA
          AND    ID_ADD_CAMPO  = '1024'
          ;
        EXCEPTION
          WHEN NO_DATA_FOUND THEN
            lstVVAplica := NULL;
        END;
        lstSemaStat := 'semaforo_red.png';
        --Escritura Constitutiva
        IF lstVVCheck  IS NOT NULL OR (lstVVSelect <> '0' AND lstVVFecha  IS NOT NULL) THEN
        --IF lstVVSelect != '0' AND lstVVFecha  IS NOT NULL THEN
        --IF lstVVSelect <> '0' THEN
            lstSemaStat := 'semaforo_green.png';
        END IF;
        --
        IF lstVVAplica IS NULL THEN
            lstSemaStat := 'semaforo_green.png';
        END IF;
        INSERT INTO DERCORP_ADD_CAMPO_VALOR_TAB(ID_ADD_CAMPO,
                                                ID_EMPRESA,
                                                FEC_CREATION_DATE)
        SELECT
          DA_CAMPO.ID_ADD_CAMPO, PARAM_ID_EMPRESA, SYSDATE
        FROM
          DERCORP_ADD_CAMPO_TAB DA_CAMPO
        WHERE
          DA_CAMPO.COD_CAMPO = 'C1132'
        AND
            NOT EXISTS (SELECT 1
                        FROM DERCORP_ADD_CAMPO_VALOR_TAB
                        WHERE
                        ID_ADD_CAMPO = 1132
                        AND
                        ID_EMPRESA = PARAM_ID_EMPRESA
                        )
        ;
        UPDATE DERCORP_ADD_CAMPO_VALOR_TAB
        SET    VAL_VALOR = lstSemaStat
        WHERE  1=1
        AND    ID_EMPRESA   = PARAM_ID_EMPRESA
        AND    ID_ADD_CAMPO = '1132'
        ;
    END SAVE_SEMAFORO_PR;
    --
    -- NAVA - May17
    --
    FUNCTION GET_DENOM_ACTUAL_FN(PARAM_ID_EMPRESA INT) RETURN VARCHAR
    AS
        VTN_VALUE VARCHAR(255);
    BEGIN
          SELECT
            VAL_CAT_VAL INTO VTN_VALUE
          FROM
            DERCORP_ADD_CAMPO_CAT_VAL_TAB
          WHERE
            ID_CATALOGO     = 1
            AND
              ID_CATALOGO_VALOR =
                      (SELECT VAL_VALOR
                      FROM DERCORP_ADD_CAMPO_VALOR_TAB
                      WHERE ID_EMPRESA = PARAM_ID_EMPRESA
                      AND ID_ADD_CAMPO = 500
                      );
        RETURN VTN_VALUE;
    END GET_DENOM_ACTUAL_FN;
    --
    -- NAVA - Abr21
    --
    FUNCTION GET_VALOR_TEORICO_NOMINAL_FN(PARAM_ID_EMPRESA INT) RETURN VARCHAR
    AS
        VTN_VALUE VARCHAR(255);
        VAR_VAL_VALOR   VARCHAR2(254);
    BEGIN
          SELECT
            --ATRIBUTO1 INTO VTN_VALUE
            VAL_CAT_VAL INTO VTN_VALUE
          FROM
            DERCORP_ADD_CAMPO_CAT_VAL_TAB
          WHERE
            ID_CATALOGO     = 9
            AND
              ID_CATALOGO_VALOR =
                      (SELECT VAL_VALOR
                      FROM DERCORP_ADD_CAMPO_VALOR_TAB
                      WHERE ID_EMPRESA = PARAM_ID_EMPRESA
                      AND ID_ADD_CAMPO = 519--1076 -- Se cambio de Valor teorico nominal a Valor Nominal se deja el mismo nombre del paquete
                      );
        VAR_VAL_VALOR := REPLACE(VTN_VALUE, '$', ',');
        VAR_VAL_VALOR := REPLACE(VAR_VAL_VALOR, ',', '');
        RETURN VAR_VAL_VALOR;
    END GET_VALOR_TEORICO_NOMINAL_FN;
    --
    -- NAVA - Abr27
    --
    FUNCTION GET_MONEDA_ECS_FN(PARAM_ID_EMPRESA INT) RETURN VARCHAR
    AS
        VAL_NOMINAL INT;
        MONEDA_VAL_NOMINAL VARCHAR(255);
        MONEDA_VAL_TEOR_NOMINAL VARCHAR(255);
    BEGIN
        VAL_NOMINAL := 0;
          BEGIN
                SELECT
                    count(*) INTO VAL_NOMINAL
                FROM
                  DERCORP_ADD_CAMPO_CAT_VAL_TAB
                WHERE
                  ID_CATALOGO     = 9
                  AND
                    ID_CATALOGO_VALOR =
                            (SELECT VAL_VALOR
                            FROM DERCORP_ADD_CAMPO_VALOR_TAB
                            WHERE ID_EMPRESA = PARAM_ID_EMPRESA
                            AND ID_ADD_CAMPO = 519
                            )
                  AND
                    NOM_CAT_VAL LIKE '%$%' OR NOM_CAT_VAL LIKE '%Valor Desigual'
                            ;
            EXCEPTION
                WHEN OTHERS THEN
                    --
                    NULL;
            END;
          BEGIN
             SELECT
              NOM_CAT_VAL INTO MONEDA_VAL_NOMINAL
              FROM
                DERCORP_ADD_CAMPO_CAT_VAL_TAB
              WHERE
                ID_CATALOGO     = 20
                AND
                  ID_CATALOGO_VALOR =
                          (SELECT VAL_VALOR
                          FROM DERCORP_ADD_CAMPO_VALOR_TAB
                          WHERE ID_EMPRESA = PARAM_ID_EMPRESA
                          AND ID_ADD_CAMPO = 520
                          );
          EXCEPTION
              WHEN OTHERS THEN
                  --
                  NULL;
          END;
         IF LENGTH(MONEDA_VAL_NOMINAL) > 0 AND VAL_NOMINAL > 0  THEN
            RETURN MONEDA_VAL_NOMINAL;
         END IF;
         /*SELECT
          NOM_CAT_VAL INTO MONEDA_VAL_TEOR_NOMINAL
          FROM
            DERCORP_ADD_CAMPO_CAT_VAL_TAB
          WHERE
            ID_CATALOGO     = 20
            AND
              ID_CATALOGO_VALOR =
                      (SELECT VAL_VALOR
                      FROM DERCORP_ADD_CAMPO_VALOR_TAB
                      WHERE ID_EMPRESA = PARAM_ID_EMPRESA
                      AND ID_ADD_CAMPO = 1077
                      );
          IF LENGTH(MONEDA_VAL_TEOR_NOMINAL) > 0 THEN
              RETURN MONEDA_VAL_TEOR_NOMINAL;
          END IF;*/
          RETURN '';
         --RETURN 'CUC';
         /*
          SELECT
            ATRIBUTO1 INTO VTN_VALUE
          FROM
            DERCORP_ADD_CAMPO_CAT_VAL_TAB
          WHERE
            ID_CATALOGO     = 9
            AND
              ID_CATALOGO_VALOR =
                      (SELECT VAL_VALOR
                      FROM DERCORP_ADD_CAMPO_VALOR_TAB
                      WHERE ID_EMPRESA = PARAM_ID_EMPRESA
                      AND ID_ADD_CAMPO = 1076 -- Valor Teorico Nominal
                      );
        RETURN VTN_VALUE;
        */
    END GET_MONEDA_ECS_FN;
    --ECM 05 MAYO 2016 - CAPTURA - RESUMEN GENERAL - NOMBRE CORTO
    PROCEDURE CAMBIAR_NOMBRE_CORTO_PR(PARAM_ID_EMPRESA INT)
    IS
    BEGIN
        UPDATE DERCORP_ADD_CAMPO_VALOR_TAB SET VAL_VALOR = (
            SELECT    NOM_CAT_VAL
            FROM      DERCORP_ADD_CAMPO_CAT_VAL_TAB
            WHERE     1=1
            AND       ID_CATALOGO = 1
            AND       ID_CATALOGO_VALOR = (
                                            SELECT  VAL_VALOR
                                            FROM    DERCORP_ADD_CAMPO_VALOR_TAB
                                            WHERE   1=1
                                            AND     ID_EMPRESA = PARAM_ID_EMPRESA
                                            AND     ID_ADD_CAMPO = 500 --Denominacion Actual
                                          )
        )
        WHERE 1=1
        AND   ID_EMPRESA = PARAM_ID_EMPRESA
        AND   ID_ADD_CAMPO = 501 --Nombre Corto
        ;
        UPDATE DERCORP_ADD_CAMPO_VALOR_TAB  SET VAL_VALOR = (
                                            SELECT    ID_CATALOGO_VALOR
                                            FROM      DERCORP_ADD_CAMPO_CAT_VAL_TAB
                                            WHERE     1=1
                                            AND       ID_CATALOGO = 7
                                            AND       VAL_CAT_VAL = (
                                                                    SELECT    TRIM(ATRIBUTO2)
                                                                    FROM      DERCORP_ADD_CAMPO_CAT_VAL_TAB
                                                                    WHERE     1=1
                                                                    AND       ID_CATALOGO = 1
                                                                    AND       ID_CATALOGO_VALOR = (
                                                                                                    SELECT  VAL_VALOR
                                                                                                    FROM    DERCORP_ADD_CAMPO_VALOR_TAB
                                                                                                    WHERE   1=1
                                                                                                    AND     ID_EMPRESA = PARAM_ID_EMPRESA
                                                                                                    AND     ID_ADD_CAMPO = 500 --Denominacion Actual
                                                                    )
                                            )
        )
        WHERE  1=1
        AND    ID_EMPRESA   = PARAM_ID_EMPRESA
        AND    ID_ADD_CAMPO = 509 --Pais
        ;
        UPDATE DERCORP_ADD_CAMPO_VALOR_TAB SET VAL_VALOR = (
                    SELECT    ATRIBUTO1
                    FROM      DERCORP_ADD_CAMPO_CAT_VAL_TAB
                    WHERE     1=1
                    AND       ID_CATALOGO = 1
                    AND       ID_CATALOGO_VALOR = (
                                                    SELECT  VAL_VALOR
                                                    FROM    DERCORP_ADD_CAMPO_VALOR_TAB
                                                    WHERE   1=1
                                                    AND     ID_EMPRESA = PARAM_ID_EMPRESA
                                                    AND     ID_ADD_CAMPO = 500 --Denominacion Actual
                    )
        )
        WHERE  1=1
        AND    ID_EMPRESA   = PARAM_ID_EMPRESA
        AND    ID_ADD_CAMPO = 529 --RFC
        ;
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('ERROR CODE: '||SQLCODE);
        DBMS_OUTPUT.PUT_LINE('ERROR MSG: '||SQLERRM);
    END CAMBIAR_NOMBRE_CORTO_PR;
    --ECM 11 Mayo 2016 - Captura - Administracion y Vig - Borrar registros en flex que no se muestran.
    PROCEDURE BORRAR_REG_FLEX_ADM_PR(LI_ID_EMPRESA INT)
    IS
      linIdFlex     NUMBER := 0;
    CURSOR ADD_CAMPO_CUR IS
      SELECT    ID_ADD_CAMPO,
                COD_CAMPO
      FROM      DERCORP_ADD_CAMPO_TAB
      WHERE     1=1
      AND       ID_SECCION = 20
      AND       ID_SUBSECCION = 30
      AND       DES_TIPO_CAMPO = 'CHECKBOX_A'
      ORDER BY  ID_AGRUPACION
      ;
   CURSOR ADD_CAMPO_VALOR_CUR(tsIdEmpresa NUMBER, tsIdAddCampo VARCHAR2) IS
      SELECT  COUNT(1) AS Existe
      FROM    DERCORP_ADD_CAMPO_VALOR_TAB
      WHERE   1=1
      AND     ID_EMPRESA   = tsIdEmpresa
      AND     ID_ADD_CAMPO = tsIdAddCampo
      ;
    BEGIN
      FOR i IN ADD_CAMPO_CUR
      LOOP
          FOR j IN ADD_CAMPO_VALOR_CUR(LI_ID_EMPRESA, i.ID_ADD_CAMPO)
          LOOP
              BEGIN
                  SELECT  ID_FLEX_TBL
                  INTO    linIdFlex
                  FROM    DERCORP_ADD_CAMPO_TAB
                  WHERE   1=1
                  AND     ID_SECCION     = 20
                  AND     ID_SUBSECCION  = 30
                  AND     DES_TIPO_CAMPO = 'CHECKBOX_A'
                  AND     ID_ADD_CAMPO   = i.ID_ADD_CAMPO
                  ;
              EXCEPTION
                  WHEN NO_DATA_FOUND THEN
                      linIdFlex := 0;
              END;
            IF j.Existe = 0 THEN
              DBMS_OUTPUT.PUT_LINE(i.ID_ADD_CAMPO||' '||j.Existe||' '||linIdFlex);
              /*
              DELETE  FROM DERCORP_METATBL_TAB
              WHERE   1=1
              AND     ID_FLEX_TBL = linIdFlex
              AND     ID_EMPRESA  = LI_ID_EMPRESA
              ;
              */
              --ECM 19 Mayo 2016 Cambiar borrado fisico a logico.
              UPDATE  DERCORP_METATBL_TAB
              SET     VAL_C14 = NULL
              WHERE   1=1
              AND     ID_FLEX_TBL = linIdFlex
              AND     ID_EMPRESA  = LI_ID_EMPRESA
              ;
            ELSIF j.Existe = 1 THEN
                --ECM 19 Mayo 2016 Cambiar borrado fisico a logico.
                UPDATE  DERCORP_METATBL_TAB
                SET     VAL_C14 = 1
                WHERE   1=1
                AND     ID_FLEX_TBL = linIdFlex
                AND     ID_EMPRESA  = LI_ID_EMPRESA
                ;
            END IF;
          END LOOP;
      END LOOP;
    END BORRAR_REG_FLEX_ADM_PR;
    /*
    ECM 13 Mayo 2016
    Captura - Resumen General - Capital Social
    Borrar porcentaje de participacion cuando Socio Externo es 'No'
    */
    PROCEDURE BORRAR_PORCENTAJE_PAR_PR(LI_ID_EMPRESA INT)
    IS
    lstSocioExterno  VARCHAR2(2) := NULL;
    BEGIN
        BEGIN
            SELECT VAL_CAT_VAL
            INTO   lstSocioExterno
            FROM   DERCORP_ADD_CAMPO_CAT_VAL_TAB
            WHERE  1=1
            AND    ID_CATALOGO = 18
            AND    ID_CATALOGO_VALOR = (SELECT   VAL_VALOR
                                        FROM     DERCORP_ADD_CAMPO_VALOR_TAB
                                        WHERE    1=1
                                        AND      ID_EMPRESA   = LI_ID_EMPRESA
                                        AND      ID_ADD_CAMPO = 521
                                        )
            ;
        EXCEPTION
        WHEN NO_DATA_FOUND THEN
          lstSocioExterno := NULL;
        END;
        IF lstSocioExterno = 'No' THEN
            UPDATE DERCORP_ADD_CAMPO_VALOR_TAB
            SET    VAL_VALOR = ''
            WHERE  1=1
            AND    ID_EMPRESA   = LI_ID_EMPRESA
            AND    ID_ADD_CAMPO = 522
            ;
        END IF;
    END BORRAR_PORCENTAJE_PAR_PR;
    PROCEDURE GET_MONEDA_PR(PIIN_ID_EMPRESA IN NUMBER, PSTO_MONEDA OUT VARCHAR2)
    IS
      lstMoneda VARCHAR2(256);
      linMoneda NUMBER;
    BEGIN
      BEGIN
        SELECT  VAL_VALOR
        INTO    lstMoneda
        FROM    DERCORP_ADD_CAMPO_VALOR_TAB
        WHERE   1=1
        AND     ID_ADD_CAMPO = 520
        AND     ID_EMPRESA = PIIN_ID_EMPRESA
        ;
      EXCEPTION
          WHEN NO_DATA_FOUND THEN
              lstMoneda := NULL;
      END;
      IF lstMoneda = '0' OR lstMoneda IS NULL THEN
          BEGIN
            SELECT  VAL_VALOR
            INTO    lstMoneda
            FROM    DERCORP_ADD_CAMPO_VALOR_TAB
            WHERE   1=1
            AND     ID_ADD_CAMPO = 1077
            AND     ID_EMPRESA = PIIN_ID_EMPRESA
            ;
          EXCEPTION
              WHEN NO_DATA_FOUND THEN
                  lstMoneda := NULL;
          END;
      END IF;
        IF lstMoneda IS NOT NULL THEN
            linMoneda := TO_NUMBER(lstMoneda);
            BEGIN
                SELECT  VAL_CAT_VAL
                INTO    PSTO_MONEDA
                FROM    DERCORP_ADD_CAMPO_CAT_VAL_TAB
                WHERE   1=1
                AND     ID_CATALOGO = 20
                AND     ID_CATALOGO_VALOR = linMoneda
                ;
            EXCEPTION
                WHEN NO_DATA_FOUND THEN
                    PSTO_MONEDA := ' ';
            END;
        ELSE
            PSTO_MONEDA := ' ';
        END IF;
    END GET_MONEDA_PR;
  /*
      ECM 20 Septiembre 2016
      Captura - Resumen General - Informacion General
      Obtener telefono del Domicilio Comercial
  */
  PROCEDURE GET_TEL_COMERCIAL_PR(piinIdDomCom IN INT
                                ,postTelefono OUT VARCHAR2
  )
  IS
      lstTelefono VARCHAR2(32000);
  BEGIN
      SELECT Atributo1
      INTO   lstTelefono
      FROM   DERCORP_ADD_CAMPO_CAT_VAL_TAB
      WHERE  1=1
      AND    ID_CATALOGO_VALOR = piinIdDomCom
      ;
      postTelefono := lstTelefono;
  END GET_TEL_COMERCIAL_PR;
END DERCORP_CAPTURA_PKG;
/;
