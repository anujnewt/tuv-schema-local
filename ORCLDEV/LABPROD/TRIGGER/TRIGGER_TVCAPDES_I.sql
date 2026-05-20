-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : trigger_tvcapdes_i
SET search_path = labprod,oracle,dmap_extension,public;
DROP TRIGGER IF EXISTS trigger_tvcapdes_i ON tvcapdes_i CASCADE;
-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : trigger_tvcapdes_i
SET search_path = labprod,oracle,dmap_extension,public;
CREATE TRIGGER "trigger_tvcapdes_i"
BEFORE INSERT ON tvcapdes_i FOR EACH ROW
EXECUTE PROCEDURE trigger_fct_trigger_tvcapdes_i();
