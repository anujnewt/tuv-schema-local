-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : cfdi2errores_seq_tr
SET search_path = labprod,oracle,dmap_extension,public;
DROP TRIGGER IF EXISTS cfdi2errores_seq_tr ON cfdi2errores CASCADE;
-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : cfdi2errores_seq_tr
SET search_path = labprod,oracle,dmap_extension,public;
CREATE TRIGGER "cfdi2errores_seq_tr"
BEFORE INSERT ON labprod.cfdi2errores FOR EACH ROW
WHEN (NULLIF(NEW.idError::text, '') IS NULL)
EXECUTE PROCEDURE trigger_fct_cfdi2errores_seq_tr();
