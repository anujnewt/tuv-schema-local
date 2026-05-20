-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : cfdi2deduccionesdet_seq_tr
SET search_path = labprod,oracle,dmap_extension,public;
DROP TRIGGER IF EXISTS cfdi2deduccionesdet_seq_tr ON cfdi2deduccionesdetalle CASCADE;
-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : cfdi2deduccionesdet_seq_tr
SET search_path = labprod,oracle,dmap_extension,public;
CREATE TRIGGER "cfdi2deduccionesdet_seq_tr"
BEFORE INSERT ON labprod.cfdi2deduccionesdetalle FOR EACH ROW
WHEN (NULLIF(NEW.idDeduccion::text, '') IS NULL)
EXECUTE PROCEDURE trigger_fct_cfdi2deduccionesdet_seq_tr();
