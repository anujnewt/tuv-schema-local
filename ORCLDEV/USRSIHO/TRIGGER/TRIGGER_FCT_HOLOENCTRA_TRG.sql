-- DMAP_OBJECT_GEN_TAG : TYPE : FUNCTION NAME : trigger_fct_holoenctra_trg()
SET search_path = usrsiho,oracle,dmap_extension,public;
CREATE OR REPLACE FUNCTION trigger_fct_holoenctra_trg() RETURNS trigger AS $BODY$
BEGIN
-- For Toad:  Highlight column ENC_NUM_ID
  NEW.ENC_NUM_ID := nextval('holoenctra_seq');
RETURN NEW;
END
$BODY$
 LANGUAGE 'plpgsql';
