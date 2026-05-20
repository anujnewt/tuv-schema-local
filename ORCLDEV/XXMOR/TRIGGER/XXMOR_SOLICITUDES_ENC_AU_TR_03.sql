CREATE OR REPLACE EDITIONABLE TRIGGER "XXMOR"."XXMOR_SOLICITUDES_ENC_AU_TR_03" 
BEFORE UPDATE
ON XXMOR.XXMOR_SOLICITUDES_ENC_TAB
REFERENCING NEW AS New OLD AS Old
FOR EACH ROW
DECLARE
    linFlag    NUMBER;
    lstDescErr VARCHAR2(4000);
    lstFileErr VARCHAR2(350);
    lstMethErr VARCHAR2(1000);
PRAGMA AUTONOMOUS_TRANSACTION;
BEGIN
   linFlag := 0;
   lstDescErr := '';
    IF(:OLD.ADVID <> :NEW.ADVID)
    THEN
        IF(:OLD.AGYESTNUM <> :NEW.AGYESTNUM)
        THEN
            lstDescErr := 'ID_SOLICITUD['||:OLD.ID_SOLICITUD||'] - ID_SOLICITUD Update['||:NEW.ID_SOLICITUD||']'
                          ||' == ID_REQUEST['||:OLD.ID_REQUEST||'] - ID_REQUEST Update['||:NEW.ID_REQUEST||']'
                          ||' == ADVID['||:OLD.ADVID||'] - ADVID Update['||:NEW.ADVID||']'
                          ||' == AGYESTNUM['||:OLD.AGYESTNUM||'] - AGYESTNUM Update['||:NEW.AGYESTNUM||']';
            lstFileErr := 'llave encabezado violada';
            lstMethErr := 'Operacion no permitida para encabezado';
            INSERT INTO XXMOR_LOG_ERRORES_TAB
                 VALUES (XXMOR_LOG_ERROR_SQ.NEXTVAL,
                         lstDescErr,
                         lstFileErr,
                         lstMethErr,
                         SYSDATE
                        );
            XXMOR_SEND_NOTIFY_UNKNWN_PR (:OLD.ID_SOLICITUD, '1' );
            COMMIT;
            linFlag := 1;
        END IF;
    END IF;
    IF(linFlag = 1)
    THEN
        raise_application_error(-20000,lstDescErr);
    END IF;
   EXCEPTION
     WHEN OTHERS THEN
       -- Consider logging the error and then re-raise
       RAISE;
END XXMOR_SOLICITUDES_ENC_AU_TR_03;

/
ALTER TRIGGER "XXMOR"."XXMOR_SOLICITUDES_ENC_AU_TR_03" ENABLE;
