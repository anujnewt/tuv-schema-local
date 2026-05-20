-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : trigger_sips_deps
SET search_path = labconf,oracle,dmap_extension,public;
DROP TRIGGER IF EXISTS trigger_sips_deps ON com_orac_sips_deps CASCADE;
-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : trigger_sips_deps
SET search_path = labconf,oracle,dmap_extension,public;
CREATE TRIGGER "trigger_sips_deps"
BEFORE INSERT ON com_orac_sips_deps FOR EACH ROW
EXECUTE PROCEDURE trigger_fct_trigger_sips_deps();
