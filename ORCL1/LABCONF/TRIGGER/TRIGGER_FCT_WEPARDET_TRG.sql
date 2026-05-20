-- DMAP_OBJECT_GEN_TAG : TYPE : FUNCTION NAME : trigger_fct_wepardet_trg()
SET search_path = labconf,oracle,dmap_extension,public;
CREATE OR REPLACE FUNCTION trigger_fct_wepardet_trg() RETURNS trigger AS $BODY$
BEGIN
      SELECT coalesce(NEW.det_cvedet,nextval('wepardet_seq')) INTO STRICT NEW.det_cvedet;
  RETURN NEW;
END
$BODY$
 LANGUAGE 'plpgsql';
