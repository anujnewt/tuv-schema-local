-- DMAP_OBJECT_GEN_TAG : TYPE : FUNCTION NAME : trigger_fct_trig_nmlofond()
SET search_path = labprod,oracle,dmap_extension,public;
CREATE OR REPLACE FUNCTION trigger_fct_trig_nmlofond() RETURNS trigger AS $BODY$
BEGIN
  		SELECT nextval('sec_keyreg') INTO STRICT NEW.FON_KEYREG;
	RETURN NEW;
END
$BODY$
 LANGUAGE 'plpgsql';
