CREATE OR REPLACE FUNCTION trigger_fct_xxcofidi_historico_clave_tr() RETURNS trigger AS $body$
BEGIN
<<COLUMN_SEQUENCES>>
BEGIN
IF TG_OP = 'INSERT' AND NULLIF(NEW.ID_HISTORICO_CLAVE_PK::text, '') IS NULL THEN
SELECT cofidi.nextval('xxcofidi_historico_clave_sq')
INTO STRICT NEW.ID_HISTORICO_CLAVE_PK;
END IF;END;
RETURN NEW;
END
$body$
LANGUAGE 'plpgsql';
