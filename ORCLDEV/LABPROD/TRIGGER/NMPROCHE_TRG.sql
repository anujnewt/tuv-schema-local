-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : nmproche_trg
SET search_path = labprod,oracle,dmap_extension,public;
DROP TRIGGER IF EXISTS nmproche_trg ON nmproche CASCADE;
-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : nmproche_trg
SET search_path = labprod,oracle,dmap_extension,public;
CREATE TRIGGER "nmproche_trg"
BEFORE INSERT ON nmproche FOR EACH ROW
EXECUTE PROCEDURE trigger_fct_nmproche_trg();
