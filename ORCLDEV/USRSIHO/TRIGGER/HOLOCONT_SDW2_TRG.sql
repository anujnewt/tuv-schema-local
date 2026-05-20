-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : holocont_sdw2_trg
SET search_path = usrsiho,oracle,dmap_extension,public;
DROP TRIGGER IF EXISTS holocont_sdw2_trg ON holocont_sdw2 CASCADE;
-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : holocont_sdw2_trg
SET search_path = usrsiho,oracle,dmap_extension,public;
CREATE TRIGGER "holocont_sdw2_trg"

BEFORE INSERT ON USRSIHO.HOLOCONT_SDW2
FOR EACH ROW
EXECUTE PROCEDURE trigger_fct_holocont_sdw2_trg();
