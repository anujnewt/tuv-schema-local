-- DMAP_OBJECT_GEN_TAG : TYPE : FUNCTION NAME : trigger_fct_weaccaut_trg()
SET search_path = labconf,oracle,dmap_extension,public;
CREATE OR REPLACE FUNCTION trigger_fct_weaccaut_trg() RETURNS trigger AS $BODY$
BEGIN
      SELECT coalesce(NEW.wea_idusua, nextval('weaccaut_seq')) INTO STRICT NEW.wea_idusua;
  RETURN NEW;
END
$BODY$
 LANGUAGE 'plpgsql';
