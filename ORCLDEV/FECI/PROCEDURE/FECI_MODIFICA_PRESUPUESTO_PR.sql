CREATE OR REPLACE EDITIONABLE PROCEDURE "FECI"."FECI_MODIFICA_PRESUPUESTO_PR" 
(
        p_IMPORTE         NUMBER,
        p_ID                NUMBER,
        p_ID_USUARIO              NUMBER
)
IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
BEGIN
        UPDATE FECI_PRESUPUESTO_TAB
        SET NUM_IMPORTE = p_IMPORTE,
        ID_USUARIO_ULT_MODIF = p_ID_USUARIO,
        FEC_ULT_MODIFICACION = SYSDATE
        WHERE ID_PRESUPUESTO = p_ID;
END FECI_MODIFICA_PRESUPUESTO_PR ;
/
