-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : holoenctra_trg
SET search_path = usrsiho,oracle,dmap_extension,public;
DROP TRIGGER IF EXISTS holoenctra_trg ON holoenctra CASCADE;
-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : holoenctra_trg
SET search_path = usrsiho,oracle,dmap_extension,public;
CREATE TRIGGER "holoenctra_trg"

BEFORE INSERT
ON USRSIHO.HOLOENCTRA
FOR EACH ROW
EXECUTE PROCEDURE trigger_fct_holoenctra_trg();
