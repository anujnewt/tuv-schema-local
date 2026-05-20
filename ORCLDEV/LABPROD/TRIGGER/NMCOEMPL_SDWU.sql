-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : nmcoempl_sdwu
SET search_path = labprod,oracle,dmap_extension,public;
DROP TRIGGER IF EXISTS nmcoempl_sdwu ON nmcoempl CASCADE;
-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : nmcoempl_sdwu
SET search_path = labprod,oracle,dmap_extension,public;
CREATE TRIGGER "nmcoempl_sdwu"
AFTER UPDATE ON nmcoempl FOR EACH ROW
EXECUTE PROCEDURE trigger_fct_nmcoempl_sdwu();
