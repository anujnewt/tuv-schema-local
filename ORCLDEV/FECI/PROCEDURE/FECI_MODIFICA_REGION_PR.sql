CREATE OR REPLACE EDITIONABLE PROCEDURE "FECI"."FECI_MODIFICA_REGION_PR" 
(
        p_CODIGO         VARCHAR2,
        p_DESCRIPCION         VARCHAR2,
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
        SET COD_REGION = p_CODIGO,
        DES_REGION = p_DESCRIPCION,
        ID_USUARIO_ULT_MODIF = p_USUARIO,
        FEC_ULT_MODIFICACION = SYSDATE
        WHERE ID_REGION = p_ID;
END FECI_MODIFICA_REGION_PR ;
/
