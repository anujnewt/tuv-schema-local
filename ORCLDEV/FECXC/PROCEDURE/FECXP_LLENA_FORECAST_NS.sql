CREATE OR REPLACE EDITIONABLE PROCEDURE "FECXC"."FECXP_LLENA_FORECAST_NS" (v_periodo             IN INTEGER,
                                                           v_versiones_real_h    IN VARCHAR2,
                                                           v_version_ppto_h      IN INTEGER,
                                                           v_versiones_real_ns   IN VARCHAR2,
                                                           v_version_ppto_ns     IN INTEGER,
                                                           v_comentario          IN VARCHAR2,
                                                           v_usuario             IN VARCHAR2  )
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
 v_error_num    INTEGER;
 v_error_code   VARCHAR2(400);
BEGIN
    dbms_output.put_line('INICIO '||TO_CHAR(SYSDATE,'DD-MM-YYYY HH:MM:SS')) ;
    DELETE
    FECXC.FECXP_FORECAST_NS ;--Se borra la tabla del forecast NO SET
    COMMIT;
   ----PARA EL REAL de Historicos---------------------------
     LOOP
           v_token_p := FECXC.FECXP_STRINGTOKENIZER( v_versiones_real_h , v_contador_p  , ',') ;
           EXIT WHEN v_token_p IS NULL ;
          IF v_token_p !=0 THEN
              --TO_CHAR(v_version_p):=TO_NUMBER(v_periodo||LPAD(v_token_p,2,'0'));
              v_version_p:=TO_NUMBER(v_periodo||v_token_p);
              dbms_output.put_line('MES->'||v_contador_p||' ID_VERSION->'||TO_CHAR(v_version_p)) ;
              CASE
                  WHEN v_contador_p = 1  THEN
                       v_enero := 1 ;
                       v_ultimo_mes_reales:=1;
                       INSERT INTO FECXC.FECXP_FORECAST_NS            (E_CODIGO, DES_EMPRESA, ID_SESION_RC, PERIODO, MES, MONEDA, TIPO_CAMBIO, CLA_FE_ID, CLA_FE_DES,
                                                                     IMPORTE_LINEA, ESTATUS, TIPO_CARATULA,ID_VERSION,TIPO_PPTO_REAL,TIPO_EMPRESA)
                       SELECT                                         E_CODIGO, DES_EMPRESA, ID_SESION_RC, PERIODO, MES, MONEDA, TIPO_CAMBIO, CLA_FE_ID, CLA_FE_DES,
                                                                     IMPORTE_LINEA, ESTATUS, TIPO_CARATULA,ID_VERSION,'R','SET'
                       FROM FECXC.FECXP_REAL_CARATULA_H
                       WHERE PERIODO     = v_periodo
                       AND   MES         = v_enero
                       AND   ID_VERSION  = TO_CHAR(v_version_p)
                       AND ROWID NOT IN( SELECT A.ROWID FROM FECXP_REAL_CARATULA_H A,
                                                FECXP_REAL_CARATULA_IMPNS B
                                           WHERE A.E_CODIGO=B.E_CODIGO
                                             AND A.PERIODO=B.PERIODO
                                             AND A.MES=B.MES
                                             AND B.UTILIZAR_REPORTE='S');
                      WHEN v_contador_p = 2  THEN
                       v_febrero   := 2;
                       v_ultimo_mes_reales:=2;
                       INSERT INTO FECXC.FECXP_FORECAST_NS            (E_CODIGO, DES_EMPRESA, ID_SESION_RC, PERIODO, MES, MONEDA, TIPO_CAMBIO, CLA_FE_ID, CLA_FE_DES,
                                                                     IMPORTE_LINEA, ESTATUS, TIPO_CARATULA,ID_VERSION,TIPO_PPTO_REAL,TIPO_EMPRESA)
                       SELECT                                         E_CODIGO, DES_EMPRESA, ID_SESION_RC, PERIODO, MES, MONEDA, TIPO_CAMBIO, CLA_FE_ID, CLA_FE_DES,
                                                                     IMPORTE_LINEA, ESTATUS, TIPO_CARATULA,ID_VERSION,'R','SET'
                       FROM FECXC.FECXP_REAL_CARATULA_H
                       WHERE PERIODO     = v_periodo
                       AND   MES         = v_febrero
                       AND   ID_VERSION  = TO_CHAR(v_version_p)
                       AND ROWID NOT IN( SELECT A.ROWID FROM FECXP_REAL_CARATULA_H A,
                                                FECXP_REAL_CARATULA_IMPNS B
                                           WHERE A.E_CODIGO=B.E_CODIGO
                                             AND A.PERIODO=B.PERIODO
                                             AND A.MES=B.MES
                                             AND B.UTILIZAR_REPORTE='S');
                  WHEN v_contador_p = 3  THEN
                       v_marzo     := 3;
                       v_ultimo_mes_reales:=3;
                       INSERT INTO FECXC.FECXP_FORECAST_NS            (E_CODIGO, DES_EMPRESA, ID_SESION_RC, PERIODO, MES, MONEDA, TIPO_CAMBIO, CLA_FE_ID, CLA_FE_DES,
                                                                     IMPORTE_LINEA, ESTATUS, TIPO_CARATULA,ID_VERSION,TIPO_PPTO_REAL,TIPO_EMPRESA)
                       SELECT                                         E_CODIGO, DES_EMPRESA, ID_SESION_RC, PERIODO, MES, MONEDA, TIPO_CAMBIO, CLA_FE_ID, CLA_FE_DES,
                                                                     IMPORTE_LINEA, ESTATUS, TIPO_CARATULA,ID_VERSION,'R','SET'
                       FROM FECXC.FECXP_REAL_CARATULA_H
                       WHERE PERIODO     = v_periodo
                       AND   MES         = v_marzo
                       AND   ID_VERSION  = TO_CHAR(v_version_p)
                       AND ROWID NOT IN( SELECT A.ROWID FROM FECXP_REAL_CARATULA_H A,
                                                FECXP_REAL_CARATULA_IMPNS B
                                           WHERE A.E_CODIGO=B.E_CODIGO
                                             AND A.PERIODO=B.PERIODO
                                             AND A.MES=B.MES
                                             AND B.UTILIZAR_REPORTE='S');
                  WHEN v_contador_p = 4  THEN
                       v_abril     := 4;
                       v_ultimo_mes_reales:=4;
                       INSERT INTO FECXC.FECXP_FORECAST_NS            (E_CODIGO, DES_EMPRESA, ID_SESION_RC, PERIODO, MES, MONEDA, TIPO_CAMBIO, CLA_FE_ID, CLA_FE_DES,
                                                                     IMPORTE_LINEA, ESTATUS, TIPO_CARATULA,ID_VERSION,TIPO_PPTO_REAL,TIPO_EMPRESA)
                       SELECT                                         E_CODIGO, DES_EMPRESA, ID_SESION_RC, PERIODO, MES, MONEDA, TIPO_CAMBIO, CLA_FE_ID, CLA_FE_DES,
                                                                     IMPORTE_LINEA, ESTATUS, TIPO_CARATULA,ID_VERSION,'R','SET'
                       FROM FECXC.FECXP_REAL_CARATULA_H
                       WHERE PERIODO     = v_periodo
                       AND   MES         = v_abril
                       AND   ID_VERSION  = TO_CHAR(v_version_p)
                       AND ROWID NOT IN( SELECT A.ROWID FROM FECXP_REAL_CARATULA_H A,
                                                FECXP_REAL_CARATULA_IMPNS B
                                           WHERE A.E_CODIGO=B.E_CODIGO
                                             AND A.PERIODO=B.PERIODO
                                             AND A.MES=B.MES
                                             AND B.UTILIZAR_REPORTE='S');
                  WHEN v_contador_p = 5  THEN
                       v_mayo      := 5;
                       v_ultimo_mes_reales:=5;
                       INSERT INTO FECXC.FECXP_FORECAST_NS            (E_CODIGO, DES_EMPRESA, ID_SESION_RC, PERIODO, MES, MONEDA, TIPO_CAMBIO, CLA_FE_ID, CLA_FE_DES,
                                                                     IMPORTE_LINEA, ESTATUS, TIPO_CARATULA,ID_VERSION,TIPO_PPTO_REAL,TIPO_EMPRESA)
                       SELECT                                         E_CODIGO, DES_EMPRESA, ID_SESION_RC, PERIODO, MES, MONEDA, TIPO_CAMBIO, CLA_FE_ID, CLA_FE_DES,
                                                                     IMPORTE_LINEA, ESTATUS, TIPO_CARATULA,ID_VERSION,'R','SET'
                       FROM FECXC.FECXP_REAL_CARATULA_H
                       WHERE PERIODO     = v_periodo
                       AND   MES         = v_mayo
                       AND   ID_VERSION  = TO_CHAR(v_version_p)
                       AND ROWID NOT IN( SELECT A.ROWID FROM FECXP_REAL_CARATULA_H A,
                                                             FECXP_REAL_CARATULA_IMPNS B
                                           WHERE A.E_CODIGO=B.E_CODIGO
                                             AND A.PERIODO=B.PERIODO
                                             AND A.MES=B.MES
                                             AND B.UTILIZAR_REPORTE='S');
                  WHEN v_contador_p = 6  THEN
                       v_junio     := 6;
                       v_ultimo_mes_reales:=6;
                       INSERT INTO FECXC.FECXP_FORECAST_NS            (E_CODIGO, DES_EMPRESA, ID_SESION_RC, PERIODO, MES, MONEDA, TIPO_CAMBIO, CLA_FE_ID, CLA_FE_DES,
                                                                     IMPORTE_LINEA, ESTATUS, TIPO_CARATULA,ID_VERSION,TIPO_PPTO_REAL,TIPO_EMPRESA)
                       SELECT                                         E_CODIGO, DES_EMPRESA, ID_SESION_RC, PERIODO, MES, MONEDA, TIPO_CAMBIO, CLA_FE_ID, CLA_FE_DES,
                                                                     IMPORTE_LINEA, ESTATUS, TIPO_CARATULA,ID_VERSION,'R','SET'
                       FROM FECXC.FECXP_REAL_CARATULA_H
                       WHERE PERIODO     = v_periodo
                       AND   MES         = v_junio
                       AND   ID_VERSION  = TO_CHAR(v_version_p)
                       AND ROWID NOT IN( SELECT A.ROWID FROM FECXP_REAL_CARATULA_H A,
                                                             FECXP_REAL_CARATULA_IMPNS B
                                           WHERE A.E_CODIGO=B.E_CODIGO
                                             AND A.PERIODO=B.PERIODO
                                             AND A.MES=B.MES
                                             AND B.UTILIZAR_REPORTE='S');
                  WHEN v_contador_p = 7  THEN
                       v_julio     := 7;
                       v_ultimo_mes_reales:=7;
                       INSERT INTO FECXC.FECXP_FORECAST_NS            (E_CODIGO, DES_EMPRESA, ID_SESION_RC, PERIODO, MES, MONEDA, TIPO_CAMBIO, CLA_FE_ID, CLA_FE_DES,
                                                                     IMPORTE_LINEA, ESTATUS, TIPO_CARATULA,ID_VERSION,TIPO_PPTO_REAL,TIPO_EMPRESA)
                       SELECT                                         E_CODIGO, DES_EMPRESA, ID_SESION_RC, PERIODO, MES, MONEDA, TIPO_CAMBIO, CLA_FE_ID, CLA_FE_DES,
                                                                     IMPORTE_LINEA, ESTATUS, TIPO_CARATULA,ID_VERSION,'R','SET'
                       FROM FECXC.FECXP_REAL_CARATULA_H
                       WHERE PERIODO     = v_periodo
                       AND   MES         = v_julio
                       AND   ID_VERSION  = TO_CHAR(v_version_p)
                       AND ROWID NOT IN( SELECT A.ROWID FROM FECXP_REAL_CARATULA_H A,
                                                             FECXP_REAL_CARATULA_IMPNS B
                                           WHERE A.E_CODIGO=B.E_CODIGO
                                             AND A.PERIODO=B.PERIODO
                                             AND A.MES=B.MES
                                             AND B.UTILIZAR_REPORTE='S');
                  WHEN v_contador_p = 8  THEN
                       v_agosto    := 8;
                       v_ultimo_mes_reales:=8;
                       INSERT INTO FECXC.FECXP_FORECAST_NS            (E_CODIGO, DES_EMPRESA, ID_SESION_RC, PERIODO, MES, MONEDA, TIPO_CAMBIO, CLA_FE_ID, CLA_FE_DES,
                                                                     IMPORTE_LINEA, ESTATUS, TIPO_CARATULA,ID_VERSION,TIPO_PPTO_REAL,TIPO_EMPRESA)
                       SELECT                                         E_CODIGO, DES_EMPRESA, ID_SESION_RC, PERIODO, MES, MONEDA, TIPO_CAMBIO, CLA_FE_ID, CLA_FE_DES,
                                                                     IMPORTE_LINEA, ESTATUS, TIPO_CARATULA,ID_VERSION,'R','SET'
                       FROM FECXC.FECXP_REAL_CARATULA_H
                       WHERE PERIODO     = v_periodo
                       AND   MES         = v_agosto
                       AND   ID_VERSION  = TO_CHAR(v_version_p)
                       AND ROWID NOT IN( SELECT A.ROWID FROM FECXP_REAL_CARATULA_H A,
                                                             FECXP_REAL_CARATULA_IMPNS B
                                           WHERE A.E_CODIGO=B.E_CODIGO
                                             AND A.PERIODO=B.PERIODO
                                             AND A.MES=B.MES
                                             AND B.UTILIZAR_REPORTE='S');
                  WHEN v_contador_p = 9  THEN
                       v_septiembre:= 9;
                       v_ultimo_mes_reales:=9;
                       INSERT INTO FECXC.FECXP_FORECAST_NS            (E_CODIGO, DES_EMPRESA, ID_SESION_RC, PERIODO, MES, MONEDA, TIPO_CAMBIO, CLA_FE_ID, CLA_FE_DES,
                                                                     IMPORTE_LINEA, ESTATUS, TIPO_CARATULA,ID_VERSION,TIPO_PPTO_REAL,TIPO_EMPRESA)
                       SELECT                                         E_CODIGO, DES_EMPRESA, ID_SESION_RC, PERIODO, MES, MONEDA, TIPO_CAMBIO, CLA_FE_ID, CLA_FE_DES,
                                                                     IMPORTE_LINEA, ESTATUS, TIPO_CARATULA,ID_VERSION,'R','SET'
                       FROM FECXC.FECXP_REAL_CARATULA_H
                       WHERE PERIODO     = v_periodo
                       AND   MES         = v_septiembre
                       AND   ID_VERSION  = TO_CHAR(v_version_p)
                       AND ROWID NOT IN( SELECT A.ROWID FROM FECXP_REAL_CARATULA_H A,
                                                             FECXP_REAL_CARATULA_IMPNS B
                                           WHERE A.E_CODIGO=B.E_CODIGO
                                             AND A.PERIODO=B.PERIODO
                                             AND A.MES=B.MES
                                             AND B.UTILIZAR_REPORTE='S');
                  WHEN v_contador_p = 10 THEN
                       v_octubre   := 10;
                       v_ultimo_mes_reales:=10;
                       INSERT INTO FECXC.FECXP_FORECAST_NS            (E_CODIGO, DES_EMPRESA, ID_SESION_RC, PERIODO, MES, MONEDA, TIPO_CAMBIO, CLA_FE_ID, CLA_FE_DES,
                                                                     IMPORTE_LINEA, ESTATUS, TIPO_CARATULA,ID_VERSION,TIPO_PPTO_REAL,TIPO_EMPRESA)
                       SELECT                                         E_CODIGO, DES_EMPRESA, ID_SESION_RC, PERIODO, MES, MONEDA, TIPO_CAMBIO, CLA_FE_ID, CLA_FE_DES,
                                                                     IMPORTE_LINEA, ESTATUS, TIPO_CARATULA,ID_VERSION,'R','SET'
                       FROM FECXC.FECXP_REAL_CARATULA_H
                       WHERE PERIODO     = v_periodo
                       AND   MES         = v_octubre
                       AND   ID_VERSION  = TO_CHAR(v_version_p)
                       AND ROWID NOT IN( SELECT A.ROWID FROM FECXP_REAL_CARATULA_H A,
                                                             FECXP_REAL_CARATULA_IMPNS B
                                           WHERE A.E_CODIGO=B.E_CODIGO
                                             AND A.PERIODO=B.PERIODO
                                             AND A.MES=B.MES
                                             AND B.UTILIZAR_REPORTE='S');
                  WHEN v_contador_p = 11 THEN
                       v_noviembre := 11;
                       v_ultimo_mes_reales:=11;
                       INSERT INTO FECXC.FECXP_FORECAST_NS            (E_CODIGO, DES_EMPRESA, ID_SESION_RC, PERIODO, MES, MONEDA, TIPO_CAMBIO, CLA_FE_ID, CLA_FE_DES,
                                                                     IMPORTE_LINEA, ESTATUS, TIPO_CARATULA,ID_VERSION,TIPO_PPTO_REAL,TIPO_EMPRESA)
                       SELECT                                         E_CODIGO, DES_EMPRESA, ID_SESION_RC, PERIODO, MES, MONEDA, TIPO_CAMBIO, CLA_FE_ID, CLA_FE_DES,
                                                                     IMPORTE_LINEA, ESTATUS, TIPO_CARATULA,ID_VERSION,'R','SET'
                       FROM FECXC.FECXP_REAL_CARATULA_H
                       WHERE PERIODO     = v_periodo
                       AND   MES         = v_noviembre
                       AND   ID_VERSION  = TO_CHAR(v_version_p)
                       AND ROWID NOT IN( SELECT A.ROWID FROM FECXP_REAL_CARATULA_H A,
                                                             FECXP_REAL_CARATULA_IMPNS B
                                           WHERE A.E_CODIGO=B.E_CODIGO
                                             AND A.PERIODO=B.PERIODO
                                             AND A.MES=B.MES
                                             AND B.UTILIZAR_REPORTE='S');
                  WHEN v_contador_p = 12 THEN
                       v_diciembre := 12;
                       v_ultimo_mes_reales:=12;
                       INSERT INTO FECXC.FECXP_FORECAST_NS            (E_CODIGO, DES_EMPRESA, ID_SESION_RC, PERIODO, MES, MONEDA, TIPO_CAMBIO, CLA_FE_ID, CLA_FE_DES,
                                                                     IMPORTE_LINEA, ESTATUS, TIPO_CARATULA,ID_VERSION,TIPO_PPTO_REAL,TIPO_EMPRESA)
                       SELECT                                         E_CODIGO, DES_EMPRESA, ID_SESION_RC, PERIODO, MES, MONEDA, TIPO_CAMBIO, CLA_FE_ID, CLA_FE_DES,
                                                                     IMPORTE_LINEA, ESTATUS, TIPO_CARATULA,ID_VERSION,'R','SET'
                       FROM FECXC.FECXP_REAL_CARATULA_H
                       WHERE PERIODO     = v_periodo
                       AND   MES         = v_diciembre
                       AND   ID_VERSION  = TO_CHAR(v_version_p)
                       AND ROWID NOT IN( SELECT A.ROWID FROM FECXP_REAL_CARATULA_H A,
                                                             FECXP_REAL_CARATULA_IMPNS B
                                           WHERE A.E_CODIGO=B.E_CODIGO
                                             AND A.PERIODO=B.PERIODO
                                             AND A.MES=B.MES
                                             AND B.UTILIZAR_REPORTE='S');
              END CASE;
          END IF;
           v_contador_p := v_contador_p + 1 ;
           COMMIT;
     END LOOP ;
     -----PARA EL PRESUPUESTO  de HISTORICOS---------------------------
     INSERT INTO FECXC.FECXP_FORECAST_NS                 (E_CODIGO, DES_EMPRESA, ID_SESION_RC, PERIODO, MES, MONEDA, TIPO_CAMBIO, CLA_FE_ID, CLA_FE_DES,
                                                         IMPORTE_LINEA, ESTATUS, TIPO_CARATULA,ID_VERSION,TIPO_PPTO_REAL,TIPO_EMPRESA)
     SELECT                                              E_CODIGO, DES_EMPRESA, ID_SESION_PC, PERIODO, MES, MONEDA, TIPO_CAMBIO, CLA_FE_ID, CLA_FE_DES,
                                                         IMPORTE_LINEA, ESTATUS,''            ,ID_VERSION,'P','SET'
     FROM FECXC.FECXP_PPTO_CARATULA_H
     WHERE PERIODO     = v_periodo
     --AND   ID_VERSION  = v_periodo||LPAD(TO_CHAR(v_version_ppto_h,2,'0')
     AND   ID_VERSION  = v_periodo||v_version_ppto_h
     AND MES NOT IN (v_enero,v_febrero,v_marzo,v_abril,v_mayo,v_junio,v_julio,v_agosto,v_septiembre,v_octubre,v_noviembre,v_diciembre)
     AND ROWID NOT IN( SELECT A.ROWID FROM FECXP_REAL_CARATULA_H A,
                                           FECXP_PPTO_CARATULA_IMPNS B
                                           WHERE A.E_CODIGO=B.E_CODIGO
                                             AND A.PERIODO=B.PERIODO
                                             AND A.MES=B.MES
                                             AND B.UTILIZAR_REPORTE='S');
    COMMIT;
    ----------------------------------------------------------------------------------------------------------------------------------
 -------Reiniciamos variables para  llenar con informacion de las Empresas NO SET ----------------------------------------
             v_version_p    :=0;
             v_token_p      :='';
             v_contador_p   := 1 ;--para recorrer las versiones
             v_enero        :=0;
             v_febrero      :=0;
             v_marzo        :=0;
             v_abril        :=0;
             v_mayo         :=0;
             v_junio        :=0;
             v_julio        :=0;
             v_agosto       :=0;
             v_septiembre   :=0;
             v_octubre      :=0;
             v_noviembre    :=0;
             v_diciembre    :=0;
             v_ultimo_mes_reales :=0;
             v_contador_ppto :=0;
      ---PARA EL REAL de NO SET---------------------------
     LOOP
           v_token_p := FECXC.FECXP_STRINGTOKENIZER( v_versiones_real_ns , v_contador_p  , ',') ;
           EXIT WHEN v_token_p IS NULL ;
          IF v_token_p !=0 THEN
              --TO_CHAR(v_version_p):=TO_NUMBER(v_periodo||LPAD(v_token_p,2,'0'));
              v_version_p:=TO_NUMBER(v_periodo||v_token_p);
              dbms_output.put_line('NO SET MES->'||v_contador_p||' ID_VERSION->'||TO_CHAR(v_version_p)) ;
              CASE
                  WHEN v_contador_p = 1  THEN
                       v_enero := 1 ;
                       v_ultimo_mes_reales:=1;
                       INSERT INTO FECXC.FECXP_FORECAST_NS            (E_CODIGO, DES_EMPRESA, ID_SESION_RC, PERIODO, MES, MONEDA, TIPO_CAMBIO, CLA_FE_ID, CLA_FE_DES,
                                                                     IMPORTE_LINEA, ESTATUS, TIPO_CARATULA,ID_VERSION,TIPO_PPTO_REAL,TIPO_EMPRESA)
                       SELECT                                         E_CODIGO, DES_EMPRESA, ID_SESION_RC, PERIODO, MES, MONEDA, TIPO_CAMBIO, CLA_FE_ID, CLA_FE_DES,
                                                                     IMPORTE_LINEA, ESTATUS, TIPO_CARATULA,ID_VERSION,'R','NO SET'
                       FROM FECXC.FECXP_REAL_CARATULA_IMPNS
                       WHERE PERIODO     = v_periodo
                       AND   MES         = v_enero
                       AND   ID_VERSION  = TO_CHAR(v_version_p)
                       AND   UTILIZAR_REPORTE='S';
                       WHEN v_contador_p = 2  THEN
                       v_febrero   := 2;
                       v_ultimo_mes_reales:=2;
                       INSERT INTO FECXC.FECXP_FORECAST_NS            (E_CODIGO, DES_EMPRESA, ID_SESION_RC, PERIODO, MES, MONEDA, TIPO_CAMBIO, CLA_FE_ID, CLA_FE_DES,
                                                                     IMPORTE_LINEA, ESTATUS, TIPO_CARATULA,ID_VERSION,TIPO_PPTO_REAL,TIPO_EMPRESA)
                       SELECT                                         E_CODIGO, DES_EMPRESA, ID_SESION_RC, PERIODO, MES, MONEDA, TIPO_CAMBIO, CLA_FE_ID, CLA_FE_DES,
                                                                     IMPORTE_LINEA, ESTATUS, TIPO_CARATULA,ID_VERSION,'R','NO SET'
                       FROM FECXC.FECXP_REAL_CARATULA_IMPNS
                       WHERE PERIODO     = v_periodo
                       AND   MES         = v_febrero
                       AND   ID_VERSION  = TO_CHAR(v_version_p)
                       AND   UTILIZAR_REPORTE='S';
                  WHEN v_contador_p = 3  THEN
                       v_marzo     := 3;
                       v_ultimo_mes_reales:=3;
                       INSERT INTO FECXC.FECXP_FORECAST_NS            (E_CODIGO, DES_EMPRESA, ID_SESION_RC, PERIODO, MES, MONEDA, TIPO_CAMBIO, CLA_FE_ID, CLA_FE_DES,
                                                                     IMPORTE_LINEA, ESTATUS, TIPO_CARATULA,ID_VERSION,TIPO_PPTO_REAL,TIPO_EMPRESA)
                       SELECT                                         E_CODIGO, DES_EMPRESA, ID_SESION_RC, PERIODO, MES, MONEDA, TIPO_CAMBIO, CLA_FE_ID, CLA_FE_DES,
                                                                     IMPORTE_LINEA, ESTATUS, TIPO_CARATULA,ID_VERSION,'R','NO SET'
                       FROM FECXC.FECXP_REAL_CARATULA_IMPNS
                       WHERE PERIODO     = v_periodo
                       AND   MES         = v_marzo
                       AND   ID_VERSION  = TO_CHAR(v_version_p)
                       AND   UTILIZAR_REPORTE='S';
                  WHEN v_contador_p = 4  THEN
                       v_abril     := 4;
                       v_ultimo_mes_reales:=4;
                       INSERT INTO FECXC.FECXP_FORECAST_NS            (E_CODIGO, DES_EMPRESA, ID_SESION_RC, PERIODO, MES, MONEDA, TIPO_CAMBIO, CLA_FE_ID, CLA_FE_DES,
                                                                     IMPORTE_LINEA, ESTATUS, TIPO_CARATULA,ID_VERSION,TIPO_PPTO_REAL,TIPO_EMPRESA)
                       SELECT                                         E_CODIGO, DES_EMPRESA, ID_SESION_RC, PERIODO, MES, MONEDA, TIPO_CAMBIO, CLA_FE_ID, CLA_FE_DES,
                                                                     IMPORTE_LINEA, ESTATUS, TIPO_CARATULA,ID_VERSION,'R','NO SET'
                       FROM FECXC.FECXP_REAL_CARATULA_IMPNS
                       WHERE PERIODO     = v_periodo
                       AND   MES         = v_abril
                       AND   ID_VERSION  = TO_CHAR(v_version_p)
                       AND   UTILIZAR_REPORTE='S';
                  WHEN v_contador_p = 5  THEN
                       v_mayo      := 5;
                       v_ultimo_mes_reales:=5;
                       INSERT INTO FECXC.FECXP_FORECAST_NS            (E_CODIGO, DES_EMPRESA, ID_SESION_RC, PERIODO, MES, MONEDA, TIPO_CAMBIO, CLA_FE_ID, CLA_FE_DES,
                                                                     IMPORTE_LINEA, ESTATUS, TIPO_CARATULA,ID_VERSION,TIPO_PPTO_REAL,TIPO_EMPRESA)
                       SELECT                                         E_CODIGO, DES_EMPRESA, ID_SESION_RC, PERIODO, MES, MONEDA, TIPO_CAMBIO, CLA_FE_ID, CLA_FE_DES,
                                                                     IMPORTE_LINEA, ESTATUS, TIPO_CARATULA,ID_VERSION,'R','NO SET'
                       FROM FECXC.FECXP_REAL_CARATULA_IMPNS
                       WHERE PERIODO     = v_periodo
                       AND   MES         = v_mayo
                       AND   ID_VERSION  = TO_CHAR(v_version_p)
                       AND   UTILIZAR_REPORTE='S';
                  WHEN v_contador_p = 6  THEN
                       v_junio     := 6;
                       v_ultimo_mes_reales:=6;
                       INSERT INTO FECXC.FECXP_FORECAST_NS            (E_CODIGO, DES_EMPRESA, ID_SESION_RC, PERIODO, MES, MONEDA, TIPO_CAMBIO, CLA_FE_ID, CLA_FE_DES,
                                                                     IMPORTE_LINEA, ESTATUS, TIPO_CARATULA,ID_VERSION,TIPO_PPTO_REAL,TIPO_EMPRESA)
                       SELECT                                         E_CODIGO, DES_EMPRESA, ID_SESION_RC, PERIODO, MES, MONEDA, TIPO_CAMBIO, CLA_FE_ID, CLA_FE_DES,
                                                                     IMPORTE_LINEA, ESTATUS, TIPO_CARATULA,ID_VERSION,'R','NO SET'
                       FROM FECXC.FECXP_REAL_CARATULA_IMPNS
                       WHERE PERIODO     = v_periodo
                       AND   MES         = v_junio
                       AND   ID_VERSION  = TO_CHAR(v_version_p)
                       AND   UTILIZAR_REPORTE='S';
                  WHEN v_contador_p = 7  THEN
                       v_julio     := 7;
                       v_ultimo_mes_reales:=7;
                       INSERT INTO FECXC.FECXP_FORECAST_NS            (E_CODIGO, DES_EMPRESA, ID_SESION_RC, PERIODO, MES, MONEDA, TIPO_CAMBIO, CLA_FE_ID, CLA_FE_DES,
                                                                     IMPORTE_LINEA, ESTATUS, TIPO_CARATULA,ID_VERSION,TIPO_PPTO_REAL,TIPO_EMPRESA)
                       SELECT                                         E_CODIGO, DES_EMPRESA, ID_SESION_RC, PERIODO, MES, MONEDA, TIPO_CAMBIO, CLA_FE_ID, CLA_FE_DES,
                                                                     IMPORTE_LINEA, ESTATUS, TIPO_CARATULA,ID_VERSION,'R','NO SET'
                       FROM FECXC.FECXP_REAL_CARATULA_IMPNS
                       WHERE PERIODO     = v_periodo
                       AND   MES         = v_julio
                       AND   ID_VERSION  = TO_CHAR(v_version_p)
                       AND   UTILIZAR_REPORTE='S';
                  WHEN v_contador_p = 8  THEN
                       v_agosto    := 8;
                       v_ultimo_mes_reales:=8;
                       INSERT INTO FECXC.FECXP_FORECAST_NS            (E_CODIGO, DES_EMPRESA, ID_SESION_RC, PERIODO, MES, MONEDA, TIPO_CAMBIO, CLA_FE_ID, CLA_FE_DES,
                                                                     IMPORTE_LINEA, ESTATUS, TIPO_CARATULA,ID_VERSION,TIPO_PPTO_REAL,TIPO_EMPRESA)
                       SELECT                                         E_CODIGO, DES_EMPRESA, ID_SESION_RC, PERIODO, MES, MONEDA, TIPO_CAMBIO, CLA_FE_ID, CLA_FE_DES,
                                                                     IMPORTE_LINEA, ESTATUS, TIPO_CARATULA,ID_VERSION,'R','NO SET'
                       FROM FECXC.FECXP_REAL_CARATULA_IMPNS
                       WHERE PERIODO     = v_periodo
                       AND   MES         = v_agosto
                       AND   ID_VERSION  = TO_CHAR(v_version_p)
                       AND   UTILIZAR_REPORTE='S';
                  WHEN v_contador_p = 9  THEN
                       v_septiembre:= 9;
                       v_ultimo_mes_reales:=9;
                       INSERT INTO FECXC.FECXP_FORECAST_NS            (E_CODIGO, DES_EMPRESA, ID_SESION_RC, PERIODO, MES, MONEDA, TIPO_CAMBIO, CLA_FE_ID, CLA_FE_DES,
                                                                     IMPORTE_LINEA, ESTATUS, TIPO_CARATULA,ID_VERSION,TIPO_PPTO_REAL,TIPO_EMPRESA)
                       SELECT                                         E_CODIGO, DES_EMPRESA, ID_SESION_RC, PERIODO, MES, MONEDA, TIPO_CAMBIO, CLA_FE_ID, CLA_FE_DES,
                                                                     IMPORTE_LINEA, ESTATUS, TIPO_CARATULA,ID_VERSION,'R','NO SET'
                       FROM FECXC.FECXP_REAL_CARATULA_IMPNS
                       WHERE PERIODO     = v_periodo
                       AND   MES         = v_septiembre
                       AND   ID_VERSION  = TO_CHAR(v_version_p)
                       AND   UTILIZAR_REPORTE='S';
                  WHEN v_contador_p = 10 THEN
                       v_octubre   := 10;
                       v_ultimo_mes_reales:=10;
                       INSERT INTO FECXC.FECXP_FORECAST_NS            (E_CODIGO, DES_EMPRESA, ID_SESION_RC, PERIODO, MES, MONEDA, TIPO_CAMBIO, CLA_FE_ID, CLA_FE_DES,
                                                                     IMPORTE_LINEA, ESTATUS, TIPO_CARATULA,ID_VERSION,TIPO_PPTO_REAL,TIPO_EMPRESA)
                       SELECT                                         E_CODIGO, DES_EMPRESA, ID_SESION_RC, PERIODO, MES, MONEDA, TIPO_CAMBIO, CLA_FE_ID, CLA_FE_DES,
                                                                     IMPORTE_LINEA, ESTATUS, TIPO_CARATULA,ID_VERSION,'R','NO SET'
                       FROM FECXC.FECXP_REAL_CARATULA_IMPNS
                       WHERE PERIODO     = v_periodo
                       AND   MES         = v_octubre
                       AND   ID_VERSION  = TO_CHAR(v_version_p)
                       AND   UTILIZAR_REPORTE='S';
                  WHEN v_contador_p = 11 THEN
                       v_noviembre := 11;
                       v_ultimo_mes_reales:=11;
                       INSERT INTO FECXC.FECXP_FORECAST_NS            (E_CODIGO, DES_EMPRESA, ID_SESION_RC, PERIODO, MES, MONEDA, TIPO_CAMBIO, CLA_FE_ID, CLA_FE_DES,
                                                                     IMPORTE_LINEA, ESTATUS, TIPO_CARATULA,ID_VERSION,TIPO_PPTO_REAL,TIPO_EMPRESA)
                       SELECT                                         E_CODIGO, DES_EMPRESA, ID_SESION_RC, PERIODO, MES, MONEDA, TIPO_CAMBIO, CLA_FE_ID, CLA_FE_DES,
                                                                     IMPORTE_LINEA, ESTATUS, TIPO_CARATULA,ID_VERSION,'R','NO SET'
                       FROM FECXC.FECXP_REAL_CARATULA_IMPNS
                       WHERE PERIODO     = v_periodo
                       AND   MES         = v_noviembre
                       AND   ID_VERSION  = TO_CHAR(v_version_p)
                       AND   UTILIZAR_REPORTE='S';
                  WHEN v_contador_p = 12 THEN
                       v_diciembre := 12;
                       v_ultimo_mes_reales:=12;
                       INSERT INTO FECXC.FECXP_FORECAST_NS            (E_CODIGO, DES_EMPRESA, ID_SESION_RC, PERIODO, MES, MONEDA, TIPO_CAMBIO, CLA_FE_ID, CLA_FE_DES,
                                                                     IMPORTE_LINEA, ESTATUS, TIPO_CARATULA,ID_VERSION,TIPO_PPTO_REAL,TIPO_EMPRESA)
                       SELECT                                         E_CODIGO, DES_EMPRESA, ID_SESION_RC, PERIODO, MES, MONEDA, TIPO_CAMBIO, CLA_FE_ID, CLA_FE_DES,
                                                                     IMPORTE_LINEA, ESTATUS, TIPO_CARATULA,ID_VERSION,'R','NO SET'
                       FROM FECXC.FECXP_REAL_CARATULA_IMPNS
                       WHERE PERIODO     = v_periodo
                       AND   MES         = v_diciembre
                       AND   ID_VERSION  = TO_CHAR(v_version_p)
                       AND   UTILIZAR_REPORTE='S';
              END CASE;
          END IF;
           v_contador_p := v_contador_p + 1 ;
           COMMIT;
     END LOOP ;
       -----PARA EL PRESUPUESTO de NO SET---------------------------
     INSERT INTO FECXC.FECXP_FORECAST_NS                 (E_CODIGO, DES_EMPRESA, ID_SESION_RC, PERIODO, MES, MONEDA, TIPO_CAMBIO, CLA_FE_ID, CLA_FE_DES,
                                                         IMPORTE_LINEA, ESTATUS, TIPO_CARATULA,ID_VERSION,TIPO_PPTO_REAL,TIPO_EMPRESA)
     SELECT                                              E_CODIGO, DES_EMPRESA, ID_SESION_PC, PERIODO, MES, MONEDA, TIPO_CAMBIO, CLA_FE_ID, CLA_FE_DES,
                                                         IMPORTE_LINEA, ESTATUS,'',ID_VERSION,'P','NO SET'
     FROM FECXC.FECXP_PPTO_CARATULA_IMPNS
     WHERE PERIODO     = v_periodo
     AND   ID_VERSION  = v_periodo||v_version_ppto_NS
     AND MES NOT IN (v_enero,v_febrero,v_marzo,v_abril,v_mayo,v_junio,v_julio,v_agosto,v_septiembre,v_octubre,v_noviembre,v_diciembre);
     --Dbms_output.put_line('MESES DE PPTO->'||v_enero||v_febrero||v_marzo||v_abril||v_mayo||v_junio||v_julio||v_agosto||v_septiembre||v_octubre||v_noviembre||v_diciembre) ;
    COMMIT;
    ----------------------------------------------------------------------------------------------------------------------------------
   v_contador_ppto:=v_ultimo_mes_reales;
   v_contador_ppto:=0;
   v_ultimo_mes_reales:=0;
   v_ultimo_mes_reales:=v_ultimo_mes_reales+1;
   FOR IC IN v_ultimo_mes_reales..12 LOOP
    ----------PASAR EL SALDO FINAL DEL ULTIMO MES DE REALES AL PRIMERO DE PRESUPUESTO------------
    --dbms_output.put_line('ULTIMO MES DE REALES->'||v_contador_ppto||' PRIMER MES DE PRESUPUESTO->'||(v_contador_ppto+1)) ;
    IF (v_contador_ppto+1) >1 THEN --EXCEPTO ENERO
                    DELETE FECXC.FECXP_FORECAST_NS ---BORRAR LOS REGISTROS DE SALDOS INICIALES DEL PRIMER MES DE PRESUPUESTO
                    WHERE MES = (v_contador_ppto+1)
                    AND  CLA_FE_ID IN ('SI','SI COIN', 'SI INV');
                    --INSERTAR LOS REGISTROS DE SALDOS FINALES DEL ULTIMO MES DE REALES EN LOS DE SALDOS INICIALES DEL PRIMER MES DE PRESUPUESTO
                   INSERT INTO FECXC.FECXP_FORECAST_NS (E_CODIGO, DES_EMPRESA, ID_SESION_RC,
                                                       PERIODO, MES, MONEDA,
                                                       TIPO_CAMBIO, CLA_FE_ID, CLA_FE_DES,
                                                       IMPORTE_LINEA, ESTATUS, TIPO_CARATULA,
                                                       ID_VERSION, TIPO_PPTO_REAL, TIPO_EMPRESA)
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
                                                       ID_VERSION, TIPO_PPTO_REAL,TIPO_EMPRESA
                   FROM FECXC.FECXP_FORECAST_NS
                   WHERE MES = v_contador_ppto
                   AND  CLA_FE_ID IN ('SF','SF COIN', 'SF INV');
                   -- AND  CLA_FE_DES IN ('SDO INICIAL CHEQUERAS','SDO INICIAL COINVERSION','SDO INICIAL INVERSION');
                   COMMIT;
                    -----BORRAR EL SALDO FINAL DEL MES
                    DELETE FECXC.FECXP_FORECAST_NS ---BORRAR LOS REGISTROS DE SALDOS INICIALES DEL PRIMER MES DE PRESUPUESTO
                    WHERE MES = (v_contador_ppto+1)
                    AND  CLA_FE_ID IN ('SF','SF COIN', 'SF INV');
                    commit;
                   ---insertando saldos finales
                   INSERT INTO FECXC.FECXP_FORECAST_NS (E_CODIGO, DES_EMPRESA, ID_SESION_RC,
                                                       PERIODO, MES, MONEDA,
                                                       TIPO_CAMBIO, CLA_FE_ID, CLA_FE_DES,
                                                       IMPORTE_LINEA, ESTATUS, TIPO_CARATULA,
                                                       ID_VERSION, TIPO_PPTO_REAL, TIPO_EMPRESA)
                   SELECT
                                                       E_CODIGO, DES_EMPRESA, ID_SESION_RC,
                                                       PERIODO, (v_contador_ppto+1), MONEDA,
                                                       TIPO_CAMBIO,  CLA_FE_ID,
                                                                    CLA_FE_DES,
                                                       IMPORTE_LINEA, ESTATUS, TIPO_CARATULA,
                                                       ID_VERSION, TIPO_PPTO_REAL, TIPO_EMPRESA
                   FROM FECXC.FECXP_FORECAST_NS
                   WHERE MES = v_contador_ppto
                   AND  CLA_FE_ID IN ('SF','SF COIN', 'SF INV');
                   commit;
                   --insertando ==INCREMENTO NETO DE EFECTIVO DEL PERIODO como saldo final
                                 INSERT INTO FECXC.FECXP_FORECAST_NS (E_CODIGO,
                                                                     DES_EMPRESA,
                                                                     ID_SESION_RC,
                                                                     PERIODO, MES, MONEDA,
                                                                     TIPO_CAMBIO, CLA_FE_ID, CLA_FE_DES,
                                                                     IMPORTE_LINEA, ESTATUS, TIPO_CARATULA,
                                                                     ID_VERSION, TIPO_PPTO_REAL,TIPO_EMPRESA)
                                          SELECT     distinct        EMPRESA_COD,
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
                                                                     C.TIPO_EMPRESA
                                            FROM    (
                                                                SELECT  B.ID_SEG   SEGMENTO_EMPRESA_COD,
                                                                        B.DESC_SEG SEGMENTO_EMPRESA_DES,
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
                                                                        ID_SESION_RC,
                                                                        C.TIPO_EMPRESA
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
                                                                                ID_VERSION ,
                                                                                ID_SESION_RC,
                                                                                C.TIPO_EMPRESA
                                                                        FROM    FECXC.FECXP_FORECAST_NS C
                                                                        WHERE   C.MES= (v_contador_ppto+1)
                                                                        AND  PERIODO=V_PERIODO
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
                                                                                 ID_VERSION,
                                                                                 ID_SESION_RC,
                                                                                 C.TIPO_EMPRESA
                                                                        FROM    FECXC.FECXP_FORECAST_NS C
                                                                        WHERE   C.MES= (v_contador_ppto+1)
                                                                        AND  PERIODO=V_PERIODO
                                                                        ) C,
                                                                        FECXC.FECXP_CLASIFICACION_FE F,
                                                                       FECXC.FECXP_EMP_X_SEGMENTO_NO_SET  A,
                                                                       FECXC.FECXP_SEG_NO_SET B,
                                                                       FECXC.FECXP_MONEDAS_NO_SET M
                                                                WHERE    C.CLA_FE_ID = F.CLA_FE_ID
                                                                AND        C.PERIODO <= TO_NUMBER(TO_CHAR(SYSDATE,'YYYY'))
                                                                AND        F.CLA_ATRIBUTO4 IN ('01 ACTIVIDADES DE INVERSION','01 ACTIVIDADES DE FINANCIAMIENTO','01 INGRESOS OPERATIVOS','02 EGRESOS OPERATIVOS')
                                                                AND        A.ID_SEGMENTO NOT IN (11, 15, 17,18, 20, 26, 6, 13, 25)
                                                                AND        A.ID_SEGMENTO = B.ID_SEG
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
                                                                GROUP BY B.ID_SEG,
                                                                        B.DESC_SEG,
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
                                                                        ID_SESION_RC,
                                                                        C.TIPO_EMPRESA) C;
                        commit;
                    v_contador_ppto:=v_contador_ppto+1;
    ELSE  ---SOLO ENERO
                    DELETE FECXP_FORECAST_NS ---BORRAR LOS REGISTROS DE SALDOS INICIALES DEL MES DE ENERO
                    WHERE MES = 1
                    AND  CLA_FE_ID IN ('SF','SF COIN', 'SF INV');
                    COMMIT;
                   --INSERTAR LOS REGISTROS DE SALDOS INICIALES DE ENERO COMO FINALES ENERO
                   INSERT INTO FECXC.FECXP_FORECAST_NS (E_CODIGO, DES_EMPRESA, ID_SESION_RC,
                                                       PERIODO, MES, MONEDA,
                                                       TIPO_CAMBIO, CLA_FE_ID, CLA_FE_DES,
                                                       IMPORTE_LINEA, ESTATUS, TIPO_CARATULA,
                                                       ID_VERSION, TIPO_PPTO_REAL, TIPO_EMPRESA)
                   SELECT
                                                       E_CODIGO, DES_EMPRESA, ID_SESION_RC,
                                                       PERIODO, 1, MONEDA,
                                                       TIPO_CAMBIO, DECODE (CLA_FE_ID, 'SI','SF',
                                                                                       'SI INV','SF INV',
                                                                                       'SI COIN','SF COIN',cla_fe_id),
                                                                    DECODE (CLA_FE_DES,'SDO INICIAL CHEQUERAS','SDO FINAL CHEQUERAS',
                                                                                       'SDO INICIAL INVERSION','SDO FINAL INVERSION',
                                                                                       'SDO INICIAL COINVERSION','SDO FINAL COINVERSION',
                                                                                       'SALDO INICIAL','SALDO FINAL',CLA_FE_DES),
                                                       IMPORTE_LINEA, ESTATUS, TIPO_CARATULA,
                                                       ID_VERSION, TIPO_PPTO_REAL, TIPO_EMPRESA
                   FROM FECXC.FECXP_FORECAST_NS
                   WHERE MES = 1
                   AND  CLA_FE_ID IN ('SI','SI COIN', 'SI INV');
                   COMMIT;
                   ---insertando ==INCREMENTO NETO DE EFECTIVO DEL PERIODO como saldo final
                   INSERT INTO FECXC.FECXP_FORECAST_NS (             E_CODIGO,
                                                                     DES_EMPRESA,
                                                                     ID_SESION_RC,
                                                                     PERIODO, MES, MONEDA,
                                                                     TIPO_CAMBIO, CLA_FE_ID, CLA_FE_DES,
                                                                     IMPORTE_LINEA, ESTATUS, TIPO_CARATULA,
                                                                     ID_VERSION, TIPO_PPTO_REAL,TIPO_EMPRESA)
                                          SELECT     distinct        EMPRESA_COD,
                                                                     EMPRESA_DES,
                                                                     C.ID_SESION_RC,
                                                                     C.PERIODO,
                                                                     1,
                                                                     C.MONEDA,
                                                                     C.TIPO_CAMBIO,
                                                                     'SF' AS CLA_FE_ID,
                                                                     'SALDO FINAL' AS CLA_FE_DES,
                                                                     C.REAL_MON_ORIGEN,
                                                                     C.ESTATUS,
                                                                     C.TIPO_CARATULA,
                                                                     C.ID_VERSION,
                                                                     'P',
                                                                     C.TIPO_EMPRESA
                                            FROM    (
                                                                SELECT    B.ID_SEG SEGMENTO_EMPRESA_COD,
                                                                          B.DESC_SEG SEGMENTO_EMPRESA_DES,
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
                                                                        ID_SESION_RC,
                                                                        C.TIPO_EMPRESA
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
                                                                                ID_VERSION ,
                                                                                ID_SESION_RC,
                                                                                C.TIPO_EMPRESA
                                                                        FROM    FECXC.FECXP_FORECAST_NS C
                                                                        WHERE   C.MES= 1
                                                                        AND  PERIODO= V_PERIODO
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
                                                                                 ID_VERSION,
                                                                                 ID_SESION_RC,
                                                                                C.TIPO_EMPRESA
                                                                        FROM    FECXC.FECXP_FORECAST_NS C
                                                                        WHERE   C.MES= 1
                                                                        AND  PERIODO= V_PERIODO
                                                                        ) C,
                                                                        FECXC.FECXP_CLASIFICACION_FE F,
                                                                       FECXC.FECXP_EMP_X_SEGMENTO_NO_SET  A,
                                                                       FECXC.FECXP_SEG_NO_SET B,
                                                                       FECXC.FECXP_MONEDAS_NO_SET M
                                                                WHERE    C.CLA_FE_ID = F.CLA_FE_ID
                                                                AND        C.PERIODO <= TO_NUMBER(TO_CHAR(SYSDATE,'YYYY'))
                                                                AND        F.CLA_ATRIBUTO4 IN ('01 ACTIVIDADES DE INVERSION','01 ACTIVIDADES DE FINANCIAMIENTO','01 INGRESOS OPERATIVOS','02 EGRESOS OPERATIVOS')
                                                                AND        A.ID_SEGMENTO NOT IN (11, 15, 17,18, 20, 26, 6, 13, 25)
                                                                AND        A.ID_SEGMENTO = B.ID_SEG
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
                                                                GROUP BY B.ID_SEG,
                                                                        B.DESC_SEG,
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
                                                                        ID_SESION_RC,
                                                                         C.TIPO_EMPRESA) C;
                        commit;
                    v_contador_ppto:=v_contador_ppto+1;
    END IF;
    END LOOP;
UPDATE FECXP_PPTO_EXTRACCION_PARAMS
       SET ESTATUS_PROCESO = 'INACTIVO',ESTATUS_EXT_ULT_EJECUCION= 'EXITOSO'
       WHERE PROCESO_ID =20;
-------------------------BITACORA-----------------------------------------------------------------------------------------------------------------
INSERT INTO FECXC.BITACORA_FORECAST_NS (
   FECHA_CREACION, VER_ENE_HIST, VER_FEB_HIST,
   VER_MAR_HIST, VER_ABR_HIST, VER_MAY_HIST,
   VER_JUN_HIST, VER_JUL_HIST, VER_AGO_HIST,
   VER_SEP_HIST, VER_OCT_HIST, VER_NOV_HIST,
   VER_DIC_HIST, VER_ENE_NS, VER_FEB_NS,
   VER_MAR_NS, VER_ABR_NS, VER_MAY_NS,
   VER_JUN_NS, VER_JUL_NS, VER_AGO_NS,
   VER_SEP_NS, VER_OCT_NS, VER_NOV_NS,
   VER_DIC_NS,PPTO_HIST ,PPTO_NS,  COMENTARIO, USUARIO)
VALUES (SYSDATE ,v_periodo||SUBSTR(v_versiones_real_h,0,1) , v_periodo||SUBSTR(v_versiones_real_h,3,1),
 v_periodo||SUBSTR(v_versiones_real_h,5,1),v_periodo||SUBSTR(v_versiones_real_h,7,1) ,v_periodo||SUBSTR(v_versiones_real_h,9,1) ,
 v_periodo||SUBSTR(v_versiones_real_h,11,1),v_periodo||SUBSTR(v_versiones_real_h,13,1),v_periodo||SUBSTR(v_versiones_real_h,15,1) ,
 v_periodo||SUBSTR(v_versiones_real_h,17,1),v_periodo||SUBSTR(v_versiones_real_h,19,1),v_periodo||SUBSTR(v_versiones_real_h,21,1),
 v_periodo||SUBSTR(v_versiones_real_h,23,1),v_periodo||SUBSTR(v_versiones_real_ns,0,1) , v_periodo||SUBSTR(v_versiones_real_ns,3,1),
 v_periodo||SUBSTR(v_versiones_real_ns,5,1),v_periodo||SUBSTR(v_versiones_real_ns,7,1) ,v_periodo||SUBSTR(v_versiones_real_ns,9,1) ,
 v_periodo||SUBSTR(v_versiones_real_ns,11,1),v_periodo||SUBSTR(v_versiones_real_ns,13,1),v_periodo||SUBSTR(v_versiones_real_ns,15,1) ,
 v_periodo||SUBSTR(v_versiones_real_ns,17,1),v_periodo||SUBSTR(v_versiones_real_ns,19,1),v_periodo||SUBSTR(v_versiones_real_ns,21,1),
 v_periodo||SUBSTR(v_versiones_real_ns,23,1),to_number(to_char(v_periodo)||to_char(v_version_ppto_h)),to_number(to_char(v_periodo)||to_char(v_version_ppto_ns)),v_comentario,v_usuario);
--------------------------------------------------------------------------------------------------------------------------------------------------
dbms_output.put_line('TERMINO '||TO_CHAR(SYSDATE,'DD-MM-YYYY HH:MM:SS')) ;
COMMIT;
EXCEPTION
 WHEN OTHERS THEN
       v_error_num:= SQLERRM;
       v_error_code:= SQLCODE;
      UPDATE FECXP_PPTO_EXTRACCION_PARAMS
       SET ESTATUS_PROCESO = 'INACTIVO',ESTATUS_EXT_ULT_EJECUCION= 'ERROR' ,
                 ATRIBUTO2 = 'An error was encountered - '||v_error_code||' -ERROR- '||v_error_num
       WHERE PROCESO_ID =20;
     raise_application_error(-20001,'An error was encountered - '||SQLCODE||' -ERROR- '||SQLERRM);
     ROLLBACK;
END;
/
