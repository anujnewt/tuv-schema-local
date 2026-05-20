-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : tvlofini_trg
SET search_path = labprod,oracle,dmap_extension,public;
DROP TRIGGER IF EXISTS tvlofini_trg ON tvlofini CASCADE;
-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : tvlofini_trg
SET search_path = labprod,oracle,dmap_extension,public;
CREATE TRIGGER "tvlofini_trg"
BEFORE INSERT ON tvlofini FOR EACH ROW
EXECUTE PROCEDURE trigger_fct_tvlofini_trg();
