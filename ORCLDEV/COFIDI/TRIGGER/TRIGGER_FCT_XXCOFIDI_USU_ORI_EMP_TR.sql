CREATE OR REPLACE FUNCTION trigger_fct_xxcofidi_usu_ori_emp_tr() RETURNS trigger AS $body$
BEGIN
<<COLUMN_SEQUENCES>>
BEGIN
IF TG_OP = 'INSERT' AND NULLIF(NEW.ID_USU_ORI_EMP_PK::text, '') IS NULL THEN
SELECT nextval('cofidi.xxcofidi_usu_ori_emp_sq')
INTO STRICT NEW.ID_USU_ORI_EMP_PK;
END IF;END;
RETURN NEW;
END
$body$
LANGUAGE 'plpgsql';
