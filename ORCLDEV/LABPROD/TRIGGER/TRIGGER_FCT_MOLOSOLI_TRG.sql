-- DMAP_OBJECT_GEN_TAG : TYPE : FUNCTION NAME : trigger_fct_molosoli_trg()
SET search_path = labprod,oracle,dmap_extension,public;
CREATE OR REPLACE FUNCTION trigger_fct_molosoli_trg() RETURNS trigger AS $BODY$
BEGIN
      SELECT coalesce(NEW.sol_keysol, nextval('labprod.molosoli_seq')) INTO STRICT NEW.sol_keysol;
  RETURN NEW;
END
$BODY$
 LANGUAGE 'plpgsql';
