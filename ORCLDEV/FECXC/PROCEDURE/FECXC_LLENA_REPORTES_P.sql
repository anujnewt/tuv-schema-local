CREATE OR REPLACE EDITIONABLE PROCEDURE "FECXC"."FECXC_LLENA_REPORTES_P" 
(
p_ANIO                 IN NUMBER,
p_MES              IN NUMBER,
p_FECHA           IN DATE,
p_TIPO              IN NUMBER,
p_INPC              IN NUMBER,
p_FORMATO           IN NUMBER,
p_MENSUALIZADO       IN NUMBER,
p_SEGMENTOSESP       IN NUMBER
)
IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
v_MONLOC             varchar2(2);
v_INPC                  number(20,11);
v_INPC2                  number(20,11);
tcp_actualizado         number(20,11);
tcp_actualizado_dos         number(20,11);
no_hubo_inpc       exception;
tipo_reporte_inpc varchar2(50);
t_count                 number;
t_countdos              number;
t_cobranzames_act       number;
t_cobranzames_act_dos   number;
t_min                   number;
t_min_dos               number;
/*
// Modificaci?n: p_INPC recibir? el valor 2 para los reportes con valores nominales y reales, se agregar?n columnas para valores noinales/reales.
// Se hace modificaci?n para reporte de tvlocal, intermex y canales
// Fecha:29-Mayo-2008
// Oscar Reyes ORM
*/
BEGIN
IF p_INPC = 1 THEN
   tipo_reporte_inpc := 'CIF.ACTUALIZADAS';
   select INPC_ACTUAL
   into v_INPC
   from FECXC_INPC
   WHERE ANO_INPC = p_ANIO
        AND MES_INPC = p_MES;
ELSIF p_INPC = 0 THEN
  tipo_reporte_inpc := 'CIFRAS NOMINALES';
  v_INPC := 1;
ELSE
    /*ORM incluye AMBAS opciones Se calcular? la cifra nominal y la real */
   tipo_reporte_inpc := 'CIF.ACT. Y NOM.';
   /*Para el tipo 1 las cifras actuales se calcular?n nominales y las que se adicionan como reales*/
   IF p_TIPO = 1 THEN
           v_INPC := 1;
        select INPC_ACTUAL
           into v_INPC2
           from FECXC_INPC
           WHERE ANO_INPC = p_ANIO
            AND MES_INPC = p_MES;
   else
   /*Para el tipo 2  y 3 se calcular?n cifras reales y se adicionan las nominales*/
        select INPC_ACTUAL
        INTO v_INPC
        from FECXC_INPC
        WHERE ANO_INPC = p_ANIO
            AND MES_INPC = p_MES;
        v_INPC2 := 1;
   end if;
END IF;
IF p_MENSUALIZADO = 0 THEN
   tipo_reporte_inpc := tipo_reporte_inpc || '-MENSUALIZADO';
ELSE
   tipo_reporte_inpc := tipo_reporte_inpc || '-A LA FECHA';
END IF;
IF p_TIPO = 1  THEN
   /***************************************************************************************************************************
                L L E N A D O   D E   E S T R U C T U R A   P A R A   T V   L O C A L
   ***************************************************************************************************************************/
    DELETE FECXC_COBRANZA_DELDIA;
    DELETE FECXC_COBRANZA_DELMES;
    DELETE FECXC_COBRANZA_ALAFECHA;
    DELETE FECXC_PRESUP_DELMES;
    DELETE FECXC_COBRANZA_ANTERIOR;
    DELETE FECXC_PRESUP_ALAFECHA;
    DELETE FECXC_PARAMETROS_TVLOCAL;
    INSERT INTO FECXC_PARAMETROS_TVLOCAL(ANIO,MES,FECHA,ACTUALIZADO)
    values (p_ANIO,p_MES,p_FECHA,tipo_reporte_inpc);
    /*LLENA COBRANZA DEL DIA */
    INSERT INTO FECXC_COBRANZA_DELDIA(E_CODIGO, SEGMENTO,CODMONEDA, COBRANZA_DIA)
    SELECT A.E_CODIGO, B.SEGMENTO1,C.CODMONEDA,
    sum(B.IMPORTE*(CASE
            WHEN p_SEGMENTOSESP = 0
               THEN 1
            ELSE
               CASE
                    WHEN F.COD_SEC_LIN IS NULL
                        THEN 1
                    WHEN F.COD_SEC_LIN IS NOT NULL AND F.SECMONEDA = (SELECT NVL(q.EQ_SIF,0) FROM AD_FECXC.FECXC_MONEDAS_EQUIVALENCIA q WHERE q.SECMONEDA = A.SECMONEDA)
                        THEN 1
                    WHEN F.COD_SEC_LIN IS NOT NULL AND F.SECMONEDA IN(22)
                         AND F.SECMONEDA <> (SELECT NVL(q.EQ_SIF,0) FROM AD_FECXC.FECXC_MONEDAS_EQUIVALENCIA q WHERE q.SECMONEDA = A.SECMONEDA)
                        THEN E.TIPO_CAMBIO
                    WHEN F.COD_SEC_LIN IS NOT NULL AND F.SECMONEDA NOT IN(22)
                         AND (SELECT NVL(q.EQ_SIF,0) FROM AD_FECXC.FECXC_MONEDAS_EQUIVALENCIA q WHERE q.SECMONEDA = A.SECMONEDA) = 22
                        THEN (SELECT TIPO_CAMBIO_DLS FROM FECXC_TPC WHERE FECHA_TPC = A.F_DEPOSITO AND SECMONEDA = F.SECMONEDA)
                    WHEN
                         F.COD_SEC_LIN IS NOT NULL
                         AND F.SECMONEDA NOT IN (22)
                         AND F.SECMONEDA <> (SELECT NVL(q.EQ_SIF,0) FROM AD_FECXC.FECXC_MONEDAS_EQUIVALENCIA q WHERE q.SECMONEDA = A.SECMONEDA)
                        THEN
                            (SELECT ROUND(CONVERSION_RATE,4)
                              FROM FECXC_TPC_MULTIMONEDA_VW
                              WHERE FROM_CURRENCY = (SELECT MON_ORACLE FROM AD_FECXC.FECXC_TPC_MULTIMONEDA WHERE SECMONEDA = (SELECT NVL(q.EQ_SIF,0) FROM AD_FECXC.FECXC_MONEDAS_EQUIVALENCIA q WHERE q.SECMONEDA = A.SECMONEDA))
                              AND TO_CURRENCY = (SELECT MON_ORACLE FROM AD_FECXC.FECXC_TPC_MULTIMONEDA WHERE SECMONEDA = F.SECMONEDA)
                              AND CONVERSION_DATE = A.F_DEPOSITO
                            )
                    ELSE 1
               END
       END))/p_FORMATO COBRANZA_DIA
       FROM FECXC_ENC_CLASIFICADOS A, FECXC_DET_CLASIFICADOS B, FECXC_MONEDAS C, FECXC_CALENDARIO_COB D,
            FECXC_TPC E,
            FECXC_SEGMULTIMON F
    WHERE   A.E_CODIGO = B.E_CODIGO
            AND A.COD_SEC_CLASIFICA = B.COD_SEC_CLASIFICA
            AND A.SECMONEDA = C.SECMONEDA
            AND A.F_DEPOSITO between D.FECHA_INICIO AND D.FECHA_FIN
            AND A.F_DEPOSITO = p_FECHA                 ---PARAMETRO DEL DIA
            AND EXISTS(SELECT 1 FROM FECXC_DET_CLASFECXC clas
                                WHERE B.COD_SEC_CATCLAS = clas.COD_SEC_CATCLAS
                                AND B.COD_SEC_DET = clas.COD_SEC_DET
                                AND clas.EXCLUIR_ENREPORTES = 'NO')
            AND A.SECMONEDA = E.SECMONEDA (+)
            AND A.F_DEPOSITO = E.FECHA_TPC (+)
            AND B.SEGMENTO1 = F.COD_SEC_LIN (+)
            group by A.E_CODIGO, B.SEGMENTO1, C.CODMONEDA;
    /*LLENA COBRANZA DEL MES */
    IF p_MENSUALIZADO = 0 THEN           /* MENSUALIZADO... */
        INSERT INTO FECXC_COBRANZA_DELMES(
           E_CODIGO, SEGMENTO,
           CODMONEDA, COBRANZA_MES)
        SELECT A.E_CODIGO, B.SEGMENTO1,C.CODMONEDA,
            sum(B.IMPORTE*(CASE
                WHEN p_SEGMENTOSESP = 0
                   THEN 1
                ELSE
                   CASE
                        WHEN F.COD_SEC_LIN IS NULL
                           THEN 1
                        WHEN F.COD_SEC_LIN IS NOT NULL AND F.SECMONEDA = (SELECT NVL(q.EQ_SIF,0) FROM AD_FECXC.FECXC_MONEDAS_EQUIVALENCIA q WHERE q.SECMONEDA = A.SECMONEDA)
                            AND (SELECT NVL(q.EQ_SIF,0) FROM AD_FECXC.FECXC_MONEDAS_EQUIVALENCIA q WHERE q.SECMONEDA = A.SECMONEDA) IN(22)
                           THEN DECODE(p_INPC,1,v_INPC/nvl(E.INPC_ACTUAL,v_INPC),1)
                        WHEN F.COD_SEC_LIN IS NOT NULL AND F.SECMONEDA = (SELECT NVL(q.EQ_SIF,0) FROM AD_FECXC.FECXC_MONEDAS_EQUIVALENCIA q WHERE q.SECMONEDA = A.SECMONEDA)
                            AND (SELECT NVL(q.EQ_SIF,0) FROM AD_FECXC.FECXC_MONEDAS_EQUIVALENCIA q WHERE q.SECMONEDA = A.SECMONEDA) NOT IN(22)
                           THEN 1
                        WHEN F.COD_SEC_LIN IS NOT NULL AND F.SECMONEDA IN(22)
                             AND F.SECMONEDA <> (SELECT NVL(q.EQ_SIF,0) FROM AD_FECXC.FECXC_MONEDAS_EQUIVALENCIA q WHERE q.SECMONEDA = A.SECMONEDA)
                           THEN E.TIPO_CAMBIO
                        WHEN F.COD_SEC_LIN IS NOT NULL AND F.SECMONEDA NOT IN(22)
                             AND (SELECT NVL(q.EQ_SIF,0) FROM AD_FECXC.FECXC_MONEDAS_EQUIVALENCIA q WHERE q.SECMONEDA = A.SECMONEDA) IN(22)
                           THEN (SELECT TIPO_CAMBIO_DLS FROM FECXC_TPC WHERE FECHA_TPC = A.F_DEPOSITO AND SECMONEDA = F.SECMONEDA) * DECODE(p_INPC,1,v_INPC/nvl(E.INPC_ACTUAL,v_INPC),1)
                        WHEN
                             F.COD_SEC_LIN IS NOT NULL
                             AND F.SECMONEDA NOT IN (22)
                             AND F.SECMONEDA <> (SELECT NVL(q.EQ_SIF,0) FROM AD_FECXC.FECXC_MONEDAS_EQUIVALENCIA q WHERE q.SECMONEDA = A.SECMONEDA)
                           THEN
                                (SELECT ROUND(CONVERSION_RATE,4)
                                  FROM FECXC_TPC_MULTIMONEDA_VW
                                  WHERE FROM_CURRENCY = (SELECT MON_ORACLE FROM AD_FECXC.FECXC_TPC_MULTIMONEDA WHERE SECMONEDA = (SELECT NVL(q.EQ_SIF,0) FROM AD_FECXC.FECXC_MONEDAS_EQUIVALENCIA q WHERE q.SECMONEDA = A.SECMONEDA))
                                  AND TO_CURRENCY = (SELECT MON_ORACLE FROM AD_FECXC.FECXC_TPC_MULTIMONEDA WHERE SECMONEDA = F.SECMONEDA)
                                  AND CONVERSION_DATE = A.F_DEPOSITO
                                )
                        ELSE 1
                   END
           END))/p_FORMATO COBRANZA_MES
        FROM FECXC_ENC_CLASIFICADOS A, FECXC_DET_CLASIFICADOS B, FECXC_MONEDAS C, FECXC_CALENDARIO_COB D, FECXC_INPC E,
            FECXC_TPC E,
            FECXC_SEGMULTIMON F
        WHERE A.E_CODIGO = B.E_CODIGO
              AND A.COD_SEC_CLASIFICA = B.COD_SEC_CLASIFICA
              AND A.SECMONEDA = C.SECMONEDA
              AND A.F_DEPOSITO between D.FECHA_INICIO AND D.FECHA_FIN
              AND D.ANIO_COBRANZA = p_ANIO             --PARAMETRO DE A?O
                AND D.MES_COBRANZA = p_MES             --PARAMETRO DE MES
              AND A.F_DEPOSITO <= p_FECHA
              AND D.ANIO_COBRANZA = E.ANO_INPC (+)
              AND D.MES_COBRANZA = E.MES_INPC  (+)
                AND EXISTS(SELECT 1 FROM FECXC_DET_CLASFECXC clas
                              WHERE B.COD_SEC_CATCLAS = clas.COD_SEC_CATCLAS
                                  AND B.COD_SEC_DET = clas.COD_SEC_DET
                                AND clas.EXCLUIR_ENREPORTES = 'NO')
          AND A.SECMONEDA = E.SECMONEDA (+)
            AND A.F_DEPOSITO = E.FECHA_TPC (+)
          AND B.SEGMENTO1 = F.COD_SEC_LIN (+)
        group by A.E_CODIGO, B.SEGMENTO1, C.CODMONEDA;
        /*LLENA COBRANZA DEL A LA FECHA */
        INSERT INTO FECXC_COBRANZA_ALAFECHA(E_CODIGO, SEGMENTO,CODMONEDA, COBRANZA_ALAFECHA, COBRANZAREAL_ALAFECHA)
        SELECT A.E_CODIGO,B.SEGMENTO1,C.CODMONEDA,sum(B.IMPORTE*(CASE
                WHEN p_SEGMENTOSESP = 0
                   THEN 1
                ELSE
                   CASE
                        WHEN F.COD_SEC_LIN IS NULL
                           THEN 1
                        WHEN F.COD_SEC_LIN IS NOT NULL AND F.SECMONEDA = (SELECT NVL(q.EQ_SIF,0) FROM AD_FECXC.FECXC_MONEDAS_EQUIVALENCIA q WHERE q.SECMONEDA = A.SECMONEDA)
                            AND (SELECT NVL(q.EQ_SIF,0) FROM AD_FECXC.FECXC_MONEDAS_EQUIVALENCIA q WHERE q.SECMONEDA = A.SECMONEDA) IN(22)
                           THEN DECODE(p_INPC,1,v_INPC/nvl(E.INPC_ACTUAL,v_INPC),1)
                        WHEN F.COD_SEC_LIN IS NOT NULL AND F.SECMONEDA = (SELECT NVL(q.EQ_SIF,0) FROM AD_FECXC.FECXC_MONEDAS_EQUIVALENCIA q WHERE q.SECMONEDA = A.SECMONEDA)
                            AND (SELECT NVL(q.EQ_SIF,0) FROM AD_FECXC.FECXC_MONEDAS_EQUIVALENCIA q WHERE q.SECMONEDA = A.SECMONEDA) NOT IN(22)
                           THEN 1
                        WHEN F.COD_SEC_LIN IS NOT NULL AND F.SECMONEDA IN(22)
                             AND F.SECMONEDA <> (SELECT NVL(q.EQ_SIF,0) FROM AD_FECXC.FECXC_MONEDAS_EQUIVALENCIA q WHERE q.SECMONEDA = A.SECMONEDA)
                           THEN E.TIPO_CAMBIO
                        WHEN F.COD_SEC_LIN IS NOT NULL AND F.SECMONEDA NOT IN(22)
                             AND (SELECT NVL(q.EQ_SIF,0) FROM AD_FECXC.FECXC_MONEDAS_EQUIVALENCIA q WHERE q.SECMONEDA = A.SECMONEDA) IN(22)
                           THEN (SELECT TIPO_CAMBIO_DLS FROM FECXC_TPC WHERE FECHA_TPC = A.F_DEPOSITO AND SECMONEDA = F.SECMONEDA) * DECODE(p_INPC,1,v_INPC/nvl(E.INPC_ACTUAL,v_INPC),1)
                        WHEN
                             F.COD_SEC_LIN IS NOT NULL
                             AND F.SECMONEDA NOT IN (22)
                             AND F.SECMONEDA <> (SELECT NVL(q.EQ_SIF,0) FROM AD_FECXC.FECXC_MONEDAS_EQUIVALENCIA q WHERE q.SECMONEDA = A.SECMONEDA)
                           THEN
                                (SELECT ROUND(CONVERSION_RATE,4)
                                  FROM FECXC_TPC_MULTIMONEDA_VW
                                  WHERE FROM_CURRENCY = (SELECT MON_ORACLE FROM AD_FECXC.FECXC_TPC_MULTIMONEDA WHERE SECMONEDA = (SELECT NVL(q.EQ_SIF,0) FROM AD_FECXC.FECXC_MONEDAS_EQUIVALENCIA q WHERE q.SECMONEDA = A.SECMONEDA))
                                  AND TO_CURRENCY = (SELECT MON_ORACLE FROM AD_FECXC.FECXC_TPC_MULTIMONEDA WHERE SECMONEDA = F.SECMONEDA)
                                  AND CONVERSION_DATE = A.F_DEPOSITO
                                )
                        ELSE 1
                   END
           END))/p_FORMATO COBRANZA_ALAFECHA, sum(B.IMPORTE*(CASE
                WHEN p_SEGMENTOSESP = 0
                   THEN 1
                ELSE
                   CASE
                        WHEN F.COD_SEC_LIN IS NULL
                           THEN 1
                        WHEN F.COD_SEC_LIN IS NOT NULL AND F.SECMONEDA = (SELECT NVL(q.EQ_SIF,0) FROM AD_FECXC.FECXC_MONEDAS_EQUIVALENCIA q WHERE q.SECMONEDA = A.SECMONEDA)
                            AND (SELECT NVL(q.EQ_SIF,0) FROM AD_FECXC.FECXC_MONEDAS_EQUIVALENCIA q WHERE q.SECMONEDA = A.SECMONEDA) IN(22)
                           THEN DECODE(p_INPC,2,v_INPC2/nvl(E.INPC_ACTUAL,v_INPC2),1)
                        WHEN F.COD_SEC_LIN IS NOT NULL AND F.SECMONEDA = (SELECT NVL(q.EQ_SIF,0) FROM AD_FECXC.FECXC_MONEDAS_EQUIVALENCIA q WHERE q.SECMONEDA = A.SECMONEDA)
                            AND (SELECT NVL(q.EQ_SIF,0) FROM AD_FECXC.FECXC_MONEDAS_EQUIVALENCIA q WHERE q.SECMONEDA = A.SECMONEDA) NOT IN(22)
                           THEN 1
                        WHEN F.COD_SEC_LIN IS NOT NULL AND F.SECMONEDA IN(22)
                             AND F.SECMONEDA <> (SELECT NVL(q.EQ_SIF,0) FROM AD_FECXC.FECXC_MONEDAS_EQUIVALENCIA q WHERE q.SECMONEDA = A.SECMONEDA)
                           THEN E.TIPO_CAMBIO
                        WHEN F.COD_SEC_LIN IS NOT NULL AND F.SECMONEDA NOT IN(22)
                             AND (SELECT NVL(q.EQ_SIF,0) FROM AD_FECXC.FECXC_MONEDAS_EQUIVALENCIA q WHERE q.SECMONEDA = A.SECMONEDA) IN(22)
                           THEN (SELECT TIPO_CAMBIO_DLS FROM FECXC_TPC WHERE FECHA_TPC = A.F_DEPOSITO AND SECMONEDA = F.SECMONEDA) * DECODE(p_INPC,2,v_INPC2/nvl(E.INPC_ACTUAL,v_INPC2),1)
                        WHEN
                             F.COD_SEC_LIN IS NOT NULL
                             AND F.SECMONEDA NOT IN (22)
                             AND F.SECMONEDA <> (SELECT NVL(q.EQ_SIF,0) FROM AD_FECXC.FECXC_MONEDAS_EQUIVALENCIA q WHERE q.SECMONEDA = A.SECMONEDA)
                           THEN
                                (SELECT ROUND(CONVERSION_RATE,4)
                                  FROM FECXC_TPC_MULTIMONEDA_VW
                                  WHERE FROM_CURRENCY = (SELECT MON_ORACLE FROM AD_FECXC.FECXC_TPC_MULTIMONEDA WHERE SECMONEDA = (SELECT NVL(q.EQ_SIF,0) FROM AD_FECXC.FECXC_MONEDAS_EQUIVALENCIA q WHERE q.SECMONEDA = A.SECMONEDA))
                                  AND TO_CURRENCY = (SELECT MON_ORACLE FROM AD_FECXC.FECXC_TPC_MULTIMONEDA WHERE SECMONEDA = F.SECMONEDA)
                                  AND CONVERSION_DATE = A.F_DEPOSITO
                                )
                        ELSE 1
                   END
           END))/p_FORMATO COBRANZAREAL_ALAFECHA
        FROM FECXC_ENC_CLASIFICADOS A, FECXC_DET_CLASIFICADOS B, FECXC_MONEDAS C, FECXC_CALENDARIO_COB D, FECXC_INPC E,
            FECXC_TPC E,
            FECXC_SEGMULTIMON F
        WHERE A.E_CODIGO = B.E_CODIGO
              AND A.COD_SEC_CLASIFICA = B.COD_SEC_CLASIFICA
              AND A.SECMONEDA = C.SECMONEDA
              AND A.F_DEPOSITO between D.FECHA_INICIO AND D.FECHA_FIN
              AND D.ANIO_COBRANZA = p_ANIO                    --PARAMETRO DE A?O
                AND D.MES_COBRANZA <= p_MES
              AND A.F_DEPOSITO <= p_FECHA
              AND D.ANIO_COBRANZA = E.ANO_INPC (+)
              AND D.MES_COBRANZA = E.MES_INPC  (+)
              AND EXISTS(SELECT 1 FROM FECXC_DET_CLASFECXC clas
                                  WHERE B.COD_SEC_CATCLAS = clas.COD_SEC_CATCLAS
                                      AND B.COD_SEC_DET = clas.COD_SEC_DET
                                    AND clas.EXCLUIR_ENREPORTES = 'NO')
              AND A.SECMONEDA = E.SECMONEDA (+)
                AND A.F_DEPOSITO = E.FECHA_TPC (+)
              AND B.SEGMENTO1 = F.COD_SEC_LIN (+)
        group by A.E_CODIGO, B.SEGMENTO1, C.CODMONEDA;
        /*LLENA COBRANZA ANTERIOR MISMO DIA */
        INSERT INTO FECXC_COBRANZA_ANTERIOR(E_CODIGO, SEGMENTO,CODMONEDA, COBRANZA_ANTERIOR, COBRANZAREAL_ANTERIOR)
        SELECT A.E_CODIGO, B.SEGMENTO1,C.CODMONEDA,sum(B.IMPORTE*(CASE
                WHEN p_SEGMENTOSESP = 0
                   THEN 1
                ELSE
                   CASE
                        WHEN F.COD_SEC_LIN IS NULL
                           THEN 1
                        WHEN F.COD_SEC_LIN IS NOT NULL AND F.SECMONEDA = (SELECT NVL(q.EQ_SIF,0) FROM AD_FECXC.FECXC_MONEDAS_EQUIVALENCIA q WHERE q.SECMONEDA = A.SECMONEDA)
                            AND (SELECT NVL(q.EQ_SIF,0) FROM AD_FECXC.FECXC_MONEDAS_EQUIVALENCIA q WHERE q.SECMONEDA = A.SECMONEDA) IN(22)
                           THEN DECODE(p_INPC,1,v_INPC/nvl(E.INPC_ACTUAL,v_INPC),1)
                        WHEN F.COD_SEC_LIN IS NOT NULL AND F.SECMONEDA = (SELECT NVL(q.EQ_SIF,0) FROM AD_FECXC.FECXC_MONEDAS_EQUIVALENCIA q WHERE q.SECMONEDA = A.SECMONEDA)
                            AND (SELECT NVL(q.EQ_SIF,0) FROM AD_FECXC.FECXC_MONEDAS_EQUIVALENCIA q WHERE q.SECMONEDA = A.SECMONEDA) NOT IN(22)
                           THEN 1
                        WHEN F.COD_SEC_LIN IS NOT NULL AND F.SECMONEDA IN(22)
                             AND F.SECMONEDA <> (SELECT NVL(q.EQ_SIF,0) FROM AD_FECXC.FECXC_MONEDAS_EQUIVALENCIA q WHERE q.SECMONEDA = A.SECMONEDA)
                           THEN E.TIPO_CAMBIO
                        WHEN F.COD_SEC_LIN IS NOT NULL AND F.SECMONEDA NOT IN(22)
                             AND (SELECT NVL(q.EQ_SIF,0) FROM AD_FECXC.FECXC_MONEDAS_EQUIVALENCIA q WHERE q.SECMONEDA = A.SECMONEDA) IN(22)
                           THEN (SELECT TIPO_CAMBIO_DLS FROM FECXC_TPC WHERE FECHA_TPC = A.F_DEPOSITO AND SECMONEDA = F.SECMONEDA) * DECODE(p_INPC,1,v_INPC/nvl(E.INPC_ACTUAL,v_INPC),1)
                        WHEN
                             F.COD_SEC_LIN IS NOT NULL
                             AND F.SECMONEDA NOT IN (22)
                             AND F.SECMONEDA <> (SELECT NVL(q.EQ_SIF,0) FROM AD_FECXC.FECXC_MONEDAS_EQUIVALENCIA q WHERE q.SECMONEDA = A.SECMONEDA)
                           THEN
                                (SELECT ROUND(CONVERSION_RATE,4)
                                  FROM FECXC_TPC_MULTIMONEDA_VW
                                  WHERE FROM_CURRENCY = (SELECT MON_ORACLE FROM AD_FECXC.FECXC_TPC_MULTIMONEDA WHERE SECMONEDA = (SELECT NVL(q.EQ_SIF,0) FROM AD_FECXC.FECXC_MONEDAS_EQUIVALENCIA q WHERE q.SECMONEDA = A.SECMONEDA))
                                  AND TO_CURRENCY = (SELECT MON_ORACLE FROM AD_FECXC.FECXC_TPC_MULTIMONEDA WHERE SECMONEDA = F.SECMONEDA)
                                  AND CONVERSION_DATE = A.F_DEPOSITO
                                )
                        ELSE 1
                   END
           END))/p_FORMATO COBRANZA_ANTERIOR, sum(B.IMPORTE*(CASE
                WHEN p_SEGMENTOSESP = 0
                   THEN 1
                ELSE
                   CASE
                        WHEN F.COD_SEC_LIN IS NULL
                           THEN 1
                        WHEN F.COD_SEC_LIN IS NOT NULL AND F.SECMONEDA = (SELECT NVL(q.EQ_SIF,0) FROM AD_FECXC.FECXC_MONEDAS_EQUIVALENCIA q WHERE q.SECMONEDA = A.SECMONEDA)
                            AND (SELECT NVL(q.EQ_SIF,0) FROM AD_FECXC.FECXC_MONEDAS_EQUIVALENCIA q WHERE q.SECMONEDA = A.SECMONEDA) IN(22)
                           THEN DECODE(p_INPC,2,v_INPC2/nvl(E.INPC_ACTUAL,v_INPC2),1)
                        WHEN F.COD_SEC_LIN IS NOT NULL AND F.SECMONEDA = (SELECT NVL(q.EQ_SIF,0) FROM AD_FECXC.FECXC_MONEDAS_EQUIVALENCIA q WHERE q.SECMONEDA = A.SECMONEDA)
                            AND (SELECT NVL(q.EQ_SIF,0) FROM AD_FECXC.FECXC_MONEDAS_EQUIVALENCIA q WHERE q.SECMONEDA = A.SECMONEDA) NOT IN(22)
                           THEN 1
                        WHEN F.COD_SEC_LIN IS NOT NULL AND F.SECMONEDA IN(22)
                             AND F.SECMONEDA <> (SELECT NVL(q.EQ_SIF,0) FROM AD_FECXC.FECXC_MONEDAS_EQUIVALENCIA q WHERE q.SECMONEDA = A.SECMONEDA)
                           THEN E.TIPO_CAMBIO
                        WHEN F.COD_SEC_LIN IS NOT NULL AND F.SECMONEDA NOT IN(22)
                             AND (SELECT NVL(q.EQ_SIF,0) FROM AD_FECXC.FECXC_MONEDAS_EQUIVALENCIA q WHERE q.SECMONEDA = A.SECMONEDA) IN(22)
                           THEN (SELECT TIPO_CAMBIO_DLS FROM FECXC_TPC WHERE FECHA_TPC = A.F_DEPOSITO AND SECMONEDA = F.SECMONEDA) * DECODE(p_INPC,2,v_INPC2/nvl(E.INPC_ACTUAL,v_INPC2),1)
                        WHEN
                             F.COD_SEC_LIN IS NOT NULL
                             AND F.SECMONEDA NOT IN (22)
                             AND F.SECMONEDA <> (SELECT NVL(q.EQ_SIF,0) FROM AD_FECXC.FECXC_MONEDAS_EQUIVALENCIA q WHERE q.SECMONEDA = A.SECMONEDA)
                           THEN
                                (SELECT ROUND(CONVERSION_RATE,4)
                                  FROM FECXC_TPC_MULTIMONEDA_VW
                                  WHERE FROM_CURRENCY = (SELECT MON_ORACLE FROM AD_FECXC.FECXC_TPC_MULTIMONEDA WHERE SECMONEDA = (SELECT NVL(q.EQ_SIF,0) FROM AD_FECXC.FECXC_MONEDAS_EQUIVALENCIA q WHERE q.SECMONEDA = A.SECMONEDA))
                                  AND TO_CURRENCY = (SELECT MON_ORACLE FROM AD_FECXC.FECXC_TPC_MULTIMONEDA WHERE SECMONEDA = F.SECMONEDA)
                                  AND CONVERSION_DATE = A.F_DEPOSITO
                                )
                        ELSE 1
                   END
           END))/p_FORMATO COBRANZAREAL_ANTERIOR
        FROM FECXC_ENC_CLASIFICADOS A, FECXC_DET_CLASIFICADOS B, FECXC_MONEDAS C, FECXC_CALENDARIO_COB D, FECXC_INPC E,
            FECXC_TPC E,
            FECXC_SEGMULTIMON F
        WHERE A.E_CODIGO = B.E_CODIGO
              AND A.COD_SEC_CLASIFICA = B.COD_SEC_CLASIFICA
              AND A.SECMONEDA = C.SECMONEDA
              AND A.F_DEPOSITO between D.FECHA_INICIO AND D.FECHA_FIN
              AND D.ANIO_COBRANZA = p_ANIO -1                    --PARAMETRO DE A?O
                AND D.MES_COBRANZA <= p_MES                        --PARAMETRO DE MES
              AND D.ANIO_COBRANZA = E.ANO_INPC  (+)
              AND D.MES_COBRANZA = E.MES_INPC    (+)
              AND EXISTS(SELECT 1 FROM FECXC_DET_CLASFECXC clas
                                  WHERE B.COD_SEC_CATCLAS = clas.COD_SEC_CATCLAS
                                      AND B.COD_SEC_DET = clas.COD_SEC_DET
                                    AND clas.EXCLUIR_ENREPORTES = 'NO')
              AND A.SECMONEDA = E.SECMONEDA (+)
                AND A.F_DEPOSITO = E.FECHA_TPC (+)
              AND B.SEGMENTO1 = F.COD_SEC_LIN (+)
        group by A.E_CODIGO, B.SEGMENTO1, C.CODMONEDA;
        /*LLENA PRESUPUESTO DEL MES */
        INSERT INTO FECXC_PRESUP_DELMES(
           SEGMENTO, CODMONEDA, PRESUP_MES, PRESUPREAL_MES)
        SELECT B.SEGMENTO1, C.CODMONEDA,sum(B.IMPORTE*DECODE(C.ES_MONEDA_LOCCAL,1,DECODE(p_INPC,1,v_INPC/nvl(E.INPC_ACTUAL,v_INPC),1),1))/p_FORMATO PRESUP_MES,
        sum(B.IMPORTE*DECODE(C.ES_MONEDA_LOCCAL,1,DECODE(p_INPC,2,v_INPC2/nvl(E.INPC_ACTUAL,v_INPC2),1),1))/p_FORMATO PRESUPREAL_MES
        FROM FECXC_ENC_DE_PRESU A, FECXC_DET_PRES_DIARIO B, FECXC_MONEDAS C, FECXC_CALENDARIO_COB D, FECXC_INPC E
        WHERE A.SEC_PRESUP = B.SEC_PRESUP
              AND A.SECMONEDA = C.SECMONEDA
              AND B.DIARIO between D.FECHA_INICIO AND D.FECHA_FIN
              AND D.ANIO_COBRANZA = p_ANIO                    --PARAMETRO DE A?O
                AND D.MES_COBRANZA = p_MES                      --PARAMETRO DE MES
              AND D.ANIO_COBRANZA = E.ANO_INPC (+)
              AND D.MES_COBRANZA = E.MES_INPC   (+)
        group by B.SEGMENTO1, C.CODMONEDA;
        /*LLENA PRESUPUESTO DEL ALAFECHA */
        INSERT INTO FECXC_PRESUP_ALAFECHA(
           SEGMENTO, CODMONEDA, PRESUP_ALAFECHA, PRESUPREAL_ALAFECHA)
        SELECT B.SEGMENTO1, C.CODMONEDA,sum(B.IMPORTE*DECODE(C.ES_MONEDA_LOCCAL,1,DECODE(p_INPC,1,v_INPC/nvl(E.INPC_ACTUAL,v_INPC),1),1))/p_FORMATO PRESUP_ALAFECHA,
        sum(B.IMPORTE*DECODE(C.ES_MONEDA_LOCCAL,1,DECODE(p_INPC,2,v_INPC2/nvl(E.INPC_ACTUAL,v_INPC2),1),1))/p_FORMATO PRESUPREAL_ALAFECHA
        FROM FECXC_ENC_DE_PRESU A, FECXC_DET_PRES_DIARIO B, FECXC_MONEDAS C, FECXC_CALENDARIO_COB D, FECXC_INPC E
        WHERE A.SEC_PRESUP = B.SEC_PRESUP
              AND A.SECMONEDA = C.SECMONEDA
              AND B.DIARIO between D.FECHA_INICIO AND D.FECHA_FIN
              AND D.ANIO_COBRANZA = p_ANIO                    --PARAMETRO DE A?O
              AND D.MES_COBRANZA <= p_MES                  --PARAMETRO DEL MES
              AND D.ANIO_COBRANZA = E.ANO_INPC (+)
              AND D.MES_COBRANZA = E.MES_INPC   (+)
        group by B.SEGMENTO1, C.CODMONEDA;
    ELSE      /* A UNA FECHA DADA */
        INSERT INTO FECXC_COBRANZA_DELMES(E_CODIGO, SEGMENTO,CODMONEDA, COBRANZA_MES)
        SELECT A.E_CODIGO, B.SEGMENTO1,C.CODMONEDA,
            sum(B.IMPORTE*(CASE
                WHEN p_SEGMENTOSESP = 0
                   THEN 1
                ELSE
                   CASE
                        WHEN F.COD_SEC_LIN IS NULL
                           THEN 1
                        WHEN F.COD_SEC_LIN IS NOT NULL AND F.SECMONEDA = (SELECT NVL(q.EQ_SIF,0) FROM AD_FECXC.FECXC_MONEDAS_EQUIVALENCIA q WHERE q.SECMONEDA = A.SECMONEDA)
                            AND (SELECT NVL(q.EQ_SIF,0) FROM AD_FECXC.FECXC_MONEDAS_EQUIVALENCIA q WHERE q.SECMONEDA = A.SECMONEDA) IN(22)
                           THEN DECODE(p_INPC,1,v_INPC/nvl(E.INPC_ACTUAL,v_INPC),1)
                        WHEN F.COD_SEC_LIN IS NOT NULL AND F.SECMONEDA = (SELECT NVL(q.EQ_SIF,0) FROM AD_FECXC.FECXC_MONEDAS_EQUIVALENCIA q WHERE q.SECMONEDA = A.SECMONEDA)
                            AND (SELECT NVL(q.EQ_SIF,0) FROM AD_FECXC.FECXC_MONEDAS_EQUIVALENCIA q WHERE q.SECMONEDA = A.SECMONEDA) NOT IN(22)
                           THEN 1
                        WHEN F.COD_SEC_LIN IS NOT NULL AND F.SECMONEDA IN(22)
                             AND F.SECMONEDA <> (SELECT NVL(q.EQ_SIF,0) FROM AD_FECXC.FECXC_MONEDAS_EQUIVALENCIA q WHERE q.SECMONEDA = A.SECMONEDA)
                           THEN E.TIPO_CAMBIO
                        WHEN F.COD_SEC_LIN IS NOT NULL AND F.SECMONEDA NOT IN(22)
                             AND (SELECT NVL(q.EQ_SIF,0) FROM AD_FECXC.FECXC_MONEDAS_EQUIVALENCIA q WHERE q.SECMONEDA = A.SECMONEDA) IN(22)
                           THEN (SELECT TIPO_CAMBIO_DLS FROM FECXC_TPC WHERE FECHA_TPC = A.F_DEPOSITO AND SECMONEDA = F.SECMONEDA) * DECODE(p_INPC,1,v_INPC/nvl(E.INPC_ACTUAL,v_INPC),1)
                        WHEN
                             F.COD_SEC_LIN IS NOT NULL
                             AND F.SECMONEDA NOT IN (22)
                             AND F.SECMONEDA <> (SELECT NVL(q.EQ_SIF,0) FROM AD_FECXC.FECXC_MONEDAS_EQUIVALENCIA q WHERE q.SECMONEDA = A.SECMONEDA)
                           THEN
                                (SELECT ROUND(CONVERSION_RATE,4)
                                  FROM FECXC_TPC_MULTIMONEDA_VW
                                  WHERE FROM_CURRENCY = (SELECT MON_ORACLE FROM AD_FECXC.FECXC_TPC_MULTIMONEDA WHERE SECMONEDA = (SELECT NVL(q.EQ_SIF,0) FROM AD_FECXC.FECXC_MONEDAS_EQUIVALENCIA q WHERE q.SECMONEDA = A.SECMONEDA))
                                  AND TO_CURRENCY = (SELECT MON_ORACLE FROM AD_FECXC.FECXC_TPC_MULTIMONEDA WHERE SECMONEDA = F.SECMONEDA)
                                  AND CONVERSION_DATE = A.F_DEPOSITO
                                )
                        ELSE 1
                   END
           END))/p_FORMATO COBRANZA_MES
        FROM FECXC_ENC_CLASIFICADOS A, FECXC_DET_CLASIFICADOS B, FECXC_MONEDAS C, FECXC_CALENDARIO_COB D, FECXC_INPC E,
            FECXC_TPC E,
            FECXC_SEGMULTIMON F
        WHERE A.E_CODIGO = B.E_CODIGO
              AND A.COD_SEC_CLASIFICA = B.COD_SEC_CLASIFICA
              AND A.SECMONEDA = C.SECMONEDA
              AND A.F_DEPOSITO between D.FECHA_INICIO AND D.FECHA_FIN
              AND D.ANIO_COBRANZA = p_ANIO             --PARAMETRO DE A?O
                AND D.MES_COBRANZA = p_MES             --PARAMETRO DE MES
              AND D.ANIO_COBRANZA = E.ANO_INPC (+)
              AND D.MES_COBRANZA = E.MES_INPC   (+)
              AND A.F_DEPOSITO <= p_FECHA
              AND EXISTS(SELECT 1 FROM FECXC_DET_CLASFECXC clas
                              WHERE B.COD_SEC_CATCLAS = clas.COD_SEC_CATCLAS
                                  AND B.COD_SEC_DET = clas.COD_SEC_DET
                                AND clas.EXCLUIR_ENREPORTES = 'NO')
              AND A.SECMONEDA = E.SECMONEDA (+)
                AND A.F_DEPOSITO = E.FECHA_TPC (+)
              AND B.SEGMENTO1 = F.COD_SEC_LIN (+)
        group by A.E_CODIGO, B.SEGMENTO1, C.CODMONEDA;
        /*LLENA COBRANZA DEL A LA FECHA */
        INSERT INTO FECXC_COBRANZA_ALAFECHA(
           E_CODIGO, SEGMENTO,
           CODMONEDA, COBRANZA_ALAFECHA, COBRANZAREAL_ALAFECHA)
        SELECT A.E_CODIGO, B.SEGMENTO1,
           C.CODMONEDA,sum(B.IMPORTE*(CASE
                WHEN p_SEGMENTOSESP = 0
                   THEN 1
                ELSE
                   CASE
                        WHEN F.COD_SEC_LIN IS NULL
                           THEN 1
                        WHEN F.COD_SEC_LIN IS NOT NULL AND F.SECMONEDA = (SELECT NVL(q.EQ_SIF,0) FROM AD_FECXC.FECXC_MONEDAS_EQUIVALENCIA q WHERE q.SECMONEDA = A.SECMONEDA)
                            AND (SELECT NVL(q.EQ_SIF,0) FROM AD_FECXC.FECXC_MONEDAS_EQUIVALENCIA q WHERE q.SECMONEDA = A.SECMONEDA) IN(22)
                           THEN DECODE(p_INPC,1,v_INPC/nvl(E.INPC_ACTUAL,v_INPC),1)
                        WHEN F.COD_SEC_LIN IS NOT NULL AND F.SECMONEDA = (SELECT NVL(q.EQ_SIF,0) FROM AD_FECXC.FECXC_MONEDAS_EQUIVALENCIA q WHERE q.SECMONEDA = A.SECMONEDA)
                            AND (SELECT NVL(q.EQ_SIF,0) FROM AD_FECXC.FECXC_MONEDAS_EQUIVALENCIA q WHERE q.SECMONEDA = A.SECMONEDA) NOT IN(22)
                           THEN 1
                        WHEN F.COD_SEC_LIN IS NOT NULL AND F.SECMONEDA IN(22)
                             AND F.SECMONEDA <> (SELECT NVL(q.EQ_SIF,0) FROM AD_FECXC.FECXC_MONEDAS_EQUIVALENCIA q WHERE q.SECMONEDA = A.SECMONEDA)
                           THEN E.TIPO_CAMBIO
                        WHEN F.COD_SEC_LIN IS NOT NULL AND F.SECMONEDA NOT IN(22)
                             AND (SELECT NVL(q.EQ_SIF,0) FROM AD_FECXC.FECXC_MONEDAS_EQUIVALENCIA q WHERE q.SECMONEDA = A.SECMONEDA) IN(22)
                           THEN (SELECT TIPO_CAMBIO_DLS FROM FECXC_TPC WHERE FECHA_TPC = A.F_DEPOSITO AND SECMONEDA = F.SECMONEDA) * DECODE(p_INPC,1,v_INPC/nvl(E.INPC_ACTUAL,v_INPC),1)
                        WHEN
                             F.COD_SEC_LIN IS NOT NULL
                             AND F.SECMONEDA NOT IN (22)
                             AND F.SECMONEDA <> (SELECT NVL(q.EQ_SIF,0) FROM AD_FECXC.FECXC_MONEDAS_EQUIVALENCIA q WHERE q.SECMONEDA = A.SECMONEDA)
                           THEN
                                (SELECT ROUND(CONVERSION_RATE,4)
                                  FROM FECXC_TPC_MULTIMONEDA_VW
                                  WHERE FROM_CURRENCY = (SELECT MON_ORACLE FROM AD_FECXC.FECXC_TPC_MULTIMONEDA WHERE SECMONEDA = (SELECT NVL(q.EQ_SIF,0) FROM AD_FECXC.FECXC_MONEDAS_EQUIVALENCIA q WHERE q.SECMONEDA = A.SECMONEDA))
                                  AND TO_CURRENCY = (SELECT MON_ORACLE FROM AD_FECXC.FECXC_TPC_MULTIMONEDA WHERE SECMONEDA = F.SECMONEDA)
                                  AND CONVERSION_DATE = A.F_DEPOSITO
                                )
                        ELSE 1
                   END
           END))/p_FORMATO COBRANZA_ALAFECHA, sum(B.IMPORTE*(CASE
                WHEN p_SEGMENTOSESP = 0
                   THEN 1
                ELSE
                   CASE
                        WHEN F.COD_SEC_LIN IS NULL
                           THEN 1
                        WHEN F.COD_SEC_LIN IS NOT NULL AND F.SECMONEDA = (SELECT NVL(q.EQ_SIF,0) FROM AD_FECXC.FECXC_MONEDAS_EQUIVALENCIA q WHERE q.SECMONEDA = A.SECMONEDA)
                            AND (SELECT NVL(q.EQ_SIF,0) FROM AD_FECXC.FECXC_MONEDAS_EQUIVALENCIA q WHERE q.SECMONEDA = A.SECMONEDA) IN(22)
                           THEN DECODE(p_INPC,2,v_INPC2/nvl(E.INPC_ACTUAL,v_INPC2),1)
                        WHEN F.COD_SEC_LIN IS NOT NULL AND F.SECMONEDA = (SELECT NVL(q.EQ_SIF,0) FROM AD_FECXC.FECXC_MONEDAS_EQUIVALENCIA q WHERE q.SECMONEDA = A.SECMONEDA)
                            AND (SELECT NVL(q.EQ_SIF,0) FROM AD_FECXC.FECXC_MONEDAS_EQUIVALENCIA q WHERE q.SECMONEDA = A.SECMONEDA) NOT IN(22)
                           THEN 1
                        WHEN F.COD_SEC_LIN IS NOT NULL AND F.SECMONEDA IN(22)
                             AND F.SECMONEDA <> (SELECT NVL(q.EQ_SIF,0) FROM AD_FECXC.FECXC_MONEDAS_EQUIVALENCIA q WHERE q.SECMONEDA = A.SECMONEDA)
                           THEN E.TIPO_CAMBIO
                        WHEN F.COD_SEC_LIN IS NOT NULL AND F.SECMONEDA NOT IN(22)
                             AND (SELECT NVL(q.EQ_SIF,0) FROM AD_FECXC.FECXC_MONEDAS_EQUIVALENCIA q WHERE q.SECMONEDA = A.SECMONEDA) IN(22)
                           THEN (SELECT TIPO_CAMBIO_DLS FROM FECXC_TPC WHERE FECHA_TPC = A.F_DEPOSITO AND SECMONEDA = F.SECMONEDA) * DECODE(p_INPC,2,v_INPC2/nvl(E.INPC_ACTUAL,v_INPC2),1)
                        WHEN
                             F.COD_SEC_LIN IS NOT NULL
                             AND F.SECMONEDA NOT IN (22)
                             AND F.SECMONEDA <> (SELECT NVL(q.EQ_SIF,0) FROM AD_FECXC.FECXC_MONEDAS_EQUIVALENCIA q WHERE q.SECMONEDA = A.SECMONEDA)
                           THEN
                                (SELECT ROUND(CONVERSION_RATE,4)
                                  FROM FECXC_TPC_MULTIMONEDA_VW
                                  WHERE FROM_CURRENCY = (SELECT MON_ORACLE FROM AD_FECXC.FECXC_TPC_MULTIMONEDA WHERE SECMONEDA = (SELECT NVL(q.EQ_SIF,0) FROM AD_FECXC.FECXC_MONEDAS_EQUIVALENCIA q WHERE q.SECMONEDA = A.SECMONEDA))
                                  AND TO_CURRENCY = (SELECT MON_ORACLE FROM AD_FECXC.FECXC_TPC_MULTIMONEDA WHERE SECMONEDA = F.SECMONEDA)
                                  AND CONVERSION_DATE = A.F_DEPOSITO
                                )
                        ELSE 1
                   END
           END))/p_FORMATO COBRANZAREAL_ALAFECHA
        FROM FECXC_ENC_CLASIFICADOS A, FECXC_DET_CLASIFICADOS B, FECXC_MONEDAS C, FECXC_CALENDARIO_COB D, FECXC_INPC E,
            FECXC_TPC E,
            FECXC_SEGMULTIMON F
        WHERE A.E_CODIGO = B.E_CODIGO
              AND A.COD_SEC_CLASIFICA = B.COD_SEC_CLASIFICA
              AND A.SECMONEDA = C.SECMONEDA
              AND A.F_DEPOSITO between D.FECHA_INICIO AND D.FECHA_FIN
              AND D.ANIO_COBRANZA = p_ANIO                    --PARAMETRO DE A?O
                AND A.F_DEPOSITO <= p_FECHA                ---PARAMETRO DEL DIA
              AND D.ANIO_COBRANZA = E.ANO_INPC (+)
              AND D.MES_COBRANZA = E.MES_INPC  (+)
                AND EXISTS(SELECT 1 FROM FECXC_DET_CLASFECXC clas
                              WHERE B.COD_SEC_CATCLAS = clas.COD_SEC_CATCLAS
                                  AND B.COD_SEC_DET = clas.COD_SEC_DET
                                AND clas.EXCLUIR_ENREPORTES = 'NO')
              AND A.SECMONEDA = E.SECMONEDA (+)
                AND A.F_DEPOSITO = E.FECHA_TPC (+)
              AND B.SEGMENTO1 = F.COD_SEC_LIN (+)
        group by A.E_CODIGO, B.SEGMENTO1, C.CODMONEDA;
        /*LLENA COBRANZA ANTERIOR MISMO DIA */
        INSERT INTO FECXC_COBRANZA_ANTERIOR(
           E_CODIGO, SEGMENTO,
           CODMONEDA, COBRANZA_ANTERIOR, COBRANZAREAL_ANTERIOR)
        SELECT A.E_CODIGO, B.SEGMENTO1,
           C.CODMONEDA,sum(B.IMPORTE*(CASE
                WHEN p_SEGMENTOSESP = 0
                   THEN 1
                ELSE
                   CASE
                        WHEN F.COD_SEC_LIN IS NULL
                           THEN 1
                        WHEN F.COD_SEC_LIN IS NOT NULL AND F.SECMONEDA = (SELECT NVL(q.EQ_SIF,0) FROM AD_FECXC.FECXC_MONEDAS_EQUIVALENCIA q WHERE q.SECMONEDA = A.SECMONEDA)
                            AND (SELECT NVL(q.EQ_SIF,0) FROM AD_FECXC.FECXC_MONEDAS_EQUIVALENCIA q WHERE q.SECMONEDA = A.SECMONEDA) IN(22)
                           THEN DECODE(p_INPC,1,v_INPC/nvl(E.INPC_ACTUAL,v_INPC),1)
                        WHEN F.COD_SEC_LIN IS NOT NULL AND F.SECMONEDA = (SELECT NVL(q.EQ_SIF,0) FROM AD_FECXC.FECXC_MONEDAS_EQUIVALENCIA q WHERE q.SECMONEDA = A.SECMONEDA)
                            AND (SELECT NVL(q.EQ_SIF,0) FROM AD_FECXC.FECXC_MONEDAS_EQUIVALENCIA q WHERE q.SECMONEDA = A.SECMONEDA) NOT IN(22)
                           THEN 1
                        WHEN F.COD_SEC_LIN IS NOT NULL AND F.SECMONEDA IN(22)
                             AND F.SECMONEDA <> (SELECT NVL(q.EQ_SIF,0) FROM AD_FECXC.FECXC_MONEDAS_EQUIVALENCIA q WHERE q.SECMONEDA = A.SECMONEDA)
                           THEN E.TIPO_CAMBIO
                        WHEN F.COD_SEC_LIN IS NOT NULL AND F.SECMONEDA NOT IN(22)
                             AND (SELECT NVL(q.EQ_SIF,0) FROM AD_FECXC.FECXC_MONEDAS_EQUIVALENCIA q WHERE q.SECMONEDA = A.SECMONEDA) IN(22)
                           THEN (SELECT TIPO_CAMBIO_DLS FROM FECXC_TPC WHERE FECHA_TPC = A.F_DEPOSITO AND SECMONEDA = F.SECMONEDA) * DECODE(p_INPC,1,v_INPC/nvl(E.INPC_ACTUAL,v_INPC),1)
                        WHEN
                             F.COD_SEC_LIN IS NOT NULL
                             AND F.SECMONEDA NOT IN (22)
                             AND F.SECMONEDA <> (SELECT NVL(q.EQ_SIF,0) FROM AD_FECXC.FECXC_MONEDAS_EQUIVALENCIA q WHERE q.SECMONEDA = A.SECMONEDA)
                           THEN
                                (SELECT ROUND(CONVERSION_RATE,4)
                                  FROM FECXC_TPC_MULTIMONEDA_VW
                                  WHERE FROM_CURRENCY = (SELECT MON_ORACLE FROM AD_FECXC.FECXC_TPC_MULTIMONEDA WHERE SECMONEDA = (SELECT NVL(q.EQ_SIF,0) FROM AD_FECXC.FECXC_MONEDAS_EQUIVALENCIA q WHERE q.SECMONEDA = A.SECMONEDA))
                                  AND TO_CURRENCY = (SELECT MON_ORACLE FROM AD_FECXC.FECXC_TPC_MULTIMONEDA WHERE SECMONEDA = F.SECMONEDA)
                                  AND CONVERSION_DATE = A.F_DEPOSITO
                                )
                        ELSE 1
                   END
           END))/p_FORMATO COBRANZA_ANTERIOR, sum(B.IMPORTE*(CASE
                WHEN p_SEGMENTOSESP = 0
                   THEN 1
                ELSE
                   CASE
                        WHEN F.COD_SEC_LIN IS NULL
                           THEN 1
                        WHEN F.COD_SEC_LIN IS NOT NULL AND F.SECMONEDA = (SELECT NVL(q.EQ_SIF,0) FROM AD_FECXC.FECXC_MONEDAS_EQUIVALENCIA q WHERE q.SECMONEDA = A.SECMONEDA)
                            AND (SELECT NVL(q.EQ_SIF,0) FROM AD_FECXC.FECXC_MONEDAS_EQUIVALENCIA q WHERE q.SECMONEDA = A.SECMONEDA) IN(22)
                           THEN DECODE(p_INPC,2,v_INPC2/nvl(E.INPC_ACTUAL,v_INPC2),1)
                        WHEN F.COD_SEC_LIN IS NOT NULL AND F.SECMONEDA = (SELECT NVL(q.EQ_SIF,0) FROM AD_FECXC.FECXC_MONEDAS_EQUIVALENCIA q WHERE q.SECMONEDA = A.SECMONEDA)
                            AND (SELECT NVL(q.EQ_SIF,0) FROM AD_FECXC.FECXC_MONEDAS_EQUIVALENCIA q WHERE q.SECMONEDA = A.SECMONEDA) NOT IN(22)
                           THEN 1
                        WHEN F.COD_SEC_LIN IS NOT NULL AND F.SECMONEDA IN(22)
                             AND F.SECMONEDA <> (SELECT NVL(q.EQ_SIF,0) FROM AD_FECXC.FECXC_MONEDAS_EQUIVALENCIA q WHERE q.SECMONEDA = A.SECMONEDA)
                           THEN E.TIPO_CAMBIO
                        WHEN F.COD_SEC_LIN IS NOT NULL AND F.SECMONEDA NOT IN(22)
                             AND (SELECT NVL(q.EQ_SIF,0) FROM AD_FECXC.FECXC_MONEDAS_EQUIVALENCIA q WHERE q.SECMONEDA = A.SECMONEDA) IN(22)
                           THEN (SELECT TIPO_CAMBIO_DLS FROM FECXC_TPC WHERE FECHA_TPC = A.F_DEPOSITO AND SECMONEDA = F.SECMONEDA) * DECODE(p_INPC,2,v_INPC2/nvl(E.INPC_ACTUAL,v_INPC2),1)
                        WHEN
                             F.COD_SEC_LIN IS NOT NULL
                             AND F.SECMONEDA NOT IN (22)
                             AND F.SECMONEDA <> (SELECT NVL(q.EQ_SIF,0) FROM AD_FECXC.FECXC_MONEDAS_EQUIVALENCIA q WHERE q.SECMONEDA = A.SECMONEDA)
                           THEN
                                (SELECT ROUND(CONVERSION_RATE,4)
                                  FROM FECXC_TPC_MULTIMONEDA_VW
                                  WHERE FROM_CURRENCY = (SELECT MON_ORACLE FROM AD_FECXC.FECXC_TPC_MULTIMONEDA WHERE SECMONEDA = (SELECT NVL(q.EQ_SIF,0) FROM AD_FECXC.FECXC_MONEDAS_EQUIVALENCIA q WHERE q.SECMONEDA = A.SECMONEDA))
                                  AND TO_CURRENCY = (SELECT MON_ORACLE FROM AD_FECXC.FECXC_TPC_MULTIMONEDA WHERE SECMONEDA = F.SECMONEDA)
                                  AND CONVERSION_DATE = A.F_DEPOSITO
                                )
                        ELSE 1
                   END
           END))/p_FORMATO COBRANZAREAL_ANTERIOR
        FROM FECXC_ENC_CLASIFICADOS A, FECXC_DET_CLASIFICADOS B, FECXC_MONEDAS C, FECXC_CALENDARIO_COB D, FECXC_INPC E,
            FECXC_TPC E,
            FECXC_SEGMULTIMON F
        WHERE A.E_CODIGO = B.E_CODIGO
              AND A.COD_SEC_CLASIFICA = B.COD_SEC_CLASIFICA
              AND A.SECMONEDA = C.SECMONEDA
              AND A.F_DEPOSITO between D.FECHA_INICIO AND D.FECHA_FIN
              AND D.ANIO_COBRANZA = p_ANIO -1                    --PARAMETRO DE A?O
                AND A.F_DEPOSITO <= to_date(p_FECHA)-365                 ---PARAMETRO DEL DIA
              AND D.ANIO_COBRANZA = E.ANO_INPC  (+)
              AND D.MES_COBRANZA = E.MES_INPC    (+)
              AND EXISTS(SELECT 1 FROM FECXC_DET_CLASFECXC clas
                              WHERE B.COD_SEC_CATCLAS = clas.COD_SEC_CATCLAS
                                  AND B.COD_SEC_DET = clas.COD_SEC_DET
                                AND clas.EXCLUIR_ENREPORTES = 'NO')
              AND A.SECMONEDA = E.SECMONEDA (+)
                AND A.F_DEPOSITO = E.FECHA_TPC (+)
              AND B.SEGMENTO1 = F.COD_SEC_LIN (+)
        group by A.E_CODIGO, B.SEGMENTO1, C.CODMONEDA;
        /*LLENA PRESUPUESTO DEL MES */
        INSERT INTO FECXC_PRESUP_DELMES(
           SEGMENTO, CODMONEDA, PRESUP_MES, PRESUPREAL_MES)
        SELECT B.SEGMENTO1, C.CODMONEDA,sum(B.IMPORTE*DECODE(C.ES_MONEDA_LOCCAL,1,DECODE(p_INPC,1,v_INPC/nvl(E.INPC_ACTUAL,v_INPC),1),1))/p_FORMATO PRESUP_MES,
        sum(B.IMPORTE*DECODE(C.ES_MONEDA_LOCCAL,1,DECODE(p_INPC,2,v_INPC2/nvl(E.INPC_ACTUAL,v_INPC2),1),1))/p_FORMATO PRESUPREAL_MES
        FROM FECXC_ENC_DE_PRESU A, FECXC_DET_PRES_DIARIO B, FECXC_MONEDAS C, FECXC_CALENDARIO_COB D, FECXC_INPC E
        WHERE A.SEC_PRESUP = B.SEC_PRESUP
              AND A.SECMONEDA = C.SECMONEDA
              AND B.DIARIO between D.FECHA_INICIO AND D.FECHA_FIN
              AND D.ANIO_COBRANZA = p_ANIO                    --PARAMETRO DE A?O
                AND D.MES_COBRANZA = p_MES                      --PARAMETRO DE MES
              AND B.DIARIO <= p_FECHA
              AND D.ANIO_COBRANZA = E.ANO_INPC (+)
              AND D.MES_COBRANZA = E.MES_INPC   (+)
        group by B.SEGMENTO1, C.CODMONEDA;
        /*LLENA PRESUPUESTO DEL ALAFECHA */
        INSERT INTO FECXC_PRESUP_ALAFECHA(
           SEGMENTO, CODMONEDA, PRESUP_ALAFECHA,PRESUPREAL_ALAFECHA)
        SELECT B.SEGMENTO1, C.CODMONEDA,sum(B.IMPORTE*DECODE(C.ES_MONEDA_LOCCAL,1,DECODE(p_INPC,1,v_INPC/nvl(E.INPC_ACTUAL,v_INPC),1),1))/p_FORMATO PRESUP_ALAFECHA,
        sum(B.IMPORTE*DECODE(C.ES_MONEDA_LOCCAL,1,DECODE(p_INPC,2,v_INPC2/nvl(E.INPC_ACTUAL,v_INPC2),1),1))/p_FORMATO PRESUPREAL_ALAFECHA
        FROM FECXC_ENC_DE_PRESU A, FECXC_DET_PRES_DIARIO B, FECXC_MONEDAS C, FECXC_CALENDARIO_COB D, FECXC_INPC E
        WHERE A.SEC_PRESUP = B.SEC_PRESUP
              AND A.SECMONEDA = C.SECMONEDA
              AND B.DIARIO between D.FECHA_INICIO AND D.FECHA_FIN
              AND D.ANIO_COBRANZA = p_ANIO                    --PARAMETRO DE A?O
              AND B.DIARIO <= p_FECHA
              AND D.ANIO_COBRANZA = E.ANO_INPC (+)
              AND D.MES_COBRANZA = E.MES_INPC   (+)
        group by B.SEGMENTO1, C.CODMONEDA;
    END IF;      -- MENSUALIZADO
    IF p_SEGMENTOSESP = 1 THEN
        UPDATE FECXC_COBRANZA_DELDIA up_table
        SET CODMONEDA = (SELECT CODMONEDA FROM FECXC_MONEDAS x, FECXC_SEGMULTIMON y WHERE x.SECMONEDA = y.SECMONEDA AND y.COD_SEC_LIN = up_table.SEGMENTO)
        WHERE SEGMENTO IS NOT NULL;
        UPDATE FECXC_COBRANZA_DELMES up_table
        SET CODMONEDA = (SELECT CODMONEDA FROM FECXC_MONEDAS x, FECXC_SEGMULTIMON y WHERE x.SECMONEDA = y.SECMONEDA AND y.COD_SEC_LIN = up_table.SEGMENTO)
        WHERE SEGMENTO IS NOT NULL;
        UPDATE FECXC_COBRANZA_ALAFECHA up_table
        SET CODMONEDA = (SELECT CODMONEDA FROM FECXC_MONEDAS x, FECXC_SEGMULTIMON y WHERE x.SECMONEDA = y.SECMONEDA AND y.COD_SEC_LIN = up_table.SEGMENTO)
        WHERE SEGMENTO IS NOT NULL;
        UPDATE FECXC_COBRANZA_ANTERIOR up_table
        SET CODMONEDA = (SELECT CODMONEDA FROM FECXC_MONEDAS x, FECXC_SEGMULTIMON y WHERE x.SECMONEDA = y.SECMONEDA AND y.COD_SEC_LIN = up_table.SEGMENTO)
        WHERE SEGMENTO IS NOT NULL;
        /*
        UPDATE FECXC_COBRANZA_DELDIA up_table
        SET CODMONEDA = (select min(CODMONEDA) from FECXC_MONEDAS M WHERE M.ES_MONEDA_LOCCAL = 1)
        WHERE EXISTS(select 1
                       from FECXC_SEGMULTIMON B
                     WHERE up_table.SEGMENTO = B.COD_SEC_LIN
                     AND up_table.SEGMENTO IN (1,2,3,9,4,5,6,7))
            AND EXISTS(SELECT 1
                       from FECXC_MONEDAS C
                       WHERE up_table.CODMONEDA = C.CODMONEDA
                                AND (C.ES_MONEDA_LOCCAL is null
                                      OR C.ES_MONEDA_LOCCAL = 0));
        UPDATE FECXC_COBRANZA_DELMES up_table
        SET CODMONEDA = (select min(CODMONEDA) from FECXC_MONEDAS M WHERE M.ES_MONEDA_LOCCAL = 1)
        WHERE EXISTS(select 1
                       from FECXC_SEGMULTIMON B
                     WHERE up_table.SEGMENTO = B.COD_SEC_LIN
                     AND up_table.SEGMENTO IN (1,2,3,9,4,5,6,7))
            AND EXISTS(SELECT 1
                       from FECXC_MONEDAS C
                       WHERE up_table.CODMONEDA = C.CODMONEDA
                                AND (C.ES_MONEDA_LOCCAL is null
                                      OR C.ES_MONEDA_LOCCAL = 0));
        UPDATE FECXC_COBRANZA_ALAFECHA up_table
        SET CODMONEDA = (select min(CODMONEDA) from FECXC_MONEDAS M WHERE M.ES_MONEDA_LOCCAL = 1)
        WHERE EXISTS(select 1
                       from FECXC_SEGMULTIMON B
                     WHERE up_table.SEGMENTO = B.COD_SEC_LIN
                     AND up_table.SEGMENTO IN (1,2,3,9,4,5,6,7))
            AND EXISTS(SELECT 1
                       from FECXC_MONEDAS C
                       WHERE up_table.CODMONEDA = C.CODMONEDA
                                AND (C.ES_MONEDA_LOCCAL is null
                                      OR C.ES_MONEDA_LOCCAL = 0));
        UPDATE FECXC_COBRANZA_ANTERIOR up_table
        SET CODMONEDA = (select min(CODMONEDA) from FECXC_MONEDAS M WHERE M.ES_MONEDA_LOCCAL = 1)
        WHERE EXISTS(select 1
                       from FECXC_SEGMULTIMON B
                     WHERE up_table.SEGMENTO = B.COD_SEC_LIN
                     AND up_table.SEGMENTO IN (1,2,3,9,4,5,6,7))
            AND EXISTS(SELECT 1
                       from FECXC_MONEDAS C
                       WHERE up_table.CODMONEDA = C.CODMONEDA
                                AND (C.ES_MONEDA_LOCCAL is null
                                      OR C.ES_MONEDA_LOCCAL = 0));
       */
       INSERT INTO FECXC_COBRANZA_DELDIA_tmp(E_CODIGO, SEGMENTO, CODMONEDA, COBRANZA_DIA)
       select E_CODIGO, SEGMENTO, CODMONEDA, sum(COBRANZA_DIA)
       from FECXC_COBRANZA_DELDIA
       group by E_CODIGO, SEGMENTO, CODMONEDA;
       INSERT INTO FECXC_COBRANZA_DELMES_tmp(E_CODIGO,SEGMENTO,CODMONEDA,COBRANZA_MES)
       select E_CODIGO,SEGMENTO,CODMONEDA, sum(COBRANZA_MES)
       from FECXC_COBRANZA_DELMES
       group by E_CODIGO,SEGMENTO,CODMONEDA;
       INSERT INTO FECXC_COBRANZA_ALAFECHA_tmp(E_CODIGO, SEGMENTO, CODMONEDA, COBRANZA_ALAFECHA, COBRANZAREAL_ALAFECHA)
       select E_CODIGO, SEGMENTO, CODMONEDA, sum(COBRANZA_ALAFECHA), sum(COBRANZAREAL_ALAFECHA)
       from FECXC_COBRANZA_ALAFECHA
       group by E_CODIGO, SEGMENTO, CODMONEDA;
       INSERT INTO FECXC_COBRANZA_ANTERIOR_tmp(E_CODIGO, SEGMENTO, CODMONEDA, COBRANZA_ANTERIOR, COBRANZAREAL_ANTERIOR)
       select E_CODIGO, SEGMENTO, CODMONEDA, sum(COBRANZA_ANTERIOR), sum(COBRANZAREAL_ANTERIOR)
       from FECXC_COBRANZA_ANTERIOR
       group by E_CODIGO, SEGMENTO, CODMONEDA;
       DELETE FECXC_COBRANZA_DELDIA;
       INSERT INTO FECXC_COBRANZA_DELDIA(E_CODIGO, SEGMENTO, CODMONEDA, COBRANZA_DIA)
       SELECT E_CODIGO, SEGMENTO, CODMONEDA, COBRANZA_DIA
       FROM FECXC_COBRANZA_DELDIA_tmp;
       DELETE FECXC_COBRANZA_DELMES;
       INSERT INTO FECXC_COBRANZA_DELMES(E_CODIGO,SEGMENTO,CODMONEDA,COBRANZA_MES)
       select E_CODIGO,SEGMENTO,CODMONEDA,COBRANZA_MES
       from FECXC_COBRANZA_DELMES_tmp;
       DELETE FECXC_COBRANZA_ALAFECHA;
       INSERT INTO FECXC_COBRANZA_ALAFECHA(E_CODIGO, SEGMENTO, CODMONEDA, COBRANZA_ALAFECHA, COBRANZAREAL_ALAFECHA)
       select E_CODIGO, SEGMENTO, CODMONEDA, COBRANZA_ALAFECHA, COBRANZAREAL_ALAFECHA
       from FECXC_COBRANZA_ALAFECHA_tmp;
       DELETE FECXC_COBRANZA_ANTERIOR;
       INSERT INTO FECXC_COBRANZA_ANTERIOR(E_CODIGO, SEGMENTO, CODMONEDA, COBRANZA_ANTERIOR, COBRANZAREAL_ANTERIOR)
       select E_CODIGO, SEGMENTO, CODMONEDA, COBRANZA_ANTERIOR, COBRANZAREAL_ANTERIOR
       from FECXC_COBRANZA_ANTERIOR_tmp;
     END IF;
--  Realiza la conversi?n de Tipo de Cambio dependiendo de su moneda inicial a DLS. MN Y DLS se quedan tal cual.
/*
    DELETE FROM FECXC_TIPOCAMBIO_tmp;
    INSERT INTO FECXC_TIPOCAMBIO_tmp
    SELECT m.CODMONEDA, NVL(t.TIPO_CAMBIO_DLS, 0)
    FROM
    FECXC_MONEDAS m, FECXC_TPC t
    WHERE
    m.SECMONEDA = t.SECMONEDA
    AND
    t.FECHA_TPC = p_FECHA;
    DELETE FROM FECXC_COBRANZA_DELDIA_tmp;
    INSERT INTO FECXC_COBRANZA_DELDIA_tmp
    SELECT c.E_CODIGO, c.SEGMENTO, 'DLS', CASE
                                           WHEN t.TIPO_CAMBIO_DLS IS NULL THEN 0
                                           ELSE (c.COBRANZA_DIA / t.TIPO_CAMBIO_DLS)
                                        END as CAMBIO_DLS
    FROM FECXC_COBRANZA_DELDIA c, FECXC_SEGMULTIMON s, FECXC_TPC t
    WHERE
    c.SEGMENTO = s.COD_SEC_LIN
    AND
    t.SECMONEDA IN (SELECT SECMONEDA FROM FECXC_MONEDAS WHERE CODMONEDA = c.CODMONEDA)
    AND
    c.CODMONEDA <> (SELECT m.CODMONEDA FROM FECXC_MONEDAS m WHERE m.SECMONEDA = s.SECMONEDA)
    AND
    t.FECHA_TPC = p_FECHA;
    DELETE FROM FECXC_COBRANZA_DELDIA a
    WHERE EXISTS(SELECT b.E_CODIGO, b.SEGMENTO FROM FECXC_COBRANZA_DELDIA_tmp b WHERE a.E_CODIGO = b.E_CODIGO AND a.SEGMENTO = b.SEGMENTO);
    INSERT INTO FECXC_COBRANZA_DELDIA
    SELECT E_CODIGO, SEGMENTO, CODMONEDA, COBRANZA_DIA FROM FECXC_COBRANZA_DELDIA_TMP;
    DELETE FROM FECXC_COBRANZA_DELMES_tmp;
    INSERT INTO FECXC_COBRANZA_DELMES_tmp
    SELECT c.E_CODIGO, c.SEGMENTO, 'DLS', CASE
                                         WHEN t.TIPO_CAMBIO_DLS IS NULL THEN 0
                                         ELSE (c.COBRANZA_MES / t.TIPO_CAMBIO_DLS)
                                      END as CAMBIO_DLS
    FROM FECXC_COBRANZA_DELMES c, FECXC_SEGMULTIMON s, FECXC_TPC t
    WHERE
    c.SEGMENTO = s.COD_SEC_LIN
    AND
    t.SECMONEDA IN (SELECT SECMONEDA FROM FECXC_MONEDAS WHERE CODMONEDA = c.CODMONEDA)
    AND
    c.CODMONEDA <> (SELECT m.CODMONEDA FROM FECXC_MONEDAS m WHERE m.SECMONEDA = s.SECMONEDA)
    AND
    t.FECHA_TPC = p_FECHA;
    DELETE FROM FECXC_COBRANZA_DELMES a
    WHERE EXISTS(SELECT b.E_CODIGO, b.SEGMENTO FROM FECXC_COBRANZA_DELMES_tmp b WHERE a.E_CODIGO = b.E_CODIGO AND a.SEGMENTO = b.SEGMENTO);
    INSERT INTO FECXC_COBRANZA_DELMES
    SELECT E_CODIGO, SEGMENTO, CODMONEDA, COBRANZA_MES FROM FECXC_COBRANZA_DELMES_TMP;
    DELETE FROM FECXC_COBRANZA_ALAFECHA_tmp;
    INSERT INTO FECXC_COBRANZA_ALAFECHA_tmp
    SELECT c.E_CODIGO, c.SEGMENTO, 'DLS', CASE
                                         WHEN t.TIPO_CAMBIO_DLS IS NULL THEN 0
                                         ELSE (c.COBRANZA_ALAFECHA / t.TIPO_CAMBIO_DLS)
                                      END as CAMBIO_DLS,
                                      CASE
                                         WHEN t.TIPO_CAMBIO_DLS IS NULL THEN 0
                                         ELSE (c.COBRANZAREAL_ALAFECHA / t.TIPO_CAMBIO_DLS)
                                      END as CAMBIOREAL_DLS
    FROM FECXC_COBRANZA_ALAFECHA c, FECXC_SEGMULTIMON s, FECXC_TPC t
    WHERE
    c.SEGMENTO = s.COD_SEC_LIN
    AND
    t.SECMONEDA IN (SELECT SECMONEDA FROM FECXC_MONEDAS WHERE CODMONEDA = c.CODMONEDA)
    AND
    c.CODMONEDA <> (SELECT m.CODMONEDA FROM FECXC_MONEDAS m WHERE m.SECMONEDA = s.SECMONEDA)
    AND
    t.FECHA_TPC = p_FECHA;
    DELETE FROM FECXC_COBRANZA_ALAFECHA a
    WHERE EXISTS(SELECT b.E_CODIGO, b.SEGMENTO FROM FECXC_COBRANZA_ALAFECHA_tmp b WHERE a.E_CODIGO = b.E_CODIGO AND a.SEGMENTO = b.SEGMENTO);
    INSERT INTO FECXC_COBRANZA_ALAFECHA
    SELECT E_CODIGO, SEGMENTO, CODMONEDA, COBRANZA_ALAFECHA, COBRANZAREAL_ALAFECHA FROM FECXC_COBRANZA_ALAFECHA_TMP;
    DELETE FROM FECXC_COBRANZA_ANTERIOR_tmp;
    INSERT INTO FECXC_COBRANZA_ANTERIOR_tmp
    SELECT c.E_CODIGO, c.SEGMENTO, 'DLS', CASE
                                         WHEN t.TIPO_CAMBIO_DLS IS NULL THEN 0
                                         ELSE (c.COBRANZA_ANTERIOR / t.TIPO_CAMBIO_DLS)
                                      END as CAMBIO_DLS,
                                      CASE
                                         WHEN t.TIPO_CAMBIO_DLS IS NULL THEN 0
                                         ELSE (c.COBRANZAREAL_ANTERIOR / t.TIPO_CAMBIO_DLS)
                                      END as CAMBIOREAL_DLS
    FROM FECXC_COBRANZA_ANTERIOR c, FECXC_SEGMULTIMON s, FECXC_TPC t
    WHERE
    c.SEGMENTO = s.COD_SEC_LIN
    AND
    t.SECMONEDA IN (SELECT SECMONEDA FROM FECXC_MONEDAS WHERE CODMONEDA = c.CODMONEDA)
    AND
    c.CODMONEDA <> (SELECT m.CODMONEDA FROM FECXC_MONEDAS m WHERE m.SECMONEDA = s.SECMONEDA)
    AND
    t.FECHA_TPC = p_FECHA;
    DELETE FROM FECXC_COBRANZA_ANTERIOR a
    WHERE EXISTS(SELECT b.E_CODIGO, b.SEGMENTO FROM FECXC_COBRANZA_ANTERIOR_tmp b WHERE a.E_CODIGO = b.E_CODIGO AND a.SEGMENTO = b.SEGMENTO);
    INSERT INTO FECXC_COBRANZA_ANTERIOR
    SELECT E_CODIGO, SEGMENTO, CODMONEDA, COBRANZA_ANTERIOR, COBRANZAREAL_ANTERIOR FROM FECXC_COBRANZA_ANTERIOR_TMP;
    UPDATE FECXC_COBRANZA_DELDIA d
    SET d.COBRANZA_DIA = (SELECT CASE
                                    WHEN (SELECT t.TIPO_CAMBIO_DLS FROM FECXC_TIPOCAMBIO_TMP t WHERE t.CODMONEDA = x.CODMONEDA) IS NULL THEN 0
                                    ELSE d.COBRANZA_DIA / (SELECT t.TIPO_CAMBIO_DLS FROM FECXC_TIPOCAMBIO_TMP t WHERE t.CODMONEDA = d.CODMONEDA)
                                 END FROM FECXC_COBRANZA_DELDIA x WHERE x.E_CODIGO = d.E_CODIGO AND x.SEGMENTO = d.SEGMENTO),
    d.CODMONEDA = 'DLS'
    WHERE d.CODMONEDA NOT IN ('MN','DLS');
    UPDATE FECXC_COBRANZA_DELDIA SET COBRANZA_DIA = 0 WHERE COBRANZA_DIA IS NULL;
    UPDATE FECXC_COBRANZA_DELMES d
    SET d.COBRANZA_MES = (SELECT CASE
                                    WHEN (SELECT t.TIPO_CAMBIO_DLS FROM FECXC_TIPOCAMBIO_TMP t WHERE t.CODMONEDA = x.CODMONEDA) IS NULL THEN 0
                                    ELSE d.COBRANZA_MES / (SELECT t.TIPO_CAMBIO_DLS FROM FECXC_TIPOCAMBIO_TMP t WHERE t.CODMONEDA = d.CODMONEDA)
                                 END FROM FECXC_COBRANZA_DELMES x WHERE x.E_CODIGO = d.E_CODIGO AND x.SEGMENTO = d.SEGMENTO),
    d.CODMONEDA = 'DLS'
    WHERE d.CODMONEDA NOT IN ('MN','DLS');
    UPDATE FECXC_COBRANZA_DELMES SET COBRANZA_MES = 0 WHERE COBRANZA_MES IS NULL;
    UPDATE FECXC_COBRANZA_ALAFECHA d
    SET d.COBRANZA_ALAFECHA = (SELECT CASE
                                    WHEN (SELECT t.TIPO_CAMBIO_DLS FROM FECXC_TIPOCAMBIO_TMP t WHERE t.CODMONEDA = x.CODMONEDA) IS NULL THEN 0
                                    ELSE d.COBRANZA_ALAFECHA / (SELECT t.TIPO_CAMBIO_DLS FROM FECXC_TIPOCAMBIO_TMP t WHERE t.CODMONEDA = d.CODMONEDA)
                                 END FROM FECXC_COBRANZA_ALAFECHA x WHERE x.E_CODIGO = d.E_CODIGO AND x.SEGMENTO = d.SEGMENTO),
    d.CODMONEDA = 'DLS',
    d.COBRANZAREAL_ALAFECHA = (SELECT CASE
                                    WHEN (SELECT t.TIPO_CAMBIO_DLS FROM FECXC_TIPOCAMBIO_TMP t WHERE t.CODMONEDA = x.CODMONEDA) IS NULL THEN 0
                                    ELSE d.COBRANZAREAL_ALAFECHA / (SELECT t.TIPO_CAMBIO_DLS FROM FECXC_TIPOCAMBIO_TMP t WHERE t.CODMONEDA = d.CODMONEDA)
                                 END FROM FECXC_COBRANZA_ALAFECHA x WHERE x.E_CODIGO = d.E_CODIGO AND x.SEGMENTO = d.SEGMENTO)
    WHERE d.CODMONEDA NOT IN ('MN','DLS');
    UPDATE FECXC_COBRANZA_ALAFECHA SET COBRANZA_ALAFECHA = 0, COBRANZAREAL_ALAFECHA = 0 WHERE COBRANZA_ALAFECHA IS NULL OR COBRANZAREAL_ALAFECHA IS NULL;
    UPDATE FECXC_COBRANZA_ANTERIOR d
    SET d.COBRANZA_ANTERIOR = (SELECT CASE
                                    WHEN (SELECT t.TIPO_CAMBIO_DLS FROM FECXC_TIPOCAMBIO_TMP t WHERE t.CODMONEDA = x.CODMONEDA) IS NULL THEN 0
                                    ELSE d.COBRANZA_ANTERIOR / (SELECT t.TIPO_CAMBIO_DLS FROM FECXC_TIPOCAMBIO_TMP t WHERE t.CODMONEDA = d.CODMONEDA)
                                 END FROM FECXC_COBRANZA_ANTERIOR x WHERE x.E_CODIGO = d.E_CODIGO AND x.SEGMENTO = d.SEGMENTO),
    d.CODMONEDA = 'DLS',
    d.COBRANZAREAL_ANTERIOR = (SELECT CASE
                                    WHEN (SELECT t.TIPO_CAMBIO_DLS FROM FECXC_TIPOCAMBIO_TMP t WHERE t.CODMONEDA = x.CODMONEDA) IS NULL THEN 0
                                    ELSE d.COBRANZAREAL_ANTERIOR / (SELECT t.TIPO_CAMBIO_DLS FROM FECXC_TIPOCAMBIO_TMP t WHERE t.CODMONEDA = d.CODMONEDA)
                                 END FROM FECXC_COBRANZA_ANTERIOR x WHERE x.E_CODIGO = d.E_CODIGO AND x.SEGMENTO = d.SEGMENTO)
    WHERE d.CODMONEDA NOT IN ('MN','DLS');
    UPDATE FECXC_COBRANZA_ANTERIOR SET COBRANZA_ANTERIOR = 0, COBRANZAREAL_ANTERIOR = 0 WHERE COBRANZA_ANTERIOR IS NULL OR COBRANZAREAL_ANTERIOR IS NULL;
*/
--     LARG se ingresa codigo para cambiar el tipo de cambio de Euros a Dolares y el tipo de moneda de Euros a Dolares cuando la empresa sea 552 y el segmento 13
/*
     select count(*)
     into t_count
     from FECXC_COBRANZA_DELDIA a, FECXC_TPC b,FECXC_MONEDAS c
     where a.CODMONEDA=c.CODMONEDA and c.SECMONEDA=b.SECMONEDA and
           a.E_CODIGO=552 and a.SEGMENTO=13 and a.CODMONEDA='EUR'
           and FECHA_TPC= p_FECHA;
     if t_count>0 then
        select nvl(COBRANZA_DIA*TIPO_CAMBIO_DLS,0)
        into tcp_actualizado
        from FECXC_COBRANZA_DELDIA a, FECXC_TPC b,FECXC_MONEDAS c
        where a.CODMONEDA=c.CODMONEDA and c.SECMONEDA=b.SECMONEDA and
              a.E_CODIGO=552 and a.SEGMENTO=13 and a.CODMONEDA='EUR'
              and FECHA_TPC= p_FECHA;
        update FECXC_COBRANZA_DELDIA
        set CODMONEDA='DLS',
            COBRANZA_DIA=tcp_actualizado
        where E_CODIGO=552 and SEGMENTO=13 and CODMONEDA='EUR';
        SELECT count(*)
        into t_countdos
        FROM  FECXC_COBRANZA_DELDIA
        WHERE E_CODIGO=552 AND SEGMENTO=13 AND CODMONEDA='DLS';
        if t_countdos>1 then
            SELECT sum(nvl(COBRANZA_DIA,0))
            into t_cobranzames_act
            FROM  FECXC_COBRANZA_DELDIA
            WHERE E_CODIGO=552 AND SEGMENTO=13 AND CODMONEDA='DLS';
            select min(COBRANZA_DIA)
            into t_min
            FROM  FECXC_COBRANZA_DELDIA
            WHERE E_CODIGO=552 AND SEGMENTO=13 AND CODMONEDA='DLS';
            DELETE FROM FECXC_COBRANZA_DELDIA
                   WHERE COBRANZA_DIA=t_min AND E_CODIGO=552 AND SEGMENTO=13 AND CODMONEDA='DLS';
            update FECXC_COBRANZA_DELDIA
            set COBRANZA_DIA=t_cobranzames_act
            WHERE E_CODIGO=552 AND SEGMENTO=13 AND CODMONEDA='DLS';
        end if;
     end if;
    select count(*)
    into t_count
    from FECXC_COBRANZA_DELMES a, FECXC_TPC b,FECXC_MONEDAS c
    where a.CODMONEDA=c.CODMONEDA and c.SECMONEDA=b.SECMONEDA and
          a.E_CODIGO=552 and a.SEGMENTO=13 and a.CODMONEDA='EUR'
          and FECHA_TPC= p_FECHA;
     if t_count>0 then
        select nvl(COBRANZA_MES*TIPO_CAMBIO_DLS,0)
        into tcp_actualizado
        from FECXC_COBRANZA_DELMES a, FECXC_TPC b,FECXC_MONEDAS c
        where a.CODMONEDA=c.CODMONEDA and c.SECMONEDA=b.SECMONEDA and
              a.E_CODIGO=552 and a.SEGMENTO=13 and a.CODMONEDA='EUR'
              and FECHA_TPC= p_FECHA;
        update FECXC_COBRANZA_DELMES
        set  CODMONEDA='DLS',
             COBRANZA_MES=tcp_actualizado
        where E_CODIGO=552 and SEGMENTO=13 and CODMONEDA='EUR';
        SELECT count(*)
        into t_countdos
        FROM  FECXC_COBRANZA_DELMES
        WHERE E_CODIGO=552 AND SEGMENTO=13 AND CODMONEDA='DLS';
         if t_countdos>1 then
            SELECT SUM(nvl(COBRANZA_MES,0))
            into t_cobranzames_act
            FROM  FECXC_COBRANZA_DELMES
            WHERE E_CODIGO=552 AND SEGMENTO=13 AND CODMONEDA='DLS';
            select min(COBRANZA_MES)
            into t_min
            FROM  FECXC_COBRANZA_DELMES
            WHERE E_CODIGO=552 AND SEGMENTO=13 AND CODMONEDA='DLS';
            DELETE FROM FECXC_COBRANZA_DELMES
                   WHERE COBRANZA_MES=t_min AND E_CODIGO=552 AND SEGMENTO=13 AND CODMONEDA='DLS';
            update FECXC_COBRANZA_DELMES
            set COBRANZA_MES=t_cobranzames_act
            WHERE E_CODIGO=552 AND SEGMENTO=13 AND CODMONEDA='DLS';
        end if;
     end if;
    select count(*)
    into t_count
    from FECXC_COBRANZA_ALAFECHA a, FECXC_TPC b,FECXC_MONEDAS c
    where a.CODMONEDA=c.CODMONEDA and c.SECMONEDA=b.SECMONEDA and
          a.E_CODIGO=552 and a.SEGMENTO=13 and a.CODMONEDA='EUR'
          and FECHA_TPC= p_FECHA;
    if t_count>0 then
        select nvl(COBRANZA_ALAFECHA*TIPO_CAMBIO_DLS,0),nvl(COBRANZAREAL_ALAFECHA*TIPO_CAMBIO_DLS,0)
        into tcp_actualizado,tcp_actualizado_dos
        from FECXC_COBRANZA_ALAFECHA a, FECXC_TPC b,FECXC_MONEDAS c
        where a.CODMONEDA=c.CODMONEDA and c.SECMONEDA=b.SECMONEDA and
              a.E_CODIGO=552 and a.SEGMENTO=13 and a.CODMONEDA='EUR'
              and FECHA_TPC= p_FECHA;
        update FECXC_COBRANZA_ALAFECHA
        set  CODMONEDA='DLS',
             COBRANZA_ALAFECHA=tcp_actualizado,
             COBRANZAREAL_ALAFECHA=tcp_actualizado_dos
        where E_CODIGO=552 and SEGMENTO=13 and CODMONEDA='EUR';
        SELECT count(*)
        into t_countdos
        FROM  FECXC_COBRANZA_ALAFECHA
        WHERE E_CODIGO=552 AND SEGMENTO=13 AND CODMONEDA='DLS';
        if t_countdos>1 then
            SELECT sum(nvl(COBRANZA_ALAFECHA,0))
            into t_cobranzames_act
            FROM  FECXC_COBRANZA_ALAFECHA
            WHERE E_CODIGO=552 AND SEGMENTO=13 AND CODMONEDA='DLS';
            select min(COBRANZA_ALAFECHA)
            into t_min
            FROM  FECXC_COBRANZA_ALAFECHA
            WHERE E_CODIGO=552 AND SEGMENTO=13 AND CODMONEDA='DLS';
            SELECT sum(nvl(COBRANZAREAL_ALAFECHA,0))
            into t_cobranzames_act_dos
            FROM  FECXC_COBRANZA_ALAFECHA
            WHERE E_CODIGO=552 AND SEGMENTO=13 AND CODMONEDA='DLS';
            select min(COBRANZAREAL_ALAFECHA)
            into t_min_dos
            FROM  FECXC_COBRANZA_ALAFECHA
            WHERE E_CODIGO=552 AND SEGMENTO=13 AND CODMONEDA='DLS';
            DELETE FROM FECXC_COBRANZA_ALAFECHA
                   WHERE COBRANZA_ALAFECHA=t_min AND COBRANZAREAL_ALAFECHA=t_min_dos AND E_CODIGO=552 AND SEGMENTO=13 AND CODMONEDA='DLS';
            update FECXC_COBRANZA_ALAFECHA
            set COBRANZA_ALAFECHA=t_cobranzames_act,
                COBRANZAREAL_ALAFECHA=t_cobranzames_act_dos
            WHERE E_CODIGO=552 AND SEGMENTO=13 AND CODMONEDA='DLS';
        end if;
    end if;
    select count(*)
    into t_count
    from FECXC_COBRANZA_ANTERIOR a, FECXC_TPC b,FECXC_MONEDAS c
    where a.CODMONEDA=c.CODMONEDA and c.SECMONEDA=b.SECMONEDA and
          a.E_CODIGO=552 and a.SEGMENTO=13 and a.CODMONEDA='EUR'
          and FECHA_TPC= p_FECHA;
      if t_count>0 then
        select nvl(COBRANZA_ANTERIOR*TIPO_CAMBIO_DLS,0),nvl(COBRANZAREAL_ANTERIOR*TIPO_CAMBIO_DLS,0)
        into tcp_actualizado,tcp_actualizado_dos
        from FECXC_COBRANZA_ANTERIOR a, FECXC_TPC b,FECXC_MONEDAS c
        where a.CODMONEDA=c.CODMONEDA and c.SECMONEDA=b.SECMONEDA and
              a.E_CODIGO=552 and a.SEGMENTO=13 and a.CODMONEDA='EUR'
              and FECHA_TPC= p_FECHA;
        update FECXC_COBRANZA_ANTERIOR
        set  CODMONEDA='DLS',
             COBRANZA_ANTERIOR=tcp_actualizado,
             COBRANZAREAL_ANTERIOR=tcp_actualizado_dos
        where E_CODIGO=552 and SEGMENTO=13 and CODMONEDA='EUR';
        SELECT count(*)
        into t_countdos
        FROM  FECXC_COBRANZA_ANTERIOR
        WHERE E_CODIGO=552 AND SEGMENTO=13 AND CODMONEDA='DLS';
        if t_countdos>1 then
            SELECT sum(nvl(COBRANZA_ANTERIOR,0))
            into t_cobranzames_act
            FROM  FECXC_COBRANZA_ANTERIOR
            WHERE E_CODIGO=552 AND SEGMENTO=13 AND CODMONEDA='DLS';
            select min(COBRANZA_ANTERIOR)
            into t_min
            FROM  FECXC_COBRANZA_ANTERIOR
            WHERE E_CODIGO=552 AND SEGMENTO=13 AND CODMONEDA='DLS';
            SELECT sum(nvl(COBRANZAREAL_ANTERIOR,0))
            into t_cobranzames_act_dos
            FROM  FECXC_COBRANZA_ANTERIOR
            WHERE E_CODIGO=552 AND SEGMENTO=13 AND CODMONEDA='DLS';
            select min(COBRANZAREAL_ANTERIOR)
            into t_min_dos
            FROM  FECXC_COBRANZA_ANTERIOR
            WHERE E_CODIGO=552 AND SEGMENTO=13 AND CODMONEDA='DLS';
            DELETE FROM FECXC_COBRANZA_ANTERIOR
                   WHERE COBRANZA_ANTERIOR=t_min AND COBRANZAREAL_ANTERIOR=t_min_dos AND E_CODIGO=552 AND SEGMENTO=13 AND CODMONEDA='DLS';
            update FECXC_COBRANZA_ANTERIOR
            set COBRANZA_ANTERIOR=t_cobranzames_act,
                COBRANZAREAL_ANTERIOR=t_cobranzames_act_dos
            WHERE E_CODIGO=552 AND SEGMENTO=13 AND CODMONEDA='DLS';
        end if;
     end if;
*/
 END IF;
 IF p_TIPO = 2  THEN
    /***************************************************************************************************************************
                L L E N A D O   D E   E S T R U C T U R A   P A R A   C A N A L E S
   ***************************************************************************************************************************/
           /*Para este tipo de reporte cuando se elige que se muestren cifras nominales y reales*/
        /*Las cifras se calcular?n como reales y las agregadas ser?n nominales, las cifras nominales*/
        /*quedar?n en campos con "REAL" en su nombre pero ser?n nominales, se debe a un cambio en la definici?n del requerimiento*/
        /*los c?lculos de actualizaci?n o no DECODE(p_INPC,1,v_INPC/nvl(E.INPC_ACTUAL,v_INPC)*/
        /*Se modifican ya que se tomar? el inpc para inpc=1,2  y cuando es cero ser? nominal*/
        delete FECXC_COB_CANAL_DELDIA;
        delete FECXC_COB_CANAL_XMES;
        delete FECXC_COB_CANAL_ANTERIOR;
        delete FECXC_PRESUP_CANAL_DELMES;
        DELETE FECXC_PARAMETROS_CANALES;
        INSERT INTO FECXC_PARAMETROS_CANALES(ANIO,MES,FECHA,ACTUALIZADO)
        values (p_ANIO,p_MES,p_FECHA,tipo_reporte_inpc);
        INSERT INTO FECXC_COB_CANAL_DELDIA(
           E_CODIGO, SEGMENTO,
           CODMONEDA, MES,COBRANZA_DIA)
        SELECT A.E_CODIGO, B.SEGMENTO1,
           C.CODMONEDA, 0,sum(B.IMPORTE*(CASE WHEN p_SEGMENTOSESP = 1 AND F.COD_SEC_LIN is not null AND (C.ES_MONEDA_LOCCAL is null OR C.ES_MONEDA_LOCCAL = 0) AND E.TIPO_CAMBIO is not null THEN E.TIPO_CAMBIO ELSE 1 END))/p_FORMATO COBRANZA_MES
        FROM FECXC_ENC_CLASIFICADOS A, FECXC_DET_CLASIFICADOS B, FECXC_MONEDAS C, FECXC_CALENDARIO_COB D,
            FECXC_TPC E,
            FECXC_SEGMULTIMON F
        WHERE A.E_CODIGO = B.E_CODIGO
              AND A.COD_SEC_CLASIFICA = B.COD_SEC_CLASIFICA
              AND A.SECMONEDA = C.SECMONEDA
              AND A.F_DEPOSITO between D.FECHA_INICIO AND D.FECHA_FIN
              AND A.F_DEPOSITO = p_FECHA                ---PARAMETRO DEL DIA
                AND EXISTS(SELECT 1 FROM FECXC_DET_CLASFECXC clas
                              WHERE B.COD_SEC_CATCLAS = clas.COD_SEC_CATCLAS
                                  AND B.COD_SEC_DET = clas.COD_SEC_DET
                                AND clas.EXCLUIR_ENREPORTES = 'NO')
              AND A.SECMONEDA = E.SECMONEDA (+)
                AND A.F_DEPOSITO = E.FECHA_TPC (+)
              AND B.SEGMENTO1 = F.COD_SEC_LIN (+)
        group by A.E_CODIGO, B.SEGMENTO1, D.MES_COBRANZA, C.CODMONEDA;
        IF p_MENSUALIZADO = 0 THEN           /* MENSUALIZADO... */
            /*Se agrega columna para inpc=2*/
            INSERT INTO FECXC_COB_CANAL_XMES(
               E_CODIGO, SEGMENTO,
               CODMONEDA, MES,COBRANZA_MES, COBRANZAREAL_MES)
            SELECT A.E_CODIGO, B.SEGMENTO1,
               C.CODMONEDA, D.MES_COBRANZA,sum(B.IMPORTE*(CASE WHEN p_SEGMENTOSESP = 1 AND F.COD_SEC_LIN is not null AND (C.ES_MONEDA_LOCCAL is null OR C.ES_MONEDA_LOCCAL = 0) AND E.TIPO_CAMBIO is not null THEN E.TIPO_CAMBIO ELSE 1 END)*DECODE(C.ES_MONEDA_LOCCAL,1,DECODE(p_INPC,0,1,v_INPC/nvl(E.INPC_ACTUAL,v_INPC)),1))/p_FORMATO COBRANZA_MES,
               sum(B.IMPORTE*(CASE WHEN p_SEGMENTOSESP = 1 AND F.COD_SEC_LIN is not null AND (C.ES_MONEDA_LOCCAL is null OR C.ES_MONEDA_LOCCAL = 0) AND E.TIPO_CAMBIO is not null THEN E.TIPO_CAMBIO ELSE 1 END))/p_FORMATO COBRANZAREAL_MES
            FROM FECXC_ENC_CLASIFICADOS A, FECXC_DET_CLASIFICADOS B, FECXC_MONEDAS C, FECXC_CALENDARIO_COB D, FECXC_INPC E,
                FECXC_TPC E,
                FECXC_SEGMULTIMON F
            WHERE A.E_CODIGO = B.E_CODIGO
                  AND A.COD_SEC_CLASIFICA = B.COD_SEC_CLASIFICA
                  AND A.SECMONEDA = C.SECMONEDA
                  AND A.F_DEPOSITO between D.FECHA_INICIO AND D.FECHA_FIN
                  AND D.ANIO_COBRANZA = p_ANIO                    --PARAMETRO DE A?O
                  AND D.MES_COBRANZA <= p_MES
                  AND D.ANIO_COBRANZA = E.ANO_INPC (+)
                  AND D.MES_COBRANZA = E.MES_INPC  (+)
                  AND EXISTS(SELECT 1 FROM FECXC_DET_CLASFECXC clas
                                  WHERE B.COD_SEC_CATCLAS = clas.COD_SEC_CATCLAS
                                      AND B.COD_SEC_DET = clas.COD_SEC_DET
                                    AND clas.EXCLUIR_ENREPORTES = 'NO')
                  AND A.SECMONEDA = E.SECMONEDA (+)
                    AND A.F_DEPOSITO = E.FECHA_TPC (+)
                  AND B.SEGMENTO1 = F.COD_SEC_LIN (+)
            group by A.E_CODIGO, B.SEGMENTO1, C.CODMONEDA, D.MES_COBRANZA;
            /* Se agrega columna para inpc=2*/
            INSERT INTO FECXC_COB_CANAL_ANTERIOR(
               E_CODIGO, SEGMENTO,
               CODMONEDA, MES,COBRANZA_ANTERIOR, COBRANZAREAL_ANTERIOR)
            SELECT A.E_CODIGO, B.SEGMENTO1,
               C.CODMONEDA, D.MES_COBRANZA,sum(B.IMPORTE*(CASE WHEN p_SEGMENTOSESP = 1 AND F.COD_SEC_LIN is not null AND (C.ES_MONEDA_LOCCAL is null OR C.ES_MONEDA_LOCCAL = 0) AND E.TIPO_CAMBIO is not null THEN E.TIPO_CAMBIO ELSE 1 END)*DECODE(C.ES_MONEDA_LOCCAL,1,DECODE(p_INPC,0,1,v_INPC/nvl(E.INPC_ACTUAL,v_INPC)),1))/p_FORMATO COBRANZA_ANTERIOR,
               sum(B.IMPORTE*(CASE WHEN p_SEGMENTOSESP = 1 AND F.COD_SEC_LIN is not null AND (C.ES_MONEDA_LOCCAL is null OR C.ES_MONEDA_LOCCAL = 0) AND E.TIPO_CAMBIO is not null THEN E.TIPO_CAMBIO ELSE 1 END))/p_FORMATO COBRANZAREAL_ANTERIOR
            FROM FECXC_ENC_CLASIFICADOS A, FECXC_DET_CLASIFICADOS B, FECXC_MONEDAS C, FECXC_CALENDARIO_COB D, FECXC_INPC E,
                FECXC_TPC E,
                FECXC_SEGMULTIMON F
            WHERE A.E_CODIGO = B.E_CODIGO
                  AND A.COD_SEC_CLASIFICA = B.COD_SEC_CLASIFICA
                  AND A.SECMONEDA = C.SECMONEDA
                  AND A.F_DEPOSITO between D.FECHA_INICIO AND D.FECHA_FIN
                  AND D.ANIO_COBRANZA = p_ANIO -1                    --PARAMETRO DE A?O
                  AND D.MES_COBRANZA <= p_MES
                  AND D.ANIO_COBRANZA = E.ANO_INPC (+)
                  AND D.MES_COBRANZA = E.MES_INPC  (+)
                  AND EXISTS(SELECT 1 FROM FECXC_DET_CLASFECXC clas
                                  WHERE B.COD_SEC_CATCLAS = clas.COD_SEC_CATCLAS
                                      AND B.COD_SEC_DET = clas.COD_SEC_DET
                                    AND clas.EXCLUIR_ENREPORTES = 'NO')
                  AND A.SECMONEDA = E.SECMONEDA (+)
                    AND A.F_DEPOSITO = E.FECHA_TPC (+)
                  AND B.SEGMENTO1 = F.COD_SEC_LIN (+)
            group by A.E_CODIGO, B.SEGMENTO1, C.CODMONEDA, D.MES_COBRANZA;
            /* Se agrega columna adicional para ipc=2*/
            INSERT INTO FECXC_PRESUP_CANAL_DELMES (
               SEGMENTO, CODMONEDA, MES, PRESUP_MES, PRESUPREAL_MES)
            select B.SEGMENTO1, C.CODMONEDA, D.MES_COBRANZA, sum(B.IMPORTE*DECODE(C.ES_MONEDA_LOCCAL,1,DECODE(p_INPC,0,1,v_INPC/nvl(E.INPC_ACTUAL,v_INPC)),1))/p_FORMATO PRESUP_MES,
            sum(B.IMPORTE)/p_FORMATO PRESUPREAL_MES
            FROM FECXC_ENC_DE_PRESU A, FECXC_DET_PRES_DIARIO B, FECXC_MONEDAS C, FECXC_CALENDARIO_COB D, FECXC_INPC E
            WHERE A.SEC_PRESUP = B.SEC_PRESUP
                  AND A.SECMONEDA = C.SECMONEDA
                  AND B.DIARIO between D.FECHA_INICIO AND D.FECHA_FIN
                  AND D.ANIO_COBRANZA = p_ANIO
                  AND D.MES_COBRANZA <= p_MES
                  AND D.ANIO_COBRANZA = E.ANO_INPC (+)
                  AND D.MES_COBRANZA = E.MES_INPC  (+)
            group by B.SEGMENTO1, C.CODMONEDA, D.MES_COBRANZA;
        ELSE
               /* Se agrega columna adicional para ipc=2*/
            INSERT INTO FECXC_COB_CANAL_XMES(
               E_CODIGO, SEGMENTO,
               CODMONEDA, MES,COBRANZA_MES, COBRANZAREAL_MES)
            SELECT A.E_CODIGO, B.SEGMENTO1,
               C.CODMONEDA, D.MES_COBRANZA,sum(B.IMPORTE*(CASE WHEN p_SEGMENTOSESP = 1 AND F.COD_SEC_LIN is not null AND (C.ES_MONEDA_LOCCAL is null OR C.ES_MONEDA_LOCCAL = 0) AND E.TIPO_CAMBIO is not null THEN E.TIPO_CAMBIO ELSE 1 END)*DECODE(C.ES_MONEDA_LOCCAL,1,DECODE(p_INPC,0,1,v_INPC/nvl(E.INPC_ACTUAL,v_INPC)),1))/p_FORMATO COBRANZA_MES,
               sum(B.IMPORTE*(CASE WHEN p_SEGMENTOSESP = 1 AND F.COD_SEC_LIN is not null AND (C.ES_MONEDA_LOCCAL is null OR C.ES_MONEDA_LOCCAL = 0) AND E.TIPO_CAMBIO is not null THEN E.TIPO_CAMBIO ELSE 1 END))/p_FORMATO COBRANZAREAL_MES
            FROM FECXC_ENC_CLASIFICADOS A, FECXC_DET_CLASIFICADOS B, FECXC_MONEDAS C, FECXC_CALENDARIO_COB D, FECXC_INPC E,
                FECXC_TPC E,
                FECXC_SEGMULTIMON F
            WHERE A.E_CODIGO = B.E_CODIGO
                  AND A.COD_SEC_CLASIFICA = B.COD_SEC_CLASIFICA
                  AND A.SECMONEDA = C.SECMONEDA
                  AND A.F_DEPOSITO between D.FECHA_INICIO AND D.FECHA_FIN
                  AND D.ANIO_COBRANZA = p_ANIO                    --PARAMETRO DE A?O
                  AND D.MES_COBRANZA <= p_MES
                  AND D.ANIO_COBRANZA = E.ANO_INPC (+)
                  AND D.MES_COBRANZA = E.MES_INPC  (+)
                    AND A.F_DEPOSITO <= p_FECHA
                  AND EXISTS(SELECT 1 FROM FECXC_DET_CLASFECXC clas
                                  WHERE B.COD_SEC_CATCLAS = clas.COD_SEC_CATCLAS
                                      AND B.COD_SEC_DET = clas.COD_SEC_DET
                                    AND clas.EXCLUIR_ENREPORTES = 'NO')
                  AND A.SECMONEDA = E.SECMONEDA (+)
                    AND A.F_DEPOSITO = E.FECHA_TPC (+)
                  AND B.SEGMENTO1 = F.COD_SEC_LIN (+)
            group by A.E_CODIGO, B.SEGMENTO1, C.CODMONEDA, D.MES_COBRANZA;
            /* Se agrega columna adicional para ipc=2*/
            INSERT INTO FECXC_COB_CANAL_ANTERIOR(
               E_CODIGO, SEGMENTO,
               CODMONEDA, MES,COBRANZA_ANTERIOR, COBRANZAREAL_ANTERIOR)
            SELECT A.E_CODIGO, B.SEGMENTO1,
               C.CODMONEDA, D.MES_COBRANZA,sum(B.IMPORTE*(CASE WHEN p_SEGMENTOSESP = 1 AND F.COD_SEC_LIN is not null AND (C.ES_MONEDA_LOCCAL is null OR C.ES_MONEDA_LOCCAL = 0) AND E.TIPO_CAMBIO is not null THEN E.TIPO_CAMBIO ELSE 1 END)*DECODE(C.ES_MONEDA_LOCCAL,1,DECODE(p_INPC,0,1,v_INPC/nvl(E.INPC_ACTUAL,v_INPC)),1))/p_FORMATO COBRANZA_ANTERIOR,
               sum(B.IMPORTE*(CASE WHEN p_SEGMENTOSESP = 1 AND F.COD_SEC_LIN is not null AND (C.ES_MONEDA_LOCCAL is null OR C.ES_MONEDA_LOCCAL = 0) AND E.TIPO_CAMBIO is not null THEN E.TIPO_CAMBIO ELSE 1 END))/p_FORMATO COBRANZAREAL_ANTERIOR
            FROM FECXC_ENC_CLASIFICADOS A, FECXC_DET_CLASIFICADOS B, FECXC_MONEDAS C, FECXC_CALENDARIO_COB D, FECXC_INPC E,
                FECXC_TPC E,
                FECXC_SEGMULTIMON F
            WHERE A.E_CODIGO = B.E_CODIGO
                  AND A.COD_SEC_CLASIFICA = B.COD_SEC_CLASIFICA
                  AND A.SECMONEDA = C.SECMONEDA
                  AND A.F_DEPOSITO between D.FECHA_INICIO AND D.FECHA_FIN
                  AND D.ANIO_COBRANZA = p_ANIO -1                    --PARAMETRO DE A?O
                  AND D.MES_COBRANZA <= p_MES
                  AND D.ANIO_COBRANZA = E.ANO_INPC (+)
                  AND D.MES_COBRANZA = E.MES_INPC  (+)
                      AND A.F_DEPOSITO <= to_date(p_FECHA)-365                 ---PARAMETRO DEL DIA
                  AND EXISTS(SELECT 1 FROM FECXC_DET_CLASFECXC clas
                                  WHERE B.COD_SEC_CATCLAS = clas.COD_SEC_CATCLAS
                                      AND B.COD_SEC_DET = clas.COD_SEC_DET
                                    AND clas.EXCLUIR_ENREPORTES = 'NO')
                  AND A.SECMONEDA = E.SECMONEDA (+)
                    AND A.F_DEPOSITO = E.FECHA_TPC (+)
                  AND B.SEGMENTO1 = F.COD_SEC_LIN (+)
            group by A.E_CODIGO, B.SEGMENTO1, C.CODMONEDA, D.MES_COBRANZA;
            /* Se agrega columna adicional para ipc=2*/
            INSERT INTO FECXC_PRESUP_CANAL_DELMES (
               SEGMENTO, CODMONEDA, MES, PRESUP_MES, PRESUPREAL_MES)
            select B.SEGMENTO1, C.CODMONEDA, D.MES_COBRANZA, sum(B.IMPORTE*DECODE(C.ES_MONEDA_LOCCAL,1,DECODE(p_INPC,0,1,v_INPC/nvl(E.INPC_ACTUAL,v_INPC)),1))/p_FORMATO PRESUP_MES,
            sum(B.IMPORTE)/p_FORMATO PRESUPREAL_MES
            FROM FECXC_ENC_DE_PRESU A, FECXC_DET_PRES_DIARIO B, FECXC_MONEDAS C, FECXC_CALENDARIO_COB D, FECXC_INPC E
            WHERE A.SEC_PRESUP = B.SEC_PRESUP
                  AND A.SECMONEDA = C.SECMONEDA
                  AND B.DIARIO between D.FECHA_INICIO AND D.FECHA_FIN
                  AND D.ANIO_COBRANZA = p_ANIO
                  AND D.MES_COBRANZA <= p_MES
                  AND B.DIARIO <= p_FECHA
                  AND D.ANIO_COBRANZA = E.ANO_INPC (+)
                  AND D.MES_COBRANZA = E.MES_INPC  (+)
            group by B.SEGMENTO1, C.CODMONEDA, D.MES_COBRANZA;
        END IF;
    IF p_SEGMENTOSESP = 1 THEN
        UPDATE FECXC_COB_CANAL_DELDIA up_table
        SET CODMONEDA = (select min(CODMONEDA) from FECXC_MONEDAS M WHERE M.ES_MONEDA_LOCCAL = 1)
        WHERE EXISTS(select 1
                       from FECXC_SEGMULTIMON B
                     WHERE up_table.SEGMENTO = B.COD_SEC_LIN)
            AND EXISTS(SELECT 1
                       from FECXC_MONEDAS C
                       WHERE up_table.CODMONEDA = C.CODMONEDA
                                AND (C.ES_MONEDA_LOCCAL is null
                                      OR C.ES_MONEDA_LOCCAL = 0));
        UPDATE FECXC_COB_CANAL_XMES up_table
        SET CODMONEDA = (select min(CODMONEDA) from FECXC_MONEDAS M WHERE M.ES_MONEDA_LOCCAL = 1)
        WHERE EXISTS(select 1
                       from FECXC_SEGMULTIMON B
                     WHERE up_table.SEGMENTO = B.COD_SEC_LIN)
            AND EXISTS(SELECT 1
                       from FECXC_MONEDAS C
                       WHERE up_table.CODMONEDA = C.CODMONEDA
                                AND (C.ES_MONEDA_LOCCAL is null
                                      OR C.ES_MONEDA_LOCCAL = 0));
        UPDATE FECXC_COB_CANAL_ANTERIOR up_table
        SET CODMONEDA = (select min(CODMONEDA) from FECXC_MONEDAS M WHERE M.ES_MONEDA_LOCCAL = 1)
        WHERE EXISTS(select 1
                       from FECXC_SEGMULTIMON B
                     WHERE up_table.SEGMENTO = B.COD_SEC_LIN)
            AND EXISTS(SELECT 1
                       from FECXC_MONEDAS C
                       WHERE up_table.CODMONEDA = C.CODMONEDA
                                AND (C.ES_MONEDA_LOCCAL is null
                                      OR C.ES_MONEDA_LOCCAL = 0));
           INSERT INTO FECXC_COB_CANAL_DELDIA_tmp(E_CODIGO, SEGMENTO,CODMONEDA, MES,COBRANZA_DIA)
        select E_CODIGO, SEGMENTO,CODMONEDA, MES, sum(COBRANZA_DIA)
        from FECXC_COB_CANAL_DELDIA
        group by E_CODIGO, SEGMENTO,CODMONEDA, MES;
        INSERT INTO FECXC_COB_CANAL_XMES_tmp(E_CODIGO, SEGMENTO, CODMONEDA, MES, COBRANZA_MES, COBRANZAREAL_MES)
        SELECT E_CODIGO, SEGMENTO, CODMONEDA, MES, sum(COBRANZA_MES), sum(COBRANZAREAL_MES)
        FROM FECXC_COB_CANAL_XMES
        GROUP BY E_CODIGO, SEGMENTO, CODMONEDA, MES;
        INSERT INTO FECXC_COB_CANAL_ANTERIOR_tmp(E_CODIGO, SEGMENTO, CODMONEDA, MES, COBRANZA_ANTERIOR, COBRANZAREAL_ANTERIOR)
        SELECT E_CODIGO, SEGMENTO, CODMONEDA, MES, sum(COBRANZA_ANTERIOR), sum(COBRANZAREAL_ANTERIOR)
        FROM FECXC_COB_CANAL_ANTERIOR
        GROUP BY E_CODIGO, SEGMENTO, CODMONEDA, MES;
        DELETE FECXC_COB_CANAL_DELDIA;
           INSERT INTO FECXC_COB_CANAL_DELDIA(E_CODIGO, SEGMENTO,CODMONEDA, MES,COBRANZA_DIA)
        select E_CODIGO, SEGMENTO,CODMONEDA, MES,COBRANZA_DIA
        from FECXC_COB_CANAL_DELDIA_tmp;
        delete FECXC_COB_CANAL_XMES;
        INSERT INTO FECXC_COB_CANAL_XMES(E_CODIGO, SEGMENTO, CODMONEDA, MES, COBRANZA_MES, COBRANZAREAL_MES)
        SELECT E_CODIGO, SEGMENTO, CODMONEDA, MES, COBRANZA_MES, COBRANZAREAL_MES
        FROM FECXC_COB_CANAL_XMES_tmp;
        DELETE FECXC_COB_CANAL_ANTERIOR;
        INSERT INTO FECXC_COB_CANAL_ANTERIOR(E_CODIGO, SEGMENTO, CODMONEDA, MES, COBRANZA_ANTERIOR, COBRANZAREAL_ANTERIOR)
        SELECT E_CODIGO, SEGMENTO, CODMONEDA, MES, COBRANZA_ANTERIOR, COBRANZAREAL_ANTERIOR
        FROM FECXC_COB_CANAL_ANTERIOR_tmp;
      END IF;
END IF;
IF p_TIPO = 3 THEN
    /***************************************************************************************************************************
                L L E N A D O   D E   E S T R U C T U R A   P A R A   I N T E R M E X
   ***************************************************************************************************************************/
    delete FECXC_CANINTER_DELDIA;
    delete FECXC_CANINTER_XMES_pre;
    delete FECXC_CANINTER_XMES_cob_act;
    delete FECXC_CANINTER_XMES_cob_ant;
    delete FECXC_CANINTER_ALAFECHA_pre;
    delete FECXC_CANINTER_ALAFECH_cob_act;
    delete FECXC_CANINTER_ALAFECH_cob_ant;
    DELETE FECXC_PARAMETROS_INTERMEX;
    INSERT INTO FECXC_PARAMETROS_INTERMEX(ANIO,MES,FECHA,ACTUALIZADO)
    values (p_ANIO,p_MES,p_FECHA,tipo_reporte_inpc);
    /*Para el caso en que el reporte debe presentar cifras reales y actualizadas, se agreg? una columna*/
    /*que a pesar de tener la palabra REAL contendr? las cifras nominales */
    /*y el resto se calcular? para cifras reales*/
        ----------------------DESDE AQUI PARTE 'DEL DIA'--------------------------------------
        INSERT INTO FECXC_CANINTER_DELDIA(
           E_CODIGO, SEGMENTO, CANAL,
           CODMONEDA, MES,COBRANZA_DIA)
        SELECT A.E_CODIGO, B.SEGMENTO1,B.SEGMENTO3,
           C.CODMONEDA, 0,sum(B.IMPORTE*(CASE
            WHEN p_SEGMENTOSESP = 0
               THEN 1
            ELSE
               CASE
                    WHEN F.COD_SEC_LIN IS NULL
                        THEN 1
                    WHEN F.COD_SEC_LIN IS NOT NULL AND F.SECMONEDA = (SELECT NVL(q.EQ_SIF,0) FROM AD_FECXC.FECXC_MONEDAS_EQUIVALENCIA q WHERE q.SECMONEDA = A.SECMONEDA)
                        THEN 1
                    WHEN F.COD_SEC_LIN IS NOT NULL AND F.SECMONEDA IN(22)
                         AND F.SECMONEDA <> (SELECT NVL(q.EQ_SIF,0) FROM AD_FECXC.FECXC_MONEDAS_EQUIVALENCIA q WHERE q.SECMONEDA = A.SECMONEDA)
                        THEN E.TIPO_CAMBIO
                    WHEN F.COD_SEC_LIN IS NOT NULL AND F.SECMONEDA NOT IN(22)
                         AND (SELECT NVL(q.EQ_SIF,0) FROM AD_FECXC.FECXC_MONEDAS_EQUIVALENCIA q WHERE q.SECMONEDA = A.SECMONEDA) = 22
                        THEN (SELECT TIPO_CAMBIO_DLS FROM FECXC_TPC WHERE FECHA_TPC = A.F_DEPOSITO AND SECMONEDA = F.SECMONEDA)
                    WHEN
                         F.COD_SEC_LIN IS NOT NULL
                         AND F.SECMONEDA NOT IN (22)
                         AND F.SECMONEDA <> (SELECT NVL(q.EQ_SIF,0) FROM AD_FECXC.FECXC_MONEDAS_EQUIVALENCIA q WHERE q.SECMONEDA = A.SECMONEDA)
                        THEN
                            (SELECT ROUND(CONVERSION_RATE,4)
                              FROM FECXC_TPC_MULTIMONEDA_VW
                              WHERE FROM_CURRENCY = (SELECT MON_ORACLE FROM AD_FECXC.FECXC_TPC_MULTIMONEDA WHERE SECMONEDA = (SELECT NVL(q.EQ_SIF,0) FROM AD_FECXC.FECXC_MONEDAS_EQUIVALENCIA q WHERE q.SECMONEDA = A.SECMONEDA))
                              AND TO_CURRENCY = (SELECT MON_ORACLE FROM AD_FECXC.FECXC_TPC_MULTIMONEDA WHERE SECMONEDA = F.SECMONEDA)
                              AND CONVERSION_DATE = A.F_DEPOSITO
                            )
                    ELSE 1
               END
       END))/p_FORMATO COBRANZA_DIA
        FROM FECXC_ENC_CLASIFICADOS A, FECXC_DET_CLASIFICADOS B, FECXC_MONEDAS C, FECXC_CALENDARIO_COB D,
            FECXC_TPC E,
            FECXC_SEGMULTIMON F
        WHERE A.E_CODIGO = B.E_CODIGO
              AND A.COD_SEC_CLASIFICA = B.COD_SEC_CLASIFICA
              AND A.SECMONEDA = C.SECMONEDA
              AND A.F_DEPOSITO between D.FECHA_INICIO AND D.FECHA_FIN
              AND A.F_DEPOSITO = p_FECHA                ---PARAMETRO DEL DIA
              AND EXISTS(SELECT 1 FROM FECXC_DET_CLASFECXC clas
                          WHERE B.COD_SEC_CATCLAS = clas.COD_SEC_CATCLAS
                                  AND B.COD_SEC_DET = clas.COD_SEC_DET
                                AND clas.EXCLUIR_ENREPORTES = 'NO')
              AND A.SECMONEDA = E.SECMONEDA (+)
                AND A.F_DEPOSITO = E.FECHA_TPC (+)
              AND B.SEGMENTO1 = F.COD_SEC_LIN (+)
          group by A.E_CODIGO, B.SEGMENTO1,B.SEGMENTO3, D.MES_COBRANZA, C.CODMONEDA;
        ----------------------HASTA AQUI PARTE 'DEL DIA'--------------------------------------
        ----------------------DESDE AQUI PARTE 'DEL MES'--------------------------------------
        IF p_MENSUALIZADO = 0 THEN           /* MENSUALIZADO... */
                INSERT INTO FECXC_CANINTER_XMES_pre (
                   SEGMENTO, CANAL,CODMONEDA, MES, PRESUP_MES)
                select B.SEGMENTO1,B.SEGMENTO3, C.CODMONEDA, D.MES_COBRANZA, sum(B.IMPORTE)/p_FORMATO
                FROM FECXC_ENC_DE_PRESU A, FECXC_DET_PRES_DIARIO B, FECXC_MONEDAS C, FECXC_CALENDARIO_COB D
                WHERE A.SEC_PRESUP = B.SEC_PRESUP
                      AND A.SECMONEDA = C.SECMONEDA
                      AND B.DIARIO between D.FECHA_INICIO AND D.FECHA_FIN
                      AND D.ANIO_COBRANZA = p_ANIO
                      AND D.MES_COBRANZA = p_MES
                group by B.SEGMENTO1,B.SEGMENTO3, C.CODMONEDA, D.MES_COBRANZA;
                INSERT INTO FECXC_CANINTER_XMES_cob_act(E_CODIGO, SEGMENTO, CANAL,CODMONEDA, MES,COBRANZA_MES)
                SELECT A.E_CODIGO, B.SEGMENTO1,B.SEGMENTO3,
                   C.CODMONEDA, D.MES_COBRANZA,sum(B.IMPORTE*(CASE
                        WHEN p_SEGMENTOSESP = 0
                           THEN 1
                        ELSE
                           CASE
                                WHEN F.COD_SEC_LIN IS NULL
                                    THEN 1
                                WHEN F.COD_SEC_LIN IS NOT NULL AND F.SECMONEDA = (SELECT NVL(q.EQ_SIF,0) FROM AD_FECXC.FECXC_MONEDAS_EQUIVALENCIA q WHERE q.SECMONEDA = A.SECMONEDA)
                                    THEN 1
                                WHEN F.COD_SEC_LIN IS NOT NULL AND F.SECMONEDA IN(22)
                                     AND F.SECMONEDA <> (SELECT NVL(q.EQ_SIF,0) FROM AD_FECXC.FECXC_MONEDAS_EQUIVALENCIA q WHERE q.SECMONEDA = A.SECMONEDA)
                                    THEN E.TIPO_CAMBIO
                                WHEN F.COD_SEC_LIN IS NOT NULL AND F.SECMONEDA NOT IN(22)
                                     AND (SELECT NVL(q.EQ_SIF,0) FROM AD_FECXC.FECXC_MONEDAS_EQUIVALENCIA q WHERE q.SECMONEDA = A.SECMONEDA) = 22
                                    THEN (SELECT TIPO_CAMBIO_DLS FROM FECXC_TPC WHERE FECHA_TPC = A.F_DEPOSITO AND SECMONEDA = F.SECMONEDA)
                                WHEN
                                     F.COD_SEC_LIN IS NOT NULL
                                     AND F.SECMONEDA NOT IN (22)
                                     AND F.SECMONEDA <> (SELECT NVL(q.EQ_SIF,0) FROM AD_FECXC.FECXC_MONEDAS_EQUIVALENCIA q WHERE q.SECMONEDA = A.SECMONEDA)
                                    THEN
                                        (SELECT ROUND(CONVERSION_RATE,4)
                                          FROM FECXC_TPC_MULTIMONEDA_VW
                                          WHERE FROM_CURRENCY = (SELECT MON_ORACLE FROM AD_FECXC.FECXC_TPC_MULTIMONEDA WHERE SECMONEDA = (SELECT NVL(q.EQ_SIF,0) FROM AD_FECXC.FECXC_MONEDAS_EQUIVALENCIA q WHERE q.SECMONEDA = A.SECMONEDA))
                                          AND TO_CURRENCY = (SELECT MON_ORACLE FROM AD_FECXC.FECXC_TPC_MULTIMONEDA WHERE SECMONEDA = F.SECMONEDA)
                                          AND CONVERSION_DATE = A.F_DEPOSITO
                                        )
                                ELSE 1
                           END
                   END))/p_FORMATO COBRANZA_MES
                FROM FECXC_ENC_CLASIFICADOS A, FECXC_DET_CLASIFICADOS B, FECXC_MONEDAS C, FECXC_CALENDARIO_COB D,
                    FECXC_TPC E,
                    FECXC_SEGMULTIMON F
                WHERE A.E_CODIGO = B.E_CODIGO
                      AND A.COD_SEC_CLASIFICA = B.COD_SEC_CLASIFICA
                      AND A.SECMONEDA = C.SECMONEDA
                      AND A.F_DEPOSITO between D.FECHA_INICIO AND D.FECHA_FIN
                      AND D.ANIO_COBRANZA = p_ANIO                    --PARAMETRO DE A?O
                      AND D.MES_COBRANZA = p_MES                    --PARAMETRO DE A?O
                      AND EXISTS(SELECT 1 FROM FECXC_DET_CLASFECXC clas
                                      WHERE B.COD_SEC_CATCLAS = clas.COD_SEC_CATCLAS
                                          AND B.COD_SEC_DET = clas.COD_SEC_DET
                                        AND clas.EXCLUIR_ENREPORTES = 'NO')
                      AND A.SECMONEDA = E.SECMONEDA (+)
                        AND A.F_DEPOSITO = E.FECHA_TPC (+)
                      AND B.SEGMENTO1 = F.COD_SEC_LIN (+)
                group by A.E_CODIGO, B.SEGMENTO1,B.SEGMENTO3, C.CODMONEDA, D.MES_COBRANZA;
                /*Se agrega la columna de cobranzareal_mes*/
                INSERT INTO FECXC_CANINTER_XMES_cob_ant(
                   E_CODIGO, SEGMENTO, CANAL,
                   CODMONEDA, MES,COBRANZA_MES, COBRANZAREAL_MES)
                SELECT A.E_CODIGO, B.SEGMENTO1,B.SEGMENTO3,
                   C.CODMONEDA, D.MES_COBRANZA,sum(B.IMPORTE*(CASE
                        WHEN p_SEGMENTOSESP = 0
                           THEN 1
                        ELSE
                           CASE
                                WHEN F.COD_SEC_LIN IS NULL
                                   THEN 1
                                WHEN F.COD_SEC_LIN IS NOT NULL AND F.SECMONEDA = (SELECT NVL(q.EQ_SIF,0) FROM AD_FECXC.FECXC_MONEDAS_EQUIVALENCIA q WHERE q.SECMONEDA = A.SECMONEDA)
                                    AND (SELECT NVL(q.EQ_SIF,0) FROM AD_FECXC.FECXC_MONEDAS_EQUIVALENCIA q WHERE q.SECMONEDA = A.SECMONEDA) IN(22)
                                   THEN DECODE(p_INPC,1,v_INPC/nvl(E.INPC_ACTUAL,v_INPC),1)
                                WHEN F.COD_SEC_LIN IS NOT NULL AND F.SECMONEDA = (SELECT NVL(q.EQ_SIF,0) FROM AD_FECXC.FECXC_MONEDAS_EQUIVALENCIA q WHERE q.SECMONEDA = A.SECMONEDA)
                                    AND (SELECT NVL(q.EQ_SIF,0) FROM AD_FECXC.FECXC_MONEDAS_EQUIVALENCIA q WHERE q.SECMONEDA = A.SECMONEDA) NOT IN(22)
                                   THEN 1
                                WHEN F.COD_SEC_LIN IS NOT NULL AND F.SECMONEDA IN(22)
                                     AND F.SECMONEDA <> (SELECT NVL(q.EQ_SIF,0) FROM AD_FECXC.FECXC_MONEDAS_EQUIVALENCIA q WHERE q.SECMONEDA = A.SECMONEDA)
                                   THEN E.TIPO_CAMBIO
                                WHEN F.COD_SEC_LIN IS NOT NULL AND F.SECMONEDA NOT IN(22)
                                     AND (SELECT NVL(q.EQ_SIF,0) FROM AD_FECXC.FECXC_MONEDAS_EQUIVALENCIA q WHERE q.SECMONEDA = A.SECMONEDA) IN(22)
                                   THEN (SELECT TIPO_CAMBIO_DLS FROM FECXC_TPC WHERE FECHA_TPC = A.F_DEPOSITO AND SECMONEDA = F.SECMONEDA) * DECODE(p_INPC,1,v_INPC/nvl(E.INPC_ACTUAL,v_INPC),1)
                                WHEN
                                     F.COD_SEC_LIN IS NOT NULL
                                     AND F.SECMONEDA NOT IN (22)
                                     AND F.SECMONEDA <> (SELECT NVL(q.EQ_SIF,0) FROM AD_FECXC.FECXC_MONEDAS_EQUIVALENCIA q WHERE q.SECMONEDA = A.SECMONEDA)
                                   THEN
                                        (SELECT ROUND(CONVERSION_RATE,4)
                                          FROM FECXC_TPC_MULTIMONEDA_VW
                                          WHERE FROM_CURRENCY = (SELECT MON_ORACLE FROM AD_FECXC.FECXC_TPC_MULTIMONEDA WHERE SECMONEDA = (SELECT NVL(q.EQ_SIF,0) FROM AD_FECXC.FECXC_MONEDAS_EQUIVALENCIA q WHERE q.SECMONEDA = A.SECMONEDA))
                                          AND TO_CURRENCY = (SELECT MON_ORACLE FROM AD_FECXC.FECXC_TPC_MULTIMONEDA WHERE SECMONEDA = F.SECMONEDA)
                                          AND CONVERSION_DATE = A.F_DEPOSITO
                                        )
                                ELSE 1
                           END
                   END))/p_FORMATO COBRANZA_MES, sum(B.IMPORTE*(CASE
                        WHEN p_SEGMENTOSESP = 0
                           THEN 1
                        ELSE
                           CASE
                                WHEN F.COD_SEC_LIN IS NULL
                                    THEN 1
                                WHEN F.COD_SEC_LIN IS NOT NULL AND F.SECMONEDA = (SELECT NVL(q.EQ_SIF,0) FROM AD_FECXC.FECXC_MONEDAS_EQUIVALENCIA q WHERE q.SECMONEDA = A.SECMONEDA)
                                    THEN 1
                                WHEN F.COD_SEC_LIN IS NOT NULL AND F.SECMONEDA IN(22)
                                     AND F.SECMONEDA <> (SELECT NVL(q.EQ_SIF,0) FROM AD_FECXC.FECXC_MONEDAS_EQUIVALENCIA q WHERE q.SECMONEDA = A.SECMONEDA)
                                    THEN E.TIPO_CAMBIO
                                WHEN F.COD_SEC_LIN IS NOT NULL AND F.SECMONEDA NOT IN(22)
                                     AND (SELECT NVL(q.EQ_SIF,0) FROM AD_FECXC.FECXC_MONEDAS_EQUIVALENCIA q WHERE q.SECMONEDA = A.SECMONEDA) = 22
                                    THEN (SELECT TIPO_CAMBIO_DLS FROM FECXC_TPC WHERE FECHA_TPC = A.F_DEPOSITO AND SECMONEDA = F.SECMONEDA)
                                WHEN
                                     F.COD_SEC_LIN IS NOT NULL
                                     AND F.SECMONEDA NOT IN (22)
                                     AND F.SECMONEDA <> (SELECT NVL(q.EQ_SIF,0) FROM AD_FECXC.FECXC_MONEDAS_EQUIVALENCIA q WHERE q.SECMONEDA = A.SECMONEDA)
                                    THEN
                                        (SELECT ROUND(CONVERSION_RATE,4)
                                          FROM FECXC_TPC_MULTIMONEDA_VW
                                          WHERE FROM_CURRENCY = (SELECT MON_ORACLE FROM AD_FECXC.FECXC_TPC_MULTIMONEDA WHERE SECMONEDA = (SELECT NVL(q.EQ_SIF,0) FROM AD_FECXC.FECXC_MONEDAS_EQUIVALENCIA q WHERE q.SECMONEDA = A.SECMONEDA))
                                          AND TO_CURRENCY = (SELECT MON_ORACLE FROM AD_FECXC.FECXC_TPC_MULTIMONEDA WHERE SECMONEDA = F.SECMONEDA)
                                          AND CONVERSION_DATE = A.F_DEPOSITO
                                        )
                                ELSE 1
                           END
                   END))/p_FORMATO COBRANZAREAL_MES
                FROM FECXC_ENC_CLASIFICADOS A, FECXC_DET_CLASIFICADOS B, FECXC_MONEDAS C, FECXC_CALENDARIO_COB D, FECXC_INPC E,
                    FECXC_TPC E,
                    FECXC_SEGMULTIMON F
                WHERE A.E_CODIGO = B.E_CODIGO
                      AND A.COD_SEC_CLASIFICA = B.COD_SEC_CLASIFICA
                      AND A.SECMONEDA = C.SECMONEDA
                      AND A.F_DEPOSITO between D.FECHA_INICIO AND D.FECHA_FIN
                      AND D.ANIO_COBRANZA = p_ANIO-1                    --PARAMETRO DE A?O
                      AND D.MES_COBRANZA = p_MES                    --PARAMETRO DE A?O
                      AND D.ANIO_COBRANZA = E.ANO_INPC (+)
                      AND D.MES_COBRANZA = E.MES_INPC  (+)
                      AND EXISTS(SELECT 1 FROM FECXC_DET_CLASFECXC clas
                                      WHERE B.COD_SEC_CATCLAS = clas.COD_SEC_CATCLAS
                                          AND B.COD_SEC_DET = clas.COD_SEC_DET
                                        AND clas.EXCLUIR_ENREPORTES = 'NO')
                      AND A.SECMONEDA = E.SECMONEDA (+)
                        AND A.F_DEPOSITO = E.FECHA_TPC (+)
                      AND B.SEGMENTO1 = F.COD_SEC_LIN (+)
                group by A.E_CODIGO, B.SEGMENTO1,B.SEGMENTO3,C.CODMONEDA, D.MES_COBRANZA;
                    ----------------------DESDE AQUI PARTE 'A LA FECHA'-----------------------------------
                /*se agrega columna*/
                INSERT INTO FECXC_CANINTER_ALAFECHA_pre(
                   SEGMENTO, CANAL,CODMONEDA, MES, PRESUP_MES, PRESUPREAL_MES)
                select B.SEGMENTO1,B.SEGMENTO3, C.CODMONEDA, D.MES_COBRANZA, sum(B.IMPORTE*DECODE(C.ES_MONEDA_LOCCAL,1,DECODE(p_INPC,0,1,v_INPC/nvl(E.INPC_ACTUAL,v_INPC)),1))/p_FORMATO PRESUP_MES,
                sum(B.IMPORTE)/p_FORMATO PRESUPREAL_MES
                FROM FECXC_ENC_DE_PRESU A, FECXC_DET_PRES_DIARIO B, FECXC_MONEDAS C, FECXC_CALENDARIO_COB D, FECXC_INPC E
                WHERE A.SEC_PRESUP = B.SEC_PRESUP
                      AND A.SECMONEDA = C.SECMONEDA
                      AND B.DIARIO between D.FECHA_INICIO AND D.FECHA_FIN
                      AND D.ANIO_COBRANZA = p_ANIO
                      AND D.MES_COBRANZA <= p_MES
                      AND D.ANIO_COBRANZA = E.ANO_INPC (+)
                      AND D.MES_COBRANZA = E.MES_INPC  (+)
                group by B.SEGMENTO1,B.SEGMENTO3, C.CODMONEDA, D.MES_COBRANZA;
                /*Se agrega columna para c?lculo nominal*/
                INSERT INTO FECXC_CANINTER_ALAFECH_cob_act(
                   E_CODIGO, SEGMENTO, CANAL,
                   CODMONEDA, MES,COBRANZA_MES, COBRANZAREAL_MES)
                SELECT A.E_CODIGO, B.SEGMENTO1,B.SEGMENTO3,
                   C.CODMONEDA, D.MES_COBRANZA,sum(B.IMPORTE*(CASE
                        WHEN p_SEGMENTOSESP = 0
                           THEN 1
                        ELSE
                           CASE
                                WHEN F.COD_SEC_LIN IS NULL
                                   THEN 1
                                WHEN F.COD_SEC_LIN IS NOT NULL AND F.SECMONEDA = (SELECT NVL(q.EQ_SIF,0) FROM AD_FECXC.FECXC_MONEDAS_EQUIVALENCIA q WHERE q.SECMONEDA = A.SECMONEDA)
                                    AND A.SECMONEDA IN(22)
                                   THEN DECODE(p_INPC,1,v_INPC/nvl(E.INPC_ACTUAL,v_INPC),1)
                                WHEN F.COD_SEC_LIN IS NOT NULL AND F.SECMONEDA = (SELECT NVL(q.EQ_SIF,0) FROM AD_FECXC.FECXC_MONEDAS_EQUIVALENCIA q WHERE q.SECMONEDA = A.SECMONEDA)
                                    AND (SELECT NVL(q.EQ_SIF,0) FROM AD_FECXC.FECXC_MONEDAS_EQUIVALENCIA q WHERE q.SECMONEDA = A.SECMONEDA) NOT IN(22)
                                   THEN 1
                                WHEN F.COD_SEC_LIN IS NOT NULL AND F.SECMONEDA IN(22)
                                     AND F.SECMONEDA <> (SELECT NVL(q.EQ_SIF,0) FROM AD_FECXC.FECXC_MONEDAS_EQUIVALENCIA q WHERE q.SECMONEDA = A.SECMONEDA)
                                   THEN E.TIPO_CAMBIO
                                WHEN F.COD_SEC_LIN IS NOT NULL AND F.SECMONEDA NOT IN(22)
                                     AND (SELECT NVL(q.EQ_SIF,0) FROM AD_FECXC.FECXC_MONEDAS_EQUIVALENCIA q WHERE q.SECMONEDA = A.SECMONEDA) IN(22)
                                   THEN (SELECT TIPO_CAMBIO_DLS FROM FECXC_TPC WHERE FECHA_TPC = A.F_DEPOSITO AND SECMONEDA = F.SECMONEDA) * DECODE(p_INPC,1,v_INPC/nvl(E.INPC_ACTUAL,v_INPC),1)
                                WHEN
                                     F.COD_SEC_LIN IS NOT NULL
                                     AND F.SECMONEDA NOT IN (22)
                                     AND F.SECMONEDA <> (SELECT NVL(q.EQ_SIF,0) FROM AD_FECXC.FECXC_MONEDAS_EQUIVALENCIA q WHERE q.SECMONEDA = A.SECMONEDA)
                                   THEN
                                        (SELECT ROUND(CONVERSION_RATE,4)
                                          FROM FECXC_TPC_MULTIMONEDA_VW
                                          WHERE FROM_CURRENCY = (SELECT MON_ORACLE FROM AD_FECXC.FECXC_TPC_MULTIMONEDA WHERE SECMONEDA = (SELECT NVL(q.EQ_SIF,0) FROM AD_FECXC.FECXC_MONEDAS_EQUIVALENCIA q WHERE q.SECMONEDA = A.SECMONEDA))
                                          AND TO_CURRENCY = (SELECT MON_ORACLE FROM AD_FECXC.FECXC_TPC_MULTIMONEDA WHERE SECMONEDA = F.SECMONEDA)
                                          AND CONVERSION_DATE = A.F_DEPOSITO
                                        )
                                ELSE 1
                           END
                   END))/p_FORMATO COBRANZA_MES, sum(B.IMPORTE*(CASE
                        WHEN p_SEGMENTOSESP = 0
                           THEN 1
                        ELSE
                           CASE
                                WHEN F.COD_SEC_LIN IS NULL
                                    THEN 1
                                WHEN F.COD_SEC_LIN IS NOT NULL AND F.SECMONEDA = (SELECT NVL(q.EQ_SIF,0) FROM AD_FECXC.FECXC_MONEDAS_EQUIVALENCIA q WHERE q.SECMONEDA = A.SECMONEDA)
                                    THEN 1
                                WHEN F.COD_SEC_LIN IS NOT NULL AND F.SECMONEDA IN(22)
                                     AND F.SECMONEDA <> (SELECT NVL(q.EQ_SIF,0) FROM AD_FECXC.FECXC_MONEDAS_EQUIVALENCIA q WHERE q.SECMONEDA = A.SECMONEDA)
                                    THEN E.TIPO_CAMBIO
                                WHEN F.COD_SEC_LIN IS NOT NULL AND F.SECMONEDA NOT IN(22)
                                     AND (SELECT NVL(q.EQ_SIF,0) FROM AD_FECXC.FECXC_MONEDAS_EQUIVALENCIA q WHERE q.SECMONEDA = A.SECMONEDA) = 22
                                    THEN (SELECT TIPO_CAMBIO_DLS FROM FECXC_TPC WHERE FECHA_TPC = A.F_DEPOSITO AND SECMONEDA = F.SECMONEDA)
                                WHEN
                                     F.COD_SEC_LIN IS NOT NULL
                                     AND F.SECMONEDA NOT IN (22)
                                     AND F.SECMONEDA <> (SELECT NVL(q.EQ_SIF,0) FROM AD_FECXC.FECXC_MONEDAS_EQUIVALENCIA q WHERE q.SECMONEDA = A.SECMONEDA)
                                    THEN
                                        (SELECT ROUND(CONVERSION_RATE,4)
                                          FROM FECXC_TPC_MULTIMONEDA_VW
                                          WHERE FROM_CURRENCY = (SELECT MON_ORACLE FROM AD_FECXC.FECXC_TPC_MULTIMONEDA WHERE SECMONEDA = (SELECT NVL(q.EQ_SIF,0) FROM AD_FECXC.FECXC_MONEDAS_EQUIVALENCIA q WHERE q.SECMONEDA = A.SECMONEDA))
                                          AND TO_CURRENCY = (SELECT MON_ORACLE FROM AD_FECXC.FECXC_TPC_MULTIMONEDA WHERE SECMONEDA = F.SECMONEDA)
                                          AND CONVERSION_DATE = A.F_DEPOSITO
                                        )
                                ELSE 1
                           END
                   END))/p_FORMATO COBRANZAREAL_MES
                FROM FECXC_ENC_CLASIFICADOS A, FECXC_DET_CLASIFICADOS B, FECXC_MONEDAS C, FECXC_CALENDARIO_COB D, FECXC_INPC E,
                    FECXC_TPC E,
                    FECXC_SEGMULTIMON F
                WHERE A.E_CODIGO = B.E_CODIGO
                      AND A.COD_SEC_CLASIFICA = B.COD_SEC_CLASIFICA
                      AND A.SECMONEDA = C.SECMONEDA
                      AND A.F_DEPOSITO between D.FECHA_INICIO AND D.FECHA_FIN
                      AND D.ANIO_COBRANZA =p_ANIO                ---PARAMETRO DE A?O
                      AND D.MES_COBRANZA <= p_MES
                      AND D.ANIO_COBRANZA = E.ANO_INPC (+)
                      AND D.MES_COBRANZA = E.MES_INPC  (+)
                      AND EXISTS(SELECT 1 FROM FECXC_DET_CLASFECXC clas
                                      WHERE B.COD_SEC_CATCLAS = clas.COD_SEC_CATCLAS
                                          AND B.COD_SEC_DET = clas.COD_SEC_DET
                                        AND clas.EXCLUIR_ENREPORTES = 'NO')
                      AND A.SECMONEDA = E.SECMONEDA (+)
                        AND A.F_DEPOSITO = E.FECHA_TPC (+)
                      AND B.SEGMENTO1 = F.COD_SEC_LIN (+)
                group by A.E_CODIGO, B.SEGMENTO1,B.SEGMENTO3, C.CODMONEDA, D.MES_COBRANZA;
                /*Se agrega columna para c?lculo nominal*/
                INSERT INTO FECXC_CANINTER_ALAFECH_cob_ant(
                   E_CODIGO, SEGMENTO, CANAL,
                   CODMONEDA, MES,COBRANZA_MES, COBRANZAREAL_MES)
                SELECT A.E_CODIGO, B.SEGMENTO1,B.SEGMENTO3,
                   C.CODMONEDA, D.MES_COBRANZA,sum(B.IMPORTE*(CASE
                        WHEN p_SEGMENTOSESP = 0
                           THEN 1
                        ELSE
                           CASE
                                WHEN F.COD_SEC_LIN IS NULL
                                   THEN 1
                                WHEN F.COD_SEC_LIN IS NOT NULL AND F.SECMONEDA = (SELECT NVL(q.EQ_SIF,0) FROM AD_FECXC.FECXC_MONEDAS_EQUIVALENCIA q WHERE q.SECMONEDA = A.SECMONEDA)
                                    AND (SELECT NVL(q.EQ_SIF,0) FROM AD_FECXC.FECXC_MONEDAS_EQUIVALENCIA q WHERE q.SECMONEDA = A.SECMONEDA) IN(22)
                                   THEN DECODE(p_INPC,1,v_INPC/nvl(E.INPC_ACTUAL,v_INPC),1)
                                WHEN F.COD_SEC_LIN IS NOT NULL AND F.SECMONEDA = (SELECT NVL(q.EQ_SIF,0) FROM AD_FECXC.FECXC_MONEDAS_EQUIVALENCIA q WHERE q.SECMONEDA = A.SECMONEDA)
                                    AND (SELECT NVL(q.EQ_SIF,0) FROM AD_FECXC.FECXC_MONEDAS_EQUIVALENCIA q WHERE q.SECMONEDA = A.SECMONEDA) NOT IN(22)
                                   THEN 1
                                WHEN F.COD_SEC_LIN IS NOT NULL AND F.SECMONEDA IN(22)
                                     AND F.SECMONEDA <> (SELECT NVL(q.EQ_SIF,0) FROM AD_FECXC.FECXC_MONEDAS_EQUIVALENCIA q WHERE q.SECMONEDA = A.SECMONEDA)
                                   THEN E.TIPO_CAMBIO
                                WHEN F.COD_SEC_LIN IS NOT NULL AND F.SECMONEDA NOT IN(22)
                                     AND (SELECT NVL(q.EQ_SIF,0) FROM AD_FECXC.FECXC_MONEDAS_EQUIVALENCIA q WHERE q.SECMONEDA = A.SECMONEDA) IN(22)
                                   THEN (SELECT TIPO_CAMBIO_DLS FROM FECXC_TPC WHERE FECHA_TPC = A.F_DEPOSITO AND SECMONEDA = F.SECMONEDA) * DECODE(p_INPC,1,v_INPC/nvl(E.INPC_ACTUAL,v_INPC),1)
                                WHEN
                                     F.COD_SEC_LIN IS NOT NULL
                                     AND F.SECMONEDA NOT IN (22)
                                     AND F.SECMONEDA <> (SELECT NVL(q.EQ_SIF,0) FROM AD_FECXC.FECXC_MONEDAS_EQUIVALENCIA q WHERE q.SECMONEDA = A.SECMONEDA)
                                   THEN
                                        (SELECT ROUND(CONVERSION_RATE,4)
                                          FROM FECXC_TPC_MULTIMONEDA_VW
                                          WHERE FROM_CURRENCY = (SELECT MON_ORACLE FROM AD_FECXC.FECXC_TPC_MULTIMONEDA WHERE SECMONEDA = (SELECT NVL(q.EQ_SIF,0) FROM AD_FECXC.FECXC_MONEDAS_EQUIVALENCIA q WHERE q.SECMONEDA = A.SECMONEDA))
                                          AND TO_CURRENCY = (SELECT MON_ORACLE FROM AD_FECXC.FECXC_TPC_MULTIMONEDA WHERE SECMONEDA = F.SECMONEDA)
                                          AND CONVERSION_DATE = A.F_DEPOSITO
                                        )
                                ELSE 1
                           END
                   END))/p_FORMATO COBRANZA_ALAFECHA, sum(B.IMPORTE*(CASE
                        WHEN p_SEGMENTOSESP = 0
                           THEN 1
                        ELSE
                           CASE
                                WHEN F.COD_SEC_LIN IS NULL
                                    THEN 1
                                WHEN F.COD_SEC_LIN IS NOT NULL AND F.SECMONEDA = (SELECT NVL(q.EQ_SIF,0) FROM AD_FECXC.FECXC_MONEDAS_EQUIVALENCIA q WHERE q.SECMONEDA = A.SECMONEDA)
                                    THEN 1
                                WHEN F.COD_SEC_LIN IS NOT NULL AND F.SECMONEDA IN(22)
                                     AND F.SECMONEDA <> (SELECT NVL(q.EQ_SIF,0) FROM AD_FECXC.FECXC_MONEDAS_EQUIVALENCIA q WHERE q.SECMONEDA = A.SECMONEDA)
                                    THEN E.TIPO_CAMBIO
                                WHEN F.COD_SEC_LIN IS NOT NULL AND F.SECMONEDA NOT IN(22)
                                     AND (SELECT NVL(q.EQ_SIF,0) FROM AD_FECXC.FECXC_MONEDAS_EQUIVALENCIA q WHERE q.SECMONEDA = A.SECMONEDA) = 22
                                    THEN (SELECT TIPO_CAMBIO_DLS FROM FECXC_TPC WHERE FECHA_TPC = A.F_DEPOSITO AND SECMONEDA = F.SECMONEDA)
                                WHEN
                                     F.COD_SEC_LIN IS NOT NULL
                                     AND F.SECMONEDA NOT IN (22)
                                     AND F.SECMONEDA <> (SELECT NVL(q.EQ_SIF,0) FROM AD_FECXC.FECXC_MONEDAS_EQUIVALENCIA q WHERE q.SECMONEDA = A.SECMONEDA)
                                    THEN
                                        (SELECT ROUND(CONVERSION_RATE,4)
                                          FROM FECXC_TPC_MULTIMONEDA_VW
                                          WHERE FROM_CURRENCY = (SELECT MON_ORACLE FROM AD_FECXC.FECXC_TPC_MULTIMONEDA WHERE SECMONEDA = (SELECT NVL(q.EQ_SIF,0) FROM AD_FECXC.FECXC_MONEDAS_EQUIVALENCIA q WHERE q.SECMONEDA = A.SECMONEDA))
                                          AND TO_CURRENCY = (SELECT MON_ORACLE FROM AD_FECXC.FECXC_TPC_MULTIMONEDA WHERE SECMONEDA = F.SECMONEDA)
                                          AND CONVERSION_DATE = A.F_DEPOSITO
                                        )
                                ELSE 1
                           END
                   END))/p_FORMATO COBRANZAREAL_ALAFECHA
                FROM FECXC_ENC_CLASIFICADOS A, FECXC_DET_CLASIFICADOS B, FECXC_MONEDAS C, FECXC_CALENDARIO_COB D, FECXC_INPC E,
                    FECXC_TPC E,
                    FECXC_SEGMULTIMON F
                WHERE A.E_CODIGO = B.E_CODIGO
                      AND A.COD_SEC_CLASIFICA = B.COD_SEC_CLASIFICA
                      AND A.SECMONEDA = C.SECMONEDA
                      AND A.F_DEPOSITO between D.FECHA_INICIO AND D.FECHA_FIN
                      AND D.ANIO_COBRANZA = p_ANIO-1                    --PARAMETRO DE A?O
                      AND D.MES_COBRANZA <= p_MES
                      AND D.ANIO_COBRANZA = E.ANO_INPC   (+)
                      AND D.MES_COBRANZA = E.MES_INPC    (+)
                      AND EXISTS(SELECT 1 FROM FECXC_DET_CLASFECXC clas
                                      WHERE B.COD_SEC_CATCLAS = clas.COD_SEC_CATCLAS
                                          AND B.COD_SEC_DET = clas.COD_SEC_DET
                                        AND clas.EXCLUIR_ENREPORTES = 'NO')
                      AND A.SECMONEDA = E.SECMONEDA (+)
                        AND A.F_DEPOSITO = E.FECHA_TPC (+)
                      AND B.SEGMENTO1 = F.COD_SEC_LIN (+)
                group by A.E_CODIGO, B.SEGMENTO1,B.SEGMENTO3, C.CODMONEDA, D.MES_COBRANZA;
                ----------------------HASTA AQUI PARTE 'A LA FECHA'--------------------------------------
        ELSE    /* A LA FEHCA */
                INSERT INTO FECXC_CANINTER_XMES_pre (
                   SEGMENTO, CANAL,CODMONEDA, MES, PRESUP_MES)
                select B.SEGMENTO1,B.SEGMENTO3, C.CODMONEDA, D.MES_COBRANZA, sum(B.IMPORTE)/p_FORMATO
                FROM FECXC_ENC_DE_PRESU A, FECXC_DET_PRES_DIARIO B, FECXC_MONEDAS C, FECXC_CALENDARIO_COB D
                WHERE A.SEC_PRESUP = B.SEC_PRESUP
                      AND A.SECMONEDA = C.SECMONEDA
                      AND B.DIARIO between D.FECHA_INICIO AND D.FECHA_FIN
                      AND D.ANIO_COBRANZA = p_ANIO
                      AND D.MES_COBRANZA = p_MES
                      AND B.DIARIO <= p_FECHA
                group by B.SEGMENTO1,B.SEGMENTO3, C.CODMONEDA, D.MES_COBRANZA;
                INSERT INTO FECXC_CANINTER_XMES_cob_act(
                   E_CODIGO, SEGMENTO, CANAL,
                   CODMONEDA, MES,COBRANZA_MES)
                SELECT A.E_CODIGO, B.SEGMENTO1,B.SEGMENTO3,
                   C.CODMONEDA, D.MES_COBRANZA,sum(B.IMPORTE*(CASE
                        WHEN p_SEGMENTOSESP = 0
                           THEN 1
                        ELSE
                           CASE
                                WHEN F.COD_SEC_LIN IS NULL
                                    THEN 1
                                WHEN F.COD_SEC_LIN IS NOT NULL AND F.SECMONEDA = (SELECT NVL(q.EQ_SIF,0) FROM AD_FECXC.FECXC_MONEDAS_EQUIVALENCIA q WHERE q.SECMONEDA = A.SECMONEDA)
                                    THEN 1
                                WHEN F.COD_SEC_LIN IS NOT NULL AND F.SECMONEDA IN(22)
                                     AND F.SECMONEDA <> (SELECT NVL(q.EQ_SIF,0) FROM AD_FECXC.FECXC_MONEDAS_EQUIVALENCIA q WHERE q.SECMONEDA = A.SECMONEDA)
                                    THEN E.TIPO_CAMBIO
                                WHEN F.COD_SEC_LIN IS NOT NULL AND F.SECMONEDA NOT IN(22)
                                     AND (SELECT NVL(q.EQ_SIF,0) FROM AD_FECXC.FECXC_MONEDAS_EQUIVALENCIA q WHERE q.SECMONEDA = A.SECMONEDA) = 22
                                    THEN (SELECT TIPO_CAMBIO_DLS FROM FECXC_TPC WHERE FECHA_TPC = A.F_DEPOSITO AND SECMONEDA = F.SECMONEDA)
                                WHEN
                                     F.COD_SEC_LIN IS NOT NULL
                                     AND F.SECMONEDA NOT IN (22)
                                     AND F.SECMONEDA <> (SELECT NVL(q.EQ_SIF,0) FROM AD_FECXC.FECXC_MONEDAS_EQUIVALENCIA q WHERE q.SECMONEDA = A.SECMONEDA)
                                    THEN
                                        (SELECT ROUND(CONVERSION_RATE,4)
                                          FROM FECXC_TPC_MULTIMONEDA_VW
                                          WHERE FROM_CURRENCY = (SELECT MON_ORACLE FROM AD_FECXC.FECXC_TPC_MULTIMONEDA WHERE SECMONEDA = (SELECT NVL(q.EQ_SIF,0) FROM AD_FECXC.FECXC_MONEDAS_EQUIVALENCIA q WHERE q.SECMONEDA = A.SECMONEDA))
                                          AND TO_CURRENCY = (SELECT MON_ORACLE FROM AD_FECXC.FECXC_TPC_MULTIMONEDA WHERE SECMONEDA = F.SECMONEDA)
                                          AND CONVERSION_DATE = A.F_DEPOSITO
                                        )
                                ELSE 1
                           END
                   END))/p_FORMATO COBRANZA_MES
                FROM FECXC_ENC_CLASIFICADOS A, FECXC_DET_CLASIFICADOS B, FECXC_MONEDAS C, FECXC_CALENDARIO_COB D,
                    FECXC_TPC E,
                    FECXC_SEGMULTIMON F
                WHERE A.E_CODIGO = B.E_CODIGO
                      AND A.COD_SEC_CLASIFICA = B.COD_SEC_CLASIFICA
                      AND A.SECMONEDA = C.SECMONEDA
                      AND A.F_DEPOSITO between D.FECHA_INICIO AND D.FECHA_FIN
                      AND D.ANIO_COBRANZA = p_ANIO                    --PARAMETRO DE A?O
                      AND D.MES_COBRANZA = p_MES                    --PARAMETRO DE A?O
                      AND EXISTS(SELECT 1 FROM FECXC_DET_CLASFECXC clas
                                      WHERE B.COD_SEC_CATCLAS = clas.COD_SEC_CATCLAS
                                          AND B.COD_SEC_DET = clas.COD_SEC_DET
                                        AND clas.EXCLUIR_ENREPORTES = 'NO')
                      AND A.SECMONEDA = E.SECMONEDA (+)
                        AND A.F_DEPOSITO = E.FECHA_TPC (+)
                      AND B.SEGMENTO1 = F.COD_SEC_LIN (+)
                      AND A.F_DEPOSITO <= p_FECHA
                group by A.E_CODIGO, B.SEGMENTO1,B.SEGMENTO3, C.CODMONEDA, D.MES_COBRANZA;
                /*Se agrega columna para c?lculo nominal*/
                INSERT INTO FECXC_CANINTER_XMES_cob_ant(
                   E_CODIGO, SEGMENTO, CANAL,
                   CODMONEDA, MES,COBRANZA_MES, COBRANZAREAL_MES)
                SELECT A.E_CODIGO, B.SEGMENTO1,B.SEGMENTO3,
                   C.CODMONEDA, D.MES_COBRANZA,sum(B.IMPORTE*(CASE
                        WHEN p_SEGMENTOSESP = 0
                           THEN 1
                        ELSE
                           CASE
                                WHEN F.COD_SEC_LIN IS NULL
                                   THEN 1
                                WHEN F.COD_SEC_LIN IS NOT NULL AND F.SECMONEDA = (SELECT NVL(q.EQ_SIF,0) FROM AD_FECXC.FECXC_MONEDAS_EQUIVALENCIA q WHERE q.SECMONEDA = A.SECMONEDA)
                                    AND (SELECT NVL(q.EQ_SIF,0) FROM AD_FECXC.FECXC_MONEDAS_EQUIVALENCIA q WHERE q.SECMONEDA = A.SECMONEDA) IN(22)
                                   THEN DECODE(p_INPC,1,v_INPC/nvl(E.INPC_ACTUAL,v_INPC),1)
                                WHEN F.COD_SEC_LIN IS NOT NULL AND F.SECMONEDA = (SELECT NVL(q.EQ_SIF,0) FROM AD_FECXC.FECXC_MONEDAS_EQUIVALENCIA q WHERE q.SECMONEDA = A.SECMONEDA)
                                    AND (SELECT NVL(q.EQ_SIF,0) FROM AD_FECXC.FECXC_MONEDAS_EQUIVALENCIA q WHERE q.SECMONEDA = A.SECMONEDA) NOT IN(22)
                                   THEN 1
                                WHEN F.COD_SEC_LIN IS NOT NULL AND F.SECMONEDA IN(22)
                                     AND F.SECMONEDA <> (SELECT NVL(q.EQ_SIF,0) FROM AD_FECXC.FECXC_MONEDAS_EQUIVALENCIA q WHERE q.SECMONEDA = A.SECMONEDA)
                                   THEN E.TIPO_CAMBIO
                                WHEN F.COD_SEC_LIN IS NOT NULL AND F.SECMONEDA NOT IN(22)
                                     AND (SELECT NVL(q.EQ_SIF,0) FROM AD_FECXC.FECXC_MONEDAS_EQUIVALENCIA q WHERE q.SECMONEDA = A.SECMONEDA) IN(22)
                                   THEN (SELECT TIPO_CAMBIO_DLS FROM FECXC_TPC WHERE FECHA_TPC = A.F_DEPOSITO AND SECMONEDA = F.SECMONEDA) * DECODE(p_INPC,1,v_INPC/nvl(E.INPC_ACTUAL,v_INPC),1)
                                WHEN
                                     F.COD_SEC_LIN IS NOT NULL
                                     AND F.SECMONEDA NOT IN (22)
                                     AND F.SECMONEDA <> (SELECT NVL(q.EQ_SIF,0) FROM AD_FECXC.FECXC_MONEDAS_EQUIVALENCIA q WHERE q.SECMONEDA = A.SECMONEDA)
                                   THEN
                                        (SELECT ROUND(CONVERSION_RATE,4)
                                          FROM FECXC_TPC_MULTIMONEDA_VW
                                          WHERE FROM_CURRENCY = (SELECT MON_ORACLE FROM AD_FECXC.FECXC_TPC_MULTIMONEDA WHERE SECMONEDA = (SELECT NVL(q.EQ_SIF,0) FROM AD_FECXC.FECXC_MONEDAS_EQUIVALENCIA q WHERE q.SECMONEDA = A.SECMONEDA))
                                          AND TO_CURRENCY = (SELECT MON_ORACLE FROM AD_FECXC.FECXC_TPC_MULTIMONEDA WHERE SECMONEDA = F.SECMONEDA)
                                          AND CONVERSION_DATE = A.F_DEPOSITO
                                        )
                                ELSE 1
                           END
                   END))/p_FORMATO,sum(B.IMPORTE*(CASE
                        WHEN p_SEGMENTOSESP = 0
                           THEN 1
                        ELSE
                           CASE
                                WHEN F.COD_SEC_LIN IS NULL
                                    THEN 1
                                WHEN F.COD_SEC_LIN IS NOT NULL AND F.SECMONEDA = (SELECT NVL(q.EQ_SIF,0) FROM AD_FECXC.FECXC_MONEDAS_EQUIVALENCIA q WHERE q.SECMONEDA = A.SECMONEDA)
                                    THEN 1
                                WHEN F.COD_SEC_LIN IS NOT NULL AND F.SECMONEDA IN(22)
                                     AND F.SECMONEDA <> (SELECT NVL(q.EQ_SIF,0) FROM AD_FECXC.FECXC_MONEDAS_EQUIVALENCIA q WHERE q.SECMONEDA = A.SECMONEDA)
                                    THEN E.TIPO_CAMBIO
                                WHEN F.COD_SEC_LIN IS NOT NULL AND F.SECMONEDA NOT IN(22)
                                     AND (SELECT NVL(q.EQ_SIF,0) FROM AD_FECXC.FECXC_MONEDAS_EQUIVALENCIA q WHERE q.SECMONEDA = A.SECMONEDA) = 22
                                    THEN (SELECT TIPO_CAMBIO_DLS FROM FECXC_TPC WHERE FECHA_TPC = A.F_DEPOSITO AND SECMONEDA = F.SECMONEDA)
                                WHEN
                                     F.COD_SEC_LIN IS NOT NULL
                                     AND F.SECMONEDA NOT IN (22)
                                     AND F.SECMONEDA <> (SELECT NVL(q.EQ_SIF,0) FROM AD_FECXC.FECXC_MONEDAS_EQUIVALENCIA q WHERE q.SECMONEDA = A.SECMONEDA)
                                    THEN
                                        (SELECT ROUND(CONVERSION_RATE,4)
                                          FROM FECXC_TPC_MULTIMONEDA_VW
                                          WHERE FROM_CURRENCY = (SELECT MON_ORACLE FROM AD_FECXC.FECXC_TPC_MULTIMONEDA WHERE SECMONEDA = (SELECT NVL(q.EQ_SIF,0) FROM AD_FECXC.FECXC_MONEDAS_EQUIVALENCIA q WHERE q.SECMONEDA = A.SECMONEDA))
                                          AND TO_CURRENCY = (SELECT MON_ORACLE FROM AD_FECXC.FECXC_TPC_MULTIMONEDA WHERE SECMONEDA = F.SECMONEDA)
                                          AND CONVERSION_DATE = A.F_DEPOSITO
                                        )
                                ELSE 1
                           END
                   END))/p_FORMATO COBRANZAREAL_MES
                FROM FECXC_ENC_CLASIFICADOS A, FECXC_DET_CLASIFICADOS B, FECXC_MONEDAS C, FECXC_CALENDARIO_COB D, FECXC_INPC E,
                    FECXC_TPC E,
                    FECXC_SEGMULTIMON F
                WHERE A.E_CODIGO = B.E_CODIGO
                      AND A.COD_SEC_CLASIFICA = B.COD_SEC_CLASIFICA
                      AND A.SECMONEDA = C.SECMONEDA
                      AND A.F_DEPOSITO between D.FECHA_INICIO AND D.FECHA_FIN
                      AND D.ANIO_COBRANZA = p_ANIO-1                    --PARAMETRO DE A?O
                      AND D.MES_COBRANZA = p_MES                    --PARAMETRO DE A?O
                      AND D.ANIO_COBRANZA = E.ANO_INPC (+)
                      AND D.MES_COBRANZA = E.MES_INPC  (+)
                      AND EXISTS(SELECT 1 FROM FECXC_DET_CLASFECXC clas
                                      WHERE B.COD_SEC_CATCLAS = clas.COD_SEC_CATCLAS
                                          AND B.COD_SEC_DET = clas.COD_SEC_DET
                                        AND clas.EXCLUIR_ENREPORTES = 'NO')
                      AND A.SECMONEDA = E.SECMONEDA (+)
                        AND A.F_DEPOSITO = E.FECHA_TPC (+)
                      AND B.SEGMENTO1 = F.COD_SEC_LIN (+)
                      AND A.F_DEPOSITO <= (p_FECHA)-365
                group by A.E_CODIGO, B.SEGMENTO1,B.SEGMENTO3,C.CODMONEDA, D.MES_COBRANZA;
                ----------------------HASTA AQUI PARTE 'DEL MES'--------------------------------------
                ----------------------DESDE AQUI PARTE 'A LA FECHA'-----------------------------------
                /*Se agrega columna para c?lculo nominal*/
                INSERT INTO FECXC_CANINTER_ALAFECHA_pre(
                   SEGMENTO, CANAL,CODMONEDA, MES, PRESUP_MES, PRESUPREAL_MES)
                select B.SEGMENTO1,B.SEGMENTO3, C.CODMONEDA, D.MES_COBRANZA, sum(B.IMPORTE*DECODE(C.ES_MONEDA_LOCCAL,1,DECODE(p_INPC,0,1,v_INPC/nvl(E.INPC_ACTUAL,v_INPC)),1))/p_FORMATO PRESUP_MES,
                sum(B.IMPORTE)/p_FORMATO PRESUPREAL_MES
                FROM FECXC_ENC_DE_PRESU A, FECXC_DET_PRES_DIARIO B, FECXC_MONEDAS C, FECXC_CALENDARIO_COB D, FECXC_INPC E
                WHERE A.SEC_PRESUP = B.SEC_PRESUP
                      AND A.SECMONEDA = C.SECMONEDA
                      AND B.DIARIO between D.FECHA_INICIO AND D.FECHA_FIN
                      AND D.ANIO_COBRANZA = p_ANIO
                      AND B.DIARIO <= p_FECHA                ---PARAMETRO DEL DIA
                      AND D.ANIO_COBRANZA = E.ANO_INPC (+)
                      AND D.MES_COBRANZA = E.MES_INPC  (+)
                group by B.SEGMENTO1,B.SEGMENTO3, C.CODMONEDA, D.MES_COBRANZA;
                /*Se agrega columna para c?lculo nominal*/
                INSERT INTO FECXC_CANINTER_ALAFECH_cob_act(
                   E_CODIGO, SEGMENTO, CANAL,
                   CODMONEDA, MES,COBRANZA_MES, COBRANZAREAL_MES)
                SELECT A.E_CODIGO, B.SEGMENTO1,B.SEGMENTO3,
                   C.CODMONEDA, D.MES_COBRANZA,sum(B.IMPORTE*(CASE
                        WHEN p_SEGMENTOSESP = 0
                           THEN 1
                        ELSE
                           CASE
                                WHEN F.COD_SEC_LIN IS NULL
                                   THEN 1
                                WHEN F.COD_SEC_LIN IS NOT NULL AND F.SECMONEDA = (SELECT NVL(q.EQ_SIF,0) FROM AD_FECXC.FECXC_MONEDAS_EQUIVALENCIA q WHERE q.SECMONEDA = A.SECMONEDA)
                                    AND (SELECT NVL(q.EQ_SIF,0) FROM AD_FECXC.FECXC_MONEDAS_EQUIVALENCIA q WHERE q.SECMONEDA = A.SECMONEDA) IN(22)
                                   THEN DECODE(p_INPC,1,v_INPC/nvl(E.INPC_ACTUAL,v_INPC),1)
                                WHEN F.COD_SEC_LIN IS NOT NULL AND F.SECMONEDA = (SELECT NVL(q.EQ_SIF,0) FROM AD_FECXC.FECXC_MONEDAS_EQUIVALENCIA q WHERE q.SECMONEDA = A.SECMONEDA)
                                    AND (SELECT NVL(q.EQ_SIF,0) FROM AD_FECXC.FECXC_MONEDAS_EQUIVALENCIA q WHERE q.SECMONEDA = A.SECMONEDA) NOT IN(22)
                                   THEN 1
                                WHEN F.COD_SEC_LIN IS NOT NULL AND F.SECMONEDA IN(22)
                                     AND F.SECMONEDA <> (SELECT NVL(q.EQ_SIF,0) FROM AD_FECXC.FECXC_MONEDAS_EQUIVALENCIA q WHERE q.SECMONEDA = A.SECMONEDA)
                                   THEN E.TIPO_CAMBIO
                                WHEN F.COD_SEC_LIN IS NOT NULL AND F.SECMONEDA NOT IN(22)
                                     AND (SELECT NVL(q.EQ_SIF,0) FROM AD_FECXC.FECXC_MONEDAS_EQUIVALENCIA q WHERE q.SECMONEDA = A.SECMONEDA) IN(22)
                                   THEN (SELECT TIPO_CAMBIO_DLS FROM FECXC_TPC WHERE FECHA_TPC = A.F_DEPOSITO AND SECMONEDA = F.SECMONEDA) * DECODE(p_INPC,1,v_INPC/nvl(E.INPC_ACTUAL,v_INPC),1)
                                WHEN
                                     F.COD_SEC_LIN IS NOT NULL
                                     AND F.SECMONEDA NOT IN (22)
                                     AND F.SECMONEDA <> (SELECT NVL(q.EQ_SIF,0) FROM AD_FECXC.FECXC_MONEDAS_EQUIVALENCIA q WHERE q.SECMONEDA = A.SECMONEDA)
                                   THEN
                                        (SELECT ROUND(CONVERSION_RATE,4)
                                          FROM FECXC_TPC_MULTIMONEDA_VW
                                          WHERE FROM_CURRENCY = (SELECT MON_ORACLE FROM AD_FECXC.FECXC_TPC_MULTIMONEDA WHERE SECMONEDA = (SELECT NVL(q.EQ_SIF,0) FROM AD_FECXC.FECXC_MONEDAS_EQUIVALENCIA q WHERE q.SECMONEDA = A.SECMONEDA))
                                          AND TO_CURRENCY = (SELECT MON_ORACLE FROM AD_FECXC.FECXC_TPC_MULTIMONEDA WHERE SECMONEDA = F.SECMONEDA)
                                          AND CONVERSION_DATE = A.F_DEPOSITO
                                        )
                                ELSE 1
                           END
                   END))/p_FORMATO COBRANZA_MES, sum(B.IMPORTE*(CASE
                        WHEN p_SEGMENTOSESP = 0
                           THEN 1
                        ELSE
                           CASE
                                WHEN F.COD_SEC_LIN IS NULL
                                    THEN 1
                                WHEN F.COD_SEC_LIN IS NOT NULL AND F.SECMONEDA = (SELECT NVL(q.EQ_SIF,0) FROM AD_FECXC.FECXC_MONEDAS_EQUIVALENCIA q WHERE q.SECMONEDA = A.SECMONEDA)
                                    THEN 1
                                WHEN F.COD_SEC_LIN IS NOT NULL AND F.SECMONEDA IN(22)
                                     AND F.SECMONEDA <> (SELECT NVL(q.EQ_SIF,0) FROM AD_FECXC.FECXC_MONEDAS_EQUIVALENCIA q WHERE q.SECMONEDA = A.SECMONEDA)
                                    THEN E.TIPO_CAMBIO
                                WHEN F.COD_SEC_LIN IS NOT NULL AND F.SECMONEDA NOT IN(22)
                                     AND (SELECT NVL(q.EQ_SIF,0) FROM AD_FECXC.FECXC_MONEDAS_EQUIVALENCIA q WHERE q.SECMONEDA = A.SECMONEDA) = 22
                                    THEN (SELECT TIPO_CAMBIO_DLS FROM FECXC_TPC WHERE FECHA_TPC = A.F_DEPOSITO AND SECMONEDA = F.SECMONEDA)
                                WHEN
                                     F.COD_SEC_LIN IS NOT NULL
                                     AND F.SECMONEDA NOT IN (22)
                                     AND F.SECMONEDA <> (SELECT NVL(q.EQ_SIF,0) FROM AD_FECXC.FECXC_MONEDAS_EQUIVALENCIA q WHERE q.SECMONEDA = A.SECMONEDA)
                                    THEN
                                        (SELECT ROUND(CONVERSION_RATE,4)
                                          FROM FECXC_TPC_MULTIMONEDA_VW
                                          WHERE FROM_CURRENCY = (SELECT MON_ORACLE FROM AD_FECXC.FECXC_TPC_MULTIMONEDA WHERE SECMONEDA = (SELECT NVL(q.EQ_SIF,0) FROM AD_FECXC.FECXC_MONEDAS_EQUIVALENCIA q WHERE q.SECMONEDA = A.SECMONEDA))
                                          AND TO_CURRENCY = (SELECT MON_ORACLE FROM AD_FECXC.FECXC_TPC_MULTIMONEDA WHERE SECMONEDA = F.SECMONEDA)
                                          AND CONVERSION_DATE = A.F_DEPOSITO
                                        )
                                ELSE 1
                           END
                   END))/p_FORMATO COBRANZAREAL_MES
                FROM FECXC_ENC_CLASIFICADOS A, FECXC_DET_CLASIFICADOS B, FECXC_MONEDAS C, FECXC_CALENDARIO_COB D, FECXC_INPC E,
                    FECXC_TPC E,
                    FECXC_SEGMULTIMON F
                WHERE A.E_CODIGO = B.E_CODIGO
                      AND A.COD_SEC_CLASIFICA = B.COD_SEC_CLASIFICA
                      AND A.SECMONEDA = C.SECMONEDA
                      AND A.F_DEPOSITO between D.FECHA_INICIO AND D.FECHA_FIN
                      AND D.ANIO_COBRANZA =p_ANIO                ---PARAMETRO DE A?O
                      AND A.F_DEPOSITO <= p_FECHA                ---PARAMETRO DEL DIA
                      AND D.ANIO_COBRANZA = E.ANO_INPC (+)
                      AND D.MES_COBRANZA = E.MES_INPC  (+)
                      AND EXISTS(SELECT 1 FROM FECXC_DET_CLASFECXC clas
                                      WHERE B.COD_SEC_CATCLAS = clas.COD_SEC_CATCLAS
                                          AND B.COD_SEC_DET = clas.COD_SEC_DET
                                        AND clas.EXCLUIR_ENREPORTES = 'NO')
                      AND A.SECMONEDA = E.SECMONEDA (+)
                        AND A.F_DEPOSITO = E.FECHA_TPC (+)
                      AND B.SEGMENTO1 = F.COD_SEC_LIN (+)
                group by A.E_CODIGO, B.SEGMENTO1,B.SEGMENTO3, C.CODMONEDA, D.MES_COBRANZA;
                /*Se agrega columna para c?lculo nominal*/
                INSERT INTO FECXC_CANINTER_ALAFECH_cob_ant(
                   E_CODIGO, SEGMENTO, CANAL,
                   CODMONEDA, MES,COBRANZA_MES, COBRANZAREAL_MES)
                SELECT A.E_CODIGO, B.SEGMENTO1,B.SEGMENTO3,
                   C.CODMONEDA, D.MES_COBRANZA,sum(B.IMPORTE*(CASE
                        WHEN p_SEGMENTOSESP = 0
                           THEN 1
                        ELSE
                           CASE
                                WHEN F.COD_SEC_LIN IS NULL
                                   THEN 1
                                WHEN F.COD_SEC_LIN IS NOT NULL AND F.SECMONEDA = (SELECT NVL(q.EQ_SIF,0) FROM AD_FECXC.FECXC_MONEDAS_EQUIVALENCIA q WHERE q.SECMONEDA = A.SECMONEDA)
                                    AND (SELECT NVL(q.EQ_SIF,0) FROM AD_FECXC.FECXC_MONEDAS_EQUIVALENCIA q WHERE q.SECMONEDA = A.SECMONEDA) IN(22)
                                   THEN DECODE(p_INPC,1,v_INPC/nvl(E.INPC_ACTUAL,v_INPC),1)
                                WHEN F.COD_SEC_LIN IS NOT NULL AND F.SECMONEDA = (SELECT NVL(q.EQ_SIF,0) FROM AD_FECXC.FECXC_MONEDAS_EQUIVALENCIA q WHERE q.SECMONEDA = A.SECMONEDA)
                                    AND (SELECT NVL(q.EQ_SIF,0) FROM AD_FECXC.FECXC_MONEDAS_EQUIVALENCIA q WHERE q.SECMONEDA = A.SECMONEDA) NOT IN(22)
                                   THEN 1
                                WHEN F.COD_SEC_LIN IS NOT NULL AND F.SECMONEDA IN(22)
                                     AND F.SECMONEDA <> (SELECT NVL(q.EQ_SIF,0) FROM AD_FECXC.FECXC_MONEDAS_EQUIVALENCIA q WHERE q.SECMONEDA = A.SECMONEDA)
                                   THEN E.TIPO_CAMBIO
                                WHEN F.COD_SEC_LIN IS NOT NULL AND F.SECMONEDA NOT IN(22)
                                     AND (SELECT NVL(q.EQ_SIF,0) FROM AD_FECXC.FECXC_MONEDAS_EQUIVALENCIA q WHERE q.SECMONEDA = A.SECMONEDA) IN(22)
                                   THEN (SELECT TIPO_CAMBIO_DLS FROM FECXC_TPC WHERE FECHA_TPC = A.F_DEPOSITO AND SECMONEDA = F.SECMONEDA) * DECODE(p_INPC,1,v_INPC/nvl(E.INPC_ACTUAL,v_INPC),1)
                                WHEN
                                     F.COD_SEC_LIN IS NOT NULL
                                     AND F.SECMONEDA NOT IN (22)
                                     AND F.SECMONEDA <> (SELECT NVL(q.EQ_SIF,0) FROM AD_FECXC.FECXC_MONEDAS_EQUIVALENCIA q WHERE q.SECMONEDA = A.SECMONEDA)
                                   THEN
                                        (SELECT ROUND(CONVERSION_RATE,4)
                                          FROM FECXC_TPC_MULTIMONEDA_VW
                                          WHERE FROM_CURRENCY = (SELECT MON_ORACLE FROM AD_FECXC.FECXC_TPC_MULTIMONEDA WHERE SECMONEDA = (SELECT NVL(q.EQ_SIF,0) FROM AD_FECXC.FECXC_MONEDAS_EQUIVALENCIA q WHERE q.SECMONEDA = A.SECMONEDA))
                                          AND TO_CURRENCY = (SELECT MON_ORACLE FROM AD_FECXC.FECXC_TPC_MULTIMONEDA WHERE SECMONEDA = F.SECMONEDA)
                                          AND CONVERSION_DATE = A.F_DEPOSITO
                                        )
                                ELSE 1
                           END
                   END))/p_FORMATO COBRANZA_MES, sum(B.IMPORTE*(CASE
                        WHEN p_SEGMENTOSESP = 0
                           THEN 1
                        ELSE
                           CASE
                                WHEN F.COD_SEC_LIN IS NULL
                                    THEN 1
                                WHEN F.COD_SEC_LIN IS NOT NULL AND F.SECMONEDA = (SELECT NVL(q.EQ_SIF,0) FROM AD_FECXC.FECXC_MONEDAS_EQUIVALENCIA q WHERE q.SECMONEDA = A.SECMONEDA)
                                    THEN 1
                                WHEN F.COD_SEC_LIN IS NOT NULL AND F.SECMONEDA IN(22)
                                     AND F.SECMONEDA <> (SELECT NVL(q.EQ_SIF,0) FROM AD_FECXC.FECXC_MONEDAS_EQUIVALENCIA q WHERE q.SECMONEDA = A.SECMONEDA)
                                    THEN E.TIPO_CAMBIO
                                WHEN F.COD_SEC_LIN IS NOT NULL AND F.SECMONEDA NOT IN(22)
                                     AND (SELECT NVL(q.EQ_SIF,0) FROM AD_FECXC.FECXC_MONEDAS_EQUIVALENCIA q WHERE q.SECMONEDA = A.SECMONEDA) = 22
                                    THEN (SELECT TIPO_CAMBIO_DLS FROM FECXC_TPC WHERE FECHA_TPC = A.F_DEPOSITO AND SECMONEDA = F.SECMONEDA)
                                WHEN
                                     F.COD_SEC_LIN IS NOT NULL
                                     AND F.SECMONEDA NOT IN (22)
                                     AND F.SECMONEDA <> (SELECT NVL(q.EQ_SIF,0) FROM AD_FECXC.FECXC_MONEDAS_EQUIVALENCIA q WHERE q.SECMONEDA = A.SECMONEDA)
                                    THEN
                                        (SELECT ROUND(CONVERSION_RATE,4)
                                          FROM FECXC_TPC_MULTIMONEDA_VW
                                          WHERE FROM_CURRENCY = (SELECT MON_ORACLE FROM AD_FECXC.FECXC_TPC_MULTIMONEDA WHERE SECMONEDA = (SELECT NVL(q.EQ_SIF,0) FROM AD_FECXC.FECXC_MONEDAS_EQUIVALENCIA q WHERE q.SECMONEDA = A.SECMONEDA))
                                          AND TO_CURRENCY = (SELECT MON_ORACLE FROM AD_FECXC.FECXC_TPC_MULTIMONEDA WHERE SECMONEDA = F.SECMONEDA)
                                          AND CONVERSION_DATE = A.F_DEPOSITO
                                        )
                                ELSE 1
                           END
                   END))/p_FORMATO COBRANZAREAL_MES
                FROM FECXC_ENC_CLASIFICADOS A, FECXC_DET_CLASIFICADOS B, FECXC_MONEDAS C, FECXC_CALENDARIO_COB D, FECXC_INPC E,
                    FECXC_TPC E,
                    FECXC_SEGMULTIMON F
                WHERE A.E_CODIGO = B.E_CODIGO
                      AND A.COD_SEC_CLASIFICA = B.COD_SEC_CLASIFICA
                      AND A.SECMONEDA = C.SECMONEDA
                      AND A.F_DEPOSITO between D.FECHA_INICIO AND D.FECHA_FIN
                      AND D.ANIO_COBRANZA = p_ANIO-1                    --PARAMETRO DE A?O
                      AND A.F_DEPOSITO <= to_date(p_FECHA)-365                ---PARAMETRO DEL DIA
                      AND D.ANIO_COBRANZA = E.ANO_INPC   (+)
                      AND D.MES_COBRANZA = E.MES_INPC    (+)
                      AND EXISTS(SELECT 1 FROM FECXC_DET_CLASFECXC clas
                                      WHERE B.COD_SEC_CATCLAS = clas.COD_SEC_CATCLAS
                                          AND B.COD_SEC_DET = clas.COD_SEC_DET
                                        AND clas.EXCLUIR_ENREPORTES = 'NO')
                      AND A.SECMONEDA = E.SECMONEDA (+)
                        AND A.F_DEPOSITO = E.FECHA_TPC (+)
                      AND B.SEGMENTO1 = F.COD_SEC_LIN (+)
                group by A.E_CODIGO, B.SEGMENTO1,B.SEGMENTO3, C.CODMONEDA, D.MES_COBRANZA;
                ----------------------HASTA AQUI PARTE 'A LA FECHA'--------------------------------------
        END IF;
    IF p_SEGMENTOSESP = 1 THEN
        UPDATE FECXC_CANINTER_DELDIA up_table
        SET CODMONEDA = (SELECT CODMONEDA FROM FECXC_MONEDAS x, FECXC_SEGMULTIMON y WHERE x.SECMONEDA = y.SECMONEDA AND y.COD_SEC_LIN = up_table.SEGMENTO)
        WHERE SEGMENTO IS NOT NULL;
        UPDATE FECXC_CANINTER_XMES_cob_act up_table
        SET CODMONEDA = (SELECT CODMONEDA FROM FECXC_MONEDAS x, FECXC_SEGMULTIMON y WHERE x.SECMONEDA = y.SECMONEDA AND y.COD_SEC_LIN = up_table.SEGMENTO)
        WHERE SEGMENTO IS NOT NULL;
        UPDATE FECXC_CANINTER_XMES_cob_ant up_table
        SET CODMONEDA = (SELECT CODMONEDA FROM FECXC_MONEDAS x, FECXC_SEGMULTIMON y WHERE x.SECMONEDA = y.SECMONEDA AND y.COD_SEC_LIN = up_table.SEGMENTO)
        WHERE SEGMENTO IS NOT NULL;
        UPDATE FECXC_CANINTER_ALAFECH_cob_act up_table
        SET CODMONEDA = (SELECT CODMONEDA FROM FECXC_MONEDAS x, FECXC_SEGMULTIMON y WHERE x.SECMONEDA = y.SECMONEDA AND y.COD_SEC_LIN = up_table.SEGMENTO)
        WHERE SEGMENTO IS NOT NULL;
        UPDATE FECXC_CANINTER_ALAFECH_cob_ant up_table
        SET CODMONEDA = (SELECT CODMONEDA FROM FECXC_MONEDAS x, FECXC_SEGMULTIMON y WHERE x.SECMONEDA = y.SECMONEDA AND y.COD_SEC_LIN = up_table.SEGMENTO)
        WHERE SEGMENTO IS NOT NULL;
        /*
        UPDATE FECXC_CANINTER_DELDIA up_table
        SET CODMONEDA = (select min(CODMONEDA) from FECXC_MONEDAS M WHERE M.ES_MONEDA_LOCCAL = 1)
        WHERE EXISTS(select 1
                       from FECXC_SEGMULTIMON B
                     WHERE up_table.SEGMENTO = B.COD_SEC_LIN
                     AND up_table.SEGMENTO IN (1,2,3,9,4,5,6,7))
            AND EXISTS(SELECT 1
                       from FECXC_MONEDAS C
                       WHERE up_table.CODMONEDA = C.CODMONEDA
                                AND (C.ES_MONEDA_LOCCAL is null
                                      OR C.ES_MONEDA_LOCCAL = 0));
        UPDATE FECXC_CANINTER_XMES_cob_act up_table
        SET CODMONEDA = (select min(CODMONEDA) from FECXC_MONEDAS M WHERE M.ES_MONEDA_LOCCAL = 1)
        WHERE EXISTS(select 1
                       from FECXC_SEGMULTIMON B
                     WHERE up_table.SEGMENTO = B.COD_SEC_LIN
                     AND up_table.SEGMENTO IN (1,2,3,9,4,5,6,7))
            AND EXISTS(SELECT 1
                       from FECXC_MONEDAS C
                       WHERE up_table.CODMONEDA = C.CODMONEDA
                                AND (C.ES_MONEDA_LOCCAL is null
                                      OR C.ES_MONEDA_LOCCAL = 0));
        UPDATE FECXC_CANINTER_XMES_cob_ant up_table
        SET CODMONEDA = (select min(CODMONEDA) from FECXC_MONEDAS M WHERE M.ES_MONEDA_LOCCAL = 1)
        WHERE EXISTS(select 1
                       from FECXC_SEGMULTIMON B
                     WHERE up_table.SEGMENTO = B.COD_SEC_LIN
                     AND up_table.SEGMENTO IN (1,2,3,9,4,5,6,7))
            AND EXISTS(SELECT 1
                       from FECXC_MONEDAS C
                       WHERE up_table.CODMONEDA = C.CODMONEDA
                                AND (C.ES_MONEDA_LOCCAL is null
                                      OR C.ES_MONEDA_LOCCAL = 0));
        UPDATE FECXC_CANINTER_ALAFECH_cob_act up_table
        SET CODMONEDA = (select min(CODMONEDA) from FECXC_MONEDAS M WHERE M.ES_MONEDA_LOCCAL = 1)
        WHERE EXISTS(select 1
                       from FECXC_SEGMULTIMON B
                     WHERE up_table.SEGMENTO = B.COD_SEC_LIN
                     AND up_table.SEGMENTO IN (1,2,3,9,4,5,6,7))
            AND EXISTS(SELECT 1
                       from FECXC_MONEDAS C
                       WHERE up_table.CODMONEDA = C.CODMONEDA
                                AND (C.ES_MONEDA_LOCCAL is null
                                      OR C.ES_MONEDA_LOCCAL = 0));
        UPDATE FECXC_CANINTER_ALAFECH_cob_ant up_table
        SET CODMONEDA = (select min(CODMONEDA) from FECXC_MONEDAS M WHERE M.ES_MONEDA_LOCCAL = 1)
        WHERE EXISTS(select 1
                       from FECXC_SEGMULTIMON B
                     WHERE up_table.SEGMENTO = B.COD_SEC_LIN
                     AND up_table.SEGMENTO IN (1,2,3,9,4,5,6,7))
            AND EXISTS(SELECT 1
                       from FECXC_MONEDAS C
                       WHERE up_table.CODMONEDA = C.CODMONEDA
                                AND (C.ES_MONEDA_LOCCAL is null
                                      OR C.ES_MONEDA_LOCCAL = 0));
        */
        INSERT INTO FECXC_CANINTER_DELDIA_tmp(E_CODIGO,  SEGMENTO,  CANAL,  CODMONEDA,  MES, COBRANZA_DIA)
        SELECT E_CODIGO,  SEGMENTO,  CANAL,  CODMONEDA,  MES, sum(COBRANZA_DIA)
        FROM FECXC_CANINTER_DELDIA
        GROUP BY E_CODIGO,  SEGMENTO,  CANAL,  CODMONEDA,  MES;
        INSERT INTO FECXC_CANINTER_XMES_COB_ACT_tm(E_CODIGO, SEGMENTO,  CANAL, CODMONEDA, MES, COBRANZA_MES)
        SELECT E_CODIGO, SEGMENTO,  CANAL, CODMONEDA, MES, SUM(COBRANZA_MES)
        FROM FECXC_CANINTER_XMES_COB_ACT
        GROUP BY E_CODIGO, SEGMENTO,  CANAL, CODMONEDA, MES;
        INSERT INTO FECXC_CANINTER_XMES_COB_ANT_tm(E_CODIGO,  SEGMENTO,  CANAL, CODMONEDA,  MES,  COBRANZA_MES, COBRANZAREAL_MES)
        SELECT E_CODIGO,  SEGMENTO,  CANAL, CODMONEDA,  MES,  SUM(COBRANZA_MES), SUM(COBRANZAREAL_MES)
        FROM FECXC_CANINTER_XMES_COB_ANT
        GROUP BY E_CODIGO,  SEGMENTO,  CANAL, CODMONEDA,  MES,  COBRANZA_MES;
        INSERT INTO FECXC_CANINTER_ALAFECH_COB_AC_(E_CODIGO,  SEGMENTO,  CANAL,  CODMONEDA,  MES,  COBRANZA_MES, COBRANZAREAL_MES)
        SELECT E_CODIGO,  SEGMENTO,  CANAL,  CODMONEDA,  MES,  sum(COBRANZA_MES), SUM(COBRANZAREAL_MES)
        FROM FECXC_CANINTER_ALAFECH_COB_ACT
        GROUP BY E_CODIGO,  SEGMENTO,  CANAL,  CODMONEDA,  MES;
        INSERT INTO FECXC_CANINTER_ALAFECH_COB_AN_(E_CODIGO,  SEGMENTO,  CANAL,  CODMONEDA,  MES,  COBRANZA_MES, COBRANZAREAL_MES)
        SELECT E_CODIGO,  SEGMENTO,  CANAL,  CODMONEDA,  MES,  SUM(COBRANZA_MES), SUM(COBRANZAREAL_MES)
        FROM FECXC_CANINTER_ALAFECH_COB_ANT
        GROUP BY E_CODIGO,  SEGMENTO,  CANAL,  CODMONEDA,  MES;
        DELETE FECXC_CANINTER_DELDIA;
        INSERT INTO FECXC_CANINTER_DELDIA(E_CODIGO,  SEGMENTO,  CANAL,  CODMONEDA,  MES, COBRANZA_DIA)
        SELECT E_CODIGO,  SEGMENTO,  CANAL,  CODMONEDA,  MES, COBRANZA_DIA
        FROM FECXC_CANINTER_DELDIA_tmp;
        DELETE FECXC_CANINTER_XMES_COB_ACT;
        INSERT INTO FECXC_CANINTER_XMES_COB_ACT(E_CODIGO, SEGMENTO,  CANAL, CODMONEDA, MES, COBRANZA_MES)
        SELECT E_CODIGO, SEGMENTO,  CANAL, CODMONEDA, MES, COBRANZA_MES
        FROM FECXC_CANINTER_XMES_COB_ACT_tm;
        DELETE FECXC_CANINTER_XMES_COB_ANT;
        INSERT INTO FECXC_CANINTER_XMES_COB_ANT(E_CODIGO,  SEGMENTO,  CANAL, CODMONEDA,  MES,  COBRANZA_MES, COBRANZAREAL_MES)
        SELECT E_CODIGO,  SEGMENTO,  CANAL, CODMONEDA,  MES,  COBRANZA_MES, COBRANZAREAL_MES
        FROM FECXC_CANINTER_XMES_COB_ANT_tm;
        DELETE FECXC_CANINTER_ALAFECH_COB_ACT;
        INSERT INTO FECXC_CANINTER_ALAFECH_COB_ACT(E_CODIGO,  SEGMENTO,  CANAL,  CODMONEDA,  MES,  COBRANZA_MES, COBRANZAREAL_MES)
        SELECT E_CODIGO,  SEGMENTO,  CANAL,  CODMONEDA,  MES,  COBRANZA_MES, COBRANZAREAL_MES
        FROM FECXC_CANINTER_ALAFECH_COB_AC_;
        DELETE FECXC_CANINTER_ALAFECH_COB_ANT;
        INSERT INTO FECXC_CANINTER_ALAFECH_COB_ANT(E_CODIGO,  SEGMENTO,  CANAL,  CODMONEDA,  MES,  COBRANZA_MES, COBRANZAREAL_MES)
        SELECT E_CODIGO,  SEGMENTO,  CANAL,  CODMONEDA,  MES,  COBRANZA_MES, COBRANZAREAL_MES
        FROM FECXC_CANINTER_ALAFECH_COB_AN_;
     END IF;
--  Realiza la conversi?n de Tipo de Cambio dependiendo de su moneda inicial a DLS. MN Y DLS se quedan tal cual.
/*
     DELETE FROM FECXC_TIPOCAMBIO_TMP;
    INSERT INTO FECXC_TIPOCAMBIO_TMP
    SELECT m.CODMONEDA, NVL(t.TIPO_CAMBIO_DLS, 0)
    FROM
    FECXC_MONEDAS m, FECXC_TPC t
    WHERE
    m.SECMONEDA = t.SECMONEDA
    AND
    t.FECHA_TPC = p_FECHA;
    DELETE FROM FECXC_CANINTER_DELDIA_tmp;
    INSERT INTO FECXC_CANINTER_DELDIA_tmp
    SELECT c.E_CODIGO, c.SEGMENTO, c.CANAL, 'DLS', c.MES, CASE
                                                         WHEN t.TIPO_CAMBIO_DLS IS NULL THEN 0
                                                         ELSE (c.COBRANZA_DIA / t.TIPO_CAMBIO_DLS)
                                                      END as CAMBIO_DLS
    FROM FECXC_CANINTER_DELDIA c, FECXC_SEGMULTIMON s, FECXC_TPC t
    WHERE
    c.SEGMENTO = s.COD_SEC_LIN
    AND
    t.SECMONEDA IN (SELECT SECMONEDA FROM FECXC_MONEDAS WHERE CODMONEDA = c.CODMONEDA)
    AND
    c.CODMONEDA <> (SELECT m.CODMONEDA FROM FECXC_MONEDAS m WHERE m.SECMONEDA = s.SECMONEDA)
    AND
    t.FECHA_TPC = p_FECHA;
    DELETE FROM FECXC_CANINTER_DELDIA a
    WHERE EXISTS(SELECT b.E_CODIGO, b.SEGMENTO FROM FECXC_CANINTER_DELDIA_tmp b WHERE a.E_CODIGO = b.E_CODIGO AND a.SEGMENTO = b.SEGMENTO);
    INSERT INTO FECXC_CANINTER_DELDIA
    SELECT E_CODIGO, SEGMENTO, CANAL, CODMONEDA, MES, COBRANZA_DIA FROM FECXC_CANINTER_DELDIA_TMP;
    DELETE FROM FECXC_CANINTER_XMES_COB_ACT_TM;
    INSERT INTO FECXC_CANINTER_XMES_COB_ACT_TM
    SELECT c.E_CODIGO, c.SEGMENTO, c.CANAL, 'DLS', c.MES, CASE
                                                         WHEN t.TIPO_CAMBIO_DLS IS NULL THEN 0
                                                         ELSE (c.COBRANZA_MES / t.TIPO_CAMBIO_DLS)
                                                      END as CAMBIO_DLS
    FROM FECXC_CANINTER_XMES_COB_ACT c, FECXC_SEGMULTIMON s, FECXC_TPC t
    WHERE
    c.SEGMENTO = s.COD_SEC_LIN
    AND
    t.SECMONEDA IN (SELECT SECMONEDA FROM FECXC_MONEDAS WHERE CODMONEDA = c.CODMONEDA)
    AND
    c.CODMONEDA <> (SELECT m.CODMONEDA FROM FECXC_MONEDAS m WHERE m.SECMONEDA = s.SECMONEDA)
    AND
    t.FECHA_TPC =  p_FECHA;
    DELETE FROM FECXC_CANINTER_XMES_COB_ACT a
    WHERE EXISTS(SELECT b.E_CODIGO, b.SEGMENTO FROM FECXC_CANINTER_XMES_COB_ACT_TM b WHERE a.E_CODIGO = b.E_CODIGO AND a.SEGMENTO = b.SEGMENTO);
    INSERT INTO FECXC_CANINTER_XMES_COB_ACT
    SELECT E_CODIGO, SEGMENTO, CANAL, CODMONEDA, MES, COBRANZA_MES FROM FECXC_CANINTER_XMES_COB_ACT_TM;
    DELETE FROM FECXC_CANINTER_XMES_COB_ANT_TM;
    INSERT INTO FECXC_CANINTER_XMES_COB_ANT_TM
    SELECT c.E_CODIGO, c.SEGMENTO, c.CANAL, 'DLS', c.MES, CASE
                                                         WHEN t.TIPO_CAMBIO_DLS IS NULL THEN 0
                                                         ELSE (c.COBRANZA_MES / t.TIPO_CAMBIO_DLS)
                                                      END as CAMBIO_DLS,
                                                      CASE
                                                         WHEN t.TIPO_CAMBIO_DLS IS NULL THEN 0
                                                         ELSE (c.COBRANZAREAL_MES / t.TIPO_CAMBIO_DLS)
                                                      END as CAMBIOREAL_DLS
    FROM FECXC_CANINTER_XMES_COB_ANT c, FECXC_SEGMULTIMON s, FECXC_TPC t
    WHERE
    c.SEGMENTO = s.COD_SEC_LIN
    AND
    t.SECMONEDA IN (SELECT SECMONEDA FROM FECXC_MONEDAS WHERE CODMONEDA = c.CODMONEDA)
    AND
    c.CODMONEDA <> (SELECT m.CODMONEDA FROM FECXC_MONEDAS m WHERE m.SECMONEDA = s.SECMONEDA)
    AND
    t.FECHA_TPC = p_FECHA;
    DELETE FROM FECXC_CANINTER_XMES_COB_ANT a
    WHERE EXISTS(SELECT b.E_CODIGO, b.SEGMENTO FROM FECXC_CANINTER_XMES_COB_ANT_TM b WHERE a.E_CODIGO = b.E_CODIGO AND a.SEGMENTO = b.SEGMENTO);
    INSERT INTO FECXC_CANINTER_XMES_COB_ANT
    SELECT E_CODIGO, SEGMENTO, CANAL, CODMONEDA, MES, COBRANZA_MES, COBRANZAREAL_MES FROM FECXC_CANINTER_XMES_COB_ANT_TM;
    DELETE FROM FECXC_CANINTER_ALAFECH_COB_AC_;
    INSERT INTO FECXC_CANINTER_ALAFECH_COB_AC_
    SELECT c.E_CODIGO, c.SEGMENTO, c.CANAL, 'DLS', c.MES,  CASE
                                                         WHEN t.TIPO_CAMBIO_DLS IS NULL THEN 0
                                                         ELSE (c.COBRANZA_MES / t.TIPO_CAMBIO_DLS)
                                                      END as CAMBIO_DLS, CASE
                                                         WHEN t.TIPO_CAMBIO_DLS IS NULL THEN 0
                                                         ELSE (c.COBRANZAREAL_MES / t.TIPO_CAMBIO_DLS)
                                                      END as CAMBIOREAL_DLS
    FROM FECXC_CANINTER_ALAFECH_COB_ACT c, FECXC_SEGMULTIMON s, FECXC_TPC t
    WHERE
    c.SEGMENTO = s.COD_SEC_LIN
    AND
    t.SECMONEDA IN (SELECT SECMONEDA FROM FECXC_MONEDAS WHERE CODMONEDA = c.CODMONEDA)
    AND
    c.CODMONEDA <> (SELECT m.CODMONEDA FROM FECXC_MONEDAS m WHERE m.SECMONEDA = s.SECMONEDA)
    AND
    t.FECHA_TPC = p_FECHA;
    DELETE FROM FECXC_CANINTER_ALAFECH_COB_ACT a
    WHERE EXISTS(SELECT b.E_CODIGO, b.SEGMENTO FROM FECXC_CANINTER_ALAFECH_COB_AC_ b WHERE a.E_CODIGO = b.E_CODIGO AND a.SEGMENTO = b.SEGMENTO);
    INSERT INTO FECXC_CANINTER_ALAFECH_COB_ACT
    SELECT E_CODIGO, SEGMENTO, CANAL, CODMONEDA, MES, COBRANZA_MES, COBRANZAREAL_MES FROM FECXC_CANINTER_ALAFECH_COB_AC_;
    DELETE FROM FECXC_CANINTER_ALAFECH_COB_AN_;
    INSERT INTO FECXC_CANINTER_ALAFECH_COB_AN_
    SELECT c.E_CODIGO, c.SEGMENTO, c.CANAL, 'DLS', c.MES, CASE
                                                         WHEN t.TIPO_CAMBIO_DLS IS NULL THEN 0
                                                         ELSE (c.COBRANZA_MES / t.TIPO_CAMBIO_DLS)
                                                      END as CAMBIO_DLS,
                                                      CASE
                                                         WHEN t.TIPO_CAMBIO_DLS IS NULL THEN 0
                                                         ELSE (c.COBRANZAREAL_MES / t.TIPO_CAMBIO_DLS)
                                                      END as CAMBIOREAL_DLS
    FROM FECXC_CANINTER_ALAFECH_COB_ANT c, FECXC_SEGMULTIMON s, FECXC_TPC t
    WHERE
    c.SEGMENTO = s.COD_SEC_LIN
    AND
    t.SECMONEDA IN (SELECT SECMONEDA FROM FECXC_MONEDAS WHERE CODMONEDA = c.CODMONEDA)
    AND
    c.CODMONEDA <> (SELECT m.CODMONEDA FROM FECXC_MONEDAS m WHERE m.SECMONEDA = s.SECMONEDA)
    AND
    t.FECHA_TPC = p_FECHA;
    DELETE FROM FECXC_CANINTER_ALAFECH_COB_ANT a
    WHERE EXISTS(SELECT b.E_CODIGO, b.SEGMENTO FROM FECXC_CANINTER_ALAFECH_COB_AN_ b WHERE a.E_CODIGO = b.E_CODIGO AND a.SEGMENTO = b.SEGMENTO);
    INSERT INTO FECXC_CANINTER_ALAFECH_COB_ANT
    SELECT E_CODIGO, SEGMENTO, CANAL, CODMONEDA, MES, COBRANZA_MES, COBRANZAREAL_MES FROM FECXC_CANINTER_ALAFECH_COB_AN_;
    UPDATE FECXC_CANINTER_DELDIA d
    SET d.COBRANZA_DIA = (SELECT CASE
                                    WHEN (SELECT t.TIPO_CAMBIO_DLS FROM FECXC_TIPOCAMBIO_TMP t WHERE t.CODMONEDA = x.CODMONEDA) IS NULL THEN 0
                                    ELSE d.COBRANZA_DIA / (SELECT t.TIPO_CAMBIO_DLS FROM FECXC_TIPOCAMBIO_TMP t WHERE t.CODMONEDA = d.CODMONEDA)
                                 END FROM FECXC_CANINTER_DELDIA x WHERE x.E_CODIGO = d.E_CODIGO AND x.SEGMENTO = d.SEGMENTO),
    d.CODMONEDA = 'DLS'
    WHERE d.CODMONEDA NOT IN ('MN','DLS');
    UPDATE FECXC_CANINTER_DELDIA SET COBRANZA_DIA = 0 WHERE COBRANZA_DIA IS NULL;
    UPDATE FECXC_CANINTER_XMES_COB_ACT d
    SET d.COBRANZA_MES = (SELECT CASE
                                    WHEN (SELECT t.TIPO_CAMBIO_DLS FROM FECXC_TIPOCAMBIO_TMP t WHERE t.CODMONEDA = x.CODMONEDA) IS NULL THEN 0
                                    ELSE d.COBRANZA_MES / (SELECT t.TIPO_CAMBIO_DLS FROM FECXC_TIPOCAMBIO_TMP t WHERE t.CODMONEDA = d.CODMONEDA)
                                 END FROM FECXC_CANINTER_XMES_COB_ACT x WHERE x.E_CODIGO = d.E_CODIGO AND x.SEGMENTO = d.SEGMENTO),
    d.CODMONEDA = 'DLS'
    WHERE d.CODMONEDA NOT IN ('MN','DLS');
    UPDATE FECXC_CANINTER_XMES_COB_ACT SET COBRANZA_MES = 0 WHERE COBRANZA_MES IS NULL;
    UPDATE FECXC_CANINTER_XMES_COB_ANT d
    SET d.COBRANZA_MES = (SELECT CASE
                                    WHEN (SELECT t.TIPO_CAMBIO_DLS FROM FECXC_TIPOCAMBIO_TMP t WHERE t.CODMONEDA = x.CODMONEDA) IS NULL THEN 0
                                    ELSE d.COBRANZA_MES / (SELECT t.TIPO_CAMBIO_DLS FROM FECXC_TIPOCAMBIO_TMP t WHERE t.CODMONEDA = d.CODMONEDA)
                                 END FROM FECXC_CANINTER_XMES_COB_ANT x WHERE x.E_CODIGO = d.E_CODIGO AND x.SEGMENTO = d.SEGMENTO),
    d.CODMONEDA = 'DLS',
    d.COBRANZAREAL_MES = (SELECT CASE
                                    WHEN (SELECT t.TIPO_CAMBIO_DLS FROM FECXC_TIPOCAMBIO_TMP t WHERE t.CODMONEDA = x.CODMONEDA) IS NULL THEN 0
                                    ELSE d.COBRANZAREAL_MES / (SELECT t.TIPO_CAMBIO_DLS FROM FECXC_TIPOCAMBIO_TMP t WHERE t.CODMONEDA = d.CODMONEDA)
                                 END FROM FECXC_CANINTER_XMES_COB_ANT x WHERE x.E_CODIGO = d.E_CODIGO AND x.SEGMENTO = d.SEGMENTO)
    WHERE d.CODMONEDA NOT IN ('MN','DLS');
    UPDATE FECXC_CANINTER_XMES_COB_ANT SET COBRANZA_MES = 0, COBRANZAREAL_MES = 0 WHERE COBRANZA_MES IS NULL OR COBRANZAREAL_MES IS NULL;
    UPDATE FECXC_CANINTER_ALAFECH_COB_ACT d
    SET d.COBRANZA_MES = (SELECT CASE
                                    WHEN (SELECT t.TIPO_CAMBIO_DLS FROM FECXC_TIPOCAMBIO_TMP t WHERE t.CODMONEDA = x.CODMONEDA) IS NULL THEN 0
                                    ELSE d.COBRANZA_MES / (SELECT t.TIPO_CAMBIO_DLS FROM FECXC_TIPOCAMBIO_TMP t WHERE t.CODMONEDA = d.CODMONEDA)
                                 END FROM FECXC_CANINTER_ALAFECH_COB_ACT x WHERE x.E_CODIGO = d.E_CODIGO AND x.SEGMENTO = d.SEGMENTO),
    d.CODMONEDA = 'DLS',
    d.COBRANZAREAL_MES = (SELECT CASE
                                    WHEN (SELECT t.TIPO_CAMBIO_DLS FROM FECXC_TIPOCAMBIO_TMP t WHERE t.CODMONEDA = x.CODMONEDA) IS NULL THEN 0
                                    ELSE d.COBRANZAREAL_MES / (SELECT t.TIPO_CAMBIO_DLS FROM FECXC_TIPOCAMBIO_TMP t WHERE t.CODMONEDA = d.CODMONEDA)
                                 END FROM FECXC_CANINTER_ALAFECH_COB_ACT x WHERE x.E_CODIGO = d.E_CODIGO AND x.SEGMENTO = d.SEGMENTO)
    WHERE d.CODMONEDA NOT IN ('MN','DLS');
    UPDATE FECXC_CANINTER_ALAFECH_COB_ACT SET COBRANZA_MES = 0, COBRANZAREAL_MES = 0 WHERE COBRANZA_MES IS NULL OR COBRANZAREAL_MES IS NULL;
    UPDATE FECXC_CANINTER_ALAFECH_COB_ANT d
    SET d.COBRANZA_MES = (SELECT CASE
                                    WHEN (SELECT t.TIPO_CAMBIO_DLS FROM FECXC_TIPOCAMBIO_TMP t WHERE t.CODMONEDA = x.CODMONEDA) IS NULL THEN 0
                                    ELSE d.COBRANZA_MES / (SELECT t.TIPO_CAMBIO_DLS FROM FECXC_TIPOCAMBIO_TMP t WHERE t.CODMONEDA = d.CODMONEDA)
                                 END FROM FECXC_CANINTER_ALAFECH_COB_ANT x WHERE x.E_CODIGO = d.E_CODIGO AND x.SEGMENTO = d.SEGMENTO),
    d.CODMONEDA = 'DLS',
    d.COBRANZAREAL_MES = (SELECT CASE
                                    WHEN (SELECT t.TIPO_CAMBIO_DLS FROM FECXC_TIPOCAMBIO_TMP t WHERE t.CODMONEDA = x.CODMONEDA) IS NULL THEN 0
                                    ELSE d.COBRANZAREAL_MES / (SELECT t.TIPO_CAMBIO_DLS FROM FECXC_TIPOCAMBIO_TMP t WHERE t.CODMONEDA = d.CODMONEDA)
                                 END FROM FECXC_CANINTER_ALAFECH_COB_ANT x WHERE x.E_CODIGO = d.E_CODIGO AND x.SEGMENTO = d.SEGMENTO)
    WHERE d.CODMONEDA NOT IN ('MN','DLS');
    UPDATE FECXC_CANINTER_ALAFECH_COB_ANT SET COBRANZA_MES = 0, COBRANZAREAL_MES = 0 WHERE COBRANZA_MES IS NULL OR COBRANZAREAL_MES IS NULL;
*/
 --     LARG se ingresa codigo para cambiar el tipo de cambio de Euros a Dolares y el tipo de moneda de Euros a Dolares cuando la empresa sea 552 y el segmento 13
/*
   select count(*)
   into t_count
   from FECXC_TPC
   where FECHA_TPC= p_FECHA
   AND SECMONEDA=15;
   if t_count>0 then
        BEGIN
          DECLARE
              CURSOR C_TC IS
                 select CANAL,nvl(COBRANZA_DIA*TIPO_CAMBIO_DLS,0) as tcp_actualizado
                 from FECXC_CANINTER_DELDIA a, FECXC_TPC b,FECXC_MONEDAS c
                 where a.CODMONEDA=c.CODMONEDA and c.SECMONEDA=b.SECMONEDA and
                       a.E_CODIGO=552 and a.SEGMENTO=13 and a.CODMONEDA='EUR'
                       and FECHA_TPC= p_FECHA;
                Variables C_TC%ROWTYPE;
          BEGIN
           FOR Variables IN C_TC LOOP
                    update FECXC_CANINTER_DELDIA
                    set CODMONEDA='DLS',
                        COBRANZA_DIA=Variables.tcp_actualizado
                    where E_CODIGO=552 and SEGMENTO=13 and CODMONEDA='EUR' and CANAL=Variables.CANAL;
                    SELECT count(*)
                    into t_countdos
                    FROM  FECXC_CANINTER_DELDIA
                    WHERE E_CODIGO=552 AND SEGMENTO=13 AND CODMONEDA='DLS' and CANAL=Variables.CANAL;
                  if t_countdos > 1 then
                        SELECT sum(nvl(COBRANZA_DIA,0))
                        into t_cobranzames_act
                        FROM  FECXC_CANINTER_DELDIA
                        WHERE E_CODIGO=552 AND SEGMENTO=13 AND CODMONEDA='DLS' and CANAL=Variables.CANAL;
                        select min(COBRANZA_DIA)
                        into t_min
                        FROM  FECXC_CANINTER_DELDIA
                        WHERE E_CODIGO=552 AND SEGMENTO=13 AND CODMONEDA='DLS' and CANAL=Variables.CANAL;
                        DELETE FROM FECXC_CANINTER_DELDIA
                               WHERE COBRANZA_DIA=t_min AND E_CODIGO=552 AND SEGMENTO=13 AND CODMONEDA='DLS' and CANAL=Variables.CANAL;
                        update FECXC_CANINTER_DELDIA
                        set COBRANZA_DIA=t_cobranzames_act
                        WHERE E_CODIGO=552 AND SEGMENTO=13 AND CODMONEDA='DLS' and CANAL=Variables.CANAL;
                  end if;
                COMMIT;
           END LOOP;
          END; --FOR
        END;--CURSOR
        BEGIN
          DECLARE
              CURSOR C_TC IS
                 select CANAL,nvl(COBRANZA_MES*TIPO_CAMBIO_DLS,0) as tcp_actualizado
                 from FECXC_CANINTER_XMES_cob_act a, FECXC_TPC b,FECXC_MONEDAS c
                 where a.CODMONEDA=c.CODMONEDA and c.SECMONEDA=b.SECMONEDA and
                       a.E_CODIGO=552 and a.SEGMENTO=13 and a.CODMONEDA='EUR'
                       and FECHA_TPC= p_FECHA;
                Variables C_TC%ROWTYPE;
          BEGIN
           FOR Variables IN C_TC LOOP
                    update FECXC_CANINTER_XMES_cob_act
                    set CODMONEDA='DLS',
                        COBRANZA_MES=Variables.tcp_actualizado
                    where E_CODIGO=552 and SEGMENTO=13 and CODMONEDA='EUR' and CANAL=Variables.CANAL;
                    SELECT count(*)
                    into t_countdos
                    FROM  FECXC_CANINTER_XMES_cob_act
                    WHERE E_CODIGO=552 AND SEGMENTO=13 AND CODMONEDA='DLS' and CANAL=Variables.CANAL;
                  if t_countdos > 1 then
                        SELECT sum(nvl(COBRANZA_MES,0))
                        into t_cobranzames_act
                        FROM  FECXC_CANINTER_XMES_cob_act
                        WHERE E_CODIGO=552 AND SEGMENTO=13 AND CODMONEDA='DLS' and CANAL=Variables.CANAL;
                        select min(COBRANZA_MES)
                        into t_min
                        FROM  FECXC_CANINTER_XMES_cob_act
                        WHERE E_CODIGO=552 AND SEGMENTO=13 AND CODMONEDA='DLS' and CANAL=Variables.CANAL;
                        DELETE FROM FECXC_CANINTER_XMES_cob_act
                               WHERE COBRANZA_MES=t_min AND E_CODIGO=552 AND SEGMENTO=13 AND CODMONEDA='DLS' and CANAL=Variables.CANAL;
                        update FECXC_CANINTER_XMES_cob_act
                        set COBRANZA_MES=t_cobranzames_act
                        WHERE E_CODIGO=552 AND SEGMENTO=13 AND CODMONEDA='DLS' and CANAL=Variables.CANAL;
                  end if;
                COMMIT;
           END LOOP;
          END; --FOR
        END;--CURSOR
       BEGIN
          DECLARE
              CURSOR C_TC IS
                 select CANAL,nvl(COBRANZA_MES*TIPO_CAMBIO_DLS,0) as tcp_actualizado,
                        nvl(COBRANZAREAL_MES*TIPO_CAMBIO_DLS,0) as tcp_actualizado_dos
                 from FECXC_CANINTER_XMES_cob_ant a, FECXC_TPC b,FECXC_MONEDAS c
                 where a.CODMONEDA=c.CODMONEDA and c.SECMONEDA=b.SECMONEDA and
                       a.E_CODIGO=552 and a.SEGMENTO=13 and a.CODMONEDA='EUR'
                       and FECHA_TPC= p_FECHA;
                Variables C_TC%ROWTYPE;
          BEGIN
           FOR Variables IN C_TC LOOP
                    update FECXC_CANINTER_XMES_cob_ant
                    set CODMONEDA='DLS',
                        COBRANZA_MES=Variables.tcp_actualizado,
                        COBRANZAREAL_MES=Variables.tcp_actualizado_dos
                    where E_CODIGO=552 and SEGMENTO=13 and CODMONEDA='EUR' and CANAL=Variables.CANAL;
                    SELECT count(*)
                    into t_countdos
                    FROM  FECXC_CANINTER_XMES_cob_ant
                    WHERE E_CODIGO=552 AND SEGMENTO=13 AND CODMONEDA='DLS' and CANAL=Variables.CANAL;
                  if t_countdos > 1 then
                        SELECT sum(nvl(COBRANZA_MES,0)),sum(nvl(COBRANZAREAL_MES,0))
                        into t_cobranzames_act,t_cobranzames_act_dos
                        FROM  FECXC_CANINTER_XMES_cob_ant
                        WHERE E_CODIGO=552 AND SEGMENTO=13 AND CODMONEDA='DLS' and CANAL=Variables.CANAL;
                        select min(COBRANZA_MES),min(COBRANZAREAL_MES)
                        into t_min,t_min_dos
                        FROM  FECXC_CANINTER_XMES_cob_ant
                        WHERE E_CODIGO=552 AND SEGMENTO=13 AND CODMONEDA='DLS' and CANAL=Variables.CANAL;
                        DELETE FROM FECXC_CANINTER_XMES_cob_ant
                               WHERE COBRANZA_MES=t_min AND COBRANZAREAL_MES=t_min_dos AND E_CODIGO=552
                               AND SEGMENTO=13 AND CODMONEDA='DLS' AND CANAL=Variables.CANAL;
                        update FECXC_CANINTER_XMES_cob_ant
                        set COBRANZA_MES=t_cobranzames_act,COBRANZAREAL_MES=t_cobranzames_act_dos
                        WHERE E_CODIGO=552 AND SEGMENTO=13 AND CODMONEDA='DLS' and CANAL=Variables.CANAL;
                  end if;
                COMMIT;
           END LOOP;
          END; --FOR
       END;--CURSOR
        BEGIN
          DECLARE
              CURSOR C_TC IS
                 select CANAL,nvl(COBRANZA_MES*TIPO_CAMBIO_DLS,0) as tcp_actualizado,
                        nvl(COBRANZAREAL_MES*TIPO_CAMBIO_DLS,0) as tcp_actualizado_dos,mes
                 from FECXC_CANINTER_ALAFECH_cob_act a, FECXC_TPC b,FECXC_MONEDAS c
                 where a.CODMONEDA=c.CODMONEDA and c.SECMONEDA=b.SECMONEDA and
                       a.E_CODIGO=552 and a.SEGMENTO=13 and a.CODMONEDA='EUR'
                       and FECHA_TPC= p_FECHA;
                Variables C_TC%ROWTYPE;
          BEGIN
           FOR Variables IN C_TC LOOP
                    update FECXC_CANINTER_ALAFECH_cob_act
                    set CODMONEDA='DLS',
                        COBRANZA_MES=Variables.tcp_actualizado,
                        COBRANZAREAL_MES=Variables.tcp_actualizado_dos
                    where E_CODIGO=552 and SEGMENTO=13 and CODMONEDA='EUR' and CANAL=Variables.CANAL
                          and MES=Variables.MES;
                    SELECT count(*)
                    into t_countdos
                    FROM  FECXC_CANINTER_ALAFECH_cob_act
                    WHERE E_CODIGO=552 AND SEGMENTO=13 AND CODMONEDA='DLS' and CANAL=Variables.CANAL
                          and MES=Variables.MES;
                  if t_countdos > 1 then
                        SELECT sum(nvl(COBRANZA_MES,0)),sum(nvl(COBRANZAREAL_MES,0))
                        into t_cobranzames_act,t_cobranzames_act_dos
                        FROM  FECXC_CANINTER_ALAFECH_cob_act
                        WHERE E_CODIGO=552 AND SEGMENTO=13 AND CODMONEDA='DLS' and CANAL=Variables.CANAL
                              and MES=Variables.MES;
                        select min(COBRANZA_MES),min(COBRANZAREAL_MES)
                        into t_min,t_min_dos
                        FROM  FECXC_CANINTER_ALAFECH_cob_act
                        WHERE E_CODIGO=552 AND SEGMENTO=13 AND CODMONEDA='DLS' and CANAL=Variables.CANAL
                              and MES=Variables.MES;
                        DELETE FROM FECXC_CANINTER_ALAFECH_cob_act
                               WHERE COBRANZA_MES=t_min AND COBRANZAREAL_MES=t_min_dos AND E_CODIGO=552
                               AND SEGMENTO=13 AND CODMONEDA='DLS' AND CANAL=Variables.CANAL
                               and MES=Variables.MES;
                        update FECXC_CANINTER_ALAFECH_cob_act
                        set COBRANZA_MES=t_cobranzames_act,COBRANZAREAL_MES=t_cobranzames_act_dos
                        WHERE E_CODIGO=552 AND SEGMENTO=13 AND CODMONEDA='DLS' and CANAL=Variables.CANAL
                        and MES=Variables.MES;
                  end if;
                COMMIT;
           END LOOP;
          END; --FOR
        END;--CURSOR
        BEGIN
          DECLARE
              CURSOR C_TC IS
                 select CANAL,nvl(COBRANZA_MES*TIPO_CAMBIO_DLS,0) as tcp_actualizado,
                        nvl(COBRANZAREAL_MES*TIPO_CAMBIO_DLS,0) as tcp_actualizado_dos,mes
                 from FECXC_CANINTER_ALAFECH_cob_ant a, FECXC_TPC b,FECXC_MONEDAS c
                 where a.CODMONEDA=c.CODMONEDA and c.SECMONEDA=b.SECMONEDA and
                       a.E_CODIGO=552 and a.SEGMENTO=13 and a.CODMONEDA='EUR'
                       and FECHA_TPC= p_FECHA;
                Variables C_TC%ROWTYPE;
          BEGIN
           FOR Variables IN C_TC LOOP
                    update FECXC_CANINTER_ALAFECH_cob_ant
                    set CODMONEDA='DLS',
                        COBRANZA_MES=Variables.tcp_actualizado,
                        COBRANZAREAL_MES=Variables.tcp_actualizado_dos
                    where E_CODIGO=552 and SEGMENTO=13 and CODMONEDA='EUR' and CANAL=Variables.CANAL
                          and MES=Variables.MES;
                    SELECT count(*)
                    into t_countdos
                    FROM  FECXC_CANINTER_ALAFECH_cob_ant
                    WHERE E_CODIGO=552 AND SEGMENTO=13 AND CODMONEDA='DLS' and CANAL=Variables.CANAL
                          and MES=Variables.MES;
                  if t_countdos > 1 then
                        SELECT sum(nvl(COBRANZA_MES,0)),sum(nvl(COBRANZAREAL_MES,0))
                        into t_cobranzames_act,t_cobranzames_act_dos
                        FROM  FECXC_CANINTER_ALAFECH_cob_ant
                        WHERE E_CODIGO=552 AND SEGMENTO=13 AND CODMONEDA='DLS' and CANAL=Variables.CANAL
                              and MES=Variables.MES;
                        select min(COBRANZA_MES),min(COBRANZAREAL_MES)
                        into t_min,t_min_dos
                        FROM  FECXC_CANINTER_ALAFECH_cob_ant
                        WHERE E_CODIGO=552 AND SEGMENTO=13 AND CODMONEDA='DLS' and CANAL=Variables.CANAL
                              and MES=Variables.MES;
                        DELETE FROM FECXC_CANINTER_ALAFECH_cob_ant
                               WHERE COBRANZA_MES=t_min AND COBRANZAREAL_MES=t_min_dos AND E_CODIGO=552
                               AND SEGMENTO=13 AND CODMONEDA='DLS' AND CANAL=Variables.CANAL
                               and MES=Variables.MES;
                        update FECXC_CANINTER_ALAFECH_cob_ant
                        set COBRANZA_MES=t_cobranzames_act,COBRANZAREAL_MES=t_cobranzames_act_dos
                        WHERE E_CODIGO=552 AND SEGMENTO=13 AND CODMONEDA='DLS' and CANAL=Variables.CANAL
                        and MES=Variables.MES;
                  end if;
                COMMIT;
           END LOOP;
          END; --FOR
        END;--CURSOR
   END IF;
*/
END IF;
COMMIT;
EXCEPTION
          WHEN NO_DATA_FOUND THEN
                 RAISE_APPLICATION_ERROR(-20000,'Es necesario capturar un INPC en el cat?logo de INPC para poder obtener los montos ACTUALIZADOS.');
END FECXC_LLENA_REPORTES_P;
/
