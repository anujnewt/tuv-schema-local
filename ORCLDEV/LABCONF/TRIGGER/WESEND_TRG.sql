-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : wesend_trg
SET search_path = labconf,oracle,dmap_extension,public;
DROP TRIGGER IF EXISTS wesend_trg ON wesend CASCADE;
-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : wesend_trg
SET search_path = labconf,oracle,dmap_extension,public;
CREATE TRIGGER "wesend_trg"
BEFORE INSERT ON wesend FOR EACH ROW
EXECUTE PROCEDURE trigger_fct_wesend_trg();
