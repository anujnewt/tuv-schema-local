-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : cfdicomprobanteemp_trg
SET search_path = labprod,oracle,dmap_extension,public;
DROP TRIGGER IF EXISTS cfdicomprobanteemp_trg ON cfdicomprobanteemp CASCADE;
-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : cfdicomprobanteemp_trg
SET search_path = labprod,oracle,dmap_extension,public;
CREATE TRIGGER "cfdicomprobanteemp_trg"
BEFORE INSERT ON cfdicomprobanteemp FOR EACH ROW
EXECUTE PROCEDURE trigger_fct_cfdicomprobanteemp_trg();
