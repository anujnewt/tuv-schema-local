-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : weparmen_trg
SET search_path = labconf,oracle,dmap_extension,public;
DROP TRIGGER IF EXISTS weparmen_trg ON weparmen CASCADE;
-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : weparmen_trg
SET search_path = labconf,oracle,dmap_extension,public;
CREATE TRIGGER "weparmen_trg"
BEFORE INSERT ON weparmen FOR EACH ROW
EXECUTE PROCEDURE trigger_fct_weparmen_trg();
