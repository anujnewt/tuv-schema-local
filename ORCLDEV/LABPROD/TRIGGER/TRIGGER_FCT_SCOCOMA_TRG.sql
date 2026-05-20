-- DMAP_OBJECT_GEN_TAG : TYPE : FUNCTION NAME : trigger_fct_scocoma_trg()
SET search_path = labprod,oracle,dmap_extension,public;
CREATE OR REPLACE FUNCTION trigger_fct_scocoma_trg() RETURNS trigger AS $BODY$
BEGIN
    SELECT nextval('labprod.scocoma_seq') INTO STRICT NEW.ID;
  RETURN NEW;
END
$BODY$
 LANGUAGE 'plpgsql';
