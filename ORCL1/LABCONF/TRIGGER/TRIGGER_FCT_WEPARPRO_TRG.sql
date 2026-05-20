-- DMAP_OBJECT_GEN_TAG : TYPE : FUNCTION NAME : trigger_fct_weparpro_trg()
SET search_path = labconf,oracle,dmap_extension,public;
CREATE OR REPLACE FUNCTION trigger_fct_weparpro_trg() RETURNS trigger AS $BODY$
BEGIN
      SELECT coalesce(NEW.pro_cvepro,nextval('weparpro_seq')) INTO STRICT NEW.pro_cvepro;
  RETURN NEW;
END
$BODY$
 LANGUAGE 'plpgsql';
