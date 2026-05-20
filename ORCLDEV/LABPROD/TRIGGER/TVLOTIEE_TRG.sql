-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : tvlotiee_trg
SET search_path = labprod,oracle,dmap_extension,public;
DROP TRIGGER IF EXISTS tvlotiee_trg ON tvlotiee CASCADE;
-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : tvlotiee_trg
SET search_path = labprod,oracle,dmap_extension,public;
CREATE TRIGGER "tvlotiee_trg"
BEFORE INSERT ON tvlotiee FOR EACH ROW
EXECUTE PROCEDURE trigger_fct_tvlotiee_trg();
