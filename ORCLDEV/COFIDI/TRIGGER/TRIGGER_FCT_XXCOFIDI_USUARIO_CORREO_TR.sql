CREATE OR REPLACE FUNCTION trigger_fct_xxcofidi_usuario_correo_tr() RETURNS trigger AS $body$
BEGIN
<<COLUMN_SEQUENCES>>
BEGIN
IF TG_OP = 'INSERT' AND NULLIF(NEW.ID_USUARIO_CORREO_PK::text, '') IS NULL THEN
SELECT cofidi.nextval('xxcofidi_usuario_correo_sq')
INTO STRICT NEW.ID_USUARIO_CORREO_PK;
END IF;END;
RETURN NEW;
END
$body$
LANGUAGE 'plpgsql';
