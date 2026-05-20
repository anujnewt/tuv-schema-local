-- DMAP_OBJECT_GEN_TAG : TYPE : FUNCTION NAME : trigger_fct_webitact_trg()
SET search_path = labconf,oracle,dmap_extension,public;
CREATE OR REPLACE FUNCTION trigger_fct_webitact_trg() RETURNS trigger AS $BODY$
BEGIN
      SELECT coalesce(NEW.wct_idbact, nextval('webitact_seq')) INTO STRICT NEW.wct_idbact;
  RETURN NEW;
END
$BODY$
 LANGUAGE 'plpgsql';
