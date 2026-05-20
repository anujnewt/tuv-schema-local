-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : isnentidades_trg
SET search_path = labconf,oracle,dmap_extension,public;
DROP TRIGGER IF EXISTS isnentidades_trg ON isnentidades CASCADE;
-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : isnentidades_trg
SET search_path = labconf,oracle,dmap_extension,public;
CREATE TRIGGER "isnentidades_trg"
BEFORE INSERT ON isnentidades FOR EACH ROW
EXECUTE PROCEDURE trigger_fct_isnentidades_trg();
