CREATE OR REPLACE FUNCTION dmap_trigger_fct_xxmor_solicitudes_enc_au_tr_03() RETURNS trigger AS $body$
DECLARE
linFlag    numeric;
lstDescErr varchar(4000);
lstFileErr varchar(350);
lstMethErr varchar(1000);
PRAGMA AUTONOMOUS_TRANSACTION;
BEGIN
BEGIN
linFlag := 0;
lstDescErr:= NULL;
IF (OLD.ADVID <> NEW.ADVID)
THEN
IF (OLD.AGYESTNUM <> NEW.AGYESTNUM)
THEN
lstDescErr := 'ID_SOLICITUD['||OLD.ID_SOLICITUD||'] - ID_SOLICITUD Update['||NEW.ID_SOLICITUD||']'
||' == ID_REQUEST['||OLD.ID_REQUEST||'] - ID_REQUEST Update['||NEW.ID_REQUEST||']'
||' == ADVID['||OLD.ADVID||'] - ADVID Update['||NEW.ADVID||']'
||' == AGYESTNUM['||OLD.AGYESTNUM||'] - AGYESTNUM Update['||NEW.AGYESTNUM||']';
lstFileErr := 'llave encabezado violada';
lstMethErr := 'Operacion no permitida para encabezado';
INSERT INTO XXMOR_LOG_ERRORES_TAB
VALUES (nextval('xxmor_log_error_sq'),
lstDescErr,
lstFileErr,
lstMethErr,
statement_timestamp()
);
call XXMOR_SEND_NOTIFY_UNKNWN_PR(OLD.ID_SOLICITUD, '1' );
COMMIT;
linFlag := 1;
END IF;
END IF;
IF (linFlag = 1)
THEN
RAISE EXCEPTION '%', lstDescErr USING ERRCODE = '45000';
END IF;
EXCEPTION
WHEN OTHERS THEN
-- Consider logging the error and then re-raise
RAISE;END;
RETURN NEW;
END
$body$
LANGUAGE 'plpgsql';
