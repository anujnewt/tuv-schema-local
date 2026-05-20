-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : scocoma_trg
SET search_path = labprod,oracle,dmap_extension,public;
DROP TRIGGER IF EXISTS scocoma_trg ON sccocoma CASCADE;
-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : scocoma_trg
SET search_path = labprod,oracle,dmap_extension,public;
CREATE TRIGGER "scocoma_trg"
BEFORE INSERT ON sccocoma FOR EACH ROW
EXECUTE PROCEDURE trigger_fct_scocoma_trg();
