CREATE OR REPLACE EDITIONABLE PROCEDURE "FECXC"."FECI_ELIMINA_REGION_PR" 
(
        p_ID                NUMBER,
        p_USUARIO              NUMBER
)
AS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
i NUMBER;
BEGIN
    UPDATE FECXC.FECI_REGION_CAT
        SET IND_ESTADO = 0,
        ID_USUARIO_ULT_MODIF = p_USUARIO
        WHERE ID_REGION = p_ID;
END FECI_ELIMINA_REGION_PR ;
/
