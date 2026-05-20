-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : cfdi2comprobanteemp_seq_tr
SET search_path = labprod,oracle,dmap_extension,public;
DROP TRIGGER IF EXISTS cfdi2comprobanteemp_seq_tr ON cfdi2comprobanteemp CASCADE;
-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : cfdi2comprobanteemp_seq_tr
SET search_path = labprod,oracle,dmap_extension,public;
CREATE TRIGGER "cfdi2comprobanteemp_seq_tr"
BEFORE INSERT ON labprod.cfdi2comprobanteemp FOR EACH ROW
WHEN (NULLIF(NEW.idComprobanteEmp::text, '') IS NULL)
EXECUTE PROCEDURE trigger_fct_cfdi2comprobanteemp_seq_tr();
