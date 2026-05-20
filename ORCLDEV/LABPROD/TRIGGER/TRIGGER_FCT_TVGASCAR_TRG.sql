-- DMAP_OBJECT_GEN_TAG : TYPE : FUNCTION NAME : trigger_fct_tvgascar_trg()
SET search_path = labprod,oracle,dmap_extension,public;
CREATE OR REPLACE FUNCTION trigger_fct_tvgascar_trg() RETURNS trigger AS $BODY$
BEGIN
      SELECT coalesce(NEW.car_keycar, nextval('tvgascar_seq')) INTO STRICT NEW.car_keycar;
  RETURN NEW;
END
$BODY$
 LANGUAGE 'plpgsql';
