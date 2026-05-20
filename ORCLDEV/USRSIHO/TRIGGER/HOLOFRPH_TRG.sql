-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : holofrph_trg
SET search_path = usrsiho,oracle,dmap_extension,public;
DROP TRIGGER IF EXISTS holofrph_trg ON holofrph CASCADE;
-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : holofrph_trg
SET search_path = usrsiho,oracle,dmap_extension,public;
CREATE TRIGGER "holofrph_trg"

BEFORE INSERT
ON USRSIHO.HOLOFRPH
FOR EACH ROW
EXECUTE PROCEDURE trigger_fct_holofrph_trg();
