CREATE OR REPLACE EDITIONABLE PROCEDURE "FECXC"."FECI_OBTENER_DETALLE_RECIBOS_PR" 
(
  p_FOLIO        NUMBER ,
    p_TIPO              VARCHAR2
)
AS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
feci_cursor SYS_REFCURSOR;
BEGIN
   open feci_cursor for
           SELECT
            A.FOLIO_RECIBO,
            A.TIPO_RECIBO,
            A.FEC_CONTABILIDAD,
            A.FEC_OPERATIVA,
            A.FEC_OPERATIVA,
            A.IMPORTE,
            A.COD_MONEDA,
            A.DES_MONEDA,
            A.COD_EMPRESA,
            A.COD_CLIENTE,
            A.DES_EMPRESA,
            A.REF_CLIENTE,
            A.REF_CLIENTE,
            A.NOM_CLIENTE,
            A.CLASE_CLIENTE,
            A.METODO_PAGO,
            A.NOM_BANCO_EMISOR,
            A.NUM_CHEQUERA,
            A.NUM_CHEQUERA,
            A.NUM_CHEQUE,
            A.NUM_OPERACION,
            A.TIPO_CAMBIO_ORIGEN,
            A.FEC_TC_ORIGEN,
            A.TIPO_CAMBIO_DOLAR,
            A.FEC_TC_DOLAR,
            A.ID_USUARIO_CLASIFICACION,
            A.FEC_CLASIFICACION,
            A.ID_USUARIO_APLICACION,
            A.FEC_APLICACION,
            A.COD_ESTADO_RECIBO,
            A.FEC_CREACION,
            A.FEC_ULT_MODIFICACION,
            A.ID_USUARIO_CREACION,
            A.ID_USUARIO_ULT_MODIF,
            A.IND_ESTADO,
            A.IND_ESTADO,
            B.DES_NOMBRES,
            B.DES_APELLIDOS,
            C.DES_NOMBRES AS DES_NOMBRES_APL,
            C.DES_APELLIDOS AS DES_APELLIDOS_APL
            FROM FECXC.FECI_RECIBOS_VW A
            LEFT JOIN FECXC.FECI_USUARIO_TAB B ON A.ID_USUARIO_CLASIFICACION = B.ID_USUARIO
            LEFT JOIN FECXC.FECI_USUARIO_TAB C ON A.ID_USUARIO_APLICACION = C.ID_USUARIO
            WHERE FOLIO_RECIBO = p_FOLIO AND TIPO_RECIBO = p_TIPO ;
    DBMS_SQL.RETURN_RESULT(feci_cursor);
END FECI_OBTENER_DETALLE_RECIBOS_PR ;
/
