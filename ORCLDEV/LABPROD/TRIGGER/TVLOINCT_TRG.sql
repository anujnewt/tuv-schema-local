-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : tvloinct_trg
SET search_path = labprod,oracle,dmap_extension,public;
DROP TRIGGER IF EXISTS tvloinct_trg ON tvloinct CASCADE;
-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : tvloinct_trg
SET search_path = labprod,oracle,dmap_extension,public;
CREATE TRIGGER "tvloinct_trg"
BEFORE INSERT ON tvloinct FOR EACH ROW
EXECUTE PROCEDURE trigger_fct_tvloinct_trg();
