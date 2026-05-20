-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : wehispass_trg
SET search_path = labprod,oracle,dmap_extension,public;
DROP TRIGGER IF EXISTS wehispass_trg ON wehispass CASCADE;
-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : wehispass_trg
SET search_path = labprod,oracle,dmap_extension,public;
CREATE TRIGGER "wehispass_trg"
BEFORE INSERT ON wehispass FOR EACH ROW
EXECUTE PROCEDURE trigger_fct_wehispass_trg();
