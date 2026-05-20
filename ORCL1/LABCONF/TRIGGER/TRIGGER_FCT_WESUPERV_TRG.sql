-- DMAP_OBJECT_GEN_TAG : TYPE : FUNCTION NAME : trigger_fct_wesuperv_trg()
SET search_path = labconf,oracle,dmap_extension,public;
CREATE OR REPLACE FUNCTION trigger_fct_wesuperv_trg() RETURNS trigger AS $BODY$
BEGIN
      SELECT coalesce(NEW.sup_cvesup, nextval('labconf.wesuperv_seq')) INTO STRICT NEW.sup_cvesup;
  RETURN NEW;
END
$BODY$
 LANGUAGE 'plpgsql';
