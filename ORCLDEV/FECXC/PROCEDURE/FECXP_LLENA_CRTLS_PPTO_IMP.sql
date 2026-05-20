CREATE OR REPLACE EDITIONABLE PROCEDURE "FECXC"."FECXP_LLENA_CRTLS_PPTO_IMP" 
AS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
v_id_sesion VARCHAR(25) := TO_CHAR(SYSDATE,'DD-MM-YYYY');
v_contador_meses INTEGER:=2;
v_existe_saldo_inicial INTEGER;
v_meses_a_actualizar INTEGER;
BEGIN
DBMS_OUTPUT.PUT_LINE('INICIO ' ||to_char(SYSDATE,'YYYY-MM-DD HH:MM:SS') );
v_contador_meses :=1;
select NVL(to_number(max (mes)),0) into v_meses_a_actualizar from  FECXC.FECXP_IMP_DAT_HIST where procesado=0 AND TIPO_IMPORTACION='P';
-----------------PARA LA CARATULA DE PPTO IMPORTADOS--------------------------
    INSERT  INTO FECXC.FECXP_PPTO_CARATULA_IMPNS (
            E_CODIGO, DES_EMPRESA, ID_SESION_PC, PERIODO, MES, MONEDA, TIPO_CAMBIO, CLA_FE_ID, CLA_FE_DES, IMPORTE_LINEA, ESTATUS,ID_VERSION,UTILIZAR_REPORTE,ID_LINEA,PROCESADO)
    SELECT  D.E_EMPRESA_IMP , E.DESC_EMP, V_ID_SESION, TO_CHAR(D.FECHA,'YYYY'), D.MES, D.MONEDA_IMP, M.TIPO_CAMBIO, D.CLA_FE_ID_IMP, SUBSTR (CLA_FE_DES, 1, 25), TO_NUMBER (C.CLA_ATRIBUTO5) * D.IMPORTE_LINEA, 'IMPORTADO',D.ATRIBUTO_3,D.UTILIZAR_REPORTE,D.ROWID,0
    FROM    FECXC.FECXP_MONEDAS_NO_SET M,
            FECXC.FECXP_EMP_NO_SET  E,
            FECXC.FECXP_CLASIFICACION_FE C,
            FECXC.FECXP_IMP_DAT_HIST D
    WHERE   1=1
    AND     D.TIPO_IMPORTACION IN ('S', 'P')
    AND     E.ID_EMP   = D.E_EMPRESA_IMP
	AND		M.MON_ORACLE = D.MONEDA_IMP
	AND		M.MES = D.MES
	AND		M.PERIODO = TO_NUMBER (TO_CHAR (D.FECHA, 'YYYY'))
	AND		C.CLA_FE_ID = D.CLA_FE_ID_IMP
    AND     D.PROCESADO = 0 ;
      COMMIT;
DBMS_OUTPUT.PUT_LINE('INICIO 3 ' ||to_char(SYSDATE,'YYYY-MM-DD HH:MM:SS')||' ' ||to_char(v_meses_a_actualizar) );
  ------------------------------------------------------------------------------------------------------------------------------------------
   FOR c_meses IN 1..12 LOOP
   DBMS_OUTPUT.PUT_LINE('INSERTANDO EL SALDO FINAL DEL MES ANTERIOR    '||to_char((v_contador_meses-1))||'COMO SALDO INICIAL DEL MES ACTUAL' ||to_char(v_contador_meses));
   IF v_contador_meses > 1 THEN  ---NO BORRA EL SALDO INICIAL DE ENERO
                 ---BORRANDO SALDO INICIAL DEL MES
                 DELETE FECXC.FECXP_PPTO_CARATULA_IMPNS
                 WHERE CLA_FE_ID LIKE '%SI%'
                 AND MES=v_contador_meses
                 AND  procesado=0;
   END IF;
   ---PARA CALCULAR EL SALDO FINAL SALDO INICIAL ENERO
   IF v_contador_meses = 1 THEN
    DBMS_OUTPUT.PUT_LINE('CALCULANDO ENERO' ||to_char(SYSDATE,'YYYY-MM-DD HH:MM:SS') );
    INSERT INTO FECXC.FECXP_PPTO_CARATULA_IMPNS (E_CODIGO       ,   DES_EMPRESA, ID_SESION_PC , PERIODO, MES,
                                                MONEDA          ,   TIPO_CAMBIO, CLA_FE_ID    , CLA_FE_DES  ,
                                                IMPORTE_LINEA   ,   ESTATUS    ,   ID_VERSION  ,
                                                UTILIZAR_REPORTE,   ID_LINEA   ,PROCESADO)
    SELECT                                      E_CODIGO       ,   DES_EMPRESA, ID_SESION_PC , PERIODO, MES,
                                                MONEDA          ,   TIPO_CAMBIO, 'SF'         , 'SDO FINAL CHEQUERAS' ,
                                                IMPORTE_LINEA   ,   ESTATUS    ,   ID_VERSION  ,
                                                UTILIZAR_REPORTE,   ID_LINEA   ,PROCESADO
    FROM FECXC.FECXP_PPTO_CARATULA_IMPNS
      WHERE MES =  1
      AND CLA_FE_ID LIKE '%SI%'
      AND  procesado=0;
     ---PARA CALCULAR EL SALDO FINAL INCREMENTO EFECTIVO NETO DEL PERIODO
        INSERT INTO FECXC.FECXP_PPTO_CARATULA_IMPNS (E_CODIGO       ,   DES_EMPRESA, ID_SESION_PC , PERIODO, MES,
                                                    MONEDA          ,   TIPO_CAMBIO, CLA_FE_ID    , CLA_FE_DES  ,
                                                    IMPORTE_LINEA   ,   ESTATUS    ,   ID_VERSION  ,
                                                    UTILIZAR_REPORTE,   ID_LINEA   ,PROCESADO)
        SELECT                                      E_CODIGO       ,   DES_EMPRESA, ID_SESION_PC , PERIODO, MES,
                                                    MONEDA          ,   TIPO_CAMBIO, 'SF'         , 'SDO FINAL CHEQUERAS' ,
                                                    IMPORTE_LINEA   ,   ESTATUS    ,   ID_VERSION  ,
                                                    UTILIZAR_REPORTE,   ID_LINEA   ,PROCESADO
        FROM FECXC.FECXP_PPTO_CARATULA_IMPNS
          WHERE MES = 1
          AND CLA_FE_ID IN(select  cla_fe_id
                             FROM    FECXP_CLASIFICACION_FE
                             WHERE   CLA_ATRIBUTO4 IN ('01 INGRESOS OPERATIVOS','02 EGRESOS OPERATIVOS', '01 ACTIVIDADES DE INVERSION','01 ACTIVIDADES DE FINANCIAMIENTO'))
          AND  procesado=0;
          COMMIT;
   ELSE      --CALCULANDO LOS DEMAS MESES
          --INSERTANDO EL SALDO FINAL DEL MES ANTERIOR COMO SALDO FINAL DEL MES ACTUAL
          INSERT INTO FECXC.FECXP_PPTO_CARATULA_IMPNS (E_CODIGO  ,   DES_EMPRESA, ID_SESION_PC, PERIODO, MES,MONEDA,   TIPO_CAMBIO, CLA_FE_ID, CLA_FE_DES, IMPORTE_LINEA, ESTATUS,  ID_VERSION,UTILIZAR_REPORTE,ID_LINEA,PROCESADO)
                                                        SELECT
                                                           E_CODIGO, DES_EMPRESA, ID_SESION_PC,
                                                           PERIODO, v_contador_meses, MONEDA,
                                                           TIPO_CAMBIO, 'SI', 'SDO INICIAL CHEQUERAS',
                                                           IMPORTE_LINEA, ESTATUS,
                                                           ID_VERSION, UTILIZAR_REPORTE, ID_LINEA,PROCESADO
                                                        FROM FECXC.FECXP_PPTO_CARATULA_IMPNS
                                                        WHERE MES=(v_contador_meses-1)
                                                        AND CLA_FE_ID LIKE '%SF%'
                                                        AND  procesado=0;
          ---PARA CALCULAR EL SALDO FINAL  A PARTIR DEL SALDO INICIAL
   INSERT INTO FECXC.FECXP_PPTO_CARATULA_IMPNS (E_CODIGO       ,   DES_EMPRESA, ID_SESION_PC , PERIODO, MES,
                                                MONEDA          ,   TIPO_CAMBIO, CLA_FE_ID    , CLA_FE_DES  ,
                                                IMPORTE_LINEA   ,   ESTATUS    ,   ID_VERSION  ,
                                                UTILIZAR_REPORTE,   ID_LINEA   ,PROCESADO)
    SELECT                                      E_CODIGO       ,   DES_EMPRESA, ID_SESION_PC , PERIODO, MES,
                                                MONEDA          ,   TIPO_CAMBIO, 'SF'         , 'SDO FINAL CHEQUERAS' ,
                                                IMPORTE_LINEA   ,   ESTATUS    ,   ID_VERSION  ,
                                                UTILIZAR_REPORTE,   ID_LINEA   ,PROCESADO
    FROM FECXC.FECXP_PPTO_CARATULA_IMPNS
      WHERE MES =  v_contador_meses
      AND CLA_FE_ID LIKE '%SI%'
      AND  procesado=0;
     ---PARA CALCULAR EL SALDO FINAL A PARTIR DE INCREMENTO EFECTIVO NETO DEL PERIODO
        INSERT INTO FECXC.FECXP_PPTO_CARATULA_IMPNS (E_CODIGO       ,   DES_EMPRESA, ID_SESION_PC , PERIODO, MES,
                                                    MONEDA          ,   TIPO_CAMBIO, CLA_FE_ID    , CLA_FE_DES  ,
                                                    IMPORTE_LINEA   ,   ESTATUS    ,   ID_VERSION  ,
                                                    UTILIZAR_REPORTE,   ID_LINEA   ,PROCESADO)
        SELECT                                      E_CODIGO       ,   DES_EMPRESA, ID_SESION_PC , PERIODO, MES,
                                                    MONEDA          ,   TIPO_CAMBIO, 'SF'         , 'SDO FINAL CHEQUERAS' ,
                                                    IMPORTE_LINEA   ,   ESTATUS    ,   ID_VERSION  ,
                                                    UTILIZAR_REPORTE,   ID_LINEA   ,PROCESADO
        FROM FECXC.FECXP_PPTO_CARATULA_IMPNS
          WHERE MES = v_contador_meses
          AND CLA_FE_ID IN(select  cla_fe_id
                             FROM    FECXP_CLASIFICACION_FE
                             WHERE   CLA_ATRIBUTO4 IN ('01 INGRESOS OPERATIVOS','02 EGRESOS OPERATIVOS', '01 ACTIVIDADES DE INVERSION','01 ACTIVIDADES DE FINANCIAMIENTO'))
          AND  procesado=0;
   END IF;
  v_contador_meses:=v_contador_meses+1;--incrementando el mes
   COMMIT;
 END LOOP;
 ---------------------------------------------------------------------------------------------------------------------------------------------
    UPDATE FECXC.FECXP_IMP_DAT_HIST
    SET  PROCESADO = 1
    WHERE PROCESADO = 0
    AND TIPO_IMPORTACION = 'P';
    UPDATE FECXC.FECXP_PPTO_CARATULA_IMPNS
    SET  PROCESADO = 1
    WHERE PROCESADO = 0;
    COMMIT;
END;
/
