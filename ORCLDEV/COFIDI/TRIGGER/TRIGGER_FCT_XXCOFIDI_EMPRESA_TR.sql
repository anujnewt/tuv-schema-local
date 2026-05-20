CREATE OR REPLACE FUNCTION trigger_fct_xxcofidi_empresa_tr() RETURNS trigger AS $body$
BEGIN
<<COLUMN_SEQUENCES>>
BEGIN
IF TG_OP = 'INSERT' AND NULLIF(NEW.ID_EMPRESA_PK::text, '') IS NULL THEN
SELECT cofidi.nextval('xxcofidi_empresa_sq')
INTO STRICT NEW.ID_EMPRESA_PK;
END IF;END;
RETURN NEW;
END
$body$
LANGUAGE 'plpgsql';
