CREATE OR REPLACE EDITIONABLE PROCEDURE "FECXC"."FECI_ELIMINA_MONEDA_PR" 
(
        p_ID                NUMBER,
        p_USUARIO              NUMBER
)
IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
BEGIN
        UPDATE FECXC.FECI_MONEDA_CAT
        SET IND_ESTADO = 0,
        ID_USUARIO_ULT_MODIF = p_USUARIO
        WHERE ID_MONEDA = p_ID;
END FECI_ELIMINA_MONEDA_PR ;
/
