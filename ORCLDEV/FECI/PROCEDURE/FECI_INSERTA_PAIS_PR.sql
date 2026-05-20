CREATE OR REPLACE EDITIONABLE PROCEDURE "FECI"."FECI_INSERTA_PAIS_PR" 
(
        p_CODIGO         VARCHAR2,
        p_DESCRIPCION         VARCHAR2,
        p_USUARIO              NUMBER
)
AS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
    ID_REGISTRO NUMBER;
    feci_cursors SYS_REFCURSOR;
BEGIN
     INSERT INTO FECI_PAIS_CAT(COD_PAIS, DES_PAIS ,FEC_CREACION,
                FEC_ULT_MODIFICACION,ID_USUARIO_CREACION , ID_USUARIO_ULT_MODIF, IND_ESTADO)
             VALUES(p_CODIGO, p_DESCRIPCION, sysdate, sysdate,
                    p_Usuario, 0, 1) returning ID_PAIS INTO ID_REGISTRO;
            open feci_cursors for
               SELECT ID_PAIS FROM FECI_PAIS_CAT WHERE ID_PAIS =  ID_REGISTRO;
    DBMS_SQL.RETURN_RESULT(feci_cursors);
END FECI_INSERTA_PAIS_PR ;
/
