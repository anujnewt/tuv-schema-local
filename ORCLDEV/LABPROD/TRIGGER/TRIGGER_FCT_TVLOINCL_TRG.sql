-- DMAP_OBJECT_GEN_TAG : TYPE : FUNCTION NAME : trigger_fct_tvloincl_trg()
SET search_path = labprod,oracle,dmap_extension,public;
CREATE OR REPLACE FUNCTION trigger_fct_tvloincl_trg() RETURNS trigger AS $BODY$
BEGIN
  SELECT nextval('tvlotiee_seq') INTO STRICT NEW.INC_KEYINC;
RETURN NEW;
END
$BODY$
 LANGUAGE 'plpgsql';
