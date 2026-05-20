CREATE OR REPLACE EDITIONABLE PROCEDURE "FECXC"."FECI_MODIFICA_SEGMENTO_PR" 
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
        UPDATE FECXC.FECI_SEGMENTO_CAT
        SET COD_SEGMENTO = p_CODIGO,
        DES_SEGMENTO = p_DESCRIPCION,
        ID_USUARIO_ULT_MODIF = p_USUARIO
        WHERE ID_SEGMENTO = p_ID;
END FECI_MODIFICA_SEGMENTO_PR ;
/
