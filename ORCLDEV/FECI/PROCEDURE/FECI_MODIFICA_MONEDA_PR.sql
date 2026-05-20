CREATE OR REPLACE EDITIONABLE PROCEDURE "FECI"."FECI_MODIFICA_MONEDA_PR" 
(
        p_CODIGO         VARCHAR2,
        p_DESCRIPCION         VARCHAR2,
        p_ID                NUMBER,
        p_USUARIO              NUMBER
)
IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
BEGIN
        UPDATE FECI_MONEDA_CAT
        SET COD_MONEDA = p_CODIGO,
        DES_MONEDA = p_DESCRIPCION,
        ID_USUARIO_ULT_MODIF = p_USUARIO,
        FEC_ULT_MODIFICACION = SYSDATE
        WHERE ID_MONEDA = p_ID;
END FECI_MODIFICA_MONEDA_PR ;
/
