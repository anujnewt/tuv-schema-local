-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : trigger_sips_data
SET search_path = labconf,oracle,dmap_extension,public;
DROP TRIGGER IF EXISTS trigger_sips_data ON com_orac_sips_data CASCADE;
-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : trigger_sips_data
SET search_path = labconf,oracle,dmap_extension,public;
CREATE TRIGGER "trigger_sips_data"
BEFORE INSERT ON com_orac_sips_data FOR EACH ROW
EXECUTE PROCEDURE trigger_fct_trigger_sips_data();
