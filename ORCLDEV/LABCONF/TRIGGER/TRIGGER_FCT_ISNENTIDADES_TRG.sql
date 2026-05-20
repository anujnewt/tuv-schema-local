CREATE OR REPLACE FUNCTION trigger_fct_isnentidades_trg() RETURNS trigger AS $body$
BEGIN
<<COLUMN_SEQUENCES>>
BEGIN
IF TG_OP = 'INSERT' AND NULLIF(NEW.ID::text, '') IS NULL THEN
SELECT nextval('labconf.isnentidades_seq') INTO STRICT NEW.ID;
END IF;END;
RETURN NEW;
END
$body$
LANGUAGE 'plpgsql';
