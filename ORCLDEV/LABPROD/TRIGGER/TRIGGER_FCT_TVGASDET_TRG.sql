-- DMAP_OBJECT_GEN_TAG : TYPE : FUNCTION NAME : trigger_fct_tvgasdet_trg()
SET search_path = labprod,oracle,dmap_extension,public;
CREATE OR REPLACE FUNCTION trigger_fct_tvgasdet_trg() RETURNS trigger AS $BODY$
BEGIN
      SELECT coalesce(NEW.det_keydet, nextval('tvgasdet_seq')) INTO STRICT NEW.det_keydet;
  RETURN NEW;
END
$BODY$
 LANGUAGE 'plpgsql';
