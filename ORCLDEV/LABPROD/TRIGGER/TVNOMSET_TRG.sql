-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : tvnomset_trg
SET search_path = labprod,oracle,dmap_extension,public;
DROP TRIGGER IF EXISTS tvnomset_trg ON tvnomset CASCADE;
-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : tvnomset_trg
SET search_path = labprod,oracle,dmap_extension,public;
CREATE TRIGGER "tvnomset_trg"
BEFORE INSERT ON tvnomset FOR EACH ROW
EXECUTE PROCEDURE trigger_fct_tvnomset_trg();
