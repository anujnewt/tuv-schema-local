-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : tvgasdet_trg
SET search_path = labprod,oracle,dmap_extension,public;
DROP TRIGGER IF EXISTS tvgasdet_trg ON tvgasdet CASCADE;
-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : tvgasdet_trg
SET search_path = labprod,oracle,dmap_extension,public;
CREATE TRIGGER "tvgasdet_trg"
BEFORE INSERT ON tvgasdet FOR EACH ROW
EXECUTE PROCEDURE trigger_fct_tvgasdet_trg();
