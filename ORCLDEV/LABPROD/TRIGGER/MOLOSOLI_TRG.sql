-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : molosoli_trg
SET search_path = labprod,oracle,dmap_extension,public;
DROP TRIGGER IF EXISTS molosoli_trg ON molosoli CASCADE;
-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : molosoli_trg
SET search_path = labprod,oracle,dmap_extension,public;
CREATE TRIGGER "molosoli_trg"
BEFORE INSERT ON molosoli FOR EACH ROW
EXECUTE PROCEDURE trigger_fct_molosoli_trg();
