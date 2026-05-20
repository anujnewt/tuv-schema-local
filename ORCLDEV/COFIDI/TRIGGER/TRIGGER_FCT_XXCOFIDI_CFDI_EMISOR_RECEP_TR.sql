CREATE OR REPLACE FUNCTION trigger_fct_xxcofidi_cfdi_emisor_recep_tr() RETURNS trigger AS $body$
BEGIN
<<COLUMN_SEQUENCES>>
BEGIN
IF TG_OP = 'INSERT' AND NULLIF(NEW.ID_CFDI_EMISOR_RECEP_PK::text, '') IS NULL THEN
SELECT cofidi.nextval('xxcofidi_cfdi_emisor_recep_sq')
INTO STRICT NEW.ID_CFDI_EMISOR_RECEP_PK;
END IF;END;
RETURN NEW;
END
$body$
LANGUAGE 'plpgsql';
