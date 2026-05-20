-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : holocont_trg
SET search_path = usrsiho,oracle,dmap_extension,public;
DROP TRIGGER IF EXISTS holocont_trg ON holocont CASCADE;
-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : holocont_trg
SET search_path = usrsiho,oracle,dmap_extension,public;
CREATE TRIGGER "holocont_trg"

BEFORE INSERT
ON USRSIHO.HOLOCONT
FOR EACH ROW
EXECUTE PROCEDURE trigger_fct_holocont_trg();
