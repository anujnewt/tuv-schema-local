-- DMAP_OBJECT_GEN_TAG : TYPE : FUNCTION NAME : trigger_fct_holocont_trg()
SET search_path = usrsiho,oracle,dmap_extension,public;
CREATE OR REPLACE FUNCTION trigger_fct_holocont_trg() RETURNS trigger AS $BODY$
BEGIN
-- For Toad:  Highlight column CON_KEYPLZ
IF ( NEW.CON_KEYPLZ IS NULL or NEW.CON_KEYPLZ = 0 ) then
  NEW.CON_KEYPLZ := nextval('holocont_seq');
end if;
RETURN NEW;
END
$BODY$
 LANGUAGE 'plpgsql';
