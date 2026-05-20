-- DMAP_OBJECT_GEN_TAG : TYPE : FUNCTION NAME : trigger_fct_webitacc_trg()
SET search_path = labconf,oracle,dmap_extension,public;
CREATE OR REPLACE FUNCTION trigger_fct_webitacc_trg() RETURNS trigger AS $BODY$
BEGIN
      SELECT coalesce(NEW.wcc_idbacc, nextval('webitacc_seq')) INTO STRICT NEW.wcc_idbacc;
  RETURN NEW;
END
$BODY$
 LANGUAGE 'plpgsql';
