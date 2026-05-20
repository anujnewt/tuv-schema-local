CREATE OR REPLACE EDITIONABLE PROCEDURE "FECXC"."FECI_INSERTA_TIPO_CAMBIO_PR" 
(
        p_FECHA             DATE,
        p_CODIGO         VARCHAR2,
        p_VALOR         NUMBER,
        p_USUARIO         NUMBER
)
AS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
    ID_REGISTRO NUMBER;
    feci_cursors SYS_REFCURSOR;
BEGIN
     INSERT INTO FECXC.FECI_TIPO_CAMBIO_CAT(FEC_FECHA_TC,COD_MONEDA, NUM_VALOR, FEC_CREACION,
                FEC_ULT_MODIFICACION,ID_USUARIO_CREACION , ID_USUARIO_ULT_MODIF, IND_ESTADO)
             VALUES(p_FECHA, p_CODIGO,p_VALOR, sysdate, sysdate,
                    p_USUARIO, 0, 1) returning ID_TIPO_CAMBIO INTO ID_REGISTRO;
            open feci_cursors for
               SELECT ID_TIPO_CAMBIO FROM FECXC.FECI_TIPO_CAMBIO_CAT WHERE ID_TIPO_CAMBIO =  ID_REGISTRO;
    DBMS_SQL.RETURN_RESULT(feci_cursors);
END FECI_INSERTA_TIPO_CAMBIO_PR ;
/
