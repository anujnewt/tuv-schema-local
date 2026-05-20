-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : trigger_sips_pues
SET search_path = labprod,oracle,dmap_extension,public;
DROP TRIGGER IF EXISTS trigger_sips_pues ON com_orac_sips_pues CASCADE;
-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : trigger_sips_pues
SET search_path = labprod,oracle,dmap_extension,public;
CREATE TRIGGER "trigger_sips_pues"
BEFORE INSERT ON com_orac_sips_pues FOR EACH ROW
EXECUTE PROCEDURE trigger_fct_trigger_sips_pues();
