CREATE OR REPLACE FUNCTION trigger_fct_xxcofidi_documento_tr() RETURNS trigger AS $body$
BEGIN
<<COLUMN_SEQUENCES>>
BEGIN
IF TG_OP = 'INSERT' AND NULLIF(NEW.ID_DOCUMENTO_PK::text, '') IS NULL THEN
SELECT cofidi.nextval('xxcofidi_documento_sq')
INTO STRICT NEW.ID_DOCUMENTO_PK;
END IF;END;
RETURN NEW;
END
$body$
LANGUAGE 'plpgsql';
