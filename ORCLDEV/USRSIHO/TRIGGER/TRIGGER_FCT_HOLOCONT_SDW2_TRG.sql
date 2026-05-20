-- DMAP_OBJECT_GEN_TAG : TYPE : FUNCTION NAME : trigger_fct_holocont_sdw2_trg()
SET search_path = usrsiho,oracle,dmap_extension,public;
CREATE OR REPLACE FUNCTION trigger_fct_holocont_sdw2_trg() RETURNS trigger AS $BODY$
BEGIN
  NEW.CONSEC := nextval('holocont_sdw2_seq');
RETURN NEW;
END
$BODY$
 LANGUAGE 'plpgsql';
