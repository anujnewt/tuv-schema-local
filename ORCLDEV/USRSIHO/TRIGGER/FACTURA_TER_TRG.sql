-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : factura_ter_trg
SET search_path = usrsiho,oracle,dmap_extension,public;
DROP TRIGGER IF EXISTS factura_ter_trg ON factura_ter CASCADE;
-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : factura_ter_trg
SET search_path = usrsiho,oracle,dmap_extension,public;
CREATE TRIGGER "factura_ter_trg"

BEFORE INSERT
ON USRSIHO.FACTURA_TER
FOR EACH ROW
EXECUTE PROCEDURE trigger_fct_factura_ter_trg();
