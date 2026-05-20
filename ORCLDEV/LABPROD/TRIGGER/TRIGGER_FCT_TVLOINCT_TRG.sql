CREATE OR REPLACE FUNCTION trigger_fct_tvloinct_trg() RETURNS trigger AS $body$
BEGIN
<<COLUMN_SEQUENCES>> BEGIN
SELECT nextval('tvloinct_seq') INTO STRICT NEW.INC_KEYINC;END;
RETURN NEW;
END
$body$
LANGUAGE 'plpgsql';
