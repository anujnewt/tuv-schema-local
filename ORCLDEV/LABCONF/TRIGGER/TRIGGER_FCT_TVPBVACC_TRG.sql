-- DMAP_OBJECT_GEN_TAG : TYPE : FUNCTION NAME : trigger_fct_tvpbvacc_trg()
SET search_path = labconf,oracle,dmap_extension,public;
CREATE OR REPLACE FUNCTION trigger_fct_tvpbvacc_trg() RETURNS trigger AS $BODY$
BEGIN
  SELECT nextval('labconf.tvpbvacc_seq') INTO STRICT NEW.ID;
RETURN NEW;
END
$BODY$
 LANGUAGE 'plpgsql';
