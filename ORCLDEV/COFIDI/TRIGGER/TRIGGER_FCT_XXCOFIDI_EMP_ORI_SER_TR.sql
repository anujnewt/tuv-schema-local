CREATE OR REPLACE FUNCTION trigger_fct_xxcofidi_emp_ori_ser_tr() RETURNS trigger AS $body$
BEGIN
<<COLUMN_SEQUENCES>>
BEGIN
IF TG_OP = 'INSERT' AND NULLIF(NEW.ID_EMP_ORI_SER_PK::text, '') IS NULL THEN
SELECT nextval('cofidi.xxcofidi_emp_ori_ser_sq')
INTO STRICT NEW.ID_EMP_ORI_SER_PK;
END IF;
END;END;
/;
$body$
LANGUAGE 'plpgsql';
