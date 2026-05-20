CREATE OR REPLACE FUNCTION trigger_fct_pendium_revoca_ep_tab_trg1() RETURNS trigger AS $body$
BEGIN
<<COLUMN_SEQUENCES>>
BEGIN
IF TG_OP = 'INSERT' AND NULLIF(NEW.ID_REVOCA_EP_PK::text, '') IS NULL THEN
SELECT nextval('pendium_revoca_ep_seq') INTO STRICT NEW.ID_REVOCA_EP_PK;
END IF;END;
RETURN NEW;
END
$body$
LANGUAGE 'plpgsql';
