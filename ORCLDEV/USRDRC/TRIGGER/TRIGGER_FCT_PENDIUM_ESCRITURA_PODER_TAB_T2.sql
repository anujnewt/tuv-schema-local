CREATE OR REPLACE FUNCTION trigger_fct_pendium_escritura_poder_tab_t2() RETURNS trigger AS $body$
BEGIN
<<COLUMN_SEQUENCES>>
BEGIN
IF TG_OP = 'INSERT' AND NULLIF(NEW.ID_EP_PK::text, '') IS NULL THEN
SELECT nextval('pendium_escritura_poder_tab_s1') INTO STRICT NEW.ID_EP_PK;
END IF;END;
RETURN NEW;
END
$body$
LANGUAGE 'plpgsql';
