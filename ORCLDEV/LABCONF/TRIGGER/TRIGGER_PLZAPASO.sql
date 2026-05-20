-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : trigger_plzapaso
SET search_path = labconf,oracle,dmap_extension,public;
DROP TRIGGER IF EXISTS trigger_plzapaso ON plzapaso CASCADE;
-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : trigger_plzapaso
SET search_path = labconf,oracle,dmap_extension,public;
CREATE TRIGGER "trigger_plzapaso"
BEFORE INSERT ON plzapaso FOR EACH ROW
EXECUTE PROCEDURE trigger_fct_trigger_plzapaso();
