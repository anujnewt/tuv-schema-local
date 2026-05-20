-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : tvpbvacc_trg
SET search_path = labprod,oracle,dmap_extension,public;
DROP TRIGGER IF EXISTS tvpbvacc_trg ON tvpbvacc CASCADE;
-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : tvpbvacc_trg
SET search_path = labprod,oracle,dmap_extension,public;
CREATE TRIGGER "tvpbvacc_trg"
BEFORE INSERT ON tvpbvacc FOR EACH ROW
EXECUTE PROCEDURE trigger_fct_tvpbvacc_trg();
