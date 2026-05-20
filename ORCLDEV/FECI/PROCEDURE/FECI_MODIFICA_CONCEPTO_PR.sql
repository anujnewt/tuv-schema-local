CREATE OR REPLACE EDITIONABLE PROCEDURE "FECI"."FECI_MODIFICA_CONCEPTO_PR" 
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
        UPDATE FECI_CONCEPTO_CAT
        SET COD_CONCEPTO = p_CODIGO,
        DES_CONCEPTO = p_DESCRIPCION,
        ID_USUARIO_ULT_MODIF = p_USUARIO,
        FEC_ULT_MODIFICACION = SYSDATE
        WHERE ID_CONCEPTO = p_ID;
END FECI_MODIFICA_CONCEPTO_PR ;
/
