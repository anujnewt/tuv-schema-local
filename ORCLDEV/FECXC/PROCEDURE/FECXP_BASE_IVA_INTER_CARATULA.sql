CREATE OR REPLACE EDITIONABLE PROCEDURE "FECXC"."FECXP_BASE_IVA_INTER_CARATULA" (V_MES INTEGER, PERIODO VARCHAR2)
IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
   CURSOR c_ingresos_ar IS SELECT folio_set, sum(aplicado) aplicado, sum(base) base, sum(iva) iva, id_status_mov
                            FROM (SELECT   acra.receipt_number AS folio_set,
                                           NVL (SUM (araa.amount_applied), 0) aplicado,
                                           NVL (SUM (araa.line_applied), 0) base,
                                           NVL (SUM (araa.tax_applied), 0) iva, fde.id_status_mov
                                      FROM ar.ar_cash_receipts_all@erp_prod acra,
                                           apps.ar_receivable_applications_all@erp_prod araa,
                                           (SELECT DISTINCT folio_set, id_status_mov
                                                       FROM fecxc.fecxp_ingresos_caratula_d_tmp fde
                                                      WHERE fde.tipo_operacion IN
                                                               (3700, 3701, 3705, 3706, 3708, 3715,
                                                                4102, 4103)
                                                        AND TO_CHAR (fecha, 'YYYY') =PERIODO
                                                        AND TO_NUMBER (TO_CHAR (fecha, 'MM')) >=
                                                                                                v_mes) fde
                                     WHERE 1 = 1
                                       AND TO_CHAR (fde.folio_set) = acra.receipt_number
                                       AND acra.cash_receipt_id = araa.cash_receipt_id
                                       AND acra.org_id = araa.org_id
                                       AND araa.status != 'UNAPP'
                                       AND araa.display = 'Y'
                                  GROUP BY acra.receipt_number, fde.id_status_mov
                                  UNION ALL
                                  SELECT   acra.receipt_number AS folio_set,
                                           NVL (SUM (araa.amount_applied), 0) aplicado,
                                           NVL (SUM (araa.line_applied), 0) base,
                                           NVL (SUM (araa.tax_applied), 0) iva, fde.id_status_mov
                                      FROM ar.ar_cash_receipts_all@erp_prod acra,
                                           apps.ar_receivable_applications_all@erp_prod araa,
                                           (SELECT DISTINCT folio_set, id_status_mov
                                                       FROM fecxc.fecxp_ingresos_caratula_d_tmp fde
                                                      WHERE fde.tipo_operacion IN
                                                               (3700, 3701, 3705, 3706, 3708, 3715,
                                                                4102, 4103)
                                                        AND TO_CHAR (fecha, 'YYYY') = PERIODO
                                                        AND TO_NUMBER (TO_CHAR (fecha, 'MM')) >=
                                                                                                v_mes) fde
                                     WHERE 1 = 1
                                       AND TO_CHAR (fde.folio_set) = acra.receipt_number
                                       AND acra.cash_receipt_id = araa.cash_receipt_id
                                       AND acra.org_id = araa.org_id
                                       AND araa.status = 'UNAPP'
                                  GROUP BY acra.receipt_number, fde.id_status_mov)
                                  GROUP BY folio_set,id_status_mov
                        ORDER BY folio_set;
   CURSOR c_ingresos_flujo (v_folio_cur INTEGER,v_id_estatus VARCHAR2) IS
          SELECT rowid as numlinea,importe,importe_linea FROM fecxp_ingresos_caratula_d_tmp WHERE FOLIO_SET=v_folio_cur AND ID_STATUS_MOV=v_id_estatus  ;
  --v_folio           VARCHAR (20);
  v_importe         NUMBER (20, 2); ---Almacena El Importe Original
  -- Variables para el IVA
  V_cla_fe_id  VARCHAR2(25);
  V_cla_fe_des VARCHAR2(50);
  V_cia        VARCHAR2(25);
  V_neg        VARCHAR2(25);
  V_cta        VARCHAR2(25);
  V_scta       VARCHAR2(25);
  V_cc         VARCHAR2(25);
  V_icia       VARCHAR2(25);
  V_top        VARCHAR2(25);
  TOTAL NUMBER;
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
  --  Variables para el manejo de Errores
  err_num NUMBER;
  err_msg VARCHAR2(100);
   TYPE REC_FECXP_INGRESOS_CARATULA IS RECORD
   (
      CLA_FE_ID           VARCHAR2(25 BYTE),
      E_CODIGO            INTEGER,
      FOLIO_SET           INTEGER,
      TIPO_OPERACION      INTEGER,
      FECHA               DATE,
      MONEDA              VARCHAR2(3 BYTE),
      IMPORTE             NUMBER(20,4),
      ID_BANCO            INTEGER,
      ID_CHEQUERA         VARCHAR2(20 BYTE),
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
      ID_STATUS_MOV       VARCHAR2(1 BYTE)
    );
    TYPE T_C1_D IS TABLE OF REC_FECXP_INGRESOS_CARATULA;
    REC_T_C1_D_TMP T_C1_D := T_C1_D();
lin_aux INTEGER:=0;
BEGIN
    SELECT CLA_FE_ID, CLA_FE_DES, CIA, NEG, CTA, SCTA, CC, ICIA, TOP
     INTO V_CLA_FE_ID, V_CLA_FE_DES, V_CIA, V_NEG, V_CTA, V_SCTA, V_CC, V_ICIA, V_TOP
     FROM fecxc.fecxp_iva_interempresas_tbl ;
    SELECT CLA_FE_ID, CLA_FE_DES, CIA, NEG, CTA, SCTA, CC, ICIA, TOP
     INTO V_CLA_FE_ID2, V_CLA_FE_DES2, V_CIA2, V_NEG2, V_CTA2, V_SCTA2, V_CC2, V_ICIA2, V_TOP2
     FROM FECXC.FECXP_IVA_INTER_ACTIVITY_TBL;
   --BUSCAR EN AR LOS FOLIOS QUE SE ENCUENTREN EN FLUJO
   lin_aux :=0;
   FOR cont IN c_ingresos_ar
   LOOP
         BEGIN
          --Se busca el importe en Flujo, OJO: Tiene que ser el importe exactamente igual y el mismo id de estatus
          SELECT IMPORTE INTO v_importe FROM FECXC.FECXC_DEP_ESPECIALES FDE WHERE FDE.ID_STATUS_MOV=cont.ID_STATUS_MOV AND NO_FOLIO_DET =  cont.folio_set;
            TOTAL:=abs(v_importe);
            /*---------------------------------------------------------------------------------------------------------------------*/
              --si vienen Montos negativos dejar el Folio tal como esta
            IF (cont.APLICADO<0) OR (cont.BASE<0) OR (cont.IVA <0) THEN
             null;--NO SE HACE NADA
            ELSE
            --revisa que FLUJO cuadre contra AR
            IF ((ABS(V_IMPORTE) - abs(cont.APLICADO)) between -0.10 and 0.10) OR ((ABS(v_importe) - abs(cont.IVA+cont.BASE)) between -0.10 and 0.10)THEN
                 --DBMS_OUTPUT.PUT_LINE ('FOLIO:'||cont.folio_set);
                --DBMS_OUTPUT.PUT_LINE ('Importe del Folio:$ '||v_importe||'Base:$ '|| cont.BASE||' IVA:$ '||cont.IVA ||' Activity:$ '||(ABS(cont.APLICADO)-(ABS(cont.base)+ABS(cont.IVA))));
                --DBMS_OUTPUT.PUT_LINE (','||cont.RECEIPT_NUMBER);
                --revisar en Flujo  si existe Base, IVA u Otro
                IF ((ABS(v_importe) - abs(cont.BASE)) between -0.10 and 0.10) THEN
                   --EL REGISTRO EXISTENTE ES LA BASE
                       --DBMS_OUTPUT.PUT_LINE ('Actualiza la Base por'||Cont.Base);
                       NULL;
                ELSIF ((ABS(v_importe) - abs(cont.IVA)) between -0.10 and 0.10) THEN
                       --EL REGISTRO EXISTENTE ES EL IVA
                        UPDATE  fecxc.fecxp_ingresos_caratula_d_tmp F
                           SET  CLA_FE_ID=V_CLA_FE_ID,
                                ORA_SOIN_SEGMENTO1= CASE WHEN V_CIA  ='$' THEN F.ORA_SOIN_SEGMENTO1 ELSE V_CIA END,
                                ORA_SOIN_SEGMENTO2= CASE WHEN V_NEG  ='$' THEN F.ORA_SOIN_SEGMENTO2 ELSE V_NEG END,
                                ORA_SOIN_SEGMENTO3= CASE WHEN V_CTA  ='$' THEN F.ORA_SOIN_SEGMENTO3 ELSE V_CTA END,
                                ORACLE_SEGMENTO4=   CASE WHEN V_SCTA ='$' THEN F.ORACLE_SEGMENTO4   ELSE V_SCTA END,
                                ORACLE_SEGMENTO5=   CASE WHEN V_CC   ='$' THEN F.ORACLE_SEGMENTO5   ELSE V_CC END,
                                ORACLE_SEGMENTO6=   CASE WHEN V_ICIA ='$' THEN F.ORACLE_SEGMENTO6   ELSE V_ICIA END,
                                ORACLE_SEGMENTO7=   CASE WHEN V_TOP  ='$' THEN F.ORACLE_SEGMENTO7   ELSE V_TOP END
                         WHERE f.FOLIO_SET =cont.folio_set
                          AND f.ID_STATUS_MOV=cont.ID_STATUS_MOV  ;
                        TOTAL:=TOTAL-abs(Cont.IVA);
                        --DBMS_OUTPUT.PUT_LINE ('Actualiza el IVA por'||Cont.IVA);
                ELSIF ((ABS(v_importe) - (abs(cont.APLICADO)-(ABS(CONT.IVA)+ABS(CONT.BASE)))) between -0.10 and 0.10) THEN
                       --EL REGISTRO EXISTENTE ES EL ACTIVITY
                        UPDATE  fecxc.fecxp_ingresos_caratula_d_tmp F
                           SET  CLA_FE_ID=V_CLA_FE_ID2,
                                ORA_SOIN_SEGMENTO1= CASE WHEN V_CIA2  ='$' THEN F.ORA_SOIN_SEGMENTO1 ELSE V_CIA2 END,
                                ORA_SOIN_SEGMENTO2= CASE WHEN V_NEG2  ='$' THEN F.ORA_SOIN_SEGMENTO2 ELSE V_NEG2 END,
                                ORA_SOIN_SEGMENTO3= CASE WHEN V_CTA2  ='$' THEN F.ORA_SOIN_SEGMENTO3 ELSE V_CTA2 END,
                                ORACLE_SEGMENTO4  = CASE WHEN V_SCTA2 ='$' THEN F.ORACLE_SEGMENTO4   ELSE V_SCTA2 END,
                                ORACLE_SEGMENTO5  = CASE WHEN V_CC2   ='$' THEN F.ORACLE_SEGMENTO5   ELSE V_CC2 END,
                                ORACLE_SEGMENTO6  = CASE WHEN V_ICIA2 ='$' THEN F.ORACLE_SEGMENTO6   ELSE V_ICIA2 END,
                                ORACLE_SEGMENTO7  = CASE WHEN V_TOP2  ='$' THEN F.ORACLE_SEGMENTO7   ELSE V_TOP2 END
                         WHERE f.FOLIO_SET =cont.folio_set
                          AND f.ID_STATUS_MOV=cont.ID_STATUS_MOV  ;
                        TOTAL:=TOTAL-abs(Cont.APLICADO);
                        --DBMS_OUTPUT.PUT_LINE ('Actualiza el ACTIVITY por'||Cont.APLICADO);
                END IF;
                --Si el registro en Flujo es igual que la suma de AR APERTURAR
               IF (((ABS(v_importe) - (abs(cont.IVA)+abs(cont.BASE))) between -0.10 and 0.10) OR ((ABS(v_importe) - (abs(cont.APLICADO))) between -0.10 and 0.10)) and TOTAL !=0 THEN
                    --SI EXISTE REGISTRO DE BASE ACTUALIZAR EL EXISTENTE
                    IF  cont.BASE!=0 THEN
                        UPDATE  fecxc.fecxp_ingresos_caratula_d_tmp F
                           SET  IMPORTE_LINEA=case WHEN UPPER(f.ID_STATUS_MOV) = 'X' then ((cont.BASE)*(-1)) else cont.BASE end
                           ,    TIPO_CLASIFICACION='APERTURA ING ICIAS'
                         WHERE f.FOLIO_SET =cont.folio_set
                          AND f.ID_STATUS_MOV=cont.ID_STATUS_MOV;
                    END IF;
                   --SI EXISTE EL IVA CREAR LA LINEA
                   IF cont.IVA != 0 THEN
                     REC_T_C1_D_TMP.EXTEND;
                     lin_aux := lin_aux+1;
                        SELECT     v_cla_fe_id, f.e_codigo,
                                   f.folio_set,
                                   f.tipo_operacion,
                                   f.fecha, f.moneda,
                                   CASE WHEN UPPER(f.ID_STATUS_MOV) = 'X' THEN ((-1)*(cont.IVA)) ELSE cont.IVA END, f.id_banco,
                                   f.id_chequera,
                                   f.referencia,
                                   cont.iva,
                                   CASE WHEN V_CIA  ='$' THEN F.ORA_SOIN_SEGMENTO1  ELSE V_CIA  END,
                                   CASE WHEN V_NEG  ='$' THEN F.ORA_SOIN_SEGMENTO2  ELSE V_NEG  END,
                                   CASE WHEN V_CTA  ='$' THEN F.ORA_SOIN_SEGMENTO3  ELSE V_CTA  END,
                                   CASE WHEN V_SCTA ='$' THEN F.ORACLE_SEGMENTO4    ELSE V_SCTA END,
                                   CASE WHEN V_CC   ='$' THEN F.ORACLE_SEGMENTO5    ELSE V_CC   END,
                                   CASE WHEN V_ICIA ='$' THEN F.ORACLE_SEGMENTO6    ELSE V_ICIA END,
                                   CASE WHEN V_TOP  ='$' THEN F.ORACLE_SEGMENTO7    ELSE V_TOP  END,
                                   f.cual_erp,
                                   'APERTURA ING ICIAS',
                                   f.id_status_mov
                              INTO rec_t_c1_d_tmp (lin_aux).cla_fe_id, rec_t_c1_d_tmp (lin_aux).e_codigo,
                                   rec_t_c1_d_tmp (lin_aux).folio_set,
                                   rec_t_c1_d_tmp (lin_aux).tipo_operacion,
                                   rec_t_c1_d_tmp (lin_aux).fecha, rec_t_c1_d_tmp (lin_aux).moneda,
                                   rec_t_c1_d_tmp (lin_aux).importe, rec_t_c1_d_tmp (lin_aux).id_banco,
                                   rec_t_c1_d_tmp (lin_aux).id_chequera,
                                   rec_t_c1_d_tmp (lin_aux).referencia,
                                   rec_t_c1_d_tmp (lin_aux).importe_linea,
                                   rec_t_c1_d_tmp (lin_aux).ora_soin_segmento1,
                                   rec_t_c1_d_tmp (lin_aux).ora_soin_segmento2,
                                   rec_t_c1_d_tmp (lin_aux).ora_soin_segmento3,
                                   rec_t_c1_d_tmp (lin_aux).oracle_segmento4,
                                   rec_t_c1_d_tmp (lin_aux).oracle_segmento5,
                                   rec_t_c1_d_tmp (lin_aux).oracle_segmento6,
                                   rec_t_c1_d_tmp (lin_aux).oracle_segmento7,
                                   rec_t_c1_d_tmp (lin_aux).cual_erp,
                                   rec_t_c1_d_tmp (lin_aux).tipo_clasificacion,
                                   rec_t_c1_d_tmp (lin_aux).id_status_mov
                              FROM fecxc.fecxp_ingresos_caratula_d_tmp f
                             WHERE folio_set = cont.folio_set
                             AND f.ID_STATUS_MOV=cont.ID_STATUS_MOV ;
                         TOTAL:=TOTAL-abs(Cont.IVA);
                         --DBMS_OUTPUT.PUT_LINE ('Crea Iva por'||Cont.IVA);
                   END IF;
                   --SI EXISTE EL ACTIVITY CREAR LA LINEA
                   IF ABS(cont.APLICADO)-(ABS(CONT.BASE)+ABS(CONT.IVA)) != 0 THEN
                     REC_T_C1_D_TMP.EXTEND;
                     lin_aux := lin_aux+1;
                        SELECT  V_CLA_FE_ID2, F.E_CODIGO, F.FOLIO_SET,   F.TIPO_OPERACION, F.FECHA, F.MONEDA, cont.iva, F.ID_BANCO, F.ID_CHEQUERA,
                           F.REFERENCIA, CASE WHEN UPPER(f.ID_STATUS_MOV) = 'X' THEN ((-1)*((ABS(cont.APLICADO) - (abs(cont.IVA)+abs(cont.BASE))))) ELSE (ABS(cont.APLICADO) - (abs(cont.IVA)+abs(cont.BASE))) END,
                           CASE WHEN V_CIA2 ='$' THEN F.ORA_SOIN_SEGMENTO1  ELSE V_CIA2 END,
                           CASE WHEN V_NEG2  ='$' THEN F.ORA_SOIN_SEGMENTO2 ELSE V_NEG2 END,
                           CASE WHEN V_CTA2  ='$' THEN F.ORA_SOIN_SEGMENTO3 ELSE V_CTA2 END,
                           CASE WHEN V_SCTA2 ='$' THEN F.ORACLE_SEGMENTO4   ELSE V_SCTA2 END,
                           CASE WHEN V_CC2   ='$' THEN F.ORACLE_SEGMENTO5   ELSE V_CC2 END,
                           CASE WHEN V_ICIA2 ='$' THEN F.ORACLE_SEGMENTO6   ELSE V_ICIA2 END,
                           CASE WHEN V_TOP2  ='$' THEN F.ORACLE_SEGMENTO7   ELSE V_TOP2 END,
                           F.CUAL_ERP, F.TIPO_CLASIFICACION, F.ID_STATUS_MOV
                       INTO REC_T_C1_D_TMP(lin_aux).CLA_FE_ID, REC_T_C1_D_TMP(lin_aux).E_CODIGO, REC_T_C1_D_TMP(lin_aux).FOLIO_SET,   REC_T_C1_D_TMP(lin_aux).TIPO_OPERACION, REC_T_C1_D_TMP(lin_aux).FECHA, REC_T_C1_D_TMP(lin_aux).MONEDA, REC_T_C1_D_TMP(lin_aux).IMPORTE, REC_T_C1_D_TMP(lin_aux).ID_BANCO, REC_T_C1_D_TMP(lin_aux).ID_CHEQUERA,
                         REC_T_C1_D_TMP(lin_aux).REFERENCIA, REC_T_C1_D_TMP(lin_aux).IMPORTE_LINEA, REC_T_C1_D_TMP(lin_aux).ORA_SOIN_SEGMENTO1, REC_T_C1_D_TMP(lin_aux).ORA_SOIN_SEGMENTO2, REC_T_C1_D_TMP(lin_aux).ORA_SOIN_SEGMENTO3, REC_T_C1_D_TMP(lin_aux).ORACLE_SEGMENTO4,
                         REC_T_C1_D_TMP(lin_aux).ORACLE_SEGMENTO5, REC_T_C1_D_TMP(lin_aux).ORACLE_SEGMENTO6, REC_T_C1_D_TMP(lin_aux).ORACLE_SEGMENTO7, REC_T_C1_D_TMP(lin_aux).CUAL_ERP, REC_T_C1_D_TMP(lin_aux).TIPO_CLASIFICACION, REC_T_C1_D_TMP(lin_aux).ID_STATUS_MOV
                       FROM FECXC.fecxp_ingresos_caratula_d_tmp F
                       WHERE FOLIO_SET=cont.folio_set
                        AND f.ID_STATUS_MOV=cont.ID_STATUS_MOV ;
                           --DBMS_OUTPUT.PUT_LINE ('Crea Activity por'|| (ABS(cont.APLICADO) - (abs(cont.IVA)+abs(cont.BASE))));
                           TOTAL:=TOTAL-(ABS(cont.APLICADO) - (abs(cont.IVA)+abs(cont.BASE)));
                   END IF;
               END IF;
            ELSE
               --DBMS_OUTPUT.PUT_LINE ('Folio: '|| cont.RECEIPT_NUMBER ||' DIFERENTE, FLUJO->'||v_importe ||' AR->'||(cont.BASE+cont.IVA));
               NULL;
            END IF;
            END IF;
            --|--DBMS_OUTPUT.PUT_LINE ('Termina Correctamente '|| cont.RECEIPT_NUMBER);
            --eliminar linea original si ACTIVYTY + IVA suman el total
            IF TOTAL=0 THEN
               DELETE FECXC.fecxp_ingresos_caratula_d_tmp F
                WHERE F.FOLIO_SET=cont.folio_set
                  AND F.ID_STATUS_MOV=cont.ID_STATUS_MOV
                  AND F.CLA_FE_ID='ING01';
            END IF;
          EXCEPTION
           WHEN NO_DATA_FOUND THEN
              --DBMS_OUTPUT.PUT_LINE ('Folio: '|| cont.RECEIPT_NUMBER ||' No Existe');
              NULL;
           WHEN OTHERS THEN
              --DBMS_OUTPUT.PUT_LINE ('->'|| cont.RECEIPT_NUMBER ||'<-'||SQLERRM);
              NULL;
          END;
         DBMS_OUTPUT.PUT_LINE ('No se le hizo nada el folio');
       END LOOP;
   IF REC_T_C1_D_TMP.COUNT != 0 THEN
      FORALL z IN REC_T_C1_D_TMP.FIRST .. REC_T_C1_D_TMP.LAST
             INSERT INTO fecxc.fecxp_ingresos_caratula_d_tmp
                    VALUES REC_T_C1_D_TMP (z);
         REC_T_C1_D_TMP.delete;
                --commit;
   END IF;
   lin_aux := 0;
   --DBMS_OUTPUT.PUT_LINE ('Termina Correctamente ');
EXCEPTION
     WHEN OTHERS THEN
     err_num := SQLCODE;
     err_msg := SUBSTR(SQLERRM, 1, 100);
     RAISE_APPLICATION_ERROR(-20000,''||TO_CHAR(err_num)||' '||err_msg);
END;
/
