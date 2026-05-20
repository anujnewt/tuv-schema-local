-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : weaccemp_trg
SET search_path = labprod,oracle,dmap_extension,public;
DROP TRIGGER IF EXISTS weaccemp_trg ON weaccemp CASCADE;
-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : weaccemp_trg
SET search_path = labprod,oracle,dmap_extension,public;
CREATE TRIGGER "weaccemp_trg"
BEFORE INSERT ON weaccemp FOR EACH ROW
EXECUTE PROCEDURE trigger_fct_weaccemp_trg();
