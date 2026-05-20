CREATE OR REPLACE EDITIONABLE PROCEDURE "FECXC"."FECI_MODIFICA_TIPO_CAMBIO_PR" 
(
        p_FECHA         VARCHAR2,
        p_CODIGO         VARCHAR2,
        p_VALOR         NUMBER,
        p_ID                NUMBER,
        p_USUARIO              NUMBER
)
IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
BEGIN
        UPDATE FECXC.FECI_TIPO_CAMBIO_CAT
        SET FEC_FECHA_TC = TO_DATE(TO_CHAR(p_FECHA, 'YYYY-MM-DD'), 'YYYY-MM-DD'),
        COD_MONEDA = p_CODIGO,
        NUM_VALOR = p_VALOR,
        ID_USUARIO_ULT_MODIF = p_USUARIO
        WHERE ID_TIPO_CAMBIO = p_ID;
END FECI_MODIFICA_TIPO_CAMBIO_PR ;
/
