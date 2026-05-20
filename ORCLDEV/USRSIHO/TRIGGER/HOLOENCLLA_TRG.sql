-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : holoenclla_trg
SET search_path = usrsiho,oracle,dmap_extension,public;
DROP TRIGGER IF EXISTS holoenclla_trg ON holoenclla CASCADE;
-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : holoenclla_trg
SET search_path = usrsiho,oracle,dmap_extension,public;
CREATE TRIGGER "holoenclla_trg"

BEFORE INSERT
ON USRSIHO.HOLOENCLLA
FOR EACH ROW
EXECUTE PROCEDURE trigger_fct_holoenclla_trg();
