CREATE OR REPLACE EDITIONABLE PROCEDURE "FECXC"."XXCHK_CARGA_MASIVA_CHEQUES" 
(
  --Parameters
  PDTFECHA_EMISION        IN DATE,
  PDTFECHA_COBRO          IN DATE,
  PDTACCOUNTING_DATE      IN DATE,
  PDEIMPORTE              IN DECIMAL,
  PINE_CODIGO             IN INTEGER,
  PINID_BANCO             IN INTEGER,
  PINID_BANCO_REP         IN INTEGER,
  PINNO_CHEQUE            IN INTEGER,
  PINPROCESADO            IN INTEGER,
  PINVENCIDO              IN INTEGER,
  PSTCREATED_BY           IN VARCHAR2,
  PSTDESC_CLIENTE         IN VARCHAR2,
  PSTENTREGADO_POR        IN VARCHAR2,
  PSTEXPIDE               IN VARCHAR2,
  PSTMONEDA               IN VARCHAR2,
  PSTREFERENCIA_CLIENTE   IN VARCHAR2
)
IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
--global variables
ENO_CHEQUE_FOUND            EXCEPTION;
ENO_CUSTOMER_FOUND          EXCEPTION;
ENO_ORG_ID_FOUND            EXCEPTION;
ENO_SET_OF_BOOKS_ID_FOUND   EXCEPTION;
ENO_GINEDO_CHEQUE_FOUND     EXCEPTION;
ENO_PERIODO                 EXCEPTION;
ENO_ERRORES                 EXCEPTION;
GINGROUP_ID                 XXCHK_CHEQ_ALL_HIST.GROUP_ID%TYPE;            --It contains the "Group_id"
GINID_SEC_CHEQUE            XXCHK_CAPTURA_CHEQUES.ID_SEC_CHEQUE%TYPE;     --It contains the "id check"
GINORG_ID                   INT;
GINSET_OF_BOOKS_ID          XXCHK_GL_INTERFACE_CHK.SET_OF_BOOKS_ID%TYPE;  --It contains the "set of books"
GSTID_CLIENTE               XXCHK_CAPTURA_CHEQUES.ID_CLIENTE%TYPE;        --It contains the "id customer"
GSTDESC_CLIENTE             XXCHK_CAPTURA_CHEQUES.DESC_CLIENTE%TYPE;        --It contains the "desc customer"
GINEDO_CHEQUE               INT;
GINT_DIAS_DIFERENCIA        INT;
GINT_ANTIGUEDAD             XXCHK_PARAMETROS_GENERALES.ANTIGUEDAD%TYPE;
GSTR_USUARIO_AUTORIZA       XXCHK_PARAMETROS_GENERALES.USUARIO_AUTORIZA%TYPE;
GSTR_ERRORES                VARCHAR2(500):='';
cont                        INT;
HAY_ERROR                   INT:=0;
BEGIN -- principal
  -- Verifica datos correctos
  -- validar empresa
  SELECT COUNT(1) INTO cont
  FROM FECXC_EMPRESAS
  WHERE E_CODIGO = PINE_CODIGO;
    DBMS_OUTPUT.PUT_LINE('Empresa' || to_char(cont));
  IF cont<1 THEN
    SELECT CONCAT(GSTR_ERRORES,'LA EMPRESA ES INCORRECTA, ')
    INTO GSTR_ERRORES
    FROM DUAL;
    select 1 into HAY_ERROR from dual;
  END IF;
  --Para validar banco
  SELECT count(1) INTO cont
  FROM XXCHK_CATALOGO_BANCOS
  WHERE ID_BANCO = PINID_BANCO;
    DBMS_OUTPUT.PUT_LINE('Banco' || to_char(cont));
  IF cont<1 THEN
    SELECT CONCAT(GSTR_ERRORES,'EL ID BANCO ES INCORRECTO, ')
    INTO GSTR_ERRORES
    FROM DUAL;
    select 1 into HAY_ERROR from dual;
  END IF;
  --Para validar la referencia del cliente
  SELECT count(1) INTO cont
  FROM RA_CUSTOMERS@ERP_PROD
  WHERE ORIG_SYSTEM_REFERENCE = TO_CHAR(PSTREFERENCIA_CLIENTE);
  IF cont<1 THEN
    SELECT CONCAT(GSTR_ERRORES,'LA REFERENCIA DEL CLIENTE ES INCORRECTA, ')
    INTO GSTR_ERRORES
    FROM DUAL;
    select 1 into HAY_ERROR from dual;
  END IF;
--Para validar moneda
  SELECT count(1) INTO cont
  FROM FECXP_MONEDAS
  WHERE MON_SET = PSTMONEDA;
  IF cont<1 THEN
    SELECT CONCAT(GSTR_ERRORES,'EL ID MONEDA ES INCORRECTO, ')
    INTO GSTR_ERRORES
    FROM DUAL;
    select 1 into HAY_ERROR from dual;
  END IF;
  BEGIN
    --Valido per?odo contable
    FECXC.XXCHK_VER_PER_CONTABLE(PDTACCOUNTING_DATE, PINE_CODIGO);
    EXCEPTION
      WHEN OTHERS THEN
        Begin
          SELECT CONCAT(GSTR_ERRORES,'FECHA DE CREACION FUERA DEL PERIODO CONTABLE (AR), ')
          INTO GSTR_ERRORES
          FROM DUAL;
          select 1 into HAY_ERROR from dual;
        end;
  END;
  --Valido antig?edad
  BEGIN
    SELECT TO_DATE(PDTFECHA_COBRO,'DD/MM/YYYY') - TO_DATE(PDTFECHA_EMISION,'DD/MM/YYYY')
    INTO GINT_DIAS_DIFERENCIA
    FROM DUAL;
    SELECT ANTIGUEDAD, USUARIO_AUTORIZA
    INTO GINT_ANTIGUEDAD, GSTR_USUARIO_AUTORIZA
    FROM XXCHK_PARAMETROS_GENERALES
    WHERE E_CODIGO = PINE_CODIGO;
    IF PSTCREATED_BY<>GSTR_USUARIO_AUTORIZA THEN
          DBMS_OUTPUT.PUT_LINE('CREATED BY <> USARIO AUTORIZA');
          IF GINT_DIAS_DIFERENCIA<0 THEN
              DBMS_OUTPUT.PUT_LINE('Fecha emison > fecha de cobro');
              SELECT CONCAT(GSTR_ERRORES,'LA FECHA DE EMISION NO PUEDE SER MAYOR QUE LA FECHA DE COBRO. ')
              INTO GSTR_ERRORES
              FROM DUAL;
              select 1 into HAY_ERROR from dual;
          ELSE
              IF GINT_DIAS_DIFERENCIA>GINT_ANTIGUEDAD THEN
                DBMS_OUTPUT.PUT_LINE('GDIAS_DIFERENCIA>GINT_ANTIGUEDAD');
                SELECT CONCAT(GSTR_ERRORES,'EL USUARIO NO TIENE PERMISOS PARA DAR DE ALTA CHEQUES ANTIGUOS. ')
                INTO GSTR_ERRORES
                FROM DUAL;
                select 1 into HAY_ERROR from dual;
              END IF;
          END IF;
    END IF;
  END;
  BEGIN
     DBMS_OUTPUT.PUT_LINE('INICIO');
    -- Verifica si ek registro ya est? procesado
    DBMS_OUTPUT.PUT_LINE('busco cheque existente');
    SELECT COUNT(ID_SEC_CHEQUE)
    INTO GINEDO_CHEQUE
    FROM XXCHK_CAPTURA_CHEQUES
    WHERE E_CODIGO = PINE_CODIGO
      AND ID_BANCO = PINID_BANCO
      AND NO_CHEQUE = PINNO_CHEQUE
      AND MONEDA = PSTMONEDA
      AND REFERENCIA_CLIENTE = TO_CHAR(PSTREFERENCIA_CLIENTE);
      IF GINEDO_CHEQUE>0 THEN
        DBMS_OUTPUT.PUT_LINE('existe cheque');
        RAISE ENO_CHEQUE_FOUND;
      ELSE
        BEGIN
          DBMS_OUTPUT.PUT_LINE('no existe cheque');
            DBMS_OUTPUT.PUT_LINE('Errrores' || to_char(GSTR_ERRORES));
            DBMS_OUTPUT.PUT_LINE('Hay error' || HAY_ERROR);
          IF HAY_ERROR=1 THEN
            RAISE ENO_ERRORES;
          ELSE
            BEGIN
                BEGIN
                    --It gets the "CUSTOMER_ID"
                    SELECT CUSTOMER_ID,CUSTOMER_NAME
                    INTO GSTID_CLIENTE,GSTDESC_CLIENTE --Variable global
                    FROM RA_CUSTOMERS@ERP_PROD
                    WHERE ORIG_SYSTEM_REFERENCE = TO_CHAR(PSTREFERENCIA_CLIENTE);
                    EXCEPTION
                        WHEN NO_DATA_FOUND THEN
                           RAISE ENO_CUSTOMER_FOUND;
                END;
                DBMS_OUTPUT.PUT_LINE( 'ID CLIENTE ' || TO_CHAR(GSTID_CLIENTE));
                --It gets the "id check"
                SELECT XXCHK_SEC_ID_CHEQUE.NEXTVAL
                INTO GINID_SEC_CHEQUE
                FROM DUAL;
                DBMS_OUTPUT.PUT_LINE( 'ID_SEC_CHEQUE ' || TO_CHAR(GINID_SEC_CHEQUE));
                --It creates the check' head of the check
                INSERT INTO XXCHK_CAPTURA_CHEQUES
                (
                    ID_SEC_CHEQUE,
                      E_CODIGO,
                      ID_BANCO,
                      ID_ESTADO_CHEQUE,
                      NO_CHEQUE,
                      REFERENCIA_CLIENTE,
                      ID_CLIENTE,
                      FECHA_EMISION,
                      FECHA_COBRO,
                      DATE_CREATED,
                      CREATED_BY,
                      MODIFIED_BY,
                      IMPORTE,
                      MONEDA,
                      ENTREGADO_POR,
                      EXPIDE,
                      IMAGEN,
                      VENCIDO,
                      DESC_CLIENTE,
                      PROCESADO,
                      ID_BANCO_REP
                )
                VALUES
                (
                  GINID_SEC_CHEQUE,
                  PINE_CODIGO,
                  PINID_BANCO,
                  CHK_CARG_MASI_CHK_PKG.CINID_ESTADO_CHEQUE,
                  PINNO_CHEQUE,
                  PSTREFERENCIA_CLIENTE,
                  GSTID_CLIENTE,
                  PDTFECHA_EMISION,
                  PDTFECHA_COBRO,
                  PDTACCOUNTING_DATE,
                  PSTCREATED_BY,
                  CHK_CARG_MASI_CHK_PKG.CSTMODIFIED_BY,
                  PDEIMPORTE,
                  PSTMONEDA,
                  PSTENTREGADO_POR,
                  PSTEXPIDE,
                  CHK_CARG_MASI_CHK_PKG.CSTIMAGEN,
                  PINVENCIDO,
                  GSTDESC_CLIENTE,
                  PINPROCESADO,
                  PINID_BANCO_REP
                );
                DBMS_OUTPUT.PUT_LINE('INSERTO CABECERO');
              BEGIN
                  SELECT ESTADO_INICIAL_CHK
                  INTO GINEDO_CHEQUE
                  FROM XXCHK_PARAMETROS_GENERALES
                  WHERE E_CODIGO = PINE_CODIGO;
                  EXCEPTION
                      WHEN NO_DATA_FOUND THEN
                      RAISE ENO_GINEDO_CHEQUE_FOUND;
              END;
              BEGIN
                 FECXC.XXCHK_ENVIA_CHKS_MANUAL(GINID_SEC_CHEQUE,CHK_CARG_MASI_CHK_PKG.CSTMODIFIED_BY,GINEDO_CHEQUE);
                 DBMS_OUTPUT.PUT_LINE('PASO ENVIA CHEQUE MANUAL');
              END;
            END;
          END IF;
        END;
      END IF;
        EXCEPTION
          WHEN ENO_PERIODO THEN
            RAISE_APPLICATION_ERROR(-20000,'FECHA DE CREACION FUERA DEL PERIODO CONTABLE (AR). ');
          WHEN ENO_CHEQUE_FOUND THEN
            RAISE_APPLICATION_ERROR(-20000,'CHEQUE YA PROCESADO.');
          WHEN ENO_ERRORES THEN
            RAISE_APPLICATION_ERROR(-20000, GSTR_ERRORES);
          WHEN ENO_CUSTOMER_FOUND THEN
            SELECT CONCAT(GSTR_ERRORES,'NO SE ENCOTRO EL CLIENTE.')
            INTO GSTR_ERRORES
            FROM DUAL;
            RAISE_APPLICATION_ERROR(-20000, GSTR_ERRORES);
          WHEN ENO_ORG_ID_FOUND THEN
            SELECT CONCAT(GSTR_ERRORES,'NO SE ENCONTRO EL ID DE LA ORGANIZACION.')
            INTO GSTR_ERRORES
            FROM DUAL;
            RAISE_APPLICATION_ERROR(-20000, GSTR_ERRORES);
          WHEN ENO_SET_OF_BOOKS_ID_FOUND THEN
            SELECT CONCAT(GSTR_ERRORES,'NO SE ENCONTRO EL LIBRO CONTABLE.')
            INTO GSTR_ERRORES
            FROM DUAL;
            RAISE_APPLICATION_ERROR(-20000, GSTR_ERRORES);
          WHEN ENO_GINEDO_CHEQUE_FOUND THEN
            SELECT CONCAT(GSTR_ERRORES,'NO SE ENCONTRO EL ESTADO INICIAL DEL CHEQUE.')
            INTO GSTR_ERRORES
            FROM DUAL;
            RAISE_APPLICATION_ERROR(-20000, GSTR_ERRORES);
          WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20000, 'ERROR: FAVOR DE VERIFICAR LAYOUT Y CONEXION A BASE');
   END;
END XXCHK_CARGA_MASIVA_CHEQUES;
/
