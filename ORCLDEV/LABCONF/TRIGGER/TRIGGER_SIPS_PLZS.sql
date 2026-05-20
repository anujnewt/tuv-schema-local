-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : trigger_sips_plzs
SET search_path = labconf,oracle,dmap_extension,public;
DROP TRIGGER IF EXISTS trigger_sips_plzs ON com_orac_sips_plzs CASCADE;
-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : trigger_sips_plzs
SET search_path = labconf,oracle,dmap_extension,public;
CREATE TRIGGER "trigger_sips_plzs"
BEFORE INSERT ON com_orac_sips_plzs FOR EACH ROW
EXECUTE PROCEDURE trigger_fct_trigger_sips_plzs();
