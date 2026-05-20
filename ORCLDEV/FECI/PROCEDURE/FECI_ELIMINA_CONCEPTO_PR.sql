CREATE OR REPLACE EDITIONABLE PROCEDURE "FECI"."FECI_ELIMINA_CONCEPTO_PR" 
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
        UPDATE FECI_CONCEPTO_CAT
        SET IND_ESTADO = 0,
        ID_USUARIO_ULT_MODIF = p_USUARIO,
        FEC_ULT_MODIFICACION = SYSDATE
        WHERE ID_CONCEPTO = p_ID;
END FECI_ELIMINA_CONCEPTO_PR ;
/
