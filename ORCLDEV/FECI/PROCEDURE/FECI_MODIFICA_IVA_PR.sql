CREATE OR REPLACE EDITIONABLE PROCEDURE "FECI"."FECI_MODIFICA_IVA_PR" 
(
        p_CODIGO         VARCHAR2,
        p_DESCRIPCION         NUMBER,
        p_ID                NUMBER,
        p_USUARIO              NUMBER
)
IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
BEGIN
        UPDATE FECI_PORCENTAJE_IVA_CAT
        SET
        COD_PORCENTAJE_IVA = p_CODIGO,
        NUM_VALOR = p_DESCRIPCION,
        ID_USUARIO_ULT_MODIF = p_USUARIO,
        FEC_ULT_MODIFICACION = SYSDATE
        WHERE ID_PORCENTAJE_IVA = p_ID;
END FECI_MODIFICA_IVA_PR ;
/
