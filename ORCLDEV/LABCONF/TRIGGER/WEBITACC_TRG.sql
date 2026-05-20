-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : webitacc_trg
SET search_path = labconf,oracle,dmap_extension,public;
DROP TRIGGER IF EXISTS webitacc_trg ON webitacc CASCADE;
-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : webitacc_trg
SET search_path = labconf,oracle,dmap_extension,public;
CREATE TRIGGER "webitacc_trg"
BEFORE INSERT ON webitacc FOR EACH ROW
EXECUTE PROCEDURE trigger_fct_webitacc_trg();
