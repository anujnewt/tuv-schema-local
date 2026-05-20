-- DMAP_OBJECT_GEN_TAG : TYPE : FUNCTION NAME : trigger_fct_wesend_trg()
SET search_path = labprod,oracle,dmap_extension,public;
CREATE OR REPLACE FUNCTION trigger_fct_wesend_trg() RETURNS trigger AS $BODY$
BEGIN
      SELECT coalesce(NEW.Id, nextval('labprod.wesend_seq')) INTO STRICT NEW.Id;
  RETURN NEW;
END
$BODY$
 LANGUAGE 'plpgsql';
