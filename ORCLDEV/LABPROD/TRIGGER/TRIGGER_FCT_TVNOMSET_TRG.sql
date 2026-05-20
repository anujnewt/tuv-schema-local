-- DMAP_OBJECT_GEN_TAG : TYPE : FUNCTION NAME : trigger_fct_tvnomset_trg()
SET search_path = labprod,oracle,dmap_extension,public;
CREATE OR REPLACE FUNCTION trigger_fct_tvnomset_trg() RETURNS trigger AS $BODY$
BEGIN
      SELECT nextval('labprod.tvnomset_seq') INTO STRICT NEW.MSE_AUXNU1;
  RETURN NEW;
END
$BODY$
 LANGUAGE 'plpgsql';
