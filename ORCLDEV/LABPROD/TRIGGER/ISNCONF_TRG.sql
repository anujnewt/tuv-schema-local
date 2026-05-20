-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : isnconf_trg
SET search_path = labprod,oracle,dmap_extension,public;
DROP TRIGGER IF EXISTS isnconf_trg ON isnconf CASCADE;
-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : isnconf_trg
SET search_path = labprod,oracle,dmap_extension,public;
CREATE TRIGGER "isnconf_trg"
BEFORE INSERT ON isnconf FOR EACH ROW
EXECUTE PROCEDURE trigger_fct_isnconf_trg();
