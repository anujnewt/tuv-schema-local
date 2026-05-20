CREATE OR REPLACE EDITIONABLE PACKAGE "FECXC"."XXMACHT_CHEQUES_STATUS" 
AS
  PROCEDURE ACTUALIZA_CHKS_STATUS;
END Xxmacht_Cheques_Status;
/
CREATE OR REPLACE EDITIONABLE PACKAGE BODY "FECXC"."XXMACHT_CHEQUES_STATUS" 
AS
  PROCEDURE ACTUALIZA_CHKS_STATUS
  IS
--*****************************************************************
-- PROCEDIMIENTO  AUTOMATICO DE COLSULTA DE CHEQUES CON EL SET
-- CREADO POR SOIN 'SOLUCIONES INTEGRALES'  (OMAR HERNANDEZ)
--*****************************************************************
   V_EMPRESA                   XXCHK_CHEQUES_ALL.E_CODIGO%TYPE;
   V_IMPORTE          		   XXCHK_CHEQUES_ALL.IMPORTE%TYPE;
   V_OPERACION_SET    		   XXCHK_CHEQUES_ALL.ID_TIPO_OPERACION_SET%TYPE;
   V_NUM_CHEQUES      		   INT;
   V_FECHA            		   XXCHK_CHEQUES_ALL.FEC_VALOR_ORIGINAL%TYPE;
   V_FROM_MAIL        		   VARCHAR(50);
   V_MAIL_CLIENTE     		   VARCHAR(50);
   V_REFERENCIA       		   XXCHK_CAPTURA_CHEQUES.REFERENCIA_CLIENTE%TYPE;
   V_BANCO                     VARCHAR(50);
   V_MONEDA                    XXCHK_CAPTURA_CHEQUES.MONEDA%TYPE;
   V_DESC_ESTADO               XXCHK_MAPEO_DE_ESTADOS.DESCRIPCION%TYPE;
   v_grp_id                    INT;
   v_usuario          	       INT:= 1;
   v_fecha_c          		   DATE;
   V_VALIDA           	       NUMBER;
   V_VALIDA2          		   NUMBER;
   V_EMPRESA_VAL      		   NUMBER;
   V_COMBINACION      		   NUMBER;
   V_COMBINACION2     		   NUMBER;
   V_ERROR                     NUMBER;
   V_ERROR2                    NUMBER;
   V_FIN_ERROR                 NUMBER;
   V_STATUS                    VARCHAR2(50 BYTE);
   V_SET_OF_BOOKS_ID           NUMBER;
   V_ACCOUNTING_DATE           DATE;
   V_CURRENCY_CODE             VARCHAR2(3 BYTE);
   V_DATE_CREATED      DATE;
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
   SECUENCIA1                  INT;
   SECUENCIA2                  INT;
   INCREMENTO                  INT;
   FECHA_NERO                  DATE;
   V_MONEDA_VAL				   XXCHK_CAPTURA_CHEQUES.MONEDA%TYPE;
   V_MON                       XXCHK_CAPTURA_CHEQUES.MONEDA%TYPE;
-- ***********************************************************************
-- SELECCIONA CLIENTES PARA MANDAR LOS MAILS DE ACTUALIZACION DE EATADOS
-- ***********************************************************************
  CURSOR SELECCIONA_CLIENTES IS
 SELECT C.EMAIL_ADDRESS, A.E_CODIGO, A.REFERENCIA_CLIENTE, A.DATE_CREATED,
        D.DESCRIPCION_BANCO, A.IMPORTE, A.MONEDA
  FROM  XXCHK_CAPTURA_CHEQUES A,
        RA_CUSTOMERS@ERP_PROD B,
        AR_CONTACTS_V@ERP_PROD C,
        XXCHK_CATALOGO_BANCOS D,
        XXCHK_CAT_EDO_CHEQUE E,
        FECXC_EMPRESAS F,
		XXCHK_CAT_EDOS G
 WHERE  B.CUSTOMER_ID = C.CUSTOMER_ID
 AND    C.EMAIL_ADDRESS IS NOT NULL
 AND    A.REFERENCIA_CLIENTE=C.ORIG_SYSTEM_REFERENCE
 AND    (A.PROCESADO IS NULL
  OR    A.PROCESADO = 2)
 AND    A.ID_ESTADO_CHEQUE = E.ID_ESTADO_CHEQUE
 AND    E.ID_ESTADO_CHEQUE = G.ID_ESTADO_CHEQUE
 AND    G.TIPO_OPERACION IN('ENFIRME','RECHAZADO')
 AND    E.ENVIA_CORREO = 1
 AND    A.ID_BANCO = D.ID_BANCO
 AND    A.E_CODIGO = F.E_CODIGO
 AND    F.CUAL_ERP = 'O'
GROUP BY C.EMAIL_ADDRESS, A.E_CODIGO, A.REFERENCIA_CLIENTE, A.DATE_CREATED,
        D.DESCRIPCION_BANCO, A.IMPORTE, A.MONEDA;
-- *****************************************
-- VALIDA LAS COMBINACIONES DE LAS CUENTAS *
-- *****************************************
  CURSOR VALIDA_COMBINACION IS
  SELECT C.C_ABONO_ERP, C.C_CARGO_ERP, A.E_CODIGO, A.MONEDA
  FROM   XXCHK_CAPTURA_CHEQUES A,
	     XXCHK_CHEQ_ALL_HIST B,
	     XXCHK_CAT_EDO_CHEQUE C,
	     apps.gl_code_combinations@ERP_PROD D,
	     FECXC_EMPRESAS E,
	     XXCHK_MAPEO_DE_ESTADOS F,
		 XXCHK_CAT_EDOS G
 WHERE A.E_CODIGO = B.E_CODIGO
 AND   A.REFERENCIA_CLIENTE = B.REFERENCIA_CLIENTE
 AND   A.ID_SEC_CHEQUE = B.ID_SEC_CHEQUE
 AND   (A.PROCESADO IS NULL
 OR    A.PROCESADO = 2)
 AND   B.PROCESADO = 1
 AND   A.E_CODIGO = C.E_CODIGO
 AND   A.ID_ESTADO_CHEQUE = C.ID_ESTADO_CHEQUE
 AND   A.E_CODIGO = E.E_CODIGO
 AND   A.ID_ESTADO_CHEQUE = G.ID_ESTADO_CHEQUE
 AND   G.TIPO_OPERACION IN('ENFIRME','SBC','RECHAZADO')
 AND   C.C_ABONO_ERP = D.CODE_COMBINATION_ID
 AND   C.ID_ESTADO_CHEQUE = F.ID_ESTADO_CHEQUE
 AND   C.CONTABILIZA=1
 AND   E.CUAL_ERP = 'O'
 GROUP BY C.C_CARGO_ERP, C.C_ABONO_ERP, A.E_CODIGO, A.MONEDA
 ORDER BY A.E_CODIGO, A.MONEDA ASC;
-- ********************************************
-- ABRE LA CONECCION CON EL SERVIDOR DE MAILS *
-- ********************************************
     l_maicon utl_smtp.connection;
BEGIN
--****************************************
  ---PARA LOS REGISTROS SALVO BUEN COBRO
--****************************************
    UPDATE  XXCHK_CAPTURA_CHEQUES B
    SET  B.ID_ESTADO_CHEQUE =     (SELECT d.id_estado_cheque
				             FROM XXCHK_CHEQUES_ALL x1,
				                  XXCHK_MAPEO_DE_ESTADOS c,
				                  XXCHK_CAT_EDOS d
				            WHERE EXISTS (
						                     SELECT   1
						                         FROM XXCHK_CHEQUES_ALL a,
						                              XXCHK_MAPEO_DE_ESTADOS c,
						                              XXCHK_CAT_EDOS d
						                        WHERE a.e_codigo = x1.e_codigo
						                          AND a.importe = x1.importe
						                          AND a.referencia_cliente = x1.referencia_cliente
						                          AND a.moneda = x1.moneda
						                          AND a.id_tipo_operacion_set = c.id_tipo_operacion_set
						                          AND c.id_estado_cheque = d.id_estado_cheque
						                          AND d.tipo_operacion IN ('SBC')
						                          AND (a.procesado IS NULL OR a.procesado = 2)
						                     GROUP BY a.e_codigo,
						                              a.importe,
						                              a.referencia_cliente,
						                              x1.moneda
						                       HAVING COUNT (1) = 1)
				              AND x1.id_tipo_operacion_set = c.id_tipo_operacion_set
				              AND c.id_estado_cheque = d.id_estado_cheque
				              AND d.tipo_operacion IN ('SBC')
				              AND (x1.procesado IS NULL OR x1.procesado = 2)
				              AND x1.e_codigo = b.e_codigo
				              AND x1.importe = b.importe
				              AND x1.referencia_cliente = b.referencia_cliente
				              AND x1.moneda = b.moneda)
				 WHERE EXISTS (
				          SELECT 1
				            FROM XXCHK_CHEQUES_ALL x1,
				                 XXCHK_MAPEO_DE_ESTADOS c,
				                 XXCHK_CAT_EDOS d
				           WHERE EXISTS (
						                    SELECT   1
						                        FROM XXCHK_CHEQUES_ALL a,
						                             XXCHK_MAPEO_DE_ESTADOS c,
						                             XXCHK_CAT_EDOS d
						                       WHERE a.e_codigo = x1.e_codigo
						                         AND a.importe = x1.importe
						                         AND a.referencia_cliente = x1.referencia_cliente
						                         AND a.moneda = x1.moneda
						                         AND a.id_tipo_operacion_set = c.id_tipo_operacion_set
						                         AND c.id_estado_cheque = d.id_estado_cheque
						                         AND d.tipo_operacion IN ('SBC')
						                         AND (a.procesado IS NULL OR a.procesado = 2)
						                    GROUP BY a.e_codigo,
						                             a.importe,
						                             a.referencia_cliente,
						                             x1.moneda
						                      HAVING COUNT (1) = 1)
				             AND x1.id_tipo_operacion_set = c.id_tipo_operacion_set
				             AND c.id_estado_cheque = d.id_estado_cheque
				             AND d.tipo_operacion IN ('SBC')
				             AND (x1.procesado IS NULL OR x1.procesado = 2)
				             AND x1.e_codigo = b.e_codigo
				             AND x1.importe = b.importe
				             AND x1.referencia_cliente = b.referencia_cliente
				             AND x1.moneda = b.moneda);
	COMMIT;
--********************************************
--REGISTRA LOS QUE ESTAN EN SALVO BUEN COBRO
--********************************************
    INSERT INTO XXCHK_CHEQ_ALL_HIST
				                  (
				                  E_CODIGO,
				                 NO_CHEQUE,
				                 ID_SEC_CHEQUE,
				                 MODIFIED_BY,
				                 TIPO_CHEQ,
				                 REFERENCIA_CLIENTE,
				                 ID_TIPO_OPERACION_SET,
								 PROCESADO,
                                 ID_ESTADO_CHEQUE
					              )
                SELECT b.E_CODIGO, b.NO_CHEQUE, b.ID_SEC_CHEQUE, 'Automatico', 'Automatico',
		         b.REFERENCIA_CLIENTE, X1.ID_TIPO_OPERACION_SET, NULL,d.id_estado_cheque
             FROM XXCHK_CHEQUES_ALL x1,
                  XXCHK_MAPEO_DE_ESTADOS c,
				  XXCHK_CAPTURA_CHEQUES b,
                  XXCHK_CAT_EDOS d
            WHERE EXISTS (SELECT   1
		                         FROM XXCHK_CHEQUES_ALL a,
		                              XXCHK_MAPEO_DE_ESTADOS c,
		                              XXCHK_CAT_EDOS d
		                        WHERE a.e_codigo = x1.e_codigo
		                          AND a.importe = x1.importe
		                          AND a.referencia_cliente = x1.referencia_cliente
		                          AND a.moneda = x1.moneda
		                          AND a.id_tipo_operacion_set =  c.id_tipo_operacion_set
		                          AND c.id_estado_cheque = d.id_estado_cheque
		                          AND d.tipo_operacion IN ('SBC')
		                          AND (a.procesado IS NULL OR a.procesado = 2)
		                     GROUP BY a.e_codigo,
		                              a.importe,
		                              a.referencia_cliente,
		                              x1.moneda
		                       HAVING COUNT (1) = 1)
              AND x1.id_tipo_operacion_set = c.id_tipo_operacion_set
              AND c.id_estado_cheque = d.id_estado_cheque
              AND d.tipo_operacion IN ('SBC')
              AND (x1.procesado IS NULL OR x1.procesado = 2)
              AND x1.e_codigo = b.e_codigo
              AND x1.importe = b.importe
              AND x1.referencia_cliente = b.referencia_cliente
              AND x1.moneda = b.moneda;
	COMMIT;
--****************************************************************
--PARA PONER LOS REGISTRO PROCESADOS QUE SON DE SALVO BUEN COBRO
--****************************************************************
       UPDATE  XXCHK_CHEQUES_ALL A
            SET A.PROCESADO = (
			                   SELECT 1
			                   FROM   XXCHK_CAPTURA_CHEQUES B, XXCHK_MAPEO_DE_ESTADOS C,  XXCHK_CAT_EDOS D
				               WHERE  A.E_CODIGO = B.E_CODIGO
				               AND    A.IMPORTE = B.IMPORTE
				               AND    A.REFERENCIA_CLIENTE=B.REFERENCIA_CLIENTE
				               AND    A.MONEDA = B.MONEDA
			                   AND    A.ID_TIPO_OPERACION_SET = C.ID_TIPO_OPERACION_SET
			                   AND    C.ID_ESTADO_CHEQUE = D.ID_ESTADO_CHEQUE
			                   AND    D.TIPO_OPERACION = 'SBC'
			                   AND    A.PROCESADO IS NULL
			                   GROUP BY  A.E_CODIGO, A.IMPORTE, D.TIPO_OPERACION, A.REFERENCIA_CLIENTE
			                   HAVING COUNT(1) = 1
			                  )
               WHERE EXISTS  (
				              SELECT   1
				              FROM  XXCHK_CAPTURA_CHEQUES b, XXCHK_MAPEO_DE_ESTADOS c,  XXCHK_CAT_EDOS D
				              WHERE A.E_CODIGO = B.E_CODIGO
				              AND  A.IMPORTE = B.IMPORTE
				              AND  A.REFERENCIA_CLIENTE = B.REFERENCIA_CLIENTE
				              AND  A.MONEDA = B.MONEDA
				              AND  A.ID_TIPO_OPERACION_SET = C.ID_TIPO_OPERACION_SET
				              AND  C.ID_ESTADO_CHEQUE = D.ID_ESTADO_CHEQUE
				              AND  D.TIPO_OPERACION = 'SBC'
				              AND  A.PROCESADO IS NULL
				              GROUP BY  A.E_CODIGO,A.IMPORTE, D.TIPO_OPERACION, A.REFERENCIA_CLIENTE
				              HAVING   COUNT(1) = 1
                 			  );
   COMMIT;
--****************************************
--PARA LOS REGISTROS RECHAZADOS O EN FIRME
--****************************************
         UPDATE XXCHK_CAPTURA_CHEQUES b
   SET b.id_estado_cheque = (SELECT d.id_estado_cheque
				             FROM XXCHK_CHEQUES_ALL x1,
				                  XXCHK_MAPEO_DE_ESTADOS c,
				                  XXCHK_CAT_EDOS d
				            WHERE EXISTS (
						                     SELECT   1
						                         FROM XXCHK_CHEQUES_ALL a,
						                              XXCHK_MAPEO_DE_ESTADOS c,
						                              XXCHK_CAT_EDOS d
						                        WHERE a.e_codigo = x1.e_codigo
						                          AND a.importe = x1.importe
						                          AND a.referencia_cliente = x1.referencia_cliente
						                          AND a.moneda = x1.moneda
						                          AND a.id_tipo_operacion_set =
						                                                       c.id_tipo_operacion_set
						                          AND c.id_estado_cheque = d.id_estado_cheque
						                          AND d.tipo_operacion IN ('ENFIRME', 'RECHAZADO')
						                          AND (a.procesado IS NULL OR a.procesado = 2)
						                     GROUP BY a.e_codigo,
						                              a.importe,
						                              a.referencia_cliente,
						                              x1.moneda
						                       HAVING COUNT (1) = 1)
				              AND x1.id_tipo_operacion_set = c.id_tipo_operacion_set
				              AND c.id_estado_cheque = d.id_estado_cheque
				              AND d.tipo_operacion IN ('ENFIRME', 'RECHAZADO')
				              AND (x1.procesado IS NULL OR x1.procesado = 2)
				              AND x1.e_codigo = b.e_codigo
				              AND x1.importe = b.importe
				              AND x1.referencia_cliente = b.referencia_cliente
				              AND x1.moneda = b.moneda)
				 WHERE EXISTS (
				          SELECT 1
				            FROM XXCHK_CHEQUES_ALL x1,
				                 XXCHK_MAPEO_DE_ESTADOS c,
				                 XXCHK_CAT_EDOS d
				           WHERE EXISTS (
						                    SELECT   1
						                        FROM XXCHK_CHEQUES_ALL a,
						                             XXCHK_MAPEO_DE_ESTADOS c,
						                             XXCHK_CAT_EDOS d
						                       WHERE a.e_codigo = x1.e_codigo
						                         AND a.importe = x1.importe
						                         AND a.referencia_cliente = x1.referencia_cliente
						                         AND a.moneda = x1.moneda
						                         AND a.id_tipo_operacion_set = c.id_tipo_operacion_set
						                         AND c.id_estado_cheque = d.id_estado_cheque
						                         AND d.tipo_operacion IN ('ENFIRME', 'RECHAZADO')
						                         AND (a.procesado IS NULL OR a.procesado = 2)
						                    GROUP BY a.e_codigo,
						                             a.importe,
						                             a.referencia_cliente,
						                             x1.moneda
						                      HAVING COUNT (1) = 1)
				             AND x1.id_tipo_operacion_set = c.id_tipo_operacion_set
				             AND c.id_estado_cheque = d.id_estado_cheque
				             AND d.tipo_operacion IN ('ENFIRME', 'RECHAZADO')
				             AND (x1.procesado IS NULL OR x1.procesado = 2)
				             AND x1.e_codigo = b.e_codigo
				             AND x1.importe = b.importe
				             AND x1.referencia_cliente = b.referencia_cliente
				             AND x1.moneda = b.moneda);
   COMMIT;
--************************************************
   --REGISTRA LOS QUE ESTAN EN  firme o rechazado
--************************************************
        DBMS_OUTPUT.PUT_LINE ('paso historico');
        INSERT INTO XXCHK_CHEQ_ALL_HIST
                  (
                 E_CODIGO,
                 NO_CHEQUE,
                 ID_SEC_CHEQUE,
                 MODIFIED_BY,
                 TIPO_CHEQ,
                 REFERENCIA_CLIENTE,
                 ID_TIPO_OPERACION_SET,
                 PROCESADO,
                 ID_ESTADO_CHEQUE
                 )
			     SELECT b.E_CODIGO, b.NO_CHEQUE, b.ID_SEC_CHEQUE, 'Automatico', 'Automatico',
		         b.REFERENCIA_CLIENTE, X1.ID_TIPO_OPERACION_SET, NULL,d.id_estado_cheque
             FROM XXCHK_CHEQUES_ALL x1,
                  XXCHK_MAPEO_DE_ESTADOS c,
				  XXCHK_CAPTURA_CHEQUES b,
                  XXCHK_CAT_EDOS d
            WHERE EXISTS (SELECT   1
		                         FROM XXCHK_CHEQUES_ALL a,
		                              XXCHK_MAPEO_DE_ESTADOS c,
		                              XXCHK_CAT_EDOS d
		                        WHERE a.e_codigo = x1.e_codigo
		                          AND a.importe = x1.importe
		                          AND a.referencia_cliente = x1.referencia_cliente
		                          AND a.moneda = x1.moneda
		                          AND a.id_tipo_operacion_set =  c.id_tipo_operacion_set
		                          AND c.id_estado_cheque = d.id_estado_cheque
		                          AND d.tipo_operacion IN ('ENFIRME', 'RECHAZADO')
		                          AND (a.procesado IS NULL OR a.procesado = 2)
		                     GROUP BY a.e_codigo,
		                              a.importe,
		                              a.referencia_cliente,
		                              x1.moneda
		                       HAVING COUNT (1) = 1)
              AND x1.id_tipo_operacion_set = c.id_tipo_operacion_set
              AND c.id_estado_cheque = d.id_estado_cheque
              AND d.tipo_operacion IN ('ENFIRME', 'RECHAZADO')
              AND (x1.procesado IS NULL OR x1.procesado = 2)
              AND x1.e_codigo = b.e_codigo
              AND x1.importe = b.importe
              AND x1.referencia_cliente = b.referencia_cliente
              AND x1.moneda = b.moneda;
	COMMIT;
--****************************************
--CURSOR PARA SACAR DATOS DE LAS PERSONAS CON CORREO
--****************************************
   OPEN SELECCIONA_CLIENTES;
      LOOP
       FETCH SELECCIONA_CLIENTES
      INTO V_MAIL_CLIENTE, V_EMPRESA,
           V_REFERENCIA, V_FECHA,
           V_BANCO, V_IMPORTE,
           V_MONEDA;
      EXIT WHEN SELECCIONA_CLIENTES%NOTFOUND;
             l_maicon :=utl_smtp.open_connection('131.1.13.59',25);
             utl_smtp.helo(l_maicon,'Sistemas_automaticos');         ----checar
             utl_smtp.mail(l_maicon,'marodriguezg@televisa.com.mx');       ----quien lo manda
             utl_smtp.rcpt(l_maicon,V_MAIL_CLIENTE);
             utl_smtp.DATA(l_maicon,'From: marodriguezg@televisa.com.mx' || utl_tcp.crlf||
                               'To: '||  V_MAIL_CLIENTE || utl_tcp.crlf ||
                               'Subject: Cambio de Estado en el cheque ' || utl_tcp.crlf ||
                               'DATOS DE LOS CHEQUES ACTUALIZADOS :' || utl_tcp.crlf ||
                               ' NO EMPRESA: ' || V_EMPRESA || utl_tcp.crlf ||
                               ' REFERENCIA CLIENTE: ' || V_REFERENCIA || utl_tcp.crlf ||
                               ' FECHA: ' || V_FECHA || utl_tcp.crlf ||
                               ' BANCO: ' || V_BANCO || utl_tcp.crlf ||
                               ' IMPORTE DEL CHEQUE: ' || V_IMPORTE || utl_tcp.crlf ||
                               ' TIPO DE CAMBIO: ' || V_MONEDA );
           END LOOP;
      CLOSE SELECCIONA_CLIENTES;
--****************************************************************************
   --actualiza el campo de procesado para los registrros que se actualizaron
--****************************************************************************
        UPDATE XXCHK_CHEQ_ALL_HIST A
    SET PROCESADO = (SELECT 1
					    FROM    XXCHK_CAPTURA_CHEQUES B, XXCHK_MAPEO_DE_ESTADOS C, XXCHK_CAT_EDOS D
					    WHERE   A.E_CODIGO=B.E_CODIGO
					    AND     A.REFERENCIA_CLIENTE=B.REFERENCIA_CLIENTE
					    AND     A.ID_TIPO_OPERACION_SET=C.ID_TIPO_OPERACION_SET
						AND     C.ID_ESTADO_CHEQUE = D.ID_ESTADO_CHEQUE
					    AND     D.TIPO_OPERACION IN ('ENFIRME','RECHAZADO', 'SBC')
						AND     A.PROCESADO IS NULL
					    GROUP BY  C.ID_ESTADO_CHEQUE, A.E_CODIGO, A.ID_TIPO_OPERACION_SET, A.REFERENCIA_CLIENTE)
	  WHERE EXISTS (
	                SELECT 1
				    FROM    XXCHK_CAPTURA_CHEQUES B, XXCHK_MAPEO_DE_ESTADOS C, XXCHK_CAT_EDOS D
				    WHERE   A.E_CODIGO=B.E_CODIGO
				    AND     A.REFERENCIA_CLIENTE=B.REFERENCIA_CLIENTE
				    AND     A.ID_TIPO_OPERACION_SET=C.ID_TIPO_OPERACION_SET
				    AND     C.ID_ESTADO_CHEQUE = D.ID_ESTADO_CHEQUE
				    AND     D.TIPO_OPERACION IN ('ENFIRME','RECHAZADO','SBC')
					AND     A.PROCESADO IS NULL
				    GROUP BY  C.ID_ESTADO_CHEQUE, A.E_CODIGO, A.ID_TIPO_OPERACION_SET, A.REFERENCIA_CLIENTE );
  COMMIT;
 DBMS_OUTPUT.PUT_LINE ('paso historico');
--******************************************************************
--PARA PONER LOS REGISTRO PROCESADOS QUE ESTAN ENFIRME O RECHAZADOS
--******************************************************************
     UPDATE  XXCHK_CHEQUES_ALL A
  SET a.PROCESADO = (
				      SELECT  1
				     FROM    XXCHK_CAPTURA_CHEQUES B, XXCHK_CHEQ_ALL_HIST C, XXCHK_MAPEO_DE_ESTADOS D, XXCHK_CAT_EDOS E
					 WHERE   A.E_CODIGO=B.E_CODIGO
				     AND     A.IMPORTE=B.IMPORTE
				     AND     A.REFERENCIA_CLIENTE=B.REFERENCIA_CLIENTE
				     AND     A.MONEDA = B.MONEDA
					 AND     B.E_CODIGO= C.E_CODIGO
					 AND     B.REFERENCIA_CLIENTE = C.REFERENCIA_CLIENTE
					 AND     B.ID_SEC_CHEQUE = C.ID_SEC_CHEQUE
					 AND     A.ID_TIPO_OPERACION_SET = C.ID_TIPO_OPERACION_SET
					 AND     C.ID_TIPO_OPERACION_SET = D.ID_TIPO_OPERACION_SET
					 AND     D.ID_ESTADO_CHEQUE      = E.ID_ESTADO_CHEQUE
					 AND     E.TIPO_OPERACION   IN  ('ENFIRME','SBC','RECHAZADO')
					 GROUP BY A.E_CODIGO, B.REFERENCIA_CLIENTE, B.IMPORTE, B.MONEDA, A.ID_TIPO_OPERACION_SET
                    )
      WHERE EXISTS (
				     SELECT  1
				     FROM    XXCHK_CAPTURA_CHEQUES B, XXCHK_CHEQ_ALL_HIST C, XXCHK_MAPEO_DE_ESTADOS D, XXCHK_CAT_EDOS E
					 WHERE   A.E_CODIGO=B.E_CODIGO
				     AND     A.IMPORTE=B.IMPORTE
				     AND     A.REFERENCIA_CLIENTE=B.REFERENCIA_CLIENTE
				     AND     A.MONEDA = B.MONEDA
					 AND     B.E_CODIGO= C.E_CODIGO
					 AND     B.REFERENCIA_CLIENTE = C.REFERENCIA_CLIENTE
					 AND     B.ID_SEC_CHEQUE = C.ID_SEC_CHEQUE
					 AND     A.ID_TIPO_OPERACION_SET = C.ID_TIPO_OPERACION_SET
					 AND     C.ID_TIPO_OPERACION_SET = D.ID_TIPO_OPERACION_SET
					 AND     D.ID_ESTADO_CHEQUE      = E.ID_ESTADO_CHEQUE
					 AND     E.TIPO_OPERACION   IN  ('ENFIRME','SBC','RECHAZADO')
					 GROUP BY A.E_CODIGO, B.REFERENCIA_CLIENTE, B.IMPORTE, B.MONEDA, A.ID_TIPO_OPERACION_SET
					 HAVING COUNT(1)=1
         			);
COMMIT;
--***************************************************************
--PARA INSERTAR REGISTROS EN LA TABLA DE GL_INTERFACE  DE ABONO *
--***************************************************************
      OPEN VALIDA_COMBINACION;
	  LOOP
	   FETCH VALIDA_COMBINACION
       INTO V_VALIDA,V_VALIDA2,V_EMPRESA_VAL, V_MONEDA_VAL;
       EXIT WHEN VALIDA_COMBINACION%NOTFOUND;
             DBMS_OUTPUT.PUT_LINE ('ENTRO AL CURSOR VALIDA COMBINACION'|| TO_CHAR(V_VALIDA) || '  '||TO_CHAR(V_EMPRESA_VAL) ||'  '||TO_CHAR(V_MONEDA_VAL));
--******************
--NUEVO SECUENCIAS *
-- *****************
	 BEGIN
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
											COMMIT;
				              ELSE IF SECUENCIA1<SECUENCIA2 THEN
				                           SELECT XXCHK_GROUP_ID_ABONO.NEXTVAL
				                           INTO INCREMENTO
				                           FROM DUAL;
										   COMMIT;
				              END IF;
						  END IF;
		           END LOOP;
END;
--***********************************************************
--  valida si existe la code_combination_:id
-- **********************************************************
  BEGIN
					          SELECT  a.code_combination_id
					          INTO  V_COMBINACION
					          FROM  apps.gl_balances@ERP_PROD a
					          WHERE a.code_combination_id = V_VALIDA
                              GROUP BY a.code_combination_id;
							  SELECT  a.code_combination_id
							  INTO  V_COMBINACION2
							  FROM  apps.gl_balances@ERP_PROD a
							  WHERE a.code_combination_id = V_VALIDA2
							  GROUP BY a.code_combination_id;
     IF V_COMBINACION IS NOT NULL AND V_COMBINACION2 IS NOT NULL THEN
--*******************************
--VALIDAR QUE TIPO DE MONEDA ES
--*******************************
	  DBMS_OUTPUT.PUT_LINE ('ENTRO PRIMER IF');
				IF V_MONEDA_VAL <> 'MXP' THEN
--****************************************************************
--PARA INSERTAR REGISTROS EN LA TABLA DE GL_INTERFACE  DE CARGO
--****************************************************************
	 DBMS_OUTPUT.PUT_LINE ('DIFERENTE MONEDA'|| TO_CHAR(V_VALIDA) || '  '||TO_CHAR(V_EMPRESA_VAL) ||'  '||TO_CHAR(V_MONEDA_VAL));
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
						             CASE GRUPO WHEN 0 THEN
						             XXCHK_GROUP_ID_CARGO.NEXTVAL END AS GRUPO_ID,
						             reference1,
						             period_name,
									 SYSDATE,
						             'SISTEMA'
						       FROM (
						             SELECT DISTINCT
                                     c.ID_SEC_CHEQUE as secuencia,
                                     c.ID_ESTADO_CHEQUE as id_estado,
						             'NEW',
						             d.set_of_books_id,
						             TO_CHAR(SYSDATE, 'DD/MON/YY')  AS FEC1,
						             c.moneda AS MONEDA, --CASE c.moneda WHEN 'MN' THEN 'MXP' END AS MONEDA,
									 CASE c.moneda WHEN 'MXP' THEN NULL
							         ELSE SYSDATE
								     END AS FECHA,
								     CASE c.moneda WHEN 'MXP' THEN NULL
							         ELSE 'Corporative'
								     END AS USUARIO,
									 CASE c.moneda WHEN 'MXP' THEN NULL
							         ELSE I.conversion_rate
								     END AS CONVERSION,
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
						             a.segment1||'-'||'c.id_sec_cheque' AS reference1,
						             TO_CHAR(SYSDATE, 'YY') AS period_name    -- TO_CHAR(SYSDATE, 'MON-YY') AS period_name
						       FROM  apps.gl_code_combinations@ERP_PROD a,
				                     XXCHK_CAT_EDO_CHEQUE b,
				                     XXCHK_CAPTURA_CHEQUES c,
				                     apps.gl_balances@ERP_PROD d,
				                     gl_sets_of_books@ERP_PROD e,
				                     XXCHK_CHEQ_ALL_HIST f,
				                     FECXC_EMPRESAS g,
									 XXCHK_CAT_EDOS H,
									 gl.gl_daily_rates@ERP_PROD I
						      WHERE  a.code_combination_id = b.c_cargo_erp
						      AND    b.c_cargo_erp = V_VALIDA2
						      AND    a.code_combination_id = d.code_combination_id
						      AND    d.set_of_books_id = e.set_of_books_id
						      AND    b.id_estado_cheque = c.id_estado_cheque
						      AND    c.e_codigo = f.e_codigo
						      AND    c.e_codigo = g.e_codigo
							  AND    c.id_sec_cheque = f.ID_SEC_CHEQUE
						      AND    c.referencia_cliente = f.referencia_cliente
							  AND    c.procesado IS NULL
						      AND    C.ID_ESTADO_CHEQUE = H.ID_ESTADO_CHEQUE
						      AND    H.TIPO_OPERACION IN ('ENFIRME','SBC','RECHAZADO')
						      AND    b.e_codigo = c.e_codigo
						      AND    c.e_codigo = V_EMPRESA_VAL
						      AND    c.moneda = I.FROM_CURRENCY
							  AND    I.FROM_CURRENCY = V_MONEDA_VAL
							  AND    I.TO_CURRENCY = 'MXP'
 							  AND    I.CONVERSION_TYPE ='Corporate'
                              AND    I.CONVERSION_DATE = '31/JAN/2007' --SYSDATE
						      AND    f.procesado = 1
						      AND    b.contabiliza = 1
						      AND    g.CUAL_ERP= 'O'
						            )
COMMIT;
--*************************************************************
-- PARA INSERTAR REGISTROS EN LA TABLA DE GL_INTERFACE  ABONO
--*************************************************************
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
								     SELECT  secuencia,
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
								             CASE GRUPO WHEN 0 THEN
								             XXCHK_GROUP_ID_ABONO.NEXTVAL END AS GRUPO_ID,
								             reference1,
								             period_name,
											 SYSDATE,
								            'SISTEMA'
								         FROM(
								             SELECT DISTINCT
                                              c.ID_SEC_CHEQUE as secuencia,
                                              c.ID_ESTADO_CHEQUE as id_estado,
								             'NEW',
								              d.set_of_books_id,
								              TO_CHAR(SYSDATE, 'DD/MON/YY')  AS FEC1,
								              c.moneda AS MONEDA, --CASE c.moneda WHEN 'MN' THEN 'MXP' END AS MONEDA,
											   CASE c.moneda WHEN 'MXP' THEN NULL
										         ELSE SYSDATE
											     END AS FECHA,
											     CASE c.moneda WHEN 'MXP' THEN NULL
										         ELSE 'Corporative'
											     END AS USUARIO,
												 CASE c.moneda WHEN 'MXP' THEN NULL
										         ELSE I.conversion_rate
											     END AS CONVERSION,
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
								               a.segment1||'-'||'c.id_sec_cheque' AS reference1,
								               TO_CHAR(SYSDATE, 'YY') AS period_name  --TO_CHAR(SYSDATE, 'MON-YY') AS period_name
								         FROM  apps.gl_code_combinations@ERP_PROD a,
						                       XXCHK_CAT_EDO_CHEQUE b,
						                       XXCHK_CAPTURA_CHEQUES c,
						                       apps.gl_balances@ERP_PROD d,
						                       gl_sets_of_books@ERP_PROD e,
						                       XXCHK_CHEQ_ALL_HIST f,
						                       FECXC_EMPRESAS g,
											   XXCHK_CAT_EDOS H,
											   gl.gl_daily_rates@ERP_PROD I
								       WHERE   a.code_combination_id = b.c_abono_erp
								       AND     b.c_abono_erp = V_VALIDA
								       AND     a.code_combination_id = d.code_combination_id
								       AND     d.set_of_books_id = e.set_of_books_id
								       AND     b.id_estado_cheque = c.id_estado_cheque
								       AND     c.e_codigo = f.e_codigo
									   AND     c.id_sec_cheque = f.ID_SEC_CHEQUE
								       AND     c.e_codigo = g.e_codigo
								       AND     c.procesado IS NULL
								       AND     C.ID_ESTADO_CHEQUE = H.ID_ESTADO_CHEQUE
								       AND     H.TIPO_OPERACION IN ('ENFIRME','SBC','RECHAZADO')
								       AND     c.e_codigo = V_EMPRESA_VAL
								       AND     b.e_codigo = c.e_codigo
								       AND     c.referencia_cliente = f.referencia_cliente
									   AND     c.moneda = I.FROM_CURRENCY
									   AND     I.FROM_CURRENCY = V_MONEDA_VAL
									   AND     I.TO_CURRENCY = 'MXP'
									   AND     I.CONVERSION_TYPE = 'Corporate'
                                       AND     I.CONVERSION_DATE = '31/JAN/2007'
								       AND     f.procesado = 1
								       AND     b.contabiliza = 1
								       AND     g.CUAL_ERP= 'O'
								          )
         COMMIT;
	END IF;
	IF V_MONEDA_VAL = 'MXP' THEN
	DBMS_OUTPUT.PUT_LINE ('MISMA MONEDA');
--****************************************************************
--PARA INSERTAR REGISTROS EN LA TABLA DE GL_INTERFACE  DE CARGO
--****************************************************************
            INSERT INTO XXCHK_GL_INTERFACE_CHK (
						                  ID_SEC_CHEQUE,
                                          ID_ESTADO_CHEQUE,
						                  STATUS,
						                  SET_OF_BOOKS_ID,
						                  ACCOUNTING_DATE,
						                  CURRENCY_CODE,
										  --CURRENCY_CONVERSION_DATE,
										  --USER_CURRENCY_CONVERSION_TYPE,
										  --CURRENCY_CONVERSION_RATE,
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
						             CASE GRUPO WHEN 0 THEN
						             XXCHK_GROUP_ID_CARGO.NEXTVAL END AS GRUPO_ID,
						             reference1,
						             period_name,
									 SYSDATE,
						             'SISTEMA'
            			       FROM (
						             SELECT DISTINCT
                                     c.ID_SEC_CHEQUE as secuencia,
                                     c.ID_ESTADO_CHEQUE as id_estado,
						             'NEW',
						             d.set_of_books_id,
						             TO_CHAR(SYSDATE, 'DD/MON/YY')  AS FEC1,
						             c.moneda AS MONEDA, --CASE c.moneda WHEN 'MN' THEN 'MXP' END AS MONEDA,
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
						             a.segment1||'-'||'c.id_sec_cheque' AS reference1,
						             TO_CHAR(SYSDATE, 'YY') AS period_name    -- TO_CHAR(SYSDATE, 'MON-YY') AS period_name
						       FROM  apps.gl_code_combinations@ERP_PROD a,
				                     XXCHK_CAT_EDO_CHEQUE b,
				                     XXCHK_CAPTURA_CHEQUES c,
				                     apps.gl_balances@ERP_PROD d,
				                     gl_sets_of_books@ERP_PROD e,
				                     XXCHK_CHEQ_ALL_HIST f,
				                     FECXC_EMPRESAS g,
									 XXCHK_CAT_EDOS H
									 --gl.gl_daily_rates@ERP_PROD I
						      WHERE  a.code_combination_id = b.c_cargo_erp
						      AND    b.c_cargo_erp = V_VALIDA2       ---OJO OMAR
						      AND    a.code_combination_id = d.code_combination_id
						      AND    d.set_of_books_id = e.set_of_books_id
						      AND    b.id_estado_cheque = c.id_estado_cheque
						      AND    c.e_codigo = f.e_codigo
						      AND    c.e_codigo = g.e_codigo
							  AND    c.id_sec_cheque = f.ID_SEC_CHEQUE
						      AND    c.referencia_cliente = f.referencia_cliente
							  AND    c.procesado IS NULL
						      AND    C.ID_ESTADO_CHEQUE = H.ID_ESTADO_CHEQUE
						      AND    H.TIPO_OPERACION IN ('ENFIRME','SBC','RECHAZADO')
						      AND    b.e_codigo = c.e_codigo
						      AND    c.e_codigo = V_EMPRESA_VAL
						      AND    c.moneda = V_MONEDA_VAL --I.FROM_CURRENCY
   						      AND    f.procesado = 1
						      AND    b.contabiliza = 1
						      AND    g.CUAL_ERP= 'O'
						            )
COMMIT;
--*************************************************************
-- PARA INSERTAR REGISTROS EN LA TABLA DE GL_INTERFACE  ABONO
--*************************************************************
			INSERT INTO XXCHK_GL_INTERFACE_CHK (
							              ID_SEC_CHEQUE,
                                          ID_ESTADO_CHEQUE,
						                  STATUS,
						                  SET_OF_BOOKS_ID,
						                  ACCOUNTING_DATE,
						                  CURRENCY_CODE,
										  --CURRENCY_CONVERSION_DATE,
										  --USER_CURRENCY_CONVERSION_TYPE,
										  --CURRENCY_CONVERSION_RATE,
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
								             CASE GRUPO WHEN 0 THEN
								             XXCHK_GROUP_ID_ABONO.NEXTVAL END AS GRUPO_ID,
								             reference1,
								             period_name,
											 SYSDATE,
								            'SISTEMA'
								         FROM(
								             SELECT DISTINCT
                                              c.ID_SEC_CHEQUE as secuencia,
                                              c.ID_ESTADO_CHEQUE as id_estado,
								             'NEW',
								              d.set_of_books_id,
								              TO_CHAR(SYSDATE, 'DD/MON/YY')  AS FEC1,
								              c.moneda AS MONEDA, --CASE c.moneda WHEN 'MN' THEN 'MXP' END AS MONEDA,
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
								               a.segment1||'-'||'c.id_sec_cheque' AS reference1,
								               TO_CHAR(SYSDATE, 'YY') AS period_name  --TO_CHAR(SYSDATE, 'MON-YY') AS period_name
								         FROM  apps.gl_code_combinations@ERP_PROD a,
						                       XXCHK_CAT_EDO_CHEQUE b,
						                       XXCHK_CAPTURA_CHEQUES c,
						                       apps.gl_balances@ERP_PROD d,
						                       gl_sets_of_books@ERP_PROD e,
						                       XXCHK_CHEQ_ALL_HIST f,
						                       FECXC_EMPRESAS g,
											   XXCHK_CAT_EDOS H
									   WHERE   a.code_combination_id = b.c_abono_erp
								       AND     b.c_abono_erp = V_VALIDA
								       AND     a.code_combination_id = d.code_combination_id
								       AND     d.set_of_books_id = e.set_of_books_id
								       AND     b.id_estado_cheque = c.id_estado_cheque
								       AND     c.e_codigo = f.e_codigo
									   AND     c.id_sec_cheque = f.ID_SEC_CHEQUE
								       AND     c.e_codigo = g.e_codigo
								       AND     c.procesado IS NULL
								       AND     C.ID_ESTADO_CHEQUE = H.ID_ESTADO_CHEQUE
								       AND     H.TIPO_OPERACION IN ('ENFIRME','SBC','RECHAZADO')
								       AND     c.e_codigo = V_EMPRESA_VAL
								       AND     b.e_codigo = c.e_codigo
								       AND     c.referencia_cliente = f.referencia_cliente
									   AND     c.moneda = V_MONEDA_VAL --I.FROM_CURRENCY
									   AND     f.procesado = 1
								       AND     b.contabiliza = 1
								       AND     g.CUAL_ERP= 'O'
								          )
         COMMIT;
     END IF;
	END IF;
EXCEPTION
WHEN NO_DATA_FOUND THEN DBMS_OUTPUT.PUT_LINE ('NO HAY DATOS');
V_COMBINACION:= 2;
--V_COMBINACION2:= 2;
END;
--****************************************************************************
 --V_VALIDA = ABONNO, SI ABONO NO ES NULO ENTONCES EL ERROR ESTA EN  CARGO
--****************************************************************************
BEGIN
 	   	IF V_COMBINACION = 2  THEN
										SELECT  a.code_combination_id
										INTO  V_ERROR
										FROM  apps.gl_balances@ERP_PROD a
										WHERE a.code_combination_id = V_VALIDA
										GROUP BY a.code_combination_id;
          COMMIT;
         IF V_ERROR IS NOT NULL THEN
                 DBMS_OUTPUT.PUT_LINE ('error abono' || V_VALIDA ||' '|| V_EMPRESA_VAL);
			    INSERT INTO XXCHK_BIT_ERRORES (CODIGO_ERROR,
			                                   DESC_ERROR,
								               ID_CHEQUE,
								               CODE_COMBINATION,
			                                   COMPANIA,
			                                   STATUS_CHEQUE)
			    SELECT DISTINCT '1','ERROR EN LA CUENTA', A.ID_ESTADO_CHEQUE,
			                    D.segment1||D.segment2||D.segment3||D.segment4||D.segment5||D.segment6||D.segment7 AS combinacion,
			                    A.E_CODIGO, G.DESCRIPCION
					   	 FROM  	XXCHK_CAPTURA_CHEQUES A,
						      	XXCHK_CHEQ_ALL_HIST B,
						      	XXCHK_CAT_EDO_CHEQUE C,
						      	apps.gl_code_combinations@ERP_PROD D,
						      	FECXC_EMPRESAS E,
						      	XXCHK_MAPEO_DE_ESTADOS F,
							  	XXCHK_CAT_EDOS G
						WHERE A.E_CODIGO = B.E_CODIGO
					    AND   A.REFERENCIA_CLIENTE = B.REFERENCIA_CLIENTE
						AND   (A.PROCESADO IS NULL
						OR    A.PROCESADO = 2)
						AND   B.PROCESADO =1
						AND   A.E_CODIGO = C.E_CODIGO
						AND   A.E_CODIGO = V_EMPRESA_VAL
						AND   A.ID_ESTADO_CHEQUE = C.ID_ESTADO_CHEQUE
						AND   A.E_CODIGO = E.E_CODIGO
						AND   C.C_CARGO_ERP = D.CODE_COMBINATION_ID
						AND   C.C_CARGO_ERP = V_VALIDA2
						AND   C.ID_ESTADO_CHEQUE = F.ID_ESTADO_CHEQUE
						AND   F.ID_ESTADO_CHEQUE = G.ID_ESTADO_CHEQUE
						AND   G.TIPO_OPERACION IN ('ENFIRME','SBC','RECHAZADO')
						AND   C.CONTABILIZA=1
						AND   E.CUAL_ERP= 'O';
     COMMIT;
    END IF;
END IF;
EXCEPTION
WHEN NO_DATA_FOUND THEN DBMS_OUTPUT.PUT_LINE ('NO HAY DATOS');
V_COMBINACION2:= 2;
END;
--****************************************************************************
 --V_VALIDA2 = CARGO , SI CARGO NO ES NULO ENTONCES EL ERROR ESTA EN  ABONO
--****************************************************************************
BEGIN
   		 IF V_COMBINACION2 = 2 THEN
                                     SELECT  a.code_combination_id
                                     INTO  V_ERROR2
                                     FROM  apps.gl_balances@ERP_PROD a
                                     WHERE a.code_combination_id = V_VALIDA2
                                     GROUP BY a.code_combination_id;
                                     COMMIT;
   		  		IF V_ERROR2 IS NOT NULL THEN
    			   DBMS_OUTPUT.PUT_LINE ('error cargo' );
					   INSERT INTO XXCHK_BIT_ERRORES (CODIGO_ERROR,
					                                   DESC_ERROR,
					                                   ID_CHEQUE,
					                                   CODE_COMBINATION,
					                                   COMPANIA,
					                                   STATUS_CHEQUE)
					    SELECT DISTINCT '1','ERROR EN LA CUENTA', A.ID_ESTADO_CHEQUE,
					                    D.segment1||D.segment2||D.segment3||D.segment4||D.segment5||D.segment6||D.segment7 AS combinacion,
					                    A.E_CODIGO, G.DESCRIPCION
					             FROM   XXCHK_CAPTURA_CHEQUES A,
					                    XXCHK_CHEQ_ALL_HIST B,
					      				XXCHK_CAT_EDO_CHEQUE C,
					      				apps.gl_code_combinations@ERP_PROD D,
					      				FECXC_EMPRESAS E,
					      				XXCHK_MAPEO_DE_ESTADOS F,
						  				XXCHK_CAT_EDOS G
					    	      WHERE A.E_CODIGO = B.E_CODIGO
					    		  AND   A.REFERENCIA_CLIENTE = B.REFERENCIA_CLIENTE
					    		  AND   (A.PROCESADO IS NULL
					    		  OR    A.PROCESADO = 2)
					    		  AND   B.PROCESADO =1
					    		  AND   A.E_CODIGO = C.E_CODIGO
					    		  AND   A.E_CODIGO = V_EMPRESA_VAL
					    		  AND   A.ID_ESTADO_CHEQUE = C.ID_ESTADO_CHEQUE
					    		  AND   A.E_CODIGO = E.E_CODIGO
					    		  AND   C.C_ABONO_ERP = D.CODE_COMBINATION_ID
					    		  AND   C.C_ABONO_ERP = V_VALIDA
					    		  AND   C.ID_ESTADO_CHEQUE = F.ID_ESTADO_CHEQUE
					    		  AND   F.ID_ESTADO_CHEQUE = G.ID_ESTADO_CHEQUE
					    		  AND   G.TIPO_OPERACION IN ('ENFIRME','SBC','RECHAZADO')
					    		  AND   C.CONTABILIZA=1
					    		  AND   E.CUAL_ERP= 'O';
     		COMMIT;
    END IF;
END IF;
EXCEPTION
WHEN NO_DATA_FOUND THEN DBMS_OUTPUT.PUT_LINE ('NO HAY DATOS');
V_FIN_ERROR:= 1;
END;
BEGIN
       		  IF V_FIN_ERROR = 1  THEN
              	 			 DBMS_OUTPUT.PUT_LINE ('error abono');
						    INSERT INTO XXCHK_BIT_ERRORES (CODIGO_ERROR,
						                                   DESC_ERROR,
											               ID_CHEQUE,
											               CODE_COMBINATION,
						                                   COMPANIA,
						                                   STATUS_CHEQUE)
						    SELECT DISTINCT '1', 'ERROR EN LA CUENTA', A.ID_ESTADO_CHEQUE,
						    	   			D.segment1||D.segment2||D.segment3||D.segment4||D.segment5||D.segment6||D.segment7 AS combinacion,
						    				A.E_CODIGO, G.DESCRIPCION
						    		 FROM   XXCHK_CAPTURA_CHEQUES A,
						        	 		XXCHK_CHEQ_ALL_HIST B,
						        	 		XXCHK_CAT_EDO_CHEQUE C,
						        			apps.gl_code_combinations@ERP_PROD D,
						        			XXCHK_MAPEO_DE_ESTADOS F,
											XXCHK_CAT_EDOS G
						    		  WHERE A.E_CODIGO = B.E_CODIGO
						    		  AND   A.REFERENCIA_CLIENTE = B.REFERENCIA_CLIENTE
						    		  AND   (A.PROCESADO IS NULL
						       		  OR    A.PROCESADO = 2)
						    		  AND   A.E_CODIGO = V_EMPRESA_VAL
						    		  AND   B.PROCESADO =1
						    		  AND   A.ID_ESTADO_CHEQUE = C.ID_ESTADO_CHEQUE
						    		  AND   C.ID_ESTADO_CHEQUE = G.ID_ESTADO_CHEQUE
						    		  AND   G.TIPO_OPERACION IN ('ENFIRME','SBC','RECHAZADO')
						    		  AND   C.C_ABONO_ERP = D.CODE_COMBINATION_ID
						    		  AND   C.C_ABONO_ERP = V_VALIDA
						    		  AND   A.ID_ESTADO_CHEQUE = F.ID_ESTADO_CHEQUE;
						    COMMIT;
					    INSERT INTO XXCHK_BIT_ERRORES (CODIGO_ERROR,
					                                   DESC_ERROR,
					                                   ID_CHEQUE,
					                                   CODE_COMBINATION,
					                                   COMPANIA,
					                                   STATUS_CHEQUE)
					    SELECT DISTINCT '1', 'ERROR EN LA CUENTA', A.ID_ESTADO_CHEQUE,
					    D.segment1||D.segment2||D.segment3||D.segment4||D.segment5||D.segment6||D.segment7 AS combinacion,
					    A.E_CODIGO, G.DESCRIPCION
					    FROM   XXCHK_CAPTURA_CHEQUES A,
					        XXCHK_CHEQ_ALL_HIST B,
					        XXCHK_CAT_EDO_CHEQUE C,
					        apps.gl_code_combinations@ERP_PROD D,
					        XXCHK_MAPEO_DE_ESTADOS F,
							XXCHK_CAT_EDOS G
					    WHERE A.E_CODIGO = B.E_CODIGO
					    AND   A.REFERENCIA_CLIENTE = B.REFERENCIA_CLIENTE
					    AND   (A.PROCESADO IS NULL
					    OR    A.PROCESADO = 2)
					    AND   A.E_CODIGO = V_EMPRESA_VAL
					    AND   B.PROCESADO =1
					    AND   A.ID_ESTADO_CHEQUE = C.ID_ESTADO_CHEQUE
					    AND   C.ID_ESTADO_CHEQUE = G.ID_ESTADO_CHEQUE
					    AND   G.TIPO_OPERACION IN ('ENFIRME','SBC','RECHAZADO')
					    AND   C.C_CARGO_ERP = D.CODE_COMBINATION_ID
					    AND   C.C_CARGO_ERP = V_VALIDA2
					    AND   A.ID_ESTADO_CHEQUE = F.ID_ESTADO_CHEQUE;
       COMMIT;
     END IF;
EXCEPTION
WHEN NO_DATA_FOUND THEN
RAISE_APPLICATION_ERROR(-20000,'No hay datos nuevos.');
END;
   V_FIN_ERROR:= NULL;
   V_COMBINACION:= NULL;
   V_COMBINACION2:= NULL;
  END LOOP;
 CLOSE VALIDA_COMBINACION;
--****************************************
--DEBITOS y CREDITOS EN SOIN
--****************************************
DBMS_OUTPUT.PUT_LINE ('SEGUNDA PARTE'|| TO_CHAR(V_VALIDA) || '  '||TO_CHAR(V_EMPRESA_VAL));
      INSERT INTO XXCHK_INTARC_ORA(
      E_CODIGO,
      INTBAT,
      INTORI,
      INTSUB,
      INTREL,
      INTDOC,
      INTREF,
      INTMON,
      INTMOE,
      INTTIP,
      INTDES,
      INTDIA,
      INTFEC,
      INTCAM,
      CTAM01,
      CTAM02,
      CTAM03,
      CTAM04,
      CTAM05,
      CTAM06,
      MONCOD,
      IMPFPO,
      TV6PRD,
      IMPREF2,
      TV9IDE,
      DATE_CREATED,
      CREATED_BY
      )
      SELECT C.E_CODIGO           AS EMPRESA,
      C.ID_SEC_CHEQUE||C.REFERENCIA_CLIENTE||C.IMPORTE||C.IMPORTE AS DOCUMENTO,
      'XX'         AS ORIGEN,
      'CK'         AS SUBORIGEN,
      0            AS RELACION,
      '  '||B.CR_CARGO_SOIN||B.CR_CARGO_SOIN2  AS DOCUMENTO,
      C.REFERENCIA_CLIENTE     AS REFERENCIA,
      C.IMPORTE    AS IMP_MON_LOC,
      C.IMPORTE    AS IMP_MON_EX,
      'C'          AS TIPO_MOV,
      'MOV XXCHK'  AS DESCRIPCION,
      'DG'         AS DIARIO,
      '20051201'      AS FECHA,
      1                 AS TIPO_CAMBIO,
      B.C_CARGO_SOIN    AS CTAM01,
      B.SC_CARGO_SOIN   AS CTAM02,
      B.SSC_CARGO_SOIN  AS CTAM03,
      '0000'            AS CTAM04,
      '000'             AS CTAM05,
      '000'             AS CTAM06,
      '01'              AS MONEDA,
      '20051201'      AS FECHAPOLIZA,
      NULL              AS TIPO_PRODUCTO,
      C.DESC_CLIENTE    AS SEG_REF_MOV,
      NULL              AS ID_DEL_TERCERO,
      SYSDATE           AS DATE_CREATED,
      'SISTEMA'         AS CREATED_BY
      FROM  XXCHK_CAT_EDO_CHEQUE b,
      XXCHK_CAPTURA_CHEQUES c,
      XXCHK_CHEQ_ALL_HIST f,
      FECXC_EMPRESAS g, XXCHK_CAT_EDOS H
      WHERE  c.e_codigo = f.e_codigo
      AND    c.referencia_cliente = f.referencia_cliente
      AND    C.ID_ESTADO_CHEQUE = H.ID_ESTADO_CHEQUE
      AND    H.TIPO_OPERACION IN ('ENFIRME','SBC','RECHAZADO')
      AND    c.id_sec_cheque=f.id_sec_cheque
      AND    b.e_codigo = c.e_codigo
      AND    b.e_codigo=f.e_codigo
      AND    b.id_estado_cheque=c.id_estado_cheque
      AND    g.e_codigo=c.e_codigo
      AND    g.cual_erp = 'S'
      AND    c.procesado IS NULL
      AND    f.procesado = 1
      AND    b.contabiliza = 1
      UNION ALL
      SELECT C.E_CODIGO           AS EMPRESA,
      C.ID_SEC_CHEQUE||C.REFERENCIA_CLIENTE||C.IMPORTE||C.IMPORTE AS DOCUMENTO,
      'XX'           AS ORIGEN,
      'CK'           AS SUBORIGEN,
      0              AS RELACION,
      '  '||B.CR_ABONO_SOIN||B.CR_ABONO_SOIN2    AS DOCUMENTO,
      C.REFERENCIA_CLIENTE     AS REFERENCIA,
      C.IMPORTE      AS IMP_MON_LOC,
      C.IMPORTE      AS IMP_MON_EX,
      'D'            AS TIPO_MOV,
      'MOV XXCHK'    AS DESCRIPCION,
      'DG'           AS DIARIO,
      '20051201'     AS FECHA,
      1                 AS TIPO_CAMBIO,
      B.C_ABONO_SOIN    AS CTAM01,
      B.SC_ABONO_SOIN   AS CTAM02,
      B.SSC_ABONO_SOIN  AS CTAM03,
      '0000'            AS CTAM04,
      '000'             AS CTAM05,
      '000'             AS CTAM06,
      '01'              AS MONEDA,
      '20051201'    AS FECHAPOLIZA,
      NULL             AS TIPO_PRODUCTO,
      C.DESC_CLIENTE   AS SEG_REF_MOV,
      NULL             AS ID_DEL_TERCERO,
      SYSDATE          AS DATE_CREATED,
      'SISTEMA'        AS CREATED_BY
      FROM  XXCHK_CAT_EDO_CHEQUE b,
      XXCHK_CAPTURA_CHEQUES c,
      XXCHK_CHEQ_ALL_HIST f,
      FECXC_EMPRESAS g, XXCHK_CAT_EDOS H
      WHERE  c.e_codigo = f.e_codigo
      AND    c.referencia_cliente = f.referencia_cliente
      AND    C.ID_ESTADO_CHEQUE = H.ID_ESTADO_CHEQUE
         AND    H.TIPO_OPERACION IN ('ENFIRME','SBC','RECHAZADO')
      AND    c.id_sec_cheque=f.id_sec_cheque
      AND    b.e_codigo = c.e_codigo
      AND    b.e_codigo=f.e_codigo
      AND    b.id_estado_cheque=c.id_estado_cheque
      AND    g.e_codigo=c.e_codigo
      AND    g.cual_erp = 'S'
      AND    c.procesado IS NULL
      AND    f.procesado = 1
      AND    b.contabiliza = 1;
 COMMIT;
--*******************************************************************
--PRUEBA ACTUALIZA EL CAMPO PROCESADO CON 2 PARA LA SIGUIENTE VUELTA
--*******************************************************************
		   UPDATE  XXCHK_CAPTURA_CHEQUES B
		   SET B.PROCESADO = (
				             SELECT  2
						     FROM    XXCHK_CHEQUES_ALL A,XXCHK_CHEQ_ALL_HIST C, XXCHK_MAPEO_DE_ESTADOS D, XXCHK_CAT_EDOS E
							 WHERE   B.E_CODIGO = A.E_CODIGO
						     AND     B.IMPORTE  = A.IMPORTE
						     AND     B.REFERENCIA_CLIENTE = A.REFERENCIA_CLIENTE
						     AND     B.MONEDA = A.MONEDA
							 AND     B.E_CODIGO= C.E_CODIGO
							 AND     B.REFERENCIA_CLIENTE = C.REFERENCIA_CLIENTE
							 AND     B.ID_SEC_CHEQUE = C.ID_SEC_CHEQUE
							 AND     A.ID_TIPO_OPERACION_SET = C.ID_TIPO_OPERACION_SET
							 AND     C.ID_TIPO_OPERACION_SET = D.ID_TIPO_OPERACION_SET
							 AND     D.ID_ESTADO_CHEQUE      = E.ID_ESTADO_CHEQUE
							 AND     E.TIPO_OPERACION   IN  ('SBC')
							 GROUP BY A.E_CODIGO, B.REFERENCIA_CLIENTE, B.IMPORTE, B.MONEDA, A.ID_TIPO_OPERACION_SET
        			 	       )
             WHERE EXISTS  (
				             SELECT  2
						     FROM    XXCHK_CHEQUES_ALL A,XXCHK_CHEQ_ALL_HIST C, XXCHK_MAPEO_DE_ESTADOS D, XXCHK_CAT_EDOS E
							 WHERE   B.E_CODIGO = A.E_CODIGO
						     AND     B.IMPORTE  = A.IMPORTE
						     AND     B.REFERENCIA_CLIENTE = A.REFERENCIA_CLIENTE
						     AND     B.MONEDA = A.MONEDA
							 AND     B.E_CODIGO= C.E_CODIGO
							 AND     B.REFERENCIA_CLIENTE = C.REFERENCIA_CLIENTE
							 AND     B.ID_SEC_CHEQUE = C.ID_SEC_CHEQUE
							 AND     A.ID_TIPO_OPERACION_SET = C.ID_TIPO_OPERACION_SET
							 AND     C.ID_TIPO_OPERACION_SET = D.ID_TIPO_OPERACION_SET
							 AND     D.ID_ESTADO_CHEQUE      = E.ID_ESTADO_CHEQUE
							 AND     E.TIPO_OPERACION   IN  ('SBC')
							 GROUP BY A.E_CODIGO, B.REFERENCIA_CLIENTE, B.IMPORTE, B.MONEDA, A.ID_TIPO_OPERACION_SET
                            );
COMMIT;
--******************************************************************
--PARA PONER LOS REGISTRO PROCESADOS QUE ESTAN ENFIRME O RECHAZADOS
--******************************************************************
	      UPDATE  XXCHK_CAPTURA_CHEQUES B
		  SET B.PROCESADO = (
			                 SELECT  1
						     FROM    XXCHK_CHEQUES_ALL A,XXCHK_CHEQ_ALL_HIST C, XXCHK_MAPEO_DE_ESTADOS D, XXCHK_CAT_EDOS E
							 WHERE   B.E_CODIGO = A.E_CODIGO
						     AND     B.IMPORTE  = A.IMPORTE
						     AND     B.REFERENCIA_CLIENTE = A.REFERENCIA_CLIENTE
						     AND     B.MONEDA = A.MONEDA
							 AND     B.E_CODIGO= C.E_CODIGO
							 AND     B.REFERENCIA_CLIENTE = C.REFERENCIA_CLIENTE
							 AND     B.ID_SEC_CHEQUE = C.ID_SEC_CHEQUE
							 AND     A.ID_TIPO_OPERACION_SET = C.ID_TIPO_OPERACION_SET
							 AND     C.ID_TIPO_OPERACION_SET = D.ID_TIPO_OPERACION_SET
							 AND     D.ID_ESTADO_CHEQUE      = E.ID_ESTADO_CHEQUE
							 AND     E.TIPO_OPERACION   IN  ('RECHAZADO','ENFIRME')
							 GROUP BY A.E_CODIGO, B.REFERENCIA_CLIENTE, B.IMPORTE, B.MONEDA, A.ID_TIPO_OPERACION_SET
			                )
			  WHERE EXISTS  (
				             SELECT  1
						     FROM    XXCHK_CHEQUES_ALL A,XXCHK_CHEQ_ALL_HIST C, XXCHK_MAPEO_DE_ESTADOS D, XXCHK_CAT_EDOS E
							 WHERE   B.E_CODIGO = A.E_CODIGO
						     AND     B.IMPORTE  = A.IMPORTE
						     AND     B.REFERENCIA_CLIENTE = A.REFERENCIA_CLIENTE
						     AND     B.MONEDA = A.MONEDA
							 AND     B.E_CODIGO= C.E_CODIGO
							 AND     B.REFERENCIA_CLIENTE = C.REFERENCIA_CLIENTE
							 AND     B.ID_SEC_CHEQUE = C.ID_SEC_CHEQUE
							 AND     A.ID_TIPO_OPERACION_SET = C.ID_TIPO_OPERACION_SET
							 AND     C.ID_TIPO_OPERACION_SET = D.ID_TIPO_OPERACION_SET
							 AND     D.ID_ESTADO_CHEQUE      = E.ID_ESTADO_CHEQUE
							 AND     E.TIPO_OPERACION   IN  ('RECHAZADO','ENFIRME')
							 GROUP BY A.E_CODIGO, B.REFERENCIA_CLIENTE, B.IMPORTE, B.MONEDA, A.ID_TIPO_OPERACION_SET
			                 );
 COMMIT;
 --********************************************
  --GENERA POLIZAS EN LA TABAL DE GL_INTERFACE
 --********************************************
DBMS_OUTPUT.PUT_LINE ('crear polzas gl');
/*
     INSERT INTO GL_INTERFACE@ERP_PROD (
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
							  PERIOD_NAME)
			        SELECT    STATUS,
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
			            FROM XXCHK_GL_INTERFACE_CHK
			            WHERE PROCESADO IS NULL;
 COMMIT;
*/
 --*******************************************
-- actualiza el campor group id del historico
--*******************************************
   UPDATE XXCHK_CHEQ_ALL_HIST A
   SET    A.GROUP_ID = ( SELECT B.GROUP_ID
                         FROM   XXCHK_GL_INTERFACE_CHK B,
                                XXCHK_CAPTURA_CHEQUES C
                         WHERE  A.ID_SEC_CHEQUE = B.ID_SEC_CHEQUE
                         AND    A.ID_ESTADO_CHEQUE = B.ID_ESTADO_CHEQUE
                         AND    B.ID_SEC_CHEQUE = C.ID_SEC_CHEQUE
                         AND    B.ID_ESTADO_CHEQUE = C.ID_ESTADO_CHEQUE
                         AND    B.PROCESADO IS NULL
                         AND    A.PROCESADO= 1
                        )
     WHERE EXISTS (      SELECT 1
                         FROM   XXCHK_GL_INTERFACE_CHK B,
                                XXCHK_CAPTURA_CHEQUES C
                         WHERE  A.ID_SEC_CHEQUE = B.ID_SEC_CHEQUE
                         AND    A.ID_ESTADO_CHEQUE = B.ID_ESTADO_CHEQUE
                         AND    B.ID_SEC_CHEQUE = C.ID_SEC_CHEQUE
                         AND    B.ID_ESTADO_CHEQUE = C.ID_ESTADO_CHEQUE
                         AND    B.PROCESADO IS NULL
                         AND    A.PROCESADO= 1
                  );
   COMMIT;
--**************************************************
  --ACTUALIZA ESTATUS PROCESADO TABLA GL_INTERFACE
--**************************************************
			   UPDATE  XXCHK_GL_INTERFACE_CHK A
			     SET A.PROCESADO = (
				          SELECT 1
			              FROM  GL_INTERFACE@ERP_PROD B
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
			              FROM  GL_INTERFACE@ERP_PROD B
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
  COMMIT;
 --EXCEPTION
 --WHEN NO_DATA_FOUND THEN DBMS_OUTPUT.PUT_LINE ('EXCEPTION'|| TO_CHAR(V_COMBINACION));
 --V_COMBINACION:= 2;
--RAISE_APPLICATION_ERROR(-20000,'No hay datos nuevos.');
END ACTUALIZA_CHKS_STATUS;
END Xxmacht_Cheques_Status;
/;
