CREATE OR REPLACE EDITIONABLE PROCEDURE "XXMOR"."XXMOR_INSERTAR_PARA_ESTATUS_PR" 
                                 (
                                         ID_SOL NUMBER,
                                         LNS    NUMBER,
                                         EST    VARCHAR2
                                 ) IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
BEGIN
    IF (LNS = 0) THEN
        UPDATE XXMOR_SOLICITUDES_ENC_TAB
        SET    ORDEN_ESTATUS = EST
        WHERE  ID_SOLICITUD  = ID_SOL;
    ELSE
        UPDATE XXMOR_SOLICITUDES_DET_TAB
        SET    LINEA_ESTATUS = EST
        WHERE  ID_SOLICITUD = ID_SOL
        AND    LINEA        = LNS;
    END IF;
    COMMIT;
END;
/
