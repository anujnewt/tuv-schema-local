-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : trigger_sips_tray
SET search_path = labconf,oracle,dmap_extension,public;
DROP TRIGGER IF EXISTS trigger_sips_tray ON com_orac_sips_tray CASCADE;
-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : trigger_sips_tray
SET search_path = labconf,oracle,dmap_extension,public;
CREATE TRIGGER "trigger_sips_tray"
BEFORE INSERT ON com_orac_sips_tray FOR EACH ROW
EXECUTE PROCEDURE trigger_fct_trigger_sips_tray();
