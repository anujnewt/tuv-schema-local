CREATE OR REPLACE FUNCTION trigger_fct_xxhr_crea_plazas_lab_trg() RETURNS trigger AS $body$
BEGIN
<<COLUMN_SEQUENCES>>
BEGIN
IF TG_OP = 'INSERT' AND NULLIF(NEW.LABORA_ID::text, '') IS NULL THEN
SELECT labprod.nextval('xxhr_crea_plazas_lab_seq') INTO STRICT NEW.LABORA_ID;
END IF;END;
RETURN NEW;
END
$body$
LANGUAGE 'plpgsql';
