-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : cfdicomprobantepro_trg
SET search_path = labprod,oracle,dmap_extension,public;
DROP TRIGGER IF EXISTS cfdicomprobantepro_trg ON cfdicomprobantepro CASCADE;
-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : cfdicomprobantepro_trg
SET search_path = labprod,oracle,dmap_extension,public;
CREATE TRIGGER "cfdicomprobantepro_trg"
BEFORE INSERT ON cfdicomprobantepro FOR EACH ROW
EXECUTE PROCEDURE trigger_fct_cfdicomprobantepro_trg();
