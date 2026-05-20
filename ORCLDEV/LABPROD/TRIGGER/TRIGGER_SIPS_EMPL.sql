-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : trigger_sips_empl
SET search_path = labprod,oracle,dmap_extension,public;
DROP TRIGGER IF EXISTS trigger_sips_empl ON com_orac_sips_empl CASCADE;
-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : trigger_sips_empl
SET search_path = labprod,oracle,dmap_extension,public;
CREATE TRIGGER "trigger_sips_empl"
BEFORE INSERT ON com_orac_sips_empl FOR EACH ROW
EXECUTE PROCEDURE trigger_fct_trigger_sips_empl();
