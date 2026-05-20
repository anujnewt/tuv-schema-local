CREATE OR REPLACE FUNCTION trigger_fct_pendium_otorgapoder_ep_tab_tr1() RETURNS trigger AS $body$
BEGIN
<<COLUMN_SEQUENCES>>
BEGIN
IF TG_OP = 'INSERT' AND NULLIF(NEW.ID_OPODER_EP_PK::text, '') IS NULL THEN
SELECT nextval('pendium_otorgapoder_ep_tab_se1') INTO STRICT NEW.ID_OPODER_EP_PK;
END IF;END;
RETURN NEW;
END
$body$
LANGUAGE 'plpgsql';
