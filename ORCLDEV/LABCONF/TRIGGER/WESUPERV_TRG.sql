-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : wesuperv_trg
SET search_path = labconf,oracle,dmap_extension,public;
DROP TRIGGER IF EXISTS wesuperv_trg ON wesuperv CASCADE;
-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : wesuperv_trg
SET search_path = labconf,oracle,dmap_extension,public;
CREATE TRIGGER "wesuperv_trg"
BEFORE INSERT ON wesuperv FOR EACH ROW
EXECUTE PROCEDURE trigger_fct_wesuperv_trg();
