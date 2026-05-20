-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : tvpbincc_trg
SET search_path = labconf,oracle,dmap_extension,public;
DROP TRIGGER IF EXISTS tvpbincc_trg ON tvpbincc CASCADE;
-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : tvpbincc_trg
SET search_path = labconf,oracle,dmap_extension,public;
CREATE TRIGGER "tvpbincc_trg"
BEFORE INSERT ON tvpbincc FOR EACH ROW
EXECUTE PROCEDURE trigger_fct_tvpbincc_trg();
