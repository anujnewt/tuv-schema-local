-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : nmloinfo_trg
SET search_path = labprod,oracle,dmap_extension,public;
DROP TRIGGER IF EXISTS nmloinfo_trg ON nmloinfo CASCADE;
-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : nmloinfo_trg
SET search_path = labprod,oracle,dmap_extension,public;
CREATE TRIGGER "nmloinfo_trg"
BEFORE INSERT ON nmloinfo FOR EACH ROW
EXECUTE PROCEDURE trigger_fct_nmloinfo_trg();
