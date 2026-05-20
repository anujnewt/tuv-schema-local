CREATE OR REPLACE EDITIONABLE PROCEDURE "FECI"."FECI_INSERTA_REGION_PR" 
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
     INSERT INTO FECI_REGION_CAT(COD_REGION, DES_REGION, FEC_CREACION,
                FEC_ULT_MODIFICACION,ID_USUARIO_CREACION , ID_USUARIO_ULT_MODIF, IND_ESTADO)
             VALUES(p_CODIGO, p_DESCRIPCION, sysdate, sysdate,
                    p_USUARIO, 0, 1) returning ID_REGION INTO ID_REGISTRO;
            open feci_cursors for
               SELECT ID_REGION FROM FECI_REGION_CAT WHERE ID_REGION =  ID_REGISTRO;
    DBMS_SQL.RETURN_RESULT(feci_cursors);
END FECI_INSERTA_REGION_PR ;
/
