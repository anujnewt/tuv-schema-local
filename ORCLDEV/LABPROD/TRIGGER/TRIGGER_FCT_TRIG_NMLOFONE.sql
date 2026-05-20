-- DMAP_OBJECT_GEN_TAG : TYPE : FUNCTION NAME : trigger_fct_trig_nmlofone()
SET search_path = labprod,oracle,dmap_extension,public;
CREATE OR REPLACE FUNCTION trigger_fct_trig_nmlofone() RETURNS trigger AS $BODY$
BEGIN
  		SELECT nextval('sec_keyfon')
  		INTO STRICT NEW.FON_KEYFON;
  RETURN NEW;
END
$BODY$
 LANGUAGE 'plpgsql';
