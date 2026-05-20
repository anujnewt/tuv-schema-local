CREATE OR REPLACE FUNCTION trigger_fct_xxcofidi_parametro_tr() RETURNS trigger AS $body$
BEGIN
<<COLUMN_SEQUENCES>>
BEGIN
IF TG_OP = 'INSERT' AND NULLIF(NEW.ID_PARAMETRO_PK::text, '') IS NULL THEN
SELECT cofidi.nextval('xxcofidi_parametro_sq')
INTO STRICT NEW.ID_PARAMETRO_PK;
END IF;END;
RETURN NEW;
END
$body$
LANGUAGE 'plpgsql';
