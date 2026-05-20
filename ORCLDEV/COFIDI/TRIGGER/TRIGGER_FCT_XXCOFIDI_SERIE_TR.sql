CREATE OR REPLACE FUNCTION trigger_fct_xxcofidi_serie_tr() RETURNS trigger AS $body$
BEGIN
<<COLUMN_SEQUENCES>>
BEGIN
IF TG_OP = 'INSERT' AND NULLIF(NEW.ID_SERIE_PK::text, '') IS NULL THEN
SELECT cofidi.nextval('xxcofidi_serie_sq')
INTO STRICT NEW.ID_SERIE_PK;
END IF;END;
RETURN NEW;
END
$body$
LANGUAGE 'plpgsql';
