CREATE OR REPLACE FUNCTION trigger_fct_xxcofidi_factura_tr() RETURNS trigger AS $body$
BEGIN
<<COLUMN_SEQUENCES>>
BEGIN
IF TG_OP = 'INSERT' AND NULLIF(NEW.ID_FACTURA_PK::text, '') IS NULL THEN
SELECT cofidi.nextval('xxcofidi_factura_sq')
INTO STRICT NEW.ID_FACTURA_PK;
END IF;END;
RETURN NEW;
END
$body$
LANGUAGE 'plpgsql';
