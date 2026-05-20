-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : weparpro_trg
SET search_path = labconf,oracle,dmap_extension,public;
DROP TRIGGER IF EXISTS weparpro_trg ON weparpro CASCADE;
-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : weparpro_trg
SET search_path = labconf,oracle,dmap_extension,public;
CREATE TRIGGER "weparpro_trg"
BEFORE INSERT ON weparpro FOR EACH ROW
EXECUTE PROCEDURE trigger_fct_weparpro_trg();
