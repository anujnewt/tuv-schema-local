-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : webitact_trg
SET search_path = labconf,oracle,dmap_extension,public;
DROP TRIGGER IF EXISTS webitact_trg ON webitact CASCADE;
-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : webitact_trg
SET search_path = labconf,oracle,dmap_extension,public;
CREATE TRIGGER "webitact_trg"
BEFORE INSERT ON webitact FOR EACH ROW
EXECUTE PROCEDURE trigger_fct_webitact_trg();
