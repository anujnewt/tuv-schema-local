-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : nmcofalt_trg
SET search_path = labprod,oracle,dmap_extension,public;
DROP TRIGGER IF EXISTS nmcofalt_trg ON nmcofalt CASCADE;
-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : nmcofalt_trg
SET search_path = labprod,oracle,dmap_extension,public;
CREATE TRIGGER "nmcofalt_trg"
AFTER INSERT ON nmcofalt FOR EACH ROW
EXECUTE PROCEDURE trigger_fct_nmcofalt_trg();
