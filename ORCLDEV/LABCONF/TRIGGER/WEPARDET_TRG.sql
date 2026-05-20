-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : wepardet_trg
SET search_path = labconf,oracle,dmap_extension,public;
DROP TRIGGER IF EXISTS wepardet_trg ON wepardet CASCADE;
-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : wepardet_trg
SET search_path = labconf,oracle,dmap_extension,public;
CREATE TRIGGER "wepardet_trg"
BEFORE INSERT ON wepardet FOR EACH ROW
EXECUTE PROCEDURE trigger_fct_wepardet_trg();
