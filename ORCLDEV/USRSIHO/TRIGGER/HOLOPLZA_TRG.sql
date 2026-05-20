-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : holoplza_trg
SET search_path = usrsiho,oracle,dmap_extension,public;
DROP TRIGGER IF EXISTS holoplza_trg ON holoplza CASCADE;
-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : holoplza_trg
SET search_path = usrsiho,oracle,dmap_extension,public;
CREATE TRIGGER "holoplza_trg"
BEFORE INSERT ON holoplza FOR EACH ROW
EXECUTE PROCEDURE trigger_fct_holoplza_trg();
