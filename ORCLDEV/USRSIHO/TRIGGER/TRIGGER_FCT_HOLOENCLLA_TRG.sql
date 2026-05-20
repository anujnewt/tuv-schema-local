-- DMAP_OBJECT_GEN_TAG : TYPE : FUNCTION NAME : trigger_fct_holoenclla_trg()
SET search_path = usrsiho,oracle,dmap_extension,public;
CREATE OR REPLACE FUNCTION trigger_fct_holoenclla_trg() RETURNS trigger AS $BODY$
BEGIN
-- For Toad:  Highlight column ENC_NUM_ID
  NEW.ENC_NUM_ID := nextval('holoenclla_seq');
RETURN NEW;
END
$BODY$
 LANGUAGE 'plpgsql';
