CREATE OR REPLACE EDITIONABLE PROCEDURE "FECI"."FECI_ELIMINA_REGION_PR" 
(
        p_ID                NUMBER,
        p_USUARIO              NUMBER
)
AS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
BEGIN
    UPDATE FECI_REGION_CAT
        SET IND_ESTADO = 0,
        ID_USUARIO_ULT_MODIF = p_USUARIO,
        FEC_ULT_MODIFICACION = SYSDATE
        WHERE ID_REGION = p_ID;
END FECI_ELIMINA_REGION_PR ;
/
