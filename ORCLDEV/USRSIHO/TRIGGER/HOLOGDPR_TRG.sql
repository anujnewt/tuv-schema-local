-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : hologdpr_trg
SET search_path = usrsiho,oracle,dmap_extension,public;
DROP TRIGGER IF EXISTS hologdpr_trg ON hologdpr CASCADE;
-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : hologdpr_trg
SET search_path = usrsiho,oracle,dmap_extension,public;
CREATE TRIGGER "hologdpr_trg"

BEFORE INSERT
ON USRSIHO.HOLOGDPR
FOR EACH ROW
EXECUTE PROCEDURE trigger_fct_hologdpr_trg();
