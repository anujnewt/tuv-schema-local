-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : trigger_traypaso
SET search_path = labprod,oracle,dmap_extension,public;
DROP TRIGGER IF EXISTS trigger_traypaso ON traypaso CASCADE;
-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : trigger_traypaso
SET search_path = labprod,oracle,dmap_extension,public;
CREATE TRIGGER "trigger_traypaso"
BEFORE INSERT ON traypaso FOR EACH ROW
EXECUTE PROCEDURE trigger_fct_trigger_traypaso();
