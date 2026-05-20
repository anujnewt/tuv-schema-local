-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : cfdiconf_trg
SET search_path = usrsiho,oracle,dmap_extension,public;
DROP TRIGGER IF EXISTS cfdiconf_trg ON cfdiconf CASCADE;
-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : cfdiconf_trg
SET search_path = usrsiho,oracle,dmap_extension,public;
CREATE TRIGGER "cfdiconf_trg"

BEFORE INSERT
ON USRSIHO.CFDICONF
FOR EACH ROW
EXECUTE PROCEDURE trigger_fct_cfdiconf_trg();
