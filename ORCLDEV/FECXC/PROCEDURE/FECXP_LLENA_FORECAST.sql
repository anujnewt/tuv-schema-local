CREATE OR REPLACE EDITIONABLE PROCEDURE "FECXC"."FECXP_LLENA_FORECAST" (v_periodo             IN INTEGER,
                                                        v_versiones_real      IN VARCHAR2,
                                                        v_version_ppto        IN INTEGER,
                                                        v_id_version_forecast IN INTEGER,
                                                        v_operacion           IN INTEGER,
                                                        v_nombre_version      IN VARCHAR2,
                                                        v_comentario          IN VARCHAR2,
                                                        v_usuario             IN VARCHAR2   )         ----1 ES PARA INSERTAR LA VERSION, 0 ES PARA BORRAR LA VERSION  )
AS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
 v_version_p    INTEGER; --PARA EL MANEJO DE LAS VERSIONES
 v_token_p      VARCHAR2(100) ;
 v_contador_p   PLS_INTEGER := 1 ;--para recorrer las versiones
 v_enero        INTEGER:=0;
 v_febrero      INTEGER:=0;
 v_marzo        INTEGER:=0;
 v_abril        INTEGER:=0;
 v_mayo         INTEGER:=0;
 v_junio        INTEGER:=0;
 v_julio        INTEGER:=0;
 v_agosto       INTEGER:=0;
 v_septiembre   INTEGER:=0;
 v_octubre      INTEGER:=0;
 v_noviembre    INTEGER:=0;
 v_diciembre    INTEGER:=0;
 v_ultimo_mes_reales INTEGER:=0;
 v_contador_ppto INTEGER:=0;
BEGIN
 IF V_OPERACION=1 THEN
     ----PARA EL REAL---------------------------
     LOOP
           v_token_p := FECXP_STRINGTOKENIZER( v_versiones_real , v_contador_p  , ',') ;
           EXIT WHEN v_token_p IS NULL ;
          IF v_token_p !=0 THEN
              --v_version_p:=TO_NUMBER(v_periodo||LPAD(v_token_p,2,'0'));
              v_version_p:=TO_NUMBER(v_periodo||v_token_p);
              dbms_output.put_line('MES->'||v_contador_p||' ID_VERSION->'||v_version_p) ;
              CASE
                  WHEN v_contador_p = 1  THEN
                       v_enero := 1 ;
                       v_ultimo_mes_reales:=1;
                       INSERT INTO FECXC.FECXP_FORECAST_H            (E_CODIGO, DES_EMPRESA, ID_SESION_RC, PERIODO, MES, MONEDA, TIPO_CAMBIO, CLA_FE_ID, CLA_FE_DES,
                                                                     IMPORTE_LINEA, ESTATUS, TIPO_CARATULA,ID_VERSION,TIPO_PPTO_REAL,ID_VERSION_FORECAST)
                       SELECT                                         E_CODIGO, DES_EMPRESA, ID_SESION_RC, PERIODO, MES, MONEDA, TIPO_CAMBIO, CLA_FE_ID, CLA_FE_DES,
                                                                     IMPORTE_LINEA, ESTATUS, TIPO_CARATULA,ID_VERSION,'R',v_id_version_forecast
                       FROM FECXC.FECXP_REAL_CARATULA_H
                       WHERE PERIODO     = v_periodo
                       AND   MES         = v_enero
                       AND   ID_VERSION  = v_version_p;
                      WHEN v_contador_p = 2  THEN
                       v_febrero   := 2;
                       v_ultimo_mes_reales:=2;
                       INSERT INTO FECXC.FECXP_FORECAST_H            (E_CODIGO, DES_EMPRESA, ID_SESION_RC, PERIODO, MES, MONEDA, TIPO_CAMBIO, CLA_FE_ID, CLA_FE_DES,
                                                                     IMPORTE_LINEA, ESTATUS, TIPO_CARATULA,ID_VERSION,TIPO_PPTO_REAL,ID_VERSION_FORECAST)
                       SELECT                                         E_CODIGO, DES_EMPRESA, ID_SESION_RC, PERIODO, MES, MONEDA, TIPO_CAMBIO, CLA_FE_ID, CLA_FE_DES,
                                                                     IMPORTE_LINEA, ESTATUS, TIPO_CARATULA,ID_VERSION,'R',v_id_version_forecast
                       FROM FECXC.FECXP_REAL_CARATULA_H
                       WHERE PERIODO     = v_periodo
                       AND   MES         = v_febrero
                       AND   ID_VERSION  = v_version_p;
                  WHEN v_contador_p = 3  THEN
                       v_marzo     := 3;
                       v_ultimo_mes_reales:=3;
                       INSERT INTO FECXC.FECXP_FORECAST_H            (E_CODIGO, DES_EMPRESA, ID_SESION_RC, PERIODO, MES, MONEDA, TIPO_CAMBIO, CLA_FE_ID, CLA_FE_DES,
                                                                     IMPORTE_LINEA, ESTATUS, TIPO_CARATULA,ID_VERSION,TIPO_PPTO_REAL,ID_VERSION_FORECAST)
                       SELECT                                         E_CODIGO, DES_EMPRESA, ID_SESION_RC, PERIODO, MES, MONEDA, TIPO_CAMBIO, CLA_FE_ID, CLA_FE_DES,
                                                                     IMPORTE_LINEA, ESTATUS, TIPO_CARATULA,ID_VERSION,'R',v_id_version_forecast
                       FROM FECXC.FECXP_REAL_CARATULA_H
                       WHERE PERIODO     = v_periodo
                       AND   MES         = v_marzo
                       AND   ID_VERSION  = v_version_p;
                  WHEN v_contador_p = 4  THEN
                       v_abril     := 4;
                       v_ultimo_mes_reales:=4;
                       INSERT INTO FECXC.FECXP_FORECAST_H            (E_CODIGO, DES_EMPRESA, ID_SESION_RC, PERIODO, MES, MONEDA, TIPO_CAMBIO, CLA_FE_ID, CLA_FE_DES,
                                                                     IMPORTE_LINEA, ESTATUS, TIPO_CARATULA,ID_VERSION,TIPO_PPTO_REAL,ID_VERSION_FORECAST)
                       SELECT                                         E_CODIGO, DES_EMPRESA, ID_SESION_RC, PERIODO, MES, MONEDA, TIPO_CAMBIO, CLA_FE_ID, CLA_FE_DES,
                                                                     IMPORTE_LINEA, ESTATUS, TIPO_CARATULA,ID_VERSION,'R',v_id_version_forecast
                       FROM FECXC.FECXP_REAL_CARATULA_H
                       WHERE PERIODO     = v_periodo
                       AND   MES         = v_abril
                       AND   ID_VERSION  = v_version_p;
                  WHEN v_contador_p = 5  THEN
                       v_mayo      := 5;
                       v_ultimo_mes_reales:=5;
                       INSERT INTO FECXC.FECXP_FORECAST_H            (E_CODIGO, DES_EMPRESA, ID_SESION_RC, PERIODO, MES, MONEDA, TIPO_CAMBIO, CLA_FE_ID, CLA_FE_DES,
                                                                     IMPORTE_LINEA, ESTATUS, TIPO_CARATULA,ID_VERSION,TIPO_PPTO_REAL,ID_VERSION_FORECAST)
                       SELECT                                         E_CODIGO, DES_EMPRESA, ID_SESION_RC, PERIODO, MES, MONEDA, TIPO_CAMBIO, CLA_FE_ID, CLA_FE_DES,
                                                                     IMPORTE_LINEA, ESTATUS, TIPO_CARATULA,ID_VERSION,'R',v_id_version_forecast
                       FROM FECXC.FECXP_REAL_CARATULA_H
                       WHERE PERIODO     = v_periodo
                       AND   MES         = v_mayo
                       AND   ID_VERSION  = v_version_p;
                  WHEN v_contador_p = 6  THEN
                       v_junio     := 6;
                       v_ultimo_mes_reales:=6;
                       INSERT INTO FECXC.FECXP_FORECAST_H            (E_CODIGO, DES_EMPRESA, ID_SESION_RC, PERIODO, MES, MONEDA, TIPO_CAMBIO, CLA_FE_ID, CLA_FE_DES,
                                                                     IMPORTE_LINEA, ESTATUS, TIPO_CARATULA,ID_VERSION,TIPO_PPTO_REAL,ID_VERSION_FORECAST)
                       SELECT                                         E_CODIGO, DES_EMPRESA, ID_SESION_RC, PERIODO, MES, MONEDA, TIPO_CAMBIO, CLA_FE_ID, CLA_FE_DES,
                                                                     IMPORTE_LINEA, ESTATUS, TIPO_CARATULA,ID_VERSION,'R',v_id_version_forecast
                       FROM FECXC.FECXP_REAL_CARATULA_H
                       WHERE PERIODO     = v_periodo
                       AND   MES         = v_junio
                       AND   ID_VERSION  = v_version_p;
                  WHEN v_contador_p = 7  THEN
                       v_julio     := 7;
                       v_ultimo_mes_reales:=7;
                       INSERT INTO FECXC.FECXP_FORECAST_H            (E_CODIGO, DES_EMPRESA, ID_SESION_RC, PERIODO, MES, MONEDA, TIPO_CAMBIO, CLA_FE_ID, CLA_FE_DES,
                                                                     IMPORTE_LINEA, ESTATUS, TIPO_CARATULA,ID_VERSION,TIPO_PPTO_REAL,ID_VERSION_FORECAST)
                       SELECT                                         E_CODIGO, DES_EMPRESA, ID_SESION_RC, PERIODO, MES, MONEDA, TIPO_CAMBIO, CLA_FE_ID, CLA_FE_DES,
                                                                     IMPORTE_LINEA, ESTATUS, TIPO_CARATULA,ID_VERSION,'R',v_id_version_forecast
                       FROM FECXC.FECXP_REAL_CARATULA_H
                       WHERE PERIODO     = v_periodo
                       AND   MES         = v_julio
                       AND   ID_VERSION  = v_version_p;
                  WHEN v_contador_p = 8  THEN
                       v_agosto    := 8;
                       v_ultimo_mes_reales:=8;
                       INSERT INTO FECXC.FECXP_FORECAST_H            (E_CODIGO, DES_EMPRESA, ID_SESION_RC, PERIODO, MES, MONEDA, TIPO_CAMBIO, CLA_FE_ID, CLA_FE_DES,
                                                                     IMPORTE_LINEA, ESTATUS, TIPO_CARATULA,ID_VERSION,TIPO_PPTO_REAL,ID_VERSION_FORECAST)
                       SELECT                                         E_CODIGO, DES_EMPRESA, ID_SESION_RC, PERIODO, MES, MONEDA, TIPO_CAMBIO, CLA_FE_ID, CLA_FE_DES,
                                                                     IMPORTE_LINEA, ESTATUS, TIPO_CARATULA,ID_VERSION,'R',v_id_version_forecast
                       FROM FECXC.FECXP_REAL_CARATULA_H
                       WHERE PERIODO     = v_periodo
                       AND   MES         = v_agosto
                       AND   ID_VERSION  = v_version_p;
                  WHEN v_contador_p = 9  THEN
                       v_septiembre:= 9;
                       v_ultimo_mes_reales:=9;
                       INSERT INTO FECXC.FECXP_FORECAST_H            (E_CODIGO, DES_EMPRESA, ID_SESION_RC, PERIODO, MES, MONEDA, TIPO_CAMBIO, CLA_FE_ID, CLA_FE_DES,
                                                                     IMPORTE_LINEA, ESTATUS, TIPO_CARATULA,ID_VERSION,TIPO_PPTO_REAL,ID_VERSION_FORECAST)
                       SELECT                                         E_CODIGO, DES_EMPRESA, ID_SESION_RC, PERIODO, MES, MONEDA, TIPO_CAMBIO, CLA_FE_ID, CLA_FE_DES,
                                                                     IMPORTE_LINEA, ESTATUS, TIPO_CARATULA,ID_VERSION,'R',v_id_version_forecast
                       FROM FECXC.FECXP_REAL_CARATULA_H
                       WHERE PERIODO     = v_periodo
                       AND   MES         = v_septiembre
                       AND   ID_VERSION  = v_version_p;
                  WHEN v_contador_p = 10 THEN
                       v_octubre   := 10;
                       v_ultimo_mes_reales:=10;
                       INSERT INTO FECXC.FECXP_FORECAST_H            (E_CODIGO, DES_EMPRESA, ID_SESION_RC, PERIODO, MES, MONEDA, TIPO_CAMBIO, CLA_FE_ID, CLA_FE_DES,
                                                                     IMPORTE_LINEA, ESTATUS, TIPO_CARATULA,ID_VERSION,TIPO_PPTO_REAL,ID_VERSION_FORECAST)
                       SELECT                                         E_CODIGO, DES_EMPRESA, ID_SESION_RC, PERIODO, MES, MONEDA, TIPO_CAMBIO, CLA_FE_ID, CLA_FE_DES,
                                                                     IMPORTE_LINEA, ESTATUS, TIPO_CARATULA,ID_VERSION,'R',v_id_version_forecast
                       FROM FECXC.FECXP_REAL_CARATULA_H
                       WHERE PERIODO     = v_periodo
                       AND   MES         = v_octubre
                       AND   ID_VERSION  = v_version_p;
                  WHEN v_contador_p = 11 THEN
                       v_noviembre := 11;
                       v_ultimo_mes_reales:=11;
                       INSERT INTO FECXC.FECXP_FORECAST_H            (E_CODIGO, DES_EMPRESA, ID_SESION_RC, PERIODO, MES, MONEDA, TIPO_CAMBIO, CLA_FE_ID, CLA_FE_DES,
                                                                     IMPORTE_LINEA, ESTATUS, TIPO_CARATULA,ID_VERSION,TIPO_PPTO_REAL,ID_VERSION_FORECAST)
                       SELECT                                         E_CODIGO, DES_EMPRESA, ID_SESION_RC, PERIODO, MES, MONEDA, TIPO_CAMBIO, CLA_FE_ID, CLA_FE_DES,
                                                                     IMPORTE_LINEA, ESTATUS, TIPO_CARATULA,ID_VERSION,'R',v_id_version_forecast
                       FROM FECXC.FECXP_REAL_CARATULA_H
                       WHERE PERIODO     = v_periodo
                       AND   MES         = v_noviembre
                       AND   ID_VERSION  = v_version_p;
                  WHEN v_contador_p = 12 THEN
                       v_diciembre := 12;
                       v_ultimo_mes_reales:=12;
                       INSERT INTO FECXC.FECXP_FORECAST_H            (E_CODIGO, DES_EMPRESA, ID_SESION_RC, PERIODO, MES, MONEDA, TIPO_CAMBIO, CLA_FE_ID, CLA_FE_DES,
                                                                     IMPORTE_LINEA, ESTATUS, TIPO_CARATULA,ID_VERSION,TIPO_PPTO_REAL,ID_VERSION_FORECAST)
                       SELECT                                         E_CODIGO, DES_EMPRESA, ID_SESION_RC, PERIODO, MES, MONEDA, TIPO_CAMBIO, CLA_FE_ID, CLA_FE_DES,
                                                                     IMPORTE_LINEA, ESTATUS, TIPO_CARATULA,ID_VERSION,'R',v_id_version_forecast
                       FROM FECXC.FECXP_REAL_CARATULA_H
                       WHERE PERIODO     = v_periodo
                       AND   MES         = v_diciembre
                       AND   ID_VERSION  = v_version_p;
              END CASE;
          END IF;
           v_contador_p := v_contador_p + 1 ;
           COMMIT;
     END LOOP ;
     -----PARA EL PRESUPUESTO---------------------------
     INSERT INTO FECXC.FECXP_FORECAST_H                 (E_CODIGO, DES_EMPRESA, ID_SESION_RC, PERIODO, MES, MONEDA, TIPO_CAMBIO, CLA_FE_ID, CLA_FE_DES,
                                                         IMPORTE_LINEA, ESTATUS, TIPO_CARATULA,ID_VERSION,TIPO_PPTO_REAL,ID_VERSION_FORECAST)
     SELECT                                              E_CODIGO, DES_EMPRESA, ID_SESION_PC, PERIODO, MES, MONEDA, TIPO_CAMBIO, CLA_FE_ID, CLA_FE_DES,
                                                         IMPORTE_LINEA, ESTATUS,''            ,ID_VERSION,'P',v_id_version_forecast
     FROM FECXC.FECXP_PPTO_CARATULA_H
     WHERE PERIODO     = v_periodo
     --AND   ID_VERSION  = v_periodo||LPAD(v_version_ppto,2,'0')
     AND   ID_VERSION  = v_periodo||v_version_ppto
     AND MES NOT IN (v_enero,v_febrero,v_marzo,v_abril,v_mayo,v_junio,v_julio,v_agosto,v_septiembre,v_octubre,v_noviembre,v_diciembre);
    COMMIT;
   v_contador_ppto:=v_ultimo_mes_reales;
   v_ultimo_mes_reales:=v_ultimo_mes_reales+1;
   FOR IC IN v_ultimo_mes_reales..12 LOOP
    ----------PASAR EL SALDO FINAL DEL ULTIMO MES DE REALES AL PRIMERO DE PRESUPUESTO------------
    dbms_output.put_line('ULTIMO MES DE REALES->'||v_contador_ppto||' PRIMER MES DE PRESUPUESTO->'||(v_contador_ppto+1)) ;
    DELETE FECXP_FORECAST_H ---BORRAR LOS REGISTROS DE SALDOS INICIALES DEL PRIMER MES DE PRESUPUESTO
    WHERE MES = (v_contador_ppto+1)
    AND  CLA_FE_ID IN ('SI','SI COIN', 'SI INV')
    AND  ID_VERSION_FORECAST=v_id_version_forecast;
    --AND  CLA_FE_DES IN ('SDO INICIAL CHEQUERAS','SDO INICIAL COINVERSION','SDO INICIAL INVERSION');
    commit;
   --INSERTAR LOS REGISTROS DE SALDOS FINALES DEL ULTIMO MES DE REALES EN LOS DE SALDOS INICIALES DEL PRIMER MES DE PRESUPUESTO
   INSERT INTO FECXC.FECXP_FORECAST_H (E_CODIGO, DES_EMPRESA, ID_SESION_RC,
                                       PERIODO, MES, MONEDA,
                                       TIPO_CAMBIO, CLA_FE_ID, CLA_FE_DES,
                                       IMPORTE_LINEA, ESTATUS, TIPO_CARATULA,
                                       ID_VERSION, TIPO_PPTO_REAL, ID_VERSION_FORECAST)
   SELECT
                                       E_CODIGO, DES_EMPRESA, ID_SESION_RC,
                                       PERIODO, (v_contador_ppto+1), MONEDA,
                                       TIPO_CAMBIO, DECODE (CLA_FE_ID, 'SF','SI',
                                                                       'SF INV','SI INV',
                                                                       'SF COIN','SI COIN',cla_fe_id),
                                                    DECODE (CLA_FE_DES,'SDO FINAL CHEQUERAS','SDO INICIAL CHEQUERAS',
                                                                       'SDO FINAL INVERSION','SDO INICIAL INVERSION',
                                                                       'SDO FINAL COINVERSION','SDO INICIAL COINVERSION',
                                                                       'SALDO FINAL','SALDO INICIAL',CLA_FE_DES),
                                       IMPORTE_LINEA, ESTATUS, TIPO_CARATULA,
                                       ID_VERSION, TIPO_PPTO_REAL, ID_VERSION_FORECAST
   FROM FECXC.FECXP_FORECAST_H
   WHERE MES = v_contador_ppto
   AND  CLA_FE_ID IN ('SF','SF COIN', 'SF INV')
   AND  ID_VERSION_FORECAST=v_id_version_forecast;
   -- AND  CLA_FE_DES IN ('SDO INICIAL CHEQUERAS','SDO INICIAL COINVERSION','SDO INICIAL INVERSION');
   COMMIT;
    -----BORRAR EL SALDO FINAL DEL MES
    DELETE FECXP_FORECAST_H ---BORRAR LOS REGISTROS DE SALDOS INICIALES DEL PRIMER MES DE PRESUPUESTO
    WHERE MES = (v_contador_ppto+1)
    AND  CLA_FE_ID IN ('SF','SF COIN', 'SF INV')
    AND  ID_VERSION_FORECAST=v_id_version_forecast;
    commit;
   ---insertando saldos finales
   INSERT INTO FECXC.FECXP_FORECAST_H (E_CODIGO, DES_EMPRESA, ID_SESION_RC,
                                       PERIODO, MES, MONEDA,
                                       TIPO_CAMBIO, CLA_FE_ID, CLA_FE_DES,
                                       IMPORTE_LINEA, ESTATUS, TIPO_CARATULA,
                                       ID_VERSION, TIPO_PPTO_REAL, ID_VERSION_FORECAST)
   SELECT
                                       E_CODIGO, DES_EMPRESA, ID_SESION_RC,
                                       PERIODO, (v_contador_ppto+1), MONEDA,
                                       TIPO_CAMBIO,  CLA_FE_ID,
                                                    CLA_FE_DES,
                                       IMPORTE_LINEA, ESTATUS, TIPO_CARATULA,
                                       ID_VERSION, TIPO_PPTO_REAL, ID_VERSION_FORECAST
   FROM FECXC.FECXP_FORECAST_H
   WHERE MES = v_contador_ppto
   AND  CLA_FE_ID IN ('SF','SF COIN', 'SF INV');
   commit;
   --insertando ==INCREMENTO NETO DE EFECTIVO DEL PERIODO como saldo final
   --insertando ==INCREMENTO NETO DE EFECTIVO DEL PERIODO como saldo final
     INSERT INTO FECXC.FECXP_FORECAST_H (E_CODIGO,
                                         DES_EMPRESA,
                                         ID_SESION_RC,
                                                       PERIODO, MES, MONEDA,
                                                       TIPO_CAMBIO, CLA_FE_ID, CLA_FE_DES,
                                                       IMPORTE_LINEA, ESTATUS, TIPO_CARATULA,
                                                       ID_VERSION, TIPO_PPTO_REAL, ID_VERSION_FORECAST)
              SELECT     distinct  EMPRESA_COD,
                           EMPRESA_DES,
                                C.ID_SESION_RC,
                                C.PERIODO,
                             (v_contador_ppto+1),
                                C.MONEDA,
                                C.TIPO_CAMBIO,
                                'SF' AS CLA_FE_ID,
                                'SALDO FINAL' AS CLA_FE_DES,
                                C.REAL_MON_ORIGEN,
                                C.ESTATUS,
                                C.TIPO_CARATULA,
                                C.ID_VERSION,
                                'P',
                                C.ID_VERSION_FORECAST
                FROM    (
SELECT    B.ID_SEGMENTO SEGMENTO_EMPRESA_COD,
        B.DES_SEGMENTO SEGMENTO_EMPRESA_DES,
        TO_CHAR(C.E_CODIGO)  EMPRESA_COD,
        C.DES_EMPRESA  EMPRESA_DES,
        C.MONEDA MONEDA,
        --C.MONEDA || ' TC: ' || TO_CHAR (M.TIPO_CAMBIO) MONEDA,
        TO_CHAR (C.PERIODO) AS PERIODO,
        TO_CHAR (TO_DATE (C.MES, 'MM'), 'MONTH', 'NLS_DATE_LANGUAGE=SPANISH') AS MES,
        TO_CHAR(LPAD(C.MES, 2, '0')) AS MES_NUM,
        M.TIPO_CAMBIO,
        'INCREM' CLAVE_FLUJO,
        'INCREMENTO NETO DE EFECTIVO DEL PERIODO' CONCEPTO_FLUJO,
        TO_NUMBER (F.CLA_ATRIBUTO1) ORDEN,
        'INCREMENTO NETO DE EFECTIVO DEL PERIODO' RUBRO,
        'INCREMENTO NETO DE EFECTIVO DEL PERIODO' AGRUPAMIENTO,
        '06 INCREMENTO NETO DE EFECTIVO DEL PERIODO' DIVISON,
        TO_NUMBER (F.CLA_ATRIBUTO3) SIGNO,
        SUM(C.REAL_MON_ORIGEN) REAL_MON_ORIGEN,
        SUM(C.REAL_MON_ORIGEN * M.TIPO_CAMBIO) REAL_MON_FUNCIONAL,
        0 REAL_MON_ORIGEN_ACUM,
        0 REAL_MON_FUNCIONAL_ACUM,
        0 REAL_MON_FUNCIONAL_ACUM2,
        0 REAL_MON_ORIGEN_ACUM2,
        'NO GENERA SALDO' TIPO_AFECTACION,
        ESTATUS,
        TIPO_CARATULA,
        ID_VERSION,
        ID_VERSION_FORECAST,
        ID_SESION_RC
FROM    (
        SELECT  C.E_CODIGO,
                C.DES_EMPRESA,
                C.MONEDA,
                C.PERIODO,
                C.MES,
                C.TIPO_CAMBIO,
                C.CLA_FE_ID,
                C.IMPORTE_LINEA REAL_MON_ORIGEN,
                0 PPTO_MON_ORIGEN,
                0 REAL_MON_ORIGEN_ACUM,
                0 PPTO_MON_ORIGEN_ACUM,
                C.ESTATUS,
                C.TIPO_CARATULA,
                ID_VERSION_FORECAST,
                ID_VERSION ,
                ID_SESION_RC
        FROM    FECXP_FORECAST_H C
        WHERE   C.MES= (v_contador_ppto+1)
        AND  ID_VERSION_FORECAST=v_id_version_forecast
        AND  PERIODO=V_PERIODO
        --WHERE   ID_VERSION = FECXP_SET_VERSION_H.GET_VERSION
        UNION ALL
        SELECT    C.E_CODIGO,
                C.DES_EMPRESA,
                C.MONEDA,
                C.PERIODO,
                C.MES,
                C.TIPO_CAMBIO,
                C.CLA_FE_ID,
                0 REAL_MON_ORIGEN,
                0 PPTO_MON_ORIGEN,
                CASE
--                WHEN C.CLA_FE_ID = 'SI' THEN CASE C.MES WHEN 1 THEN C.IMPORTE_LINEA ELSE 0 END
--                WHEN C.CLA_FE_ID IN ('SF', 'SF2', 'COLUMBUS', 'COMTELVI', 'GRUPO ESPA?A', 'NDUAL', 'COMPRA USD') THEN CASE C.MES WHEN TO_NUMBER (TO_CHAR (SYSDATE, 'MM')) - 1 THEN C.IMPORTE_LINEA ELSE 0 END
                   WHEN C.CLA_FE_ID IN ('SI', 'COLUMBUS I', 'COMTELVI I', 'GRUPO ESPA?A I', 'NOTA D I', 'COMPRA DLS I','SI COIN', 'SI INV' ) THEN
                      CASE C.MES WHEN 1 THEN C.IMPORTE_LINEA ELSE 0 END
                   WHEN C.CLA_FE_ID IN ('SF', 'SF2', 'COLUMBUS F', 'COMTELVI F', 'GRUPO ESPA?A F', 'NOTA D F', 'COMPRA DLS F','SF COIN', 'SF INV') THEN
                      CASE C.MES WHEN TO_NUMBER (TO_CHAR (SYSDATE, 'MM')) - 1 THEN C.IMPORTE_LINEA ELSE 0 END
                   ELSE
                      C.IMPORTE_LINEA
                END REAL_MON_ORIGEN_ACUM,
                0 PPTO_MON_ORIGEN_ACUM,
                C.ESTATUS,
                C.TIPO_CARATULA,
                ID_VERSION_FORECAST,
                 ID_VERSION,
                 ID_SESION_RC
        FROM    FECXP_FORECAST_H C
        WHERE   C.MES= (v_contador_ppto+1)
        AND  ID_VERSION_FORECAST=v_id_version_forecast
        AND  PERIODO=V_PERIODO
        ) C,
        FECXP_CLASIFICACION_FE F,
        FECXC_EMP_X_SEGMENTO A,
        FECXC_SEGMENTOS_FLUJO B,
        FECXP_MONEDAS M
WHERE    C.CLA_FE_ID = F.CLA_FE_ID
AND        C.PERIODO <= TO_NUMBER(TO_CHAR(SYSDATE,'YYYY'))
AND        F.CLA_ATRIBUTO4 IN ('01 ACTIVIDADES DE INVERSION','01 ACTIVIDADES DE FINANCIAMIENTO','01 INGRESOS OPERATIVOS','02 EGRESOS OPERATIVOS')
AND        A.ID_SEGMENTO NOT IN (11, 15, 17,18, 20, 26, 6, 13, 25)
AND        A.ID_SEGMENTO = B.ID_SEGMENTO
AND        C.E_CODIGO = A.E_CODIGO
AND        M.MON_ORACLE = C.MONEDA
AND        M.PERIODO =
        CASE WHEN  C.CLA_FE_ID IN ('SI','SI COIN', 'SI INV')
            THEN
                CASE C.MES WHEN 1
                    THEN C.PERIODO - 1
                    ELSE C.PERIODO
                END
            ELSE C.PERIODO
        END
AND        M.MES =
        CASE WHEN  C.CLA_FE_ID IN ('SI','SI COIN', 'SI INV')
            THEN
                CASE C.MES WHEN 1
                    THEN 12
                    ELSE C.MES - 1
                END
            ELSE C.MES
        END
AND F.CLA_FE_DES NOT IN ('CANCELACIONES')
GROUP BY B.ID_SEGMENTO,
        B.DES_SEGMENTO,
        TO_CHAR(C.E_CODIGO),
        C.DES_EMPRESA,
        C.MONEDA ,
        C.MONEDA || ' TC: ' || TO_CHAR (M.TIPO_CAMBIO),
        TO_CHAR (C.PERIODO),
        TO_CHAR (TO_DATE (C.MES, 'MM'), 'MONTH', 'NLS_DATE_LANGUAGE=SPANISH'),
        TO_CHAR(LPAD(C.MES, 2, '0')),
        M.TIPO_CAMBIO,
        TO_NUMBER (F.CLA_ATRIBUTO1),
        TO_NUMBER (F.CLA_ATRIBUTO3),
        ESTATUS,
        TIPO_CARATULA,
        ID_VERSION,
        ID_VERSION_FORECAST,
        ID_SESION_RC) C;
        commit;
   /*
     INSERT INTO FECXC.FECXP_FORECAST_H (E_CODIGO, DES_EMPRESA, ID_SESION_RC,
                                                       PERIODO, MES, MONEDA,
                                                       TIPO_CAMBIO, CLA_FE_ID, CLA_FE_DES,
                                                       IMPORTE_LINEA, ESTATUS, TIPO_CARATULA,
                                                       ID_VERSION, TIPO_PPTO_REAL, ID_VERSION_FORECAST)
                                SELECT       distinct   C.E_CODIGO,
                                C.DES_EMPRESA,
                                C.ID_SESION_RC,
                                C.PERIODO,
                                (v_contador_ppto+1),
                                C.MONEDA,
                                C.TIPO_CAMBIO,
                                'SF' AS CLA_FE_ID,
                                'SDO FINAL CHEQUERAS' AS CLA_FE_DES,
                                C.REAL_MON_ORIGEN,
                                C.ESTATUS,
                                C.TIPO_CARATULA,
                                C.ID_VERSION,
                                'P',
                                C.ID_VERSION_FORECAST
                FROM    (
                        SELECT  C.E_CODIGO,
                                C.DES_EMPRESA,
                                C.ID_SESION_RC,
                                C.MONEDA,
                                C.PERIODO,
                                C.MES,
                                C.TIPO_CAMBIO,
                                C.CLA_FE_ID,
                                C.CLA_FE_DES,
                                C.IMPORTE_LINEA REAL_MON_ORIGEN,
                                0 PPTO_MON_ORIGEN,
                                0 REAL_MON_ORIGEN_ACUM,
                                0 PPTO_MON_ORIGEN_ACUM,
                                C.ESTATUS,
                                C.ID_VERSION,
                                C.TIPO_CARATULA,
                                ID_VERSION_FORECAST
                        FROM    FECXP_FORECAST_H C
                        WHERE   C.MES= (v_contador_ppto+1)
                        AND  ID_VERSION_FORECAST=v_id_version_forecast
                        AND  PERIODO=V_PERIODO
                        UNION ALL
                        SELECT    C.E_CODIGO,
                                C.DES_EMPRESA,
                                C.ID_SESION_RC,
                                C.MONEDA,
                                C.PERIODO,
                                C.MES,
                                C.TIPO_CAMBIO,
                                C.CLA_FE_ID,
                                C.CLA_FE_DES,
                                0 REAL_MON_ORIGEN,
                                0 PPTO_MON_ORIGEN,
                                CASE
                --                WHEN C.CLA_FE_ID = 'SI' THEN CASE C.MES WHEN 1 THEN C.IMPORTE_LINEA ELSE 0 END
                --                WHEN C.CLA_FE_ID IN ('SF', 'SF2', 'COLUMBUS', 'COMTELVI', 'GRUPO ESPA?A', 'NDUAL', 'COMPRA USD') THEN CASE C.MES WHEN TO_NUMBER (TO_CHAR (SYSDATE, 'MM')) - 1 THEN C.IMPORTE_LINEA ELSE 0 END
                                   WHEN C.CLA_FE_ID IN ('SI', 'COLUMBUS I', 'COMTELVI I', 'GRUPO ESPA?A I', 'NOTA D I', 'COMPRA DLS I','SI COIN', 'SI INV' ) THEN
                                      CASE C.MES WHEN 1 THEN C.IMPORTE_LINEA ELSE 0 END
                                   WHEN C.CLA_FE_ID IN ('SF', 'SF2', 'COLUMBUS F', 'COMTELVI F', 'GRUPO ESPA?A F', 'NOTA D F', 'COMPRA DLS F','SF COIN', 'SF INV') THEN
                                      CASE C.MES WHEN TO_NUMBER (TO_CHAR (SYSDATE, 'MM')) - 1 THEN C.IMPORTE_LINEA ELSE 0 END
                                   ELSE
                                      C.IMPORTE_LINEA
                                END REAL_MON_ORIGEN_ACUM,
                                0 PPTO_MON_ORIGEN_ACUM,
                                C.ESTATUS,
                                C.ID_VERSION,
                                C.TIPO_CARATULA,
                                C.ID_VERSION_FORECAST
                        FROM    FECXP_FORECAST_H C
                        WHERE   C.MES= (v_contador_ppto+1)
                        AND  ID_VERSION_FORECAST=v_id_version_forecast
                        AND  PERIODO=V_PERIODO
                        ) C,
                        FECXP_CLASIFICACION_FE F,
                        FECXC_EMP_X_SEGMENTO A,
                        FECXC_SEGMENTOS_FLUJO B,
                        FECXP_MONEDAS M
                WHERE    C.CLA_FE_ID = F.CLA_FE_ID
                AND        C.PERIODO <= TO_NUMBER(TO_CHAR(SYSDATE,'YYYY'))
                AND        F.CLA_ATRIBUTO4 IN ('01 ACTIVIDADES DE INVERSION','01 ACTIVIDADES DE FINANCIAMIENTO','01 INGRESOS OPERATIVOS','02 EGRESOS OPERATIVOS')
                AND        A.ID_SEGMENTO NOT IN (11, 15, 17,18, 20, 26, 6, 13, 25)
                AND        A.ID_SEGMENTO = B.ID_SEGMENTO
                AND        C.E_CODIGO = A.E_CODIGO
                AND        M.MON_ORACLE = C.MONEDA
                AND        M.PERIODO =
                        CASE WHEN  C.CLA_FE_ID IN ('SI','SI COIN', 'SI INV')
                            THEN
                                CASE C.MES WHEN 1
                                    THEN C.PERIODO - 1
                                    ELSE C.PERIODO
                                END
                            ELSE C.PERIODO
                        END
                     AND        M.MES =
                        CASE WHEN  C.CLA_FE_ID IN ('SI','SI COIN', 'SI INV')
                            THEN
                                CASE C.MES WHEN 1
                                    THEN 12
                                    ELSE C.MES - 1
                                END
                            ELSE C.MES
                        END;
                      --AND F.CLA_FE_DES NOT IN ('CANCELACIONES','INGRESOS INTEREMPRESAS');
                         COMMIT;
         /*
          --------INSERTANDO LA FLUCTUACION CAMBIARIA COMO SALDO FINAL
         INSERT INTO FECXC.FECXP_FORECAST_H (E_CODIGO, DES_EMPRESA, ID_SESION_RC,
                                                       PERIODO, MES, MONEDA,
                                                       TIPO_CAMBIO, CLA_FE_ID, CLA_FE_DES,
                                                       IMPORTE_LINEA, ESTATUS, TIPO_CARATULA,
                                                       ID_VERSION, TIPO_PPTO_REAL, ID_VERSION_FORECAST)
        SELECT       distinct   C.E_CODIGO,
                                C.DES_EMPRESA,
                                C.ID_SESION_RC,
                                C.PERIODO,
                                (v_contador_ppto+1),
                                C.MONEDA,
                                C.TIPO_CAMBIO,
                                'SF' AS CLA_FE_ID,
                                'SALDO FINAL' AS CLA_FE_DES,
                                C.REAL_MON_ORIGEN,
                                C.ESTATUS,
                                C.TIPO_CARATULA,
                                C.ID_VERSION,
                                'P',
                                C.ID_VERSION_FORECAST
                            FROM    (
                                    SELECT    C.E_CODIGO,
                                            C.DES_EMPRESA,
                                            C.MONEDA,
                                            C.PERIODO,
                                            C.MES,
                                            C.TIPO_CAMBIO,
                                            C.CLA_FE_ID,
                                            C.IMPORTE_LINEA REAL_MON_ORIGEN,
                                            0 PPTO_MON_ORIGEN,
                                            0 REAL_MON_ORIGEN_ACUM,
                                            0 PPTO_MON_ORIGEN_ACUM,
                                            C.ESTATUS,
                                            C.TIPO_CARATULA,
                                            C.ID_VERSION_FORECAST,
                                            C.ID_VERSION,
                                            C.ID_SESION_RC
                                    FROM    FECXP_FORECAST_H C
                                    WHERE C.MES=  (v_contador_ppto+1)
                                    UNION ALL
                                    SELECT    C.E_CODIGO,
                                            C.DES_EMPRESA,
                                            C.MONEDA,
                                            C.PERIODO,
                                            C.MES,
                                            C.TIPO_CAMBIO,
                                            C.CLA_FE_ID,
                                            0 REAL_MON_ORIGEN,
                                            0 PPTO_MON_ORIGEN,
                                            CASE
                            --                WHEN C.CLA_FE_ID = 'SI' THEN CASE C.MES WHEN 1 THEN C.IMPORTE_LINEA ELSE 0 END
                            --                WHEN C.CLA_FE_ID IN ('SF', 'SF2', 'COLUMBUS', 'COMTELVI', 'GRUPO ESPA?A', 'NDUAL', 'COMPRA USD') THEN CASE C.MES WHEN TO_NUMBER (TO_CHAR (SYSDATE, 'MM')) - 1 THEN C.IMPORTE_LINEA ELSE 0 END
                                               WHEN C.CLA_FE_ID IN ('SI', 'COLUMBUS I', 'COMTELVI I', 'GRUPO ESPA?A I', 'NOTA D I', 'COMPRA DLS I','SI COIN', 'SI INV' ) THEN
                                                  CASE C.MES WHEN 1 THEN C.IMPORTE_LINEA ELSE 0 END
                                               WHEN C.CLA_FE_ID IN ('SF', 'SF2', 'COLUMBUS F', 'COMTELVI F', 'GRUPO ESPA?A F', 'NOTA D F', 'COMPRA DLS F','SF COIN', 'SF INV') THEN
                                                  CASE C.MES WHEN TO_NUMBER (TO_CHAR (SYSDATE, 'MM')) - 1 THEN C.IMPORTE_LINEA ELSE 0 END
                                               ELSE
                                                  C.IMPORTE_LINEA
                                            END REAL_MON_ORIGEN_ACUM,
                                            0 PPTO_MON_ORIGEN_ACUM,
                                            C.ESTATUS,
                                            C.TIPO_CARATULA,
                                            C.ID_VERSION_FORECAST,
                                            C.ID_VERSION,
                                            C.ID_SESION_RC
                                    FROM    FECXP_FORECAST_H C
                                    WHERE C.MES=  (v_contador_ppto+1)
                                    ) C,
                                    FECXP_CLASIFICACION_FE F,
                                    FECXC_EMP_X_SEGMENTO A,
                                    FECXC_SEGMENTOS_FLUJO B,
                                    FECXP_MONEDAS M,
                                    FECXP_MONEDAS N
                            WHERE    C.CLA_FE_ID = F.CLA_FE_ID
                            AND        C.PERIODO <= TO_NUMBER(TO_CHAR(SYSDATE,'YYYY'))
                            AND        A.ID_SEGMENTO NOT IN (11, 15, 17,18, 20, 26, 6, 13, 25)
                            AND        A.ID_SEGMENTO = B.ID_SEGMENTO
                            AND        C.E_CODIGO = A.E_CODIGO
                            AND     N.MON_ORACLE = C.MONEDA
                            AND        N.PERIODO = C.PERIODO
                            AND     N.MES = C.MES
                            AND        M.MON_ORACLE = C.MONEDA
                            AND        M.PERIODO =
                                    CASE WHEN  C.CLA_FE_ID IN ('SI','SI COIN', 'SI INV')
                                        THEN
                                            CASE C.MES WHEN 1
                                                THEN C.PERIODO - 1
                                                ELSE C.PERIODO
                                            END
                                        ELSE C.PERIODO
                                    END
                            AND        M.MES =
                                    CASE WHEN  C.CLA_FE_ID IN ('SI','SI COIN', 'SI INV')
                                        THEN
                                            CASE C.MES WHEN 1
                                                THEN 12
                                                ELSE C.MES - 1
                                            END
                                        ELSE C.MES
                                    END
                            AND ((C.REAL_MON_ORIGEN * N.TIPO_CAMBIO) - (C.REAL_MON_ORIGEN * M.TIPO_CAMBIO))<>0
                            AND F.CLA_FE_DES NOT IN ('CANCELACIONES');**/
                            COMMIT;
    v_contador_ppto:=v_contador_ppto+1;
    END LOOP;
    commit;
 END IF;
 IF V_OPERACION=0 THEN
    DELETE
    FROM  FECXC.FECXP_FORECAST_H
    WHERE ID_VERSION_FORECAST    = v_id_version_forecast;
    COMMIT;
 END IF;
 COMMIT;
 INSERT INTO FECXP_BITACORA_HISTORICOS(PROCESO_ID, PROCESO_NOMBRE         , CREATED_BY, DATE_CREATED, ID_VERSION           , DESC_VERSION, PERIODO, MES, COMENTARIO, TIPO_OPERACION)
 SELECT                                        19, 'HISTORICO DE FORECAST', V_USUARIO , SYSDATE     , V_ID_VERSION_FORECAST, V_NOMBRE_VERSION, V_PERIODO, 0, V_COMENTARIO, CASE WHEN V_OPERACION=1 THEN 'REGISTRA VERSION' ELSE 'ELIMINA VERSION' END
    FROM DUAL;
 COMMIT;
 UPDATE FECXP_PPTO_EXTRACCION_PARAMS
       SET ESTATUS_PROCESO = 'INACTIVO',ESTATUS_EXT_ULT_EJECUCION= 'EXITOSO'
       WHERE PROCESO_ID =19;
EXCEPTION
 WHEN OTHERS THEN
       UPDATE FECXP_PPTO_EXTRACCION_PARAMS
       SET ESTATUS_PROCESO = 'INACTIVO',ESTATUS_EXT_ULT_EJECUCION= 'ERROR'
       WHERE PROCESO_ID =19;
      raise_application_error(-20001,'An error was encountered - '||SQLCODE||' -ERROR- '||SQLERRM);
      ROLLBACK;
END;
/
