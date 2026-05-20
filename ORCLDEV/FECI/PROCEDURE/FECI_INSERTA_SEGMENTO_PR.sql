CREATE OR REPLACE EDITIONABLE PROCEDURE "FECI"."FECI_INSERTA_SEGMENTO_PR" 
(
        p_CODIGO         VARCHAR2,
        p_DESCRIPCION         VARCHAR2,
        p_Usuario              NUMBER
)
AS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
    ID_REGISTRO NUMBER;
    feci_cursors SYS_REFCURSOR;
BEGIN
     INSERT INTO FECI_SEGMENTO_CAT(COD_SEGMENTO, DES_SEGMENTO, FEC_CREACION,
                FEC_ULT_MODIFICACION,ID_USUARIO_CREACION , ID_USUARIO_ULT_MODIF, IND_ESTADO)
             VALUES(p_CODIGO, p_DESCRIPCION, sysdate, sysdate,
                    p_Usuario, 0, 1) returning ID_SEGMENTO INTO ID_REGISTRO;
            open feci_cursors for
               SELECT ID_SEGMENTO FROM FECI_SEGMENTO_CAT WHERE ID_SEGMENTO =  ID_REGISTRO;
    DBMS_SQL.RETURN_RESULT(feci_cursors);
END FECI_INSERTA_SEGMENTO_PR ;
/
