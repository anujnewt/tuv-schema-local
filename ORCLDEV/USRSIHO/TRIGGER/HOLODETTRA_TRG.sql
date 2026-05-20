-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : holodettra_trg
SET search_path = usrsiho,oracle,dmap_extension,public;
DROP TRIGGER IF EXISTS holodettra_trg ON holodettra CASCADE;
-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : holodettra_trg
SET search_path = usrsiho,oracle,dmap_extension,public;
CREATE TRIGGER "holodettra_trg"

BEFORE INSERT
ON USRSIHO.HOLODETTRA
FOR EACH ROW
EXECUTE PROCEDURE trigger_fct_holodettra_trg();
