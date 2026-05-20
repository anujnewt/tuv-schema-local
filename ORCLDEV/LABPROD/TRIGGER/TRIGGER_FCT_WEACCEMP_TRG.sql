-- DMAP_OBJECT_GEN_TAG : TYPE : FUNCTION NAME : trigger_fct_weaccemp_trg()
SET search_path = labprod,oracle,dmap_extension,public;
CREATE OR REPLACE FUNCTION trigger_fct_weaccemp_trg() RETURNS trigger AS $BODY$
BEGIN
      SELECT coalesce(NEW.wea_idusua, nextval('labprod.weaccemp_seq')) INTO STRICT NEW.wea_idusua;
  RETURN NEW;
END
$BODY$
 LANGUAGE 'plpgsql';
