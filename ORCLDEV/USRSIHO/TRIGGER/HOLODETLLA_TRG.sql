-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : holodetlla_trg
SET search_path = usrsiho,oracle,dmap_extension,public;
DROP TRIGGER IF EXISTS holodetlla_trg ON holodetlla CASCADE;
-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : holodetlla_trg
SET search_path = usrsiho,oracle,dmap_extension,public;
CREATE TRIGGER "holodetlla_trg"

BEFORE INSERT
ON USRSIHO.HOLODETLLA
FOR EACH ROW
EXECUTE PROCEDURE trigger_fct_holodetlla_trg();
