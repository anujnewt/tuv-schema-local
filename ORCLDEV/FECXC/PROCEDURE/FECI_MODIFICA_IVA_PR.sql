CREATE OR REPLACE EDITIONABLE PROCEDURE "FECXC"."FECI_MODIFICA_IVA_PR" 
(
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
        UPDATE FECXC.FECI_PORCENTAJE_IVA_CAT
        SET COD_PORCENTAJE_IVA = p_CODIGO,
        NUM_VALOR = p_VALOR,
        ID_PORCENTAJE_IVA = p_USUARIO
        WHERE ID_PORCENTAJE_IVA = p_ID;
END FECI_MODIFICA_IVA_PR ;
/
