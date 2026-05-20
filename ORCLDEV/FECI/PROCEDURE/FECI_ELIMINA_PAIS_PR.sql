CREATE OR REPLACE EDITIONABLE PROCEDURE "FECI"."FECI_ELIMINA_PAIS_PR" 
(   p_COD         VARCHAR2,
    p_USUARIO        NUMBER
)
AS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
        feci_cursors SYS_REFCURSOR;
BEGIN
        UPDATE FECI_PAIS_CAT  PAIS
        SET PAIS.IND_ESTADO = 0,
            PAIS.ID_USUARIO_ULT_MODIF = p_USUARIO,
            FEC_ULT_MODIFICACION = SYSDATE
        WHERE PAIS.COD_PAIS = p_COD
        AND NOT EXISTS (
            SELECT 1
            FROM FECI_CLASIFICACION_TAB CLS
            WHERE CLS.COD_PAIS = PAIS.COD_PAIS
        ) ;
        open feci_cursors for
               SELECT COUNT(COD_PAIS) FROM FECI_CLASIFICACION_TAB WHERE COD_PAIS =  p_COD;
    DBMS_SQL.RETURN_RESULT(feci_cursors);
END FECI_ELIMINA_PAIS_PR;
/
