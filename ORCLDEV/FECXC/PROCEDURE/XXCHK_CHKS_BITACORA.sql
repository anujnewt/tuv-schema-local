CREATE OR REPLACE EDITIONABLE PROCEDURE "FECXC"."XXCHK_CHKS_BITACORA" 
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
   V_DATE_CREATED      		   DATE;
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
   V_LIBRO					   NUMBER;
   V_DEC_EDO                   VARCHAR2(100 BYTE);
   V_MONEDA_VAL       		   XXCHK_CAPTURA_CHEQUES.MONEDA%TYPE;
   SECUENCIA1                  INT;
   SECUENCIA2                  INT;
   INCREMENTO                  INT;
   VALIDA_MONEDA      		   INT; --OJO OOC
   V_CIA					   VARCHAR2(25 BYTE);
   V_MONEDA_F				   VARCHAR2(15 BYTE);
   NOT_VALID_MON      		   exception;
   ESTATUS_NO_VALIDO  		   exception;
   INSERTA_GL    			   exception;
   INSERTA_GL_INTERFACE_CHK	   exception;
   ACTUALIZA_INTERFACE_CHK	   exception;
   ACTUALIZA_HISTORICO		   exception;
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
--QUE CAMBIARON
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
		  P_NUEVO_ESTATUS
  FROM 	  XXCHK_CAPTURA_CHEQUES A
  WHERE   A.ID_SEC_CHEQUE = P_ID_SEC_CHEQ;
 EXCEPTION
 WHEN OTHERS THEN
    ROLLBACK;
    RAISE_APPLICATION_ERROR(-20000,'ERROR AL ACTUALIZAR HISTORICO');
END XXCHK_CHKS_BITACORA;
/
