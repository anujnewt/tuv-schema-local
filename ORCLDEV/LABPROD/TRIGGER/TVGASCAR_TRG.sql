-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : tvgascar_trg
SET search_path = labprod,oracle,dmap_extension,public;
DROP TRIGGER IF EXISTS tvgascar_trg ON tvgascar CASCADE;
-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : tvgascar_trg
SET search_path = labprod,oracle,dmap_extension,public;
CREATE TRIGGER "tvgascar_trg"
BEFORE INSERT ON tvgascar FOR EACH ROW
EXECUTE PROCEDURE trigger_fct_tvgascar_trg();
