CREATE OR REPLACE EDITIONABLE PROCEDURE "FECI"."FECI_INSERTA_CLASIFICACION_PR" 
(
        p_ID_CLASIFICACION         NUMBER,
        p_FOLIO_RECIBO               NUMBER,
        p_TIPO_RECIBO              VARCHAR2,
        p_ORDEN        NUMBER,
        p_PORCENTAJE_IVA               NUMBER,
        p_IMPORTE_ORG               NUMBER ,
        p_MONTO_BASE_ORG         NUMBER,
        p_MONTO_IVA_ORG                NUMBER,
        p_IMPORTE_MXN               NUMBER ,
        p_MONTO_BASE_MXN        NUMBER,
        p_MONTO_IVA_MXN              NUMBER,
        p_IMPORTE_USD               NUMBER ,
        p_MONTO_BASE_USD         NUMBER,
        p_MONTO_IVA_USD                NUMBER,
        p_COD_SEGMENTO               VARCHAR2 ,
        p_COD_GRUPO_FORECAST         VARCHAR2,
        p_COD_CONCEPTO                VARCHAR2,
        p_COD_REGION               VARCHAR2 ,
        p_COD_PAIS         VARCHAR2,
        p_DESC_CPS               VARCHAR2
)
IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
    FOLIO NUMBER;
    feci_cursors SYS_REFCURSOR;
BEGIN
            INSERT INTO FECI_CLASIFICACION_TAB
            (FOLIO_RECIBO,TIPO_RECIBO,ORDEN,PORCENTAJE_IVA,IMPORTE_ORG,MONTO_BASE_ORG,MONTO_IVA_ORG,
            IMPORTE_MXN,MONTO_BASE_MXN,MONTO_IVA_MXN,IMPORTE_USD,MONTO_BASE_USD,MONTO_IVA_USD,COD_SEGMENTO,COD_GRUPO_FORECAST,
            COD_CONCEPTO,COD_REGION,COD_PAIS,DESC_CPS,FEC_CREACION,FEC_ULT_MODIFICACION,ID_USUARIO_CREACION,ID_USUARIO_ULT_MODIF,IND_ESTADO)
            VALUES (
            p_FOLIO_RECIBO,
            p_TIPO_RECIBO,
            p_ORDEN,
            p_PORCENTAJE_IVA,
            p_IMPORTE_ORG,
            p_MONTO_BASE_ORG,
            p_MONTO_IVA_ORG,
            p_IMPORTE_MXN,
            p_MONTO_BASE_MXN,
            p_MONTO_IVA_MXN,
            p_IMPORTE_USD,
            p_MONTO_BASE_USD,
            p_MONTO_IVA_USD,
            p_COD_SEGMENTO,
            p_COD_GRUPO_FORECAST,
            p_COD_CONCEPTO,
            p_COD_REGION,
            p_COD_PAIS,
            p_DESC_CPS,
            SYSDATE,
            SYSDATE,
            1,
            1,
            1
            ) returning FOLIO_RECIBO INTO FOLIO;
open feci_cursors for
               SELECT FOLIO_RECIBO FROM FECI_CLASIFICACION_TAB WHERE FOLIO_RECIBO =  FOLIO;
    DBMS_SQL.RETURN_RESULT(feci_cursors);
END FECI_INSERTA_CLASIFICACION_PR ;
/
