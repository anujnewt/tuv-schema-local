CREATE OR REPLACE EDITIONABLE PROCEDURE "FECXC"."FECI_MODIFICA_RECIBO_MANUAL_PR" 
(
        p_FOLIO_RECIBO   NUMBER,
        p_FECHA         DATE,
        p_MONEDA         VARCHAR2,
        p_EMPRESA         VARCHAR2,
        p_REF_CLIENTE       VARCHAR2,
        p_NOM_CLIENTE       VARCHAR2,
        p_CLASE_CLIENTE       VARCHAR2,
        p_METODO_PAGO       VARCHAR2,
        p_BANCO_EMISOR       VARCHAR2,
        p_NUM_CHEQUERA       VARCHAR2,
        p_NUM_CHEQUE       VARCHAR2,
        p_NUM_OPERACION       VARCHAR2,
        p_Usuario              NUMBER,
        p_COD_CLIENTE       VARCHAR2,
        p_IMPORTE           NUMBER
)
AS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
BEGIN
    UPDATE FECXC.FECI_RECIBO_MANUAL_TAB
    SET
       FEC_CONTABILIDAD =  TO_DATE(TO_CHAR(p_FECHA, 'yyyy-MM-dd'), 'yyyy-MM-dd'),
        FEC_OPERATIVA = TO_DATE(TO_CHAR(p_FECHA, 'yyyy-MM-dd'), 'yyyy-MM-dd'),
        IMPORTE = p_IMPORTE,
        COD_MONEDA = p_MONEDA,
        COD_EMPRESA = p_EMPRESA,
        REF_CLIENTE = p_REF_CLIENTE,
        NOM_CLIENTE = p_NOM_CLIENTE,
        CLASE_CLIENTE = p_CLASE_CLIENTE,
        METODO_PAGO = p_METODO_PAGO,
        NOM_BANCO_EMISOR = p_BANCO_EMISOR,
        NUM_CHEQUERA = p_NUM_CHEQUERA,
        NUM_CHEQUE = p_NUM_CHEQUE,
        NUM_OPERACION = p_NUM_OPERACION,
        FEC_ULT_MODIFICACION = SYSDATE,
        ID_USUARIO_ULT_MODIF = p_Usuario,
        COD_CLIENTE = p_COD_CLIENTE
        WHERE FOLIO_RECIBO_MANUAL = p_FOLIO_RECIBO;
        FECXC.FECI_MODIFICA_TIPO_CAMBIO_RECIBO_PR(p_FOLIO_RECIBO, 'MANUAL', p_Usuario);
END FECI_MODIFICA_RECIBO_MANUAL_PR ;
/
