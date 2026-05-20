-- DMAP_OBJECT_GEN_TAG : TYPE : FUNCTION NAME : trigger_fct_cfdiconf_trg()
SET search_path = usrsiho,oracle,dmap_extension,public;
CREATE OR REPLACE FUNCTION trigger_fct_cfdiconf_trg() RETURNS trigger AS $BODY$
BEGIN
-- For Toad:  Highlight column IDCONFIG
  NEW.IDCONFIG := nextval('cfdiconf_seq');
RETURN NEW;
END
$BODY$
 LANGUAGE 'plpgsql';
