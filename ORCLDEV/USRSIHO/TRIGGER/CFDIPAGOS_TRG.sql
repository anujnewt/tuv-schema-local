-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : cfdipagos_trg
SET search_path = usrsiho,oracle,dmap_extension,public;
DROP TRIGGER IF EXISTS cfdipagos_trg ON cfdipagos CASCADE;
-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : cfdipagos_trg
SET search_path = usrsiho,oracle,dmap_extension,public;
CREATE TRIGGER "cfdipagos_trg"

BEFORE INSERT
ON USRSIHO.CFDIPAGOS
FOR EACH ROW
EXECUTE PROCEDURE trigger_fct_cfdipagos_trg();
