CREATE OR REPLACE EDITIONABLE PROCEDURE "FECI"."FECI_MODIFICA_CONFIGURACION_PR" 
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
        UPDATE FECI_CONFIGURACION_CAT
        SET DES_CONFIGURACION = pstDias
       ,ID_USUARIO_ULT_MODIF = pinUsuario,
       FEC_ULT_MODIFICACION = SYSDATE
        WHERE COD_CONFIGURACION = 'DIASOP';
        UPDATE FECI_CONFIGURACION_CAT
        SET DES_CONFIGURACION = pstHora
       ,ID_USUARIO_ULT_MODIF = pinUsuario,
       FEC_ULT_MODIFICACION = SYSDATE
        WHERE COD_CONFIGURACION = 'HORAEXP';
        UPDATE FECI_CONFIGURACION_CAT
        SET DES_CONFIGURACION = pstClasificacion
       ,ID_USUARIO_ULT_MODIF = pinUsuario,
       FEC_ULT_MODIFICACION = SYSDATE
        WHERE COD_CONFIGURACION = 'CLASCLI';
    COMMIT;
END FECI_MODIFICA_CONFIGURACION_PR;
/
