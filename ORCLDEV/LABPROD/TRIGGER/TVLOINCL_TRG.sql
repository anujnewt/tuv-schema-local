-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : tvloincl_trg
SET search_path = labprod,oracle,dmap_extension,public;
DROP TRIGGER IF EXISTS tvloincl_trg ON tvloincl CASCADE;
-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : tvloincl_trg
SET search_path = labprod,oracle,dmap_extension,public;
CREATE TRIGGER "tvloincl_trg"
BEFORE INSERT ON tvloincl FOR EACH ROW
EXECUTE PROCEDURE trigger_fct_tvloincl_trg();
