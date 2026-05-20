-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : isnconf02_trg
SET search_path = labconf,oracle,dmap_extension,public;
DROP TRIGGER IF EXISTS isnconf02_trg ON isnconf CASCADE;
-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : isnconf02_trg
SET search_path = labconf,oracle,dmap_extension,public;
CREATE TRIGGER "isnconf02_trg"
BEFORE INSERT ON isnconf FOR EACH ROW
EXECUTE PROCEDURE trigger_fct_isnconf02_trg();
