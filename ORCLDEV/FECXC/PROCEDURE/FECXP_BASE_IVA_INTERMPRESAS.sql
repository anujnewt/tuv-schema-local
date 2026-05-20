CREATE OR REPLACE EDITIONABLE PROCEDURE "FECXC"."FECXP_BASE_IVA_INTERMPRESAS" ( V_FECHA_INI IN DATE,  V_FECHA_FIN IN DATE)IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
  V_NO_EMPRESA                INTEGER;
  V_NO_FOLIO_DET              INTEGER;
  V_FEC_VALOR                 DATE;
  V_REFERENCIA                VARCHAR2(30);
  V_ID_BANCO                  INTEGER;
  V_ID_BANCO_BENEF            INTEGER;
  V_ID_CHEQUERA               VARCHAR2(20);
  V_CONCEPTO                  VARCHAR2(100);
  V_TIPO_CAMBIO               NUMBER;
  V_IMPORTE                   NUMBER;
  V_NO_CHEQUE                 INTEGER;
  V_ID_TIPO_OPERACION_SET     INTEGER;
  V_ID_FORMA_PAGO             INTEGER;
  V_ID_DIVISA                 VARCHAR2(3);
  V_FEC_VALOR_ORIGINAL        DATE;
  V_ID_STATUS_MOV             VARCHAR2(1);
  V_BENEFICIARIO              VARCHAR2(60);
  V_DESCRIPCION               VARCHAR2(30);
  V_SECUENCIA_DEP_ESPECIALES  INTEGER;
  V_NO_CLIENTE                VARCHAR2(15);
  V_PERIODO                   INTEGER;
  V_CVE_OPERACION             INTEGER;
  V_ORIGEN_MOVIMIENTO         VARCHAR2(3);
  V_ID_CHEQUERA_BENEF         VARCHAR2(11);
  V_LOTE_ENTRADA              INTEGER;
  V_NO_DOCTO                  INTEGER;
  V_PLATAFORMA                VARCHAR2(1);
  V_NOM_EMPRESA               VARCHAR2(100);
  V_NO_CUENTA                 INTEGER;
  V_FOLIO_REF                 INTEGER;
  V_FECHA_ACTUALIZACION       DATE;
  V_NOM_EMPRESA_REL           VARCHAR2(100);
  V_PROCESADO                 INTEGER;
  --- Variables para el IVA
  V_cla_fe_id  VARCHAR2(25);
  V_cla_fe_des VARCHAR2(50);
  V_cia        VARCHAR2(25);
  V_neg        VARCHAR2(25);
  V_cta        VARCHAR2(25);
  V_scta       VARCHAR2(25);
  V_cc         VARCHAR2(25);
  V_icia       VARCHAR2(25);
  V_top        VARCHAR2(25);
  --- Variables para el ACTIVITY
  V_cla_fe_id2  VARCHAR2(25);
  V_cla_fe_des2 VARCHAR2(50);
  V_cia2        VARCHAR2(25);
  V_neg2        VARCHAR2(25);
  V_cta2        VARCHAR2(25);
  V_scta2       VARCHAR2(25);
  V_cc2         VARCHAR2(25);
  V_icia2       VARCHAR2(25);
  V_top2        VARCHAR2(25);
  V_IMPORTE2 NUMBER(20,2);
   --  Variables para el manejo de Errores
  err_num NUMBER;
  err_msg VARCHAR2(100);
      --Este cursor sirve para encontrar los folios que no esten aperturados en Flujo y ya se encuentren en AR
         CURSOR c_apertura_ingresos IS SELECT RECEIPT_NUMBER,SUM (APLICADO) APLICADO,SUM (BASE) BASE, SUM (IVA) IVA, ID_STATUS_MOV FROM(
SELECT /*+ INDEX (FECXC_DEP_ESPECIALES FECXC_DEP_ESPECIALES_03)  */ ACRA.RECEIPT_NUMBER AS RECEIPT_NUMBER
                                              ,NVL(SUM(ARAA.AMOUNT_APPLIED),0) APLICADO
                                              ,NVL(SUM(ARAA.LINE_APPLIED),0) BASE
                                              ,NVL(SUM(ARAA.TAX_APPLIED),0)  IVA
                                              ,ID_STATUS_MOV
                                        FROM   AR.AR_CASH_RECEIPTS_ALL@TO_TVPROD ACRA
                                              ,APPS.AR_RECEIVABLE_APPLICATIONS_ALL@TO_TVPROD ARAA
                                              ,FECXC.FECXC_DEP_ESPECIALES FDE
                                        WHERE 1=1
                                          AND TO_CHAR(FDE.NO_FOLIO_DET)=ACRA.RECEIPT_NUMBER
                                          AND ACRA.CASH_RECEIPT_ID = ARAA.CASH_RECEIPT_ID
                                          AND ACRA.ORG_ID = ARAA.ORG_ID
                                          AND ARAA.STATUS != 'UNAPP'
                                          AND ARAA.DISPLAY = 'Y'
                                          AND FDE.ID_TIPO_OPERACION_SET  in (3700,3701,3705,3706,3708,3715,4102,4103)
                                          AND FDE.APERTURADOAR = 0
                                          AND FEC_VALOR_ORIGINAL>=V_FECHA_INI
                                          AND FEC_VALOR_ORIGINAL<= V_FECHA_FIN
                                          --and FDE.no_folio_det=32032109
                                        GROUP BY  ACRA.RECEIPT_NUMBER,ID_STATUS_MOV
UNION ALL
SELECT /*+ INDEX (FECXC_DEP_ESPECIALES FECXC_DEP_ESPECIALES_03)  */ ACRA.RECEIPT_NUMBER AS RECEIPT_NUMBER
                                              ,NVL(SUM(ARAA.AMOUNT_APPLIED),0) APLICADO
                                              ,NVL(SUM(ARAA.LINE_APPLIED),0) BASE
                                              ,NVL(SUM(ARAA.TAX_APPLIED),0)  IVA
                                              ,ID_STATUS_MOV
                                        FROM   AR.AR_CASH_RECEIPTS_ALL@TO_TVPROD ACRA
                                              ,APPS.AR_RECEIVABLE_APPLICATIONS_ALL@TO_TVPROD ARAA
                                              ,FECXC.FECXC_DEP_ESPECIALES FDE
                                        WHERE 1=1
                                          AND TO_CHAR(FDE.NO_FOLIO_DET)=ACRA.RECEIPT_NUMBER
                                          AND ACRA.CASH_RECEIPT_ID = ARAA.CASH_RECEIPT_ID
                                          AND ACRA.ORG_ID = ARAA.ORG_ID
                                          AND ARAA.STATUS ='UNAPP'
                                          AND FDE.ID_TIPO_OPERACION_SET  in (3700,3701,3705,3706,3708,3715,4102,4103)
                                          AND FDE.APERTURADOAR = 0
                                          AND FEC_VALOR_ORIGINAL>=V_FECHA_INI
                                          AND FEC_VALOR_ORIGINAL<= V_FECHA_FIN
                                          --and FDE.no_folio_det=32032109
                                        GROUP BY  ACRA.RECEIPT_NUMBER,ID_STATUS_MOV)
                                        GROUP BY RECEIPT_NUMBER,ID_STATUS_MOV;
    existe_folio_ar INT:=0;
    IMPORTE_B NUMBER;
    TOTAL NUMBER;
TYPE REC_FECXP_INGRESOS_CLASIF IS RECORD
(
  CLA_FE_ID           VARCHAR2(25 BYTE),
  E_CODIGO            INTEGER,
  FOLIO_SET           INTEGER,
  TIPO_OPERACION      INTEGER,
  FECHA               DATE,
  MONEDA              VARCHAR2(3 BYTE),
  TIPO_CAMBIO         NUMBER(20,11),
  IMPORTE             NUMBER(20,2),
  CONCEPTO            VARCHAR2(100 BYTE),
  BENEFICIARIO        VARCHAR2(60 BYTE),
  ID_STATUS_MOV       VARCHAR2(1 BYTE),
  ID_CHEQUERA         VARCHAR2(20 BYTE),
  ID_BANCO            INTEGER,
  ID_FORMA_PAGO       INTEGER,
  REFERENCIA          VARCHAR2(30 BYTE),
  IMPORTE_LINEA       NUMBER(20,4),
  ORA_SOIN_SEGMENTO1  VARCHAR2(25 BYTE),
  ORA_SOIN_SEGMENTO2  VARCHAR2(25 BYTE),
  ORA_SOIN_SEGMENTO3  VARCHAR2(25 BYTE),
  ORACLE_SEGMENTO4    VARCHAR2(25 BYTE),
  ORACLE_SEGMENTO5    VARCHAR2(25 BYTE),
  ORACLE_SEGMENTO6    VARCHAR2(25 BYTE),
  ORACLE_SEGMENTO7    VARCHAR2(25 BYTE),
  CUAL_ERP            VARCHAR2(1 BYTE),
  TIPO_CLASIFICACION  VARCHAR2(20 BYTE),
  NO_CLIENTE          VARCHAR2(15 BYTE),
  DESCRIPCION         VARCHAR2(30 BYTE)
);
TYPE T_C2_D IS TABLE OF REC_FECXP_INGRESOS_CLASIF;
REC_T_C2_D_TMP T_C2_D := T_C2_D();
lin_aux INTEGER;
BEGIN
   SELECT CLA_FE_ID, CLA_FE_DES, CIA, NEG, CTA, SCTA, CC, ICIA, TOP
     INTO V_CLA_FE_ID, V_CLA_FE_DES, V_CIA, V_NEG, V_CTA, V_SCTA, V_CC, V_ICIA, V_TOP
     FROM fecxc.fecxp_iva_interempresas_tbl ;
   SELECT CLA_FE_ID, CLA_FE_DES, CIA, NEG, CTA, SCTA, CC, ICIA, TOP
     INTO V_CLA_FE_ID2, V_CLA_FE_DES2, V_CIA2, V_NEG2, V_CTA2, V_SCTA2, V_CC2, V_ICIA2, V_TOP2
     FROM FECXC.FECXP_IVA_INTER_ACTIVITY_TBL;
----Ir a AR a buscar Cada uno de los Folios Recien Extraidos
----En caso de que exista se debera elminar de FLUJO DE EFECTIVO y REAPERTURAR con las nuevas cuentas contables
----En caso de que no exista se deja en FLUJO tal y como esta
       --Aperturando los folios
       lin_aux :=0;
       FOR cont IN c_apertura_ingresos
       LOOP
          existe_folio_ar :=0;
          BEGIN
            --Se busca el importe en Flujo, OJO: Tiene que ser el importe exactamente igual y el mismo id de estatus
            SELECT IMPORTE INTO IMPORTE_B FROM FECXC.FECXC_DEP_ESPECIALES FDE WHERE FDE.ID_STATUS_MOV=cont.ID_STATUS_MOV AND NO_FOLIO_DET = cont.RECEIPT_NUMBER;
            --DBMS_OUTPUT.PUT_LINE ('Importe del  Folio en FLujo: '|| IMPORTE_B||' resultado de la operacion '||(ABS(IMPORTE_B) - (abs(cont.BASE)+abs(cont.IVA)))||' '||cont.RECEIPT_NUMBER );
            TOTAL:=abs(IMPORTE_B);
            --si vienen Montos negativos dejar el Folio tal como esta
            IF (cont.APLICADO<0) OR (cont.BASE<0) OR (cont.IVA <0) THEN
             null;--NO SE HACE NADA
            ELSE
            --revisa que FLUJO cuadre contra AR
            IF ((ABS(IMPORTE_B) - abs(cont.APLICADO)) between -0.10 and 0.10) OR ((ABS(IMPORTE_B) - abs(cont.IVA+cont.BASE)) between -0.10 and 0.10)THEN
                --DBMS_OUTPUT.PUT_LINE ('FOLIO:'||cont.RECEIPT_NUMBER);
                --DBMS_OUTPUT.PUT_LINE ('Importe del Folio:$ '||IMPORTE_B||'Base:$ '|| cont.BASE||' IVA:$ '||cont.IVA ||' Activity:$ '||(ABS(cont.APLICADO)-(ABS(cont.base)+ABS(cont.IVA))));
                --DBMS_OUTPUT.PUT_LINE (','||cont.RECEIPT_NUMBER);
                --revisar en Flujo  si existe Base, IVA u Otro
                IF ((ABS(IMPORTE_B) - abs(cont.BASE)) between -0.10 and 0.10) THEN
                   --EL REGISTRO EXISTENTE ES LA BASE
                        --MARCAR LOS FOLIOS PROCESADOS
                        UPDATE FECXC.FECXC_DEP_ESPECIALES
                        SET APERTURADOAR=1
                        WHERE NO_FOLIO_DET =cont.RECEIPT_NUMBER
                        AND ID_STATUS_MOV=cont.ID_STATUS_MOV;
                        --DBMS_OUTPUT.PUT_LINE ('Actualiza la Base por'||Cont.Base);
                ELSIF  ((ABS(IMPORTE_B) - abs(cont.IVA)) between -0.10 and 0.10) THEN
                       --EL REGISTRO EXISTENTE ES EL IVA
                        UPDATE  FECXC.FECXP_INGRESOS_CLASIF F
                           SET  CLA_FE_ID=V_CLA_FE_ID,
                                ORA_SOIN_SEGMENTO1= CASE WHEN V_CIA  ='$' THEN F.ORA_SOIN_SEGMENTO1 ELSE V_CIA END,
                                ORA_SOIN_SEGMENTO2= CASE WHEN V_NEG  ='$' THEN F.ORA_SOIN_SEGMENTO2 ELSE V_NEG END,
                                ORA_SOIN_SEGMENTO3= CASE WHEN V_CTA  ='$' THEN F.ORA_SOIN_SEGMENTO3 ELSE V_CTA END,
                                ORACLE_SEGMENTO4=   CASE WHEN V_SCTA ='$' THEN F.ORACLE_SEGMENTO4   ELSE V_SCTA END,
                                ORACLE_SEGMENTO5=   CASE WHEN V_CC   ='$' THEN F.ORACLE_SEGMENTO5   ELSE V_CC END,
                                ORACLE_SEGMENTO6=   CASE WHEN V_ICIA ='$' THEN F.ORACLE_SEGMENTO6   ELSE V_ICIA END,
                                ORACLE_SEGMENTO7=   CASE WHEN V_TOP  ='$' THEN F.ORACLE_SEGMENTO7   ELSE V_TOP END
                         WHERE f.FOLIO_SET =cont.RECEIPT_NUMBER
                          AND f.ID_STATUS_MOV=cont.ID_STATUS_MOV  ;
                        --MARCAR LOS FOLIOS PROCESADOS
                        UPDATE FECXC.FECXC_DEP_ESPECIALES
                        SET APERTURADOAR=1
                        WHERE NO_FOLIO_DET =cont.RECEIPT_NUMBER
                        AND ID_STATUS_MOV=cont.ID_STATUS_MOV;
                        TOTAL:=TOTAL-abs(Cont.IVA);
                        --DBMS_OUTPUT.PUT_LINE ('Actualiza el IVA por'||Cont.IVA);
                ELSIF ((ABS(IMPORTE_B) - (abs(cont.APLICADO)-(ABS(CONT.IVA)+ABS(CONT.BASE)))) between -0.10 and 0.10) THEN
                       --EL REGISTRO EXISTENTE ES EL ACTIVITY
                        UPDATE  FECXC.FECXP_INGRESOS_CLASIF F
                           SET  CLA_FE_ID=V_CLA_FE_ID2,
                                ORA_SOIN_SEGMENTO1= CASE WHEN V_CIA2  ='$' THEN F.ORA_SOIN_SEGMENTO1 ELSE V_CIA2 END,
                                ORA_SOIN_SEGMENTO2= CASE WHEN V_NEG2  ='$' THEN F.ORA_SOIN_SEGMENTO2 ELSE V_NEG2 END,
                                ORA_SOIN_SEGMENTO3= CASE WHEN V_CTA2  ='$' THEN F.ORA_SOIN_SEGMENTO3 ELSE V_CTA2 END,
                                ORACLE_SEGMENTO4  = CASE WHEN V_SCTA2 ='$' THEN F.ORACLE_SEGMENTO4   ELSE V_SCTA2 END,
                                ORACLE_SEGMENTO5  = CASE WHEN V_CC2   ='$' THEN F.ORACLE_SEGMENTO5   ELSE V_CC2 END,
                                ORACLE_SEGMENTO6  = CASE WHEN V_ICIA2 ='$' THEN F.ORACLE_SEGMENTO6   ELSE V_ICIA2 END,
                                ORACLE_SEGMENTO7  = CASE WHEN V_TOP2  ='$' THEN F.ORACLE_SEGMENTO7   ELSE V_TOP2 END
                         WHERE f.FOLIO_SET =cont.RECEIPT_NUMBER
                          AND f.ID_STATUS_MOV=cont.ID_STATUS_MOV  ;
                        --MARCAR LOS FOLIOS PROCESADOS
                        UPDATE FECXC.FECXC_DEP_ESPECIALES
                        SET APERTURADOAR=1
                        WHERE NO_FOLIO_DET =cont.RECEIPT_NUMBER
                        AND ID_STATUS_MOV=cont.ID_STATUS_MOV;
                        TOTAL:=TOTAL-abs(Cont.APLICADO);
                        --DBMS_OUTPUT.PUT_LINE ('Actualiza el ACTIVITY por'||Cont.APLICADO);
                END IF;
                --Si el registro en Flujo es igual que la suma de AR APERTURAR
               IF (((ABS(IMPORTE_B) - (abs(cont.IVA)+abs(cont.BASE))) between -0.10 and 0.10) OR ((ABS(IMPORTE_B) - (abs(cont.APLICADO))) between -0.10 and 0.10)) and TOTAL !=0 THEN
                    --SI EXISTE REGISTRO DE BASE ACTUALIZAR EL EXISTENTE
                    IF  cont.BASE!=0 THEN
                        UPDATE  FECXC.FECXP_INGRESOS_CLASIF F
                           SET  IMPORTE_LINEA=case WHEN UPPER(f.ID_STATUS_MOV) = 'X' then ((cont.BASE)*(-1)) else cont.BASE end
                           ,    TIPO_CLASIFICACION='APERTURA ING ICIAS'
                         WHERE f.FOLIO_SET =cont.RECEIPT_NUMBER
                          AND f.ID_STATUS_MOV=cont.ID_STATUS_MOV;
                    END IF;
                   --SI EXISTE EL IVA CREAR LA LINEA
                   IF cont.IVA != 0 THEN
                     REC_T_C2_D_TMP.EXTEND;
                     lin_aux := lin_aux+1;
                     --V_CLA_FE_ID, V_CLA_FE_DES,
                        SELECT V_CLA_FE_ID, F.E_CODIGO, F.FOLIO_SET, F.TIPO_OPERACION, F.FECHA, F.MONEDA, F.TIPO_CAMBIO, F.IMPORTE, F.CONCEPTO,
                               F.BENEFICIARIO, F.ID_STATUS_MOV, F.ID_CHEQUERA, F.ID_BANCO, F.ID_FORMA_PAGO, F.REFERENCIA, CASE WHEN UPPER(f.ID_STATUS_MOV) = 'X' THEN ((-1)*(cont.IVA)) ELSE cont.IVA END,
                               CASE WHEN V_CIA  ='$' THEN ORA_SOIN_SEGMENTO1 ELSE V_CIA END,
                               CASE WHEN V_NEG  ='$' THEN ORA_SOIN_SEGMENTO2 ELSE V_NEG END,
                               CASE WHEN V_CTA  ='$' THEN ORA_SOIN_SEGMENTO3 ELSE V_CTA END,
                               CASE WHEN V_SCTA ='$' THEN ORACLE_SEGMENTO4   ELSE V_SCTA END,
                               CASE WHEN V_CC   ='$' THEN ORACLE_SEGMENTO5   ELSE V_CC END,
                               CASE WHEN V_ICIA ='$' THEN ORACLE_SEGMENTO6   ELSE V_ICIA END,
                               CASE WHEN V_TOP  ='$' THEN ORACLE_SEGMENTO7   ELSE V_TOP END, F.CUAL_ERP,
                               'APERTURA ING ICIAS', F.NO_CLIENTE, F.DESCRIPCION
                          INTO REC_T_C2_D_TMP(lin_aux).CLA_FE_ID, REC_T_C2_D_TMP(lin_aux).E_CODIGO, REC_T_C2_D_TMP(lin_aux).FOLIO_SET, REC_T_C2_D_TMP(lin_aux).TIPO_OPERACION, REC_T_C2_D_TMP(lin_aux).FECHA, REC_T_C2_D_TMP(lin_aux).MONEDA, REC_T_C2_D_TMP(lin_aux).TIPO_CAMBIO, REC_T_C2_D_TMP(lin_aux).IMPORTE, REC_T_C2_D_TMP(lin_aux).CONCEPTO,
                               REC_T_C2_D_TMP(lin_aux).BENEFICIARIO, REC_T_C2_D_TMP(lin_aux).ID_STATUS_MOV, REC_T_C2_D_TMP(lin_aux).ID_CHEQUERA, REC_T_C2_D_TMP(lin_aux).ID_BANCO, REC_T_C2_D_TMP(lin_aux).ID_FORMA_PAGO, REC_T_C2_D_TMP(lin_aux).REFERENCIA, REC_T_C2_D_TMP(lin_aux).IMPORTE_LINEA , REC_T_C2_D_TMP(lin_aux).ORA_SOIN_SEGMENTO1, REC_T_C2_D_TMP(lin_aux).ORA_SOIN_SEGMENTO2,
                               REC_T_C2_D_TMP(lin_aux).ORA_SOIN_SEGMENTO3, REC_T_C2_D_TMP(lin_aux).ORACLE_SEGMENTO4, REC_T_C2_D_TMP(lin_aux).ORACLE_SEGMENTO5,REC_T_C2_D_TMP(lin_aux).ORACLE_SEGMENTO6, REC_T_C2_D_TMP(lin_aux).ORACLE_SEGMENTO7, REC_T_C2_D_TMP(lin_aux).CUAL_ERP,
                               REC_T_C2_D_TMP(lin_aux).TIPO_CLASIFICACION, REC_T_C2_D_TMP(lin_aux).NO_CLIENTE, REC_T_C2_D_TMP(lin_aux).DESCRIPCION
                          FROM FECXC.FECXP_INGRESOS_CLASIF F
                         WHERE F.FOLIO_SET =cont.RECEIPT_NUMBER
                           AND f.ID_STATUS_MOV=cont.ID_STATUS_MOV ;
                         TOTAL:=TOTAL-abs(Cont.IVA);
                         --DBMS_OUTPUT.PUT_LINE ('Crea Iva por'||Cont.IVA);
                   END IF;
                   --SI EXISTE EL ACTIVITY CREAR LA LINEA
                   IF ABS(cont.APLICADO)-(ABS(CONT.BASE)+ABS(CONT.IVA)) != 0 THEN
                     REC_T_C2_D_TMP.EXTEND;
                     lin_aux := lin_aux+1;
                        SELECT V_CLA_FE_ID2, F.E_CODIGO, F.FOLIO_SET, F.TIPO_OPERACION, F.FECHA, F.MONEDA, F.TIPO_CAMBIO, F.IMPORTE, F.CONCEPTO,
                               F.BENEFICIARIO, F.ID_STATUS_MOV, F.ID_CHEQUERA, F.ID_BANCO, F.ID_FORMA_PAGO, F.REFERENCIA, CASE WHEN UPPER(f.ID_STATUS_MOV) = 'X' THEN ((-1)*((ABS(cont.APLICADO) - (abs(cont.IVA)+abs(cont.BASE))))) ELSE (ABS(cont.APLICADO) - (abs(cont.IVA)+abs(cont.BASE))) END,
                               CASE WHEN V_CIA2  ='$' THEN ORA_SOIN_SEGMENTO1 ELSE V_CIA2 END,
                               CASE WHEN V_NEG2  ='$' THEN ORA_SOIN_SEGMENTO2 ELSE V_NEG2 END,
                               CASE WHEN V_CTA2  ='$' THEN ORA_SOIN_SEGMENTO3 ELSE V_CTA2 END,
                               CASE WHEN V_SCTA2 ='$' THEN ORACLE_SEGMENTO4   ELSE V_SCTA2 END,
                               CASE WHEN V_CC2   ='$' THEN ORACLE_SEGMENTO5   ELSE V_CC2 END,
                               CASE WHEN V_ICIA2 ='$' THEN ORACLE_SEGMENTO6   ELSE V_ICIA2 END,
                               CASE WHEN V_TOP2  ='$' THEN ORACLE_SEGMENTO7   ELSE V_TOP2 END, F.CUAL_ERP,
                               'APERTURA ING ICIAS', F.NO_CLIENTE, F.DESCRIPCION
                          INTO REC_T_C2_D_TMP(lin_aux).CLA_FE_ID, REC_T_C2_D_TMP(lin_aux).E_CODIGO, REC_T_C2_D_TMP(lin_aux).FOLIO_SET, REC_T_C2_D_TMP(lin_aux).TIPO_OPERACION, REC_T_C2_D_TMP(lin_aux).FECHA, REC_T_C2_D_TMP(lin_aux).MONEDA, REC_T_C2_D_TMP(lin_aux).TIPO_CAMBIO, REC_T_C2_D_TMP(lin_aux).IMPORTE, REC_T_C2_D_TMP(lin_aux).CONCEPTO,
                               REC_T_C2_D_TMP(lin_aux).BENEFICIARIO, REC_T_C2_D_TMP(lin_aux).ID_STATUS_MOV, REC_T_C2_D_TMP(lin_aux).ID_CHEQUERA, REC_T_C2_D_TMP(lin_aux).ID_BANCO, REC_T_C2_D_TMP(lin_aux).ID_FORMA_PAGO, REC_T_C2_D_TMP(lin_aux).REFERENCIA, REC_T_C2_D_TMP(lin_aux).IMPORTE_LINEA , REC_T_C2_D_TMP(lin_aux).ORA_SOIN_SEGMENTO1, REC_T_C2_D_TMP(lin_aux).ORA_SOIN_SEGMENTO2,
                               REC_T_C2_D_TMP(lin_aux).ORA_SOIN_SEGMENTO3, REC_T_C2_D_TMP(lin_aux).ORACLE_SEGMENTO4, REC_T_C2_D_TMP(lin_aux).ORACLE_SEGMENTO5,REC_T_C2_D_TMP(lin_aux).ORACLE_SEGMENTO6, REC_T_C2_D_TMP(lin_aux).ORACLE_SEGMENTO7, REC_T_C2_D_TMP(lin_aux).CUAL_ERP,
                               REC_T_C2_D_TMP(lin_aux).TIPO_CLASIFICACION, REC_T_C2_D_TMP(lin_aux).NO_CLIENTE, REC_T_C2_D_TMP(lin_aux).DESCRIPCION
                          FROM FECXC.FECXP_INGRESOS_CLASIF F
                         WHERE F.FOLIO_SET =cont.RECEIPT_NUMBER
                           AND f.ID_STATUS_MOV=cont.ID_STATUS_MOV ;
                           --DBMS_OUTPUT.PUT_LINE ('Crea Activity por'|| (ABS(cont.APLICADO) - (abs(cont.IVA)+abs(cont.BASE))));
                           TOTAL:=TOTAL- (ABS(cont.APLICADO) - (abs(cont.IVA)+abs(cont.BASE)));
                   END IF;
                   UPDATE FECXC.FECXC_DEP_ESPECIALES
                      SET APERTURADOAR=1
                    WHERE NO_FOLIO_DET =cont.RECEIPT_NUMBER
                      AND ID_STATUS_MOV=cont.ID_STATUS_MOV;
               END IF;
            ELSE
               --DBMS_OUTPUT.PUT_LINE ('Folio: '|| cont.RECEIPT_NUMBER ||' DIFERENTE, FLUJO->'||IMPORTE_B ||' AR->'||(cont.BASE+cont.IVA));
               NULL;
            END IF;
            END IF;
            --eliminar linea original si ACTIVYTY + IVA suman el total
            IF TOTAL=0 THEN
               DELETE FECXC.FECXP_INGRESOS_CLASIF F
                WHERE F.FOLIO_SET =cont.RECEIPT_NUMBER
                  AND F.ID_STATUS_MOV=cont.ID_STATUS_MOV
                  AND F.CLA_FE_ID='ING01';
            END IF;
            --|--DBMS_OUTPUT.PUT_LINE ('Termina Correctamente '|| cont.RECEIPT_NUMBER);
          EXCEPTION
           WHEN NO_DATA_FOUND THEN
              --DBMS_OUTPUT.PUT_LINE ('Folio: '|| cont.RECEIPT_NUMBER ||' No Existe');
              NULL;
           WHEN OTHERS THEN
              --DBMS_OUTPUT.PUT_LINE ('->'|| cont.RECEIPT_NUMBER ||'<-'||SQLERRM);
              NULL;
          END;
         --DBMS_OUTPUT.PUT_LINE ('No se le hizo nada el folio');
       END LOOP;
        IF REC_T_C2_D_TMP.COUNT != 0 THEN
                FORALL z IN REC_T_C2_D_TMP.FIRST .. REC_T_C2_D_TMP.LAST
                    INSERT INTO FECXC.FECXP_INGRESOS_CLASIF
                    VALUES REC_T_C2_D_TMP (z);
                REC_T_C2_D_TMP.delete;
                --commit;
        END IF;
         lin_aux := 0;
         commit;
        --DBMS_OUTPUT.PUT_LINE ('Termina Correctamente ');
EXCEPTION
     WHEN OTHERS THEN
     err_num := SQLCODE;
     err_msg := SUBSTR(SQLERRM, 1, 100);
     RAISE_APPLICATION_ERROR(-20000,''||TO_CHAR(err_num)||' '||err_msg);
END;
/
