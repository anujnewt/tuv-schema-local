-- DMAP_OBJECT_GEN_TAG : TYPE : FUNCTION NAME : trigger_fct_weparmen_trg()
SET search_path = labconf,oracle,dmap_extension,public;
CREATE OR REPLACE FUNCTION trigger_fct_weparmen_trg() RETURNS trigger AS $BODY$
BEGIN
      SELECT coalesce(NEW.wep_cvemen,nextval('weparmen_seq')) INTO STRICT NEW.wep_cvemen;
  RETURN NEW;
END
$BODY$
 LANGUAGE 'plpgsql';
