CREATE OR REPLACE FUNCTION trigger_fct_xxcofidi_origen_tr() RETURNS trigger AS $body$
BEGIN
<<COLUMN_SEQUENCES>>
BEGIN
IF TG_OP = 'INSERT' AND NULLIF(NEW.ID_ORIGEN_PK::text, '') IS NULL THEN
SELECT cofidi.nextval('xxcofidi_origen_sq')
INTO STRICT NEW.ID_ORIGEN_PK;
END IF;END;
RETURN NEW;
END
$body$
LANGUAGE 'plpgsql';
