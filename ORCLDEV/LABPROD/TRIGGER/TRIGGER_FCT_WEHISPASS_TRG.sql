-- DMAP_OBJECT_GEN_TAG : TYPE : FUNCTION NAME : trigger_fct_wehispass_trg()
SET search_path = labprod,oracle,dmap_extension,public;
CREATE OR REPLACE FUNCTION trigger_fct_wehispass_trg() RETURNS trigger AS $BODY$
BEGIN
      SELECT coalesce(NEW.weh_id, nextval('labprod.wehispass_seq')) INTO STRICT NEW.weh_id;
  RETURN NEW;
END
$BODY$
 LANGUAGE 'plpgsql';
