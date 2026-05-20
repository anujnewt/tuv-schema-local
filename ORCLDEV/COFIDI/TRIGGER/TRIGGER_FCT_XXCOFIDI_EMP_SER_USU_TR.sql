CREATE OR REPLACE FUNCTION trigger_fct_xxcofidi_emp_ser_usu_tr() RETURNS trigger AS $body$
BEGIN
<<COLUMN_SEQUENCES>>
BEGIN
IF TG_OP = 'INSERT' AND NULLIF(NEW.ID_EMPRESA_SERIE_USU_PK::text, '') IS NULL THEN
SELECT cofidi.nextval('xxcofidi_emp_ser_usu_sq')
INTO STRICT NEW.ID_EMPRESA_SERIE_USU_PK;
END IF;END;
RETURN NEW;
END
$body$
LANGUAGE 'plpgsql';
