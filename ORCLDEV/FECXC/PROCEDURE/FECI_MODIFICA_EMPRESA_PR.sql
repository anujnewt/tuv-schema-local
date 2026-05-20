CREATE OR REPLACE EDITIONABLE PROCEDURE "FECXC"."FECI_MODIFICA_EMPRESA_PR" 
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
        UPDATE FECXC.FECI_EMPRESA_CAT
        SET COD_EMPRESA = p_CODIGO,
        DES_EMPRESA = p_DESCRIPCION,
        ID_USUARIO_ULT_MODIF = p_USUARIO
        WHERE ID_EMPRESA = p_ID;
END FECI_MODIFICA_EMPRESA_PR ;
/
