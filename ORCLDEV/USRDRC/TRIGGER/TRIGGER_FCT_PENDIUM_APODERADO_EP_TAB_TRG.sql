CREATE OR REPLACE FUNCTION trigger_fct_pendium_apoderado_ep_tab_trg() RETURNS trigger AS $body$
BEGIN
<<COLUMN_SEQUENCES>>
BEGIN
IF TG_OP = 'INSERT' AND NULLIF(NEW.ID_APOD_EP_PK::text, '') IS NULL THEN
SELECT nextval('pendium_apoderado_ep_seq') INTO STRICT NEW.ID_APOD_EP_PK;
END IF;END;
RETURN NEW;
END
$body$
LANGUAGE 'plpgsql';
