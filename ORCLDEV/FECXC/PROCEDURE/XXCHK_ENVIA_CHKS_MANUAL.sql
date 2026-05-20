CREATE OR REPLACE EDITIONABLE PROCEDURE "FECXC"."XXCHK_ENVIA_CHKS_MANUAL" 
(
P_ID_SEC_CHEQ    IN  INTEGER,
P_MODIFIED_BY    IN  VARCHAR2,
P_NUEVO_ESTATUS  IN  INTEGER
)
IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
--******************************************************************
-- procedimiento automatico de cambio de estatus y envio de correos
-- creado por SOIN 'SOLUCIONES INTEGRALES'  (OMAR HERNANDEZ)
--******************************************************************
   V_CUAL_ERP         VARCHAR(2);
   V_MAIL_CLIENTE     VARCHAR(50);
   V_REFERENCIA       XXCHK_CAPTURA_CHEQUES.REFERENCIA_CLIENTE%TYPE;
   V_BANCO            XXCHK_CAPTURA_CHEQUES.ID_BANCO%TYPE;
   V_MONEDA           XXCHK_CAPTURA_CHEQUES.MONEDA%TYPE;
   V_EMPRESA          XXCHK_CAPTURA_CHEQUES.E_CODIGO%TYPE;
   V_IMPORTE          XXCHK_CAPTURA_CHEQUES.IMPORTE%TYPE;
   V_FECHA            XXCHK_CAPTURA_CHEQUES.DATE_CREATED%TYPE;
   V_PROCESADO        XXCHK_CAPTURA_CHEQUES.PROCESADO%TYPE;
   V_CLIENTE          XXCHK_CAPTURA_CHEQUES.ID_CLIENTE%TYPE;
   V_DESC_ESTADO      XXCHK_CATALOGO_BANCOS.DESCRIPCION_BANCO%TYPE;
   V_ID_ESTADO        XXCHK_CAPTURA_CHEQUES.ID_ESTADO_CHEQUE%TYPE;
   v_fecha_original   VARCHAR(10);
   v_fecha_c          DATE;
   v_usuario          INT:= 1;
   V_VALIDA           NUMBER;
   V_VALIDA2          NUMBER;
   V_EMPRESA_VAL      NUMBER;
   V_COMBINACION      NUMBER;
   V_COMBINACION2     NUMBER;
   V_ERROR            NUMBER;
   V_ERROR2           NUMBER;
   V_FIN_ERROR        NUMBER;
   V_STATUS                    VARCHAR2(50 BYTE);
   V_SET_OF_BOOKS_ID           NUMBER;
   V_ACCOUNTING_DATE           DATE;
   V_CURRENCY_CODE             VARCHAR2(3 BYTE);
   V_DATE_CREATED                 DATE;
   V_CREATED_BY                VARCHAR2(30 BYTE);
   V_ACTUAL_FLAG               VARCHAR2(1 BYTE);
   V_USER_JE_CATEGORY_NAME     VARCHAR2(25 BYTE);
   V_USER_JE_SOURCE_NAME       VARCHAR2(25 BYTE);
   V_CURRENCY_CONVERTION_DATE  DATE;
   V_CURRENCY_CONVERTION_RATE  NUMBER;
   V_SEGMENT1                  VARCHAR2(25 BYTE);
   V_SEGMENT2                  VARCHAR2(25 BYTE);
   V_SEGMENT3                  VARCHAR2(25 BYTE);
   V_SEGMENT4                  VARCHAR2(25 BYTE);
   V_SEGMENT5                  VARCHAR2(25 BYTE);
   V_SEGMENT6                  VARCHAR2(25 BYTE);
   V_SEGMENT7                  VARCHAR2(25 BYTE);
   V_ENTERED_DR                NUMBER;
   V_ENTERED_CR                NUMBER;
   V_ACCOUNTED_DR              NUMBER;
   V_ACCOUNTED_CR              NUMBER;
   V_REFERENCE1                VARCHAR2(100 BYTE);
   V_REFERENCE2                VARCHAR2(100 BYTE);
   V_PERIOD_NAME               VARCHAR2(2 BYTE);
   V_CODE_COMBINATION_ID       NUMBER;
   V_GROUP_ID                  NUMBER;
   V_CHEQUE                    NUMBER;
   V_TIPO_OPERACION            NUMBER;
   V_NVO_ESTADO                NUMBER;
   V_LIBRO                       NUMBER;
   V_DEC_EDO                   VARCHAR2(100 BYTE);
   V_MONEDA_VAL                  XXCHK_CAPTURA_CHEQUES.MONEDA%TYPE;
   SECUENCIA1                  INT;
   SECUENCIA2                  INT;
   INCREMENTO                  INT;
   VALIDA_MONEDA                 INT; --OJO OOC
   V_CIA                       VARCHAR2(25 BYTE);
   V_MONEDA_F                   VARCHAR2(15 BYTE);
   NOT_VALID_MON                 exception;
   ESTATUS_NO_VALIDO             exception;
   INSERTA_GL                   exception;
   INSERTA_GL_INTERFACE_CHK       exception;
   ACTUALIZA_INTERFACE_CHK       exception;
   ACTUALIZA_HISTORICO           exception;
    CURSOR VALIDA_COMBINACION IS
    SELECT C.C_ABONO_ERP, C.C_CARGO_ERP, A.E_CODIGO, A.MONEDA
    FROM   XXCHK_CAPTURA_CHEQUES A,
              XXCHK_CAT_EDO_CHEQUE C,
              gl.gl_code_combinations@ERP_PROD D,
              FECXC_EMPRESAS E,
              XXCHK_CAT_EDOS G
    WHERE  A.ID_SEC_CHEQUE = P_ID_SEC_CHEQ
    AND    A.E_CODIGO = C.E_CODIGO
    AND    A.ID_ESTADO_CHEQUE = C.ID_ESTADO_CHEQUE
    AND   A.E_CODIGO = E.E_CODIGO
    AND   A.ID_ESTADO_CHEQUE = G.ID_ESTADO_CHEQUE
    AND   C.C_ABONO_ERP = D.CODE_COMBINATION_ID
    AND   C.CONTABILIZA=1
    AND   E.CUAL_ERP= 'O'
    GROUP BY C.C_ABONO_ERP, C.C_CARGO_ERP, A.E_CODIGO, A.MONEDA
    ORDER BY A.E_CODIGO ,A.MONEDA ASC;
    l_maicon utl_smtp.connection;
BEGIN
--**************************************************
--  VALIDAR SI SE PUEDE HACER EL CAMBIO  DE ESTATUS
--**************************************************
  IF P_NUEVO_ESTATUS IS NOT NULL THEN
    BEGIN
              SELECT decode(count(*),0,1,1)
              INTO      V_NVO_ESTADO
              FROM      XXCHK_CAPTURA_CHEQUES A,
                     XXCHK_CAT_CAMBIOS_ESTADO B
              WHERE  A.ID_SEC_CHEQUE = P_ID_SEC_CHEQ
              AND    A.ID_ESTADO_CHEQUE = B.ID_ESTADO_CHEQUE
              AND    B.ID_ESTADO_B = P_NUEVO_ESTATUS;
      END;
    IF  V_NVO_ESTADO = 1 THEN
           UPDATE XXCHK_CAPTURA_CHEQUES A
           SET ID_ESTADO_CHEQUE = P_NUEVO_ESTATUS
           WHERE A.ID_SEC_CHEQUE = P_ID_SEC_CHEQ;
    END IF;
    ELSE  IF P_NUEVO_ESTATUS IS NULL THEN
           V_NVO_ESTADO := 1;
    END IF;
  END IF;
-- **************************************************
-- valida la empresa a donde pertenece soin u oracle
-- **************************************************
    SELECT  CUAL_ERP
    INTO    V_CUAL_ERP
    FROM    XXCHK_CAPTURA_CHEQUES xxcch, FECXC_EMPRESAS fcxce
    WHERE  xxcch.ID_SEC_CHEQUE=P_ID_SEC_CHEQ
    AND  fcxce.E_CODIGO=xxcch.E_CODIGO;
--**************************************************
--ACTUALIZA TABLA HISTORICO  DE LOS CHEQUES
--QUE CAMBIARON DE SALVO BUEN COBRE MANUALMENTE
--**************************************************
  INSERT INTO XXCHK_CHEQ_ALL_HIST (
                                    E_CODIGO,
                                    NO_CHEQUE,
                                    ID_SEC_CHEQUE,
                                    MODIFIED_BY,
                                    TIPO_CHEQ,
                                    REFERENCIA_CLIENTE,
                                    PROCESADO,
                                    ID_ESTADO_CHEQUE
                                )
  SELECT  A.E_CODIGO,
          A.NO_CHEQUE,
          A.ID_SEC_CHEQUE,
          P_MODIFIED_BY,
          'Manual',
          A.REFERENCIA_CLIENTE,
          CASE WHEN V_CUAL_ERP='O' THEN 1 ELSE 9 END,
          A.ID_ESTADO_CHEQUE
  FROM       XXCHK_CAPTURA_CHEQUES A
  WHERE   A.ID_SEC_CHEQUE = P_ID_SEC_CHEQ;
DBMS_OUTPUT.PUT_LINE ('NEW');
--****************************************
--ACTUZALIZA GL_INTERFACE_CHK
--****************************************
    OPEN VALIDA_COMBINACION;
      LOOP
         FETCH VALIDA_COMBINACION
         INTO V_VALIDA,V_VALIDA2,V_EMPRESA_VAL, V_MONEDA_VAL;
         EXIT WHEN VALIDA_COMBINACION%NOTFOUND;
         DBMS_OUTPUT.PUT_LINE ('ENTRO AL CURSOR'|| TO_CHAR(V_VALIDA) || '  '||TO_CHAR(V_EMPRESA_VAL));
--**************************************
--NUEVO SECUENCIAS
-- *************************************
         LOOP
         EXIT WHEN SECUENCIA1=SECUENCIA2;
                    SELECT XXCHK_GROUP_ID_ABONO.NEXTVAL
                    INTO SECUENCIA1
                    FROM DUAL;
                    SELECT XXCHK_GROUP_ID_CARGO.NEXTVAL
                    INTO SECUENCIA2
                    FROM DUAL;
                     IF SECUENCIA1>SECUENCIA2 THEN
                        SELECT XXCHK_GROUP_ID_CARGO.NEXTVAL
                        INTO INCREMENTO
                        FROM DUAL;
                        ELSE IF SECUENCIA1<SECUENCIA2 THEN
                                SELECT XXCHK_GROUP_ID_ABONO.NEXTVAL
                                INTO INCREMENTO
                                FROM DUAL;
                        END IF;
                      END IF;
        END LOOP;
          DBMS_OUTPUT.PUT_LINE ('SALIO DE SECUENCIAS'|| TO_CHAR(V_VALIDA) || '  '||TO_CHAR(V_EMPRESA_VAL));
--***********************************************************
--  valida si existe la code_combination_:id
-- **********************************************************
   BEGIN
          DBMS_OUTPUT.PUT_LINE ('ENTRO EN ASIGNAR COMBINACION  '|| TO_CHAR(V_VALIDA));
       V_COMBINACION:=V_VALIDA;
       V_COMBINACION2:=V_VALIDA2;
       DBMS_OUTPUT.PUT_LINE ('ESTO VALE LA COMBINACION DESPUES DE ASIGNAR '|| TO_CHAR(V_COMBINACION2));
       SELECT SEGMENT1
       INTO   V_CIA
       FROM   GL_CODE_COMBINATIONS@ERP_PROD
       WHERE  CODE_COMBINATION_ID=V_VALIDA;
       DBMS_OUTPUT.PUT_LINE ('ESTO VALE LA COMPA?IA'|| TO_CHAR(V_CIA));
       SELECT DISTINCT SET_OF_BOOKS_ID
       INTO   V_LIBRO
       FROM   XXFM_CIA_LIBRO_V@ERP_PROD
       WHERE  COMPANIA=V_CIA;
       SELECT DISTINCT CURRENCY_CODE
       INTO   V_MONEDA_F
       FROM   GL.GL_SETS_OF_BOOKS@ERP_PROD
       WHERE  SET_OF_BOOKS_ID=V_LIBRO;
       DBMS_OUTPUT.PUT_LINE ('ESTO VALE EL LIBRO '|| TO_CHAR(V_LIBRO));
       DBMS_OUTPUT.PUT_LINE ('ESTO VALE LA MONEDA FUNCIONAL'|| TO_CHAR(V_MONEDA_F));
       DBMS_OUTPUT.PUT_LINE ('ESTO VALE LA MONEDA DEL CHEQUE'|| TO_CHAR(V_MONEDA_VAL));
   END;
   DBMS_OUTPUT.PUT_LINE ('ESTO VALE COMPA?IA DE LA COMBINACION'|| TO_CHAR(V_CIA));
--***********************************************************
--  valida si existe el tipo de cambio al d?a
-- **********************************************************
   IF V_MONEDA_VAL='MN' THEN
         DBMS_OUTPUT.PUT_LINE ('ENTRO EN ASIGNAR MXP');
      SELECT 'MXP' INTO V_MONEDA_VAL FROM DUAL;
   END IF;
   IF V_MONEDA_VAL='PC' THEN
         DBMS_OUTPUT.PUT_LINE ('ENTRO EN ASIGNAR PC');
      SELECT 'COP' INTO V_MONEDA_VAL FROM DUAL;
   END IF;
   IF V_MONEDA_VAL<>V_MONEDA_F THEN
   BEGIN
             DBMS_OUTPUT.PUT_LINE ('ENTRO EN VALIDAR MONEDA EXTRANJERA');
          IF V_MONEDA_VAL='PAD' THEN SELECT 'ARS' INTO V_MONEDA_VAL FROM DUAL; END IF;
          IF V_MONEDA_VAL='DLA' THEN SELECT 'AUD' INTO V_MONEDA_VAL FROM DUAL; END IF;
          IF V_MONEDA_VAL='BRA' THEN SELECT 'BRL' INTO V_MONEDA_VAL FROM DUAL; END IF;
          IF V_MONEDA_VAL='DLC' THEN SELECT 'CAD' INTO V_MONEDA_VAL FROM DUAL; END IF;
          IF V_MONEDA_VAL='FS'     THEN SELECT 'CHF' INTO V_MONEDA_VAL FROM DUAL; END IF;
          IF V_MONEDA_VAL='MA'     THEN SELECT 'DEM' INTO V_MONEDA_VAL FROM DUAL; END IF;
          IF V_MONEDA_VAL='PS'     THEN SELECT 'ESP' INTO V_MONEDA_VAL FROM DUAL; END IF;
          IF V_MONEDA_VAL='EUR' THEN SELECT 'EUR' INTO V_MONEDA_VAL FROM DUAL; END IF;
          IF V_MONEDA_VAL='FF'     THEN SELECT 'FRF' INTO V_MONEDA_VAL FROM DUAL; END IF;
          IF V_MONEDA_VAL='LIE' THEN SELECT 'GBP' INTO V_MONEDA_VAL FROM DUAL; END IF;
          IF V_MONEDA_VAL='LI'     THEN SELECT 'ITL' INTO V_MONEDA_VAL FROM DUAL; END IF;
          IF V_MONEDA_VAL='YEN' THEN SELECT 'JPY' INTO V_MONEDA_VAL FROM DUAL; END IF;
          IF V_MONEDA_VAL='FLH' THEN SELECT 'NLG' INTO V_MONEDA_VAL FROM DUAL; END IF;
          IF V_MONEDA_VAL='COR' THEN SELECT 'SEK' INTO V_MONEDA_VAL FROM DUAL; END IF;
          IF V_MONEDA_VAL='DLS' THEN SELECT 'USD' INTO V_MONEDA_VAL FROM DUAL; END IF;
          IF V_MONEDA_VAL='BOL' THEN SELECT 'VEB' INTO V_MONEDA_VAL FROM DUAL; END IF;
          IF V_MONEDA_VAL='MN'     THEN SELECT 'MXP' INTO V_MONEDA_VAL FROM DUAL; END IF;
          IF V_MONEDA_VAL='ARS' THEN SELECT 'ARS' INTO V_MONEDA_VAL FROM DUAL; END IF;
          IF V_MONEDA_VAL='PC' THEN SELECT 'COP' INTO V_MONEDA_VAL FROM DUAL; END IF;
          SELECT TO_CHAR(date_created, 'DD/MM/YYYY')
          INTO   V_FECHA_ORIGINAL
          FROM   XXCHK_CAPTURA_CHEQUES
          WHERE  ID_SEC_CHEQUE=P_ID_SEC_CHEQ;
          SELECT 1
          INTO   VALIDA_MONEDA
          FROM    GL.GL_DAILY_RATES@ERP_PROD a
          WHERE  FROM_CURRENCY=V_MONEDA_VAL
          AND    TO_CURRENCY=V_MONEDA_F
          AND    CONVERSION_TYPE='Corporate'
          AND    TO_CHAR(CONVERSION_DATE,'DD/MM/YYYY')=V_FECHA_ORIGINAL;
          EXCEPTION
                      WHEN NO_DATA_FOUND THEN
                       RAISE NOT_VALID_MON;
          END;
     END IF;
---------------------------------------------------------------------------
     IF V_COMBINACION  IS NOT NULL THEN
        IF V_COMBINACION2  IS NOT NULL THEN
--*******************************
--VALIDAR QUE TIPO DE MONEDA ES
--*******************************
       IF V_MONEDA_VAL <> V_MONEDA_F THEN --OJO OOC
--****************************************
--PARA INSERTAR REGISTROS EN LA TABLA DE GL_INTERFACE  DE CARGO  MONEDA EXTRANJERA
--****************************************
    BEGIN
    DBMS_OUTPUT.PUT_LINE ('INSERTA CARGO EN INTERFAZ GL CHEQUES MONEDA EXTRANJERA');
    DBMS_OUTPUT.PUT_LINE ('ESTO VALE EL LIBRO '||TO_CHAR(V_LIBRO));
    DBMS_OUTPUT.PUT_LINE ('ESTO VALE LA MONEDA EN EXTRANJERA '||TO_CHAR(V_MONEDA_VAL));
    INSERT INTO XXCHK_GL_INTERFACE_CHK (
                                        ID_SEC_CHEQUE,
                                        ID_ESTADO_CHEQUE,
                                        STATUS,
                                        SET_OF_BOOKS_ID,
                                        ACCOUNTING_DATE,
                                        CURRENCY_CODE,
                                        CURRENCY_CONVERSION_DATE,
                                        USER_CURRENCY_CONVERSION_TYPE,
                                        CURRENCY_CONVERSION_RATE,
                                        ACTUAL_FLAG,
                                        USER_JE_SOURCE_NAME,
                                        USER_JE_CATEGORY_NAME,
                                        ENTERED_DR,
                                        ENTERED_CR,
                                        ACCOUNTED_DR,
                                        ACCOUNTED_CR,
                                        SEGMENT1,
                                        SEGMENT2,
                                        SEGMENT3,
                                        SEGMENT4,
                                        SEGMENT5,
                                        SEGMENT6,
                                        SEGMENT7,
                                        GROUP_ID,
                                        REFERENCE1,
                                        PERIOD_NAME,
                                        DATE_CREATED,
                                        CREATED_BY
                                          )
                                        SELECT           secuencia,
                                                       id_estado,
                                                    'NEW',
                                                    SET_OF_BOOKS_ID,
                                                    FEC1,
                                                    MONEDA,
                                                    FECHA,
                                                    USUARIO,
                                                    CONVERSION,
                                                    'A',
                                                    'ESTATUS_CHEQUE',
                                                    EST_2,
                                                    DR,
                                                    CR,
                                                    DR_ME,
                                                    CR_ME,
                                                    segment1,
                                                    segment2,
                                                    segment3,
                                                    segment4,
                                                    segment5,
                                                    segment6,
                                                    segment7,
                                                    --CASE GRUPO WHEN 0 THEN
                                                    --XXCHK_GROUP_ID_CARGO.NEXTVAL END AS GRUPO_ID,
                                                    SECUENCIA1,
                                                    reference1,
                                                    period_name,
                                                    SYSDATE,
                                                    'SISTEMA'
                                    FROM (
                                              SELECT DISTINCT      c.ID_SEC_CHEQUE as secuencia,
                                                                c.ID_ESTADO_CHEQUE as id_estado,
                                                                'NEW',
                                                                V_LIBRO AS SET_OF_BOOKS_ID,
                                                                TO_CHAR(SYSDATE, 'DD/MON/YY')  AS FEC1,
                                                                V_MONEDA_VAL AS MONEDA,
                                                                TO_CHAR(c.DATE_CREATED, 'DD/MON/YY')  AS FECHA,
                                                                'Corporate'  as usuario,
                                                                I.conversion_rate as conversion,
                                                                'A',
                                                                'ESTATUS_CHEQUE',
                                                                'ESTATUS_CHEQUE' AS EST_2,
                                                                c.importe AS DR,
                                                                0 AS CR,
                                                                (c.importe*I.conversion_rate) AS DR_ME,
                                                                0 AS CR_ME,
                                                                a.segment1,
                                                                a.segment2,
                                                                a.segment3,
                                                                a.segment4,
                                                                a.segment5,
                                                                a.segment6,
                                                                a.segment7,
                                                                0 AS GRUPO,
                                                                a.segment1||'-'||C.NO_CHEQUE||'-'||H.DESCRIPCION AS reference1,
                                                                TO_CHAR(SYSDATE, 'MON-YY') AS period_name,
                                                                SYSDATE,
                                                                'SISTEMA'
                                             FROM     gl.gl_code_combinations@ERP_PROD a,
                                                      XXCHK_CAT_EDO_CHEQUE b,
                                                         XXCHK_CAPTURA_CHEQUES c,
                                                         XXCHK_CHEQ_ALL_HIST f,
                                                         FECXC_EMPRESAS g,
                                                      XXCHK_CAT_EDOS H,
                                                      gl.gl_daily_rates@ERP_PROD I
                                             WHERE    a.code_combination_id = b.c_cargo_erp
                                                      AND    b.c_cargo_erp = V_VALIDA2
                                                      AND    b.id_estado_cheque = c.id_estado_cheque
                                                      AND    c.e_codigo = f.e_codigo
                                                      AND    c.e_codigo = g.e_codigo
                                                      AND    (c.PROCESADO IS NULL
                                                      OR     c.PROCESADO = 200)
                                                      AND    c.ID_SEC_CHEQUE = P_ID_SEC_CHEQ
                                                      AND    C.ID_ESTADO_CHEQUE = H.ID_ESTADO_CHEQUE
                                                      AND    b.e_codigo = c.e_codigo
                                                      AND    c.e_codigo = V_EMPRESA_VAL
                                                      AND    c.referencia_cliente = f.referencia_cliente
                                                      AND    I.FROM_CURRENCY = V_MONEDA_VAL
                                                      AND    I.TO_CURRENCY = V_MONEDA_F
                                                      AND    I.CONVERSION_TYPE ='Corporate'
                                                      AND    TO_CHAR(I.conversion_date,'DD/MM/YYYY')= v_fecha_original
                                                      AND    f.procesado = 1
                                                      AND    b.contabiliza = 1
                                                      AND    g.CUAL_ERP= 'O'
                                                      );
                                                    EXCEPTION
                                                    WHEN OTHERS THEN
                                                    RAISE INSERTA_GL;
    END;
--************************************************************************************
-- PARA INSERTAR REGISTROS EN LA TABLA DE GL_INTERFACE  ABONO MONEDA EXTRANJERA
--***********************************************************************************
BEGIN
    DBMS_OUTPUT.PUT_LINE ('INSERTA ABONO EN INTERFAZ GL CHEQUES MONEDA EXTRANJERA');
    DBMS_OUTPUT.PUT_LINE ('ESTO VALE EL LIBRO '||TO_CHAR(V_LIBRO));
    DBMS_OUTPUT.PUT_LINE ('ESTO VALE LA MONEDA EN EXTRANJERA'||TO_CHAR(V_MONEDA_VAL));
    INSERT INTO XXCHK_GL_INTERFACE_CHK (
                                            ID_SEC_CHEQUE,
                                            ID_ESTADO_CHEQUE,
                                            STATUS,
                                            SET_OF_BOOKS_ID,
                                            ACCOUNTING_DATE,
                                            CURRENCY_CODE,
                                            CURRENCY_CONVERSION_DATE,
                                            USER_CURRENCY_CONVERSION_TYPE,
                                            CURRENCY_CONVERSION_RATE,
                                           ACTUAL_FLAG,
                                            USER_JE_SOURCE_NAME,
                                            USER_JE_CATEGORY_NAME,
                                            ENTERED_DR,
                                            ENTERED_CR,
                                            ACCOUNTED_DR,
                                            ACCOUNTED_CR,
                                            SEGMENT1,
                                            SEGMENT2,
                                            SEGMENT3,
                                            SEGMENT4,
                                            SEGMENT5,
                                            SEGMENT6,
                                            SEGMENT7,
                                            GROUP_ID,
                                            REFERENCE1,
                                            PERIOD_NAME,
                                            DATE_CREATED,
                                            CREATED_BY
                                          )
                                            SELECT
                                                    secuencia,
                                                    id_estado,
                                                    'NEW',
                                                    SET_OF_BOOKS_ID,
                                                    FEC1,
                                                    MONEDA,
                                                    FECHA,
                                                    USUARIO,
                                                    CONVERSION,
                                                    'A',
                                                    'ESTATUS_CHEQUE',
                                                    EST_2,
                                                    DR,
                                                    CR,
                                                    DR_ME,
                                                    CR_ME,
                                                    segment1,
                                                    segment2,
                                                    segment3,
                                                    segment4,
                                                    segment5,
                                                    segment6,
                                                    segment7,
                                                    --CASE GRUPO WHEN 0 THEN
                                                    --XXCHK_GROUP_ID_ABONO.NEXTVAL END AS GRUPO_ID,
                                                    SECUENCIA1,
                                                    reference1,
                                                    period_name,
                                                    SYSDATE,
                                                    'SISTEMA'
                                            FROM (
                                                    SELECT DISTINCT
                                                                    c.ID_SEC_CHEQUE as secuencia,
                                                                    c.ID_ESTADO_CHEQUE as id_estado,
                                                                    'NEW',
                                                                    V_LIBRO as SET_OF_BOOKS_ID,
                                                                    TO_CHAR(SYSDATE, 'DD/MON/YY')  AS FEC1,
                                                                    V_MONEDA_VAL AS MONEDA,
                                                                    TO_CHAR(c.date_created, 'DD/MON/YY')  AS FECHA,
                                                                    'Corporate'  as usuario,
                                                                    I.conversion_rate as conversion,
                                                                    'A',
                                                                    'ESTATUS_CHEQUE',
                                                                    'ESTATUS_CHEQUE' AS EST_2,
                                                                    0 AS DR,
                                                                    c.importe AS CR,
                                                                    0 AS DR_ME,
                                                                    (c.importe*I.conversion_rate) AS CR_ME,
                                                                    a.segment1,
                                                                    a.segment2,
                                                                    a.segment3,
                                                                    a.segment4,
                                                                    a.segment5,
                                                                    a.segment6,
                                                                    a.segment7,
                                                                    0 AS GRUPO,
                                                                    a.segment1||'-'||C.NO_CHEQUE||'-'||H.DESCRIPCION AS reference1,
                                                                    TO_CHAR(SYSDATE, 'MON-YY') AS period_name,
                                                                    SYSDATE,
                                                                    'SISTEMA'
                                                     FROM              gl.gl_code_combinations@ERP_PROD a,
                                                                     XXCHK_CAT_EDO_CHEQUE b,
                                                                     XXCHK_CAPTURA_CHEQUES c,
                                                                     XXCHK_CHEQ_ALL_HIST f,
                                                                     FECXC_EMPRESAS g,
                                                                       XXCHK_CAT_EDOS H,
                                                                       gl.gl_daily_rates@ERP_PROD I
                                                     WHERE           a.code_combination_id = b.c_abono_erp
                                                     AND             b.c_abono_erp = V_VALIDA
                                                     AND             b.id_estado_cheque = c.id_estado_cheque
                                                     AND             c.e_codigo = f.e_codigo
                                                     AND             c.e_codigo = g.e_codigo
                                                     AND             (c.PROCESADO IS NULL
                                                     OR              c.PROCESADO = 200)
                                                     AND             c.ID_SEC_CHEQUE = P_ID_SEC_CHEQ
                                                     AND            C.ID_ESTADO_CHEQUE = H.ID_ESTADO_CHEQUE
                                                     AND            b.e_codigo = c.e_codigo
                                                     AND             c.e_codigo = V_EMPRESA_VAL
                                                     AND             c.referencia_cliente = f.referencia_cliente
                                                     AND             I.FROM_CURRENCY = V_MONEDA_VAL
                                                     AND             I.TO_CURRENCY = V_MONEDA_F
                                                     AND             I.CONVERSION_TYPE ='Corporate'
                                                     AND             TO_CHAR(I.conversion_date,'DD/MM/YYYY')=v_fecha_original
                                                     AND             f.procesado = 1
                                                     AND             b.contabiliza = 1
                                                     AND             g.CUAL_ERP= 'O'
                                                             );
                                                    EXCEPTION
                                                    WHEN OTHERS THEN
                                                    RAISE INSERTA_GL;
  END;
ELSE IF V_MONEDA_VAL = V_MONEDA_F THEN
    --****************************************
--PARA INSERTAR REGISTROS EN LA TABLA DE GL_INTERFACE  DE CARGO MONEDA LOCAL
--****************************************
BEGIN
    DBMS_OUTPUT.PUT_LINE ('INSERTA CARGO EN INTERFAZ GL CHEQUES');
    DBMS_OUTPUT.PUT_LINE ('ESTO VALE EL LIBRO '||TO_CHAR(V_LIBRO));
    DBMS_OUTPUT.PUT_LINE ('CARGO: ESTO VALE LA MONEDA EN MONEDA LOCAL'||TO_CHAR(V_MONEDA_VAL));
    INSERT INTO XXCHK_GL_INTERFACE_CHK (
                                        ID_SEC_CHEQUE,
                                        ID_ESTADO_CHEQUE,
                                        STATUS,
                                        SET_OF_BOOKS_ID,
                                        ACCOUNTING_DATE,
                                        CURRENCY_CODE,
                                        ACTUAL_FLAG,
                                        USER_JE_SOURCE_NAME,
                                        USER_JE_CATEGORY_NAME,
                                        ENTERED_DR,
                                        ENTERED_CR,
                                        ACCOUNTED_DR,
                                        ACCOUNTED_CR,
                                        SEGMENT1,
                                        SEGMENT2,
                                        SEGMENT3,
                                        SEGMENT4,
                                        SEGMENT5,
                                        SEGMENT6,
                                        SEGMENT7,
                                        GROUP_ID,
                                        REFERENCE1,
                                        PERIOD_NAME,
                                        DATE_CREATED,
                                        CREATED_BY
                                        )
                                SELECT  secuencia,
                                        id_estado,
                                        'NEW',
                                        SET_OF_BOOKS_ID,
                                        FEC1,
                                        MONEDA,
                                        'A',
                                        'ESTATUS_CHEQUE',
                                        EST_2,
                                        DR,
                                        CR,
                                        DR_ME,
                                        CR_ME,
                                        segment1,
                                        segment2,
                                        segment3,
                                        segment4,
                                        segment5,
                                        segment6,
                                        segment7,
                                        --CASE GRUPO WHEN 0 THEN
                                        --XXCHK_GROUP_ID_CARGO.NEXTVAL END AS GRUPO_ID,
                                        SECUENCIA2,
                                        reference1,
                                        period_name,
                                        SYSDATE,
                                        'SISTEMA'
                                 FROM (
                                        SELECT     DISTINCT
                                                c.ID_SEC_CHEQUE as secuencia,
                                                c.ID_ESTADO_CHEQUE as id_estado,
                                                'NEW',
                                                V_LIBRO AS SET_OF_BOOKS_ID,
                                                TO_CHAR(SYSDATE, 'DD/MON/YY')  AS FEC1,
                                                V_MONEDA_VAL AS MONEDA,
                                                SYSDATE,
                                                'SISTEMA',
                                                'A',
                                                'ESTATUS_CHEQUE',
                                                'ESTATUS_CHEQUE' AS EST_2,
                                                c.importe AS DR,
                                                0 AS CR,
                                                c.importe AS DR_ME,
                                                0 AS CR_ME,
                                                a.segment1,
                                                a.segment2,
                                                a.segment3,
                                                a.segment4,
                                                a.segment5,
                                                a.segment6,
                                                a.segment7,
                                                0 AS GRUPO,
                                                a.segment1||'-'||C.NO_CHEQUE||'-'||H.DESCRIPCION AS reference1,
                                                TO_CHAR(SYSDATE, 'MON-YY') AS period_name
                                        FROM      gl.gl_code_combinations@ERP_PROD a,
                                                XXCHK_CAT_EDO_CHEQUE b,
                                                XXCHK_CAPTURA_CHEQUES c,
                                                XXCHK_CHEQ_ALL_HIST f,
                                                FECXC_EMPRESAS g,
                                                XXCHK_CAT_EDOS H
                                        WHERE  a.code_combination_id = b.c_cargo_erp
                                        AND    b.c_cargo_erp = V_VALIDA2
                                        AND    b.id_estado_cheque = c.id_estado_cheque
                                        AND    c.e_codigo = f.e_codigo
                                        AND    c.e_codigo = g.e_codigo
                                        AND    (c.PROCESADO IS NULL
                                        OR     c.PROCESADO = 200)
                                        AND    c.ID_SEC_CHEQUE = P_ID_SEC_CHEQ
                                        AND    C.ID_ESTADO_CHEQUE = H.ID_ESTADO_CHEQUE
                                        AND    b.e_codigo = c.e_codigo
                                        AND    c.e_codigo = V_EMPRESA_VAL
                                        AND    c.referencia_cliente = f.referencia_cliente
                                        AND    f.procesado = 1
                                        AND    b.contabiliza = 1
                                        AND    g.CUAL_ERP= 'O'
                     );
              EXCEPTION
              WHEN OTHERS THEN
                RAISE INSERTA_GL_INTERFACE_CHK;
  END;
--************************************************************************************
-- PARA INSERTAR REGISTROS EN LA TABLA DE GL_INTERFACE  ABONO
--***********************************************************************************
  BEGIN
      DBMS_OUTPUT.PUT_LINE ('INSERTA ABON OEN INTERFAZ GL CHEQUES');
      DBMS_OUTPUT.PUT_LINE ('ESTO VALE EL LIBRO '||TO_CHAR(V_LIBRO));
      DBMS_OUTPUT.PUT_LINE ('ABONO: ESTO VALE LA MONEDA EN MONEDA LOCAL'||TO_CHAR(V_MONEDA_VAL));
        INSERT INTO XXCHK_GL_INTERFACE_CHK (
                                        ID_SEC_CHEQUE,
                                        ID_ESTADO_CHEQUE,
                                        STATUS,
                                        SET_OF_BOOKS_ID,
                                        ACCOUNTING_DATE,
                                        CURRENCY_CODE,
                                        ACTUAL_FLAG,
                                        USER_JE_SOURCE_NAME,
                                        USER_JE_CATEGORY_NAME,
                                        ENTERED_DR,
                                        ENTERED_CR,
                                        ACCOUNTED_DR,
                                        ACCOUNTED_CR,
                                        SEGMENT1,
                                        SEGMENT2,
                                        SEGMENT3,
                                        SEGMENT4,
                                        SEGMENT5,
                                        SEGMENT6,
                                        SEGMENT7,
                                        GROUP_ID,
                                        REFERENCE1,
                                        PERIOD_NAME,
                                        DATE_CREATED,
                                        CREATED_BY
                                      )
                            SELECT      secuencia,
                                        id_estado,
                                        'NEW',
                                        SET_OF_BOOKS_ID,
                                        FEC1,
                                        MONEDA,
                                        'A',
                                        'ESTATUS_CHEQUE',
                                        EST_2,
                                        DR,
                                        CR,
                                        DR_ME,
                                        CR_ME,
                                        segment1,
                                        segment2,
                                        segment3,
                                        segment4,
                                        segment5,
                                        segment6,
                                        segment7,
                                        --CASE GRUPO WHEN 0 THEN
                                        --XXCHK_GROUP_ID_ABONO.NEXTVAL END AS GRUPO_ID,
                                        SECUENCIA2,
                                        reference1,
                                        period_name,
                                        SYSDATE,
                                        'SISTEMA'
                             FROM       (
                                            SELECT DISTINCT
                                                    c.ID_SEC_CHEQUE as secuencia,
                                                    c.ID_ESTADO_CHEQUE as id_estado,
                                                    'NEW',
                                                    V_LIBRO AS SET_OF_BOOKS_ID,
                                                    TO_CHAR(SYSDATE, 'DD/MON/YY')  AS FEC1,
                                                    V_MONEDA_VAL AS MONEDA,
                                                    SYSDATE,
                                                    'SISTEMA',
                                                    'A',
                                                    'ESTATUS_CHEQUE',
                                                    'ESTATUS_CHEQUE' AS EST_2,
                                                    0 AS DR,
                                                    c.importe AS CR,
                                                    0 AS DR_ME,
                                                    c.importe AS CR_ME,
                                                    a.segment1,
                                                    a.segment2,
                                                    a.segment3,
                                                    a.segment4,
                                                    a.segment5,
                                                    a.segment6,
                                                    a.segment7,
                                                    0 AS GRUPO,
                                                    a.segment1||'-'||C.NO_CHEQUE||'-'||H.DESCRIPCION AS reference1,
                                                    TO_CHAR(SYSDATE, 'MON-YY') AS period_name
                                            FROM    gl.gl_code_combinations@ERP_PROD a,
                                                    XXCHK_CAT_EDO_CHEQUE b,
                                                    XXCHK_CAPTURA_CHEQUES c,
                                                    XXCHK_CHEQ_ALL_HIST f,
                                                    FECXC_EMPRESAS g,
                                                    XXCHK_CAT_EDOS H
                                            WHERE   a.code_combination_id = b.c_abono_erp
                                            AND     b.c_abono_erp = V_VALIDA
                                            AND     b.id_estado_cheque = c.id_estado_cheque
                                            AND     c.e_codigo = f.e_codigo
                                            AND     c.e_codigo = g.e_codigo
                                            AND     (c.PROCESADO IS NULL
                                            OR      c.PROCESADO = 200)
                                            AND     c.ID_SEC_CHEQUE = P_ID_SEC_CHEQ
                                            AND     C.ID_ESTADO_CHEQUE = H.ID_ESTADO_CHEQUE
                                            AND     c.e_codigo = V_EMPRESA_VAL
                                            AND     b.e_codigo = c.e_codigo
                                            AND     c.referencia_cliente = f.referencia_cliente
                                            AND     f.procesado = 1
                                            AND     b.contabiliza = 1
                                            AND     g.CUAL_ERP= 'O'
                                            );
                                            EXCEPTION
                                            WHEN OTHERS THEN
                                            RAISE INSERTA_GL_INTERFACE_CHK;
    END;
     END IF;
END IF;
   END IF;
  END IF;
  END LOOP;
CLOSE VALIDA_COMBINACION;
  --**********************************************
    --GENERA POLIZAS EN LA TABAL DE GL_INTERFACE
   --*********************************************
       BEGIN
          DBMS_OUTPUT.PUT_LINE ('INSERTA EN GL_INTERFACE');
       INSERT INTO gl.GL_INTERFACE@ERP_PROD (
                                                STATUS,
                                                SET_OF_BOOKS_ID,
                                                ACCOUNTING_DATE,
                                                CURRENCY_CODE,
                                                DATE_CREATED,
                                                CREATED_BY,
                                                ACTUAL_FLAG,
                                                USER_JE_SOURCE_NAME,
                                                USER_JE_CATEGORY_NAME,
                                                CURRENCY_CONVERSION_DATE,
                                                USER_CURRENCY_CONVERSION_TYPE,
                                                CURRENCY_CONVERSION_RATE,
                                                ENTERED_DR,
                                                ENTERED_CR,
                                                ACCOUNTED_DR,
                                                ACCOUNTED_CR,
                                                SEGMENT1,
                                                SEGMENT2,
                                                SEGMENT3,
                                                SEGMENT4,
                                                SEGMENT5,
                                                SEGMENT6,
                                                SEGMENT7,
                                                GROUP_ID,
                                                REFERENCE1,
                                                PERIOD_NAME
                                            )
                                            SELECT        STATUS,
                                                        SET_OF_BOOKS_ID,
                                                        ACCOUNTING_DATE,
                                                        CURRENCY_CODE,
                                                        DATE_CREATED,
                                                        v_usuario,
                                                        ACTUAL_FLAG,
                                                        USER_JE_SOURCE_NAME,
                                                        USER_JE_CATEGORY_NAME,
                                                        CURRENCY_CONVERSION_DATE,
                                                        USER_CURRENCY_CONVERSION_TYPE,
                                                        CURRENCY_CONVERSION_RATE,
                                                        ENTERED_DR,
                                                        ENTERED_CR,
                                                        ACCOUNTED_DR,
                                                        ACCOUNTED_CR,
                                                        SEGMENT1,
                                                        SEGMENT2,
                                                        SEGMENT3,
                                                        SEGMENT4,
                                                        SEGMENT5,
                                                        SEGMENT6,
                                                        SEGMENT7,
                                                        GROUP_ID,
                                                        REFERENCE1,
                                                        PERIOD_NAME
                                           FROM         XXCHK_GL_INTERFACE_CHK
                                           WHERE         PROCESADO IS NULL;
                                           EXCEPTION
                                           WHEN OTHERS THEN
                                           RAISE INSERTA_GL;
    END;
   --COMMIT;
  --**************************
    --ACTUALIZA ESTATUS PROCESADO TABLA GL_INTERFACE
  --**************************
      BEGIN
     DBMS_OUTPUT.PUT_LINE ('ACTUALIZA EN GL_INTERFACE_CHK');
     UPDATE  XXCHK_GL_INTERFACE_CHK A
     SET      A.PROCESADO = (
                             SELECT 1
                             FROM  gl.GL_INTERFACE@ERP_PROD B
                             WHERE A.STATUS = B.STATUS
                             AND A.SET_OF_BOOKS_ID = B.SET_OF_BOOKS_ID
                             AND A.CURRENCY_CODE = B.CURRENCY_CODE
                             AND A.USER_JE_CATEGORY_NAME = B.USER_JE_CATEGORY_NAME
                             AND A.USER_JE_SOURCE_NAME = B.USER_JE_SOURCE_NAME
                               AND A.SEGMENT1 = B.SEGMENT1
                             AND A.SEGMENT2 = B.SEGMENT2
                             AND A.SEGMENT3 = B.SEGMENT3
                             AND A.SEGMENT4 = B.SEGMENT4
                             AND A.SEGMENT5 = B.SEGMENT5
                             AND A.SEGMENT6 = B.SEGMENT6
                             AND A.SEGMENT7 = B.SEGMENT7
                             AND A.ENTERED_DR = B.ENTERED_DR
                             AND A.ENTERED_CR = B.ENTERED_CR
                             AND A.REFERENCE1 = B.REFERENCE1
                             AND A.GROUP_ID = B.GROUP_ID
                               AND A.PERIOD_NAME = B.PERIOD_NAME
                             AND A.PROCESADO IS NULL
                             GROUP BY A.STATUS, A.SET_OF_BOOKS_ID, A.CURRENCY_CODE,
                              A.USER_JE_CATEGORY_NAME, A.USER_JE_SOURCE_NAME,
                              A.SEGMENT1, A.SEGMENT2, A.SEGMENT3, A.SEGMENT4,
                              A.SEGMENT5, A.SEGMENT6, A.SEGMENT7, A.ENTERED_DR,
                              A.ENTERED_CR, A.REFERENCE1,
                              A.GROUP_ID, A.PERIOD_NAME
                         )
        WHERE EXISTS (
                            SELECT 1
                            FROM  gl.GL_INTERFACE@ERP_PROD B
                            WHERE A.STATUS = B.STATUS
                            AND A.SET_OF_BOOKS_ID = B.SET_OF_BOOKS_ID
                            AND A.CURRENCY_CODE = B.CURRENCY_CODE
                            AND A.USER_JE_CATEGORY_NAME = B.USER_JE_CATEGORY_NAME
                            AND A.USER_JE_SOURCE_NAME = B.USER_JE_SOURCE_NAME
                            AND A.SEGMENT1 = B.SEGMENT1
                            AND A.SEGMENT2 = B.SEGMENT2
                            AND A.SEGMENT3 = B.SEGMENT3
                            AND A.SEGMENT4 = B.SEGMENT4
                            AND A.SEGMENT5 = B.SEGMENT5
                            AND A.SEGMENT6 = B.SEGMENT6
                            AND A.SEGMENT7 = B.SEGMENT7
                            AND A.ENTERED_DR = B.ENTERED_DR
                            AND A.ENTERED_CR = B.ENTERED_CR
                            AND A.REFERENCE1 = B.REFERENCE1
                            AND A.GROUP_ID = B.GROUP_ID
                            AND A.PERIOD_NAME = B.PERIOD_NAME
                            AND A.PROCESADO IS NULL
                            GROUP BY A.STATUS, A.SET_OF_BOOKS_ID, A.CURRENCY_CODE,
                            A.USER_JE_CATEGORY_NAME, A.USER_JE_SOURCE_NAME,
                            A.SEGMENT1, A.SEGMENT2, A.SEGMENT3, A.SEGMENT4,
                            A.SEGMENT5, A.SEGMENT6, A.SEGMENT7, A.ENTERED_DR,
                            A.ENTERED_CR, A.REFERENCE1,
                            A.GROUP_ID, A.PERIOD_NAME
         );
         EXCEPTION
         WHEN OTHERS THEN
         RAISE ACTUALIZA_INTERFACE_CHK;
    END;
--*******************************************
-- actualiza el campor group id del historico
--*******************************************
   BEGIN
   DBMS_OUTPUT.PUT_LINE ('ACTUALIZA EN GL_CHEQ_ALL_HIST');
   UPDATE XXCHK_CHEQ_ALL_HIST A
   SET    A.GROUP_ID = ( SELECT B.GROUP_ID
                         FROM   XXCHK_GL_INTERFACE_CHK B,
                                XXCHK_CAPTURA_CHEQUES C
                         WHERE  A.ID_SEC_CHEQUE = B.ID_SEC_CHEQUE
                         AND    A.ID_ESTADO_CHEQUE = B.ID_ESTADO_CHEQUE
                         AND    B.ID_SEC_CHEQUE = C.ID_SEC_CHEQUE
                         AND    B.ID_ESTADO_CHEQUE = C.ID_ESTADO_CHEQUE
                         AND    C.ID_SEC_CHEQUE = P_ID_SEC_CHEQ
                         AND    B.ENTERED_CR = 0
                        )
     WHERE EXISTS (      SELECT 1
                         FROM   XXCHK_GL_INTERFACE_CHK B,
                                XXCHK_CAPTURA_CHEQUES C
                         WHERE  A.ID_SEC_CHEQUE = B.ID_SEC_CHEQUE
                         AND    A.ID_ESTADO_CHEQUE = B.ID_ESTADO_CHEQUE
                         AND    B.ID_SEC_CHEQUE = C.ID_SEC_CHEQUE
                         AND    B.ID_ESTADO_CHEQUE = C.ID_ESTADO_CHEQUE
                         AND    C.ID_SEC_CHEQUE = P_ID_SEC_CHEQ
                         AND    B.ENTERED_CR = 0
                  );
             EXCEPTION
              WHEN OTHERS THEN
              RAISE ACTUALIZA_HISTORICO;
    END;
COMMIT;
  EXCEPTION
      WHEN ACTUALIZA_HISTORICO THEN
    ROLLBACK;
    RAISE_APPLICATION_ERROR(-20000,'ERROR AL ACTUALIZAR HISTORICO');
    WHEN INSERTA_GL_INTERFACE_CHK THEN
      ROLLBACK;
    RAISE_APPLICATION_ERROR(-20000,'ERROR AL INSERTAR EN LA INTERFACE_CHK');
    WHEN INSERTA_GL THEN
      ROLLBACK;
    RAISE_APPLICATION_ERROR(-20000,'ERROR AL INSERTAR EN GL');
    WHEN NOT_VALID_MON THEN
    ROLLBACK;
    RAISE_APPLICATION_ERROR(-20000,'NO EXISTE EL TIPO DE CAMBIO PARA LA FECHA ESPECIFICADA');
    WHEN ESTATUS_NO_VALIDO THEN
    ROLLBACK;
    RAISE_APPLICATION_ERROR(-20000,'CAMBIO DE ESTADO NO V?LIDO');
    WHEN ACTUALIZA_INTERFACE_CHK THEN
    ROLLBACK;
    RAISE_APPLICATION_ERROR(-20000,'ERROR AL TRATAR DE ACTUALIZAR INTERFACE_CHK');
    WHEN OTHERS THEN
    ROLLBACK;
    RAISE_APPLICATION_ERROR(-20000,'SE ENCONTRO UN ERROR AL PROCESAR LA INFORMACI?N, NO SE GENER? MOVIMIENTO');
END Xxchk_Envia_Chks_Manual;
/
