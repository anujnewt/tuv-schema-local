-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : weaccaut_trg
SET search_path = labprod,oracle,dmap_extension,public;
DROP TRIGGER IF EXISTS weaccaut_trg ON weaccaut CASCADE;
-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : weaccaut_trg
SET search_path = labprod,oracle,dmap_extension,public;
CREATE TRIGGER "weaccaut_trg"
BEFORE INSERT ON weaccaut FOR EACH ROW
EXECUTE PROCEDURE trigger_fct_weaccaut_trg();
