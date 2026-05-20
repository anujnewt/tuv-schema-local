CREATE OR REPLACE EDITIONABLE PROCEDURE "FECXC"."FECI_MODIFICA_CONFIGURACION_PR" 
                    (
                        pstDias IN VARCHAR2,
                        pstHora IN VARCHAR2,
                        pstClasificacion IN VARCHAR2,
                        pinUsuario IN NUMBER
                        )
AS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
    BEGIN
        UPDATE FECXC.FECI_CONFIGURACION_CAT
        SET DES_CONFIGURACION = pstDias
       ,ID_USUARIO_ULT_MODIF = pinUsuario
        WHERE COD_CONFIGURACION = 'DIASOP';
        UPDATE FECXC.FECI_CONFIGURACION_CAT
        SET DES_CONFIGURACION = pstHora
       ,ID_USUARIO_ULT_MODIF = pinUsuario
        WHERE COD_CONFIGURACION = 'HORAEXP';
        UPDATE FECXC.FECI_CONFIGURACION_CAT
        SET DES_CONFIGURACION = pstClasificacion
       ,ID_USUARIO_ULT_MODIF = pinUsuario
        WHERE COD_CONFIGURACION = 'CLASCLI';
    COMMIT;
END FECI_MODIFICA_CONFIGURACION_PR;
/
