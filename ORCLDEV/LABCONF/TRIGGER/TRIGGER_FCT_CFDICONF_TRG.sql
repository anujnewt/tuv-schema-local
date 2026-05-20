-- DMAP_OBJECT_GEN_TAG : TYPE : FUNCTION NAME : trigger_fct_cfdiconf_trg()
SET search_path = labconf,oracle,dmap_extension,public;
CREATE OR REPLACE FUNCTION trigger_fct_cfdiconf_trg() RETURNS trigger AS $BODY$
BEGIN
      SELECT nextval('cfdiconf_seq') INTO STRICT NEW.idConfig;
    RETURN NEW;
END
$BODY$
 LANGUAGE 'plpgsql';
