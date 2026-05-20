CREATE OR REPLACE FUNCTION trigger_fct_xxcofidi_rol_tr() RETURNS trigger AS $body$
BEGIN
<<COLUMN_SEQUENCES>>
BEGIN
IF TG_OP = 'INSERT' AND NULLIF(NEW.ID_ROL_PK::text, '') IS NULL THEN
SELECT cofidi.nextval('xxcofidi_rol_sq')
INTO STRICT NEW.ID_ROL_PK;
END IF;END;
RETURN NEW;
END
$body$
LANGUAGE 'plpgsql';
