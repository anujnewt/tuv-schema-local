-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : nmcoempl_sdwi
SET search_path = labprod,oracle,dmap_extension,public;
DROP TRIGGER IF EXISTS nmcoempl_sdwi ON nmcoempl CASCADE;
-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : nmcoempl_sdwi
SET search_path = labprod,oracle,dmap_extension,public;
CREATE TRIGGER "nmcoempl_sdwi"
AFTER INSERT ON nmcoempl FOR EACH ROW
EXECUTE PROCEDURE trigger_fct_nmcoempl_sdwi();
