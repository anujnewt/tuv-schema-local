-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : trigger_emplpaso
SET search_path = labconf,oracle,dmap_extension,public;
DROP TRIGGER IF EXISTS trigger_emplpaso ON emplpaso CASCADE;
-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : trigger_emplpaso
SET search_path = labconf,oracle,dmap_extension,public;
CREATE TRIGGER "trigger_emplpaso"
BEFORE INSERT ON emplpaso FOR EACH ROW
EXECUTE PROCEDURE trigger_fct_trigger_emplpaso();
