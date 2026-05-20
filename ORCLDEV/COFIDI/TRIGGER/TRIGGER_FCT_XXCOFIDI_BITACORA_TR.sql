CREATE OR REPLACE FUNCTION trigger_fct_xxcofidi_bitacora_tr() RETURNS trigger AS $body$
BEGIN
<<COLUMN_SEQUENCES>>
BEGIN
IF TG_OP = 'INSERT' AND NULLIF(NEW.ID_BITACORA_PK::text, '') IS NULL THEN
SELECT cofidi.nextval('xxcofidi_bitacora_sq')
INTO STRICT NEW.ID_BITACORA_PK;
END IF;END;
RETURN NEW;
END
$body$
LANGUAGE 'plpgsql';
