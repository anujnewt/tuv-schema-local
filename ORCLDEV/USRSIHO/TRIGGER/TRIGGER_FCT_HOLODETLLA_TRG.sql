-- DMAP_OBJECT_GEN_TAG : TYPE : FUNCTION NAME : trigger_fct_holodetlla_trg()
SET search_path = usrsiho,oracle,dmap_extension,public;
CREATE OR REPLACE FUNCTION trigger_fct_holodetlla_trg() RETURNS trigger AS $BODY$
BEGIN
-- For Toad:  Highlight column DET_SERIAL
  NEW.DET_SERIAL := nextval('holodetlla_seq');
RETURN NEW;
END
$BODY$
 LANGUAGE 'plpgsql';
