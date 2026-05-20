-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : cfdi2percepcionesdet_seq_tr
SET search_path = labconf,oracle,dmap_extension,public;
DROP TRIGGER IF EXISTS cfdi2percepcionesdet_seq_tr ON cfdi2percepcionesdetalle CASCADE;
-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : cfdi2percepcionesdet_seq_tr
SET search_path = labconf,oracle,dmap_extension,public;
CREATE TRIGGER "cfdi2percepcionesdet_seq_tr"
BEFORE INSERT ON labconf.cfdi2percepcionesdetalle FOR EACH ROW
WHEN (NULLIF(NEW.idPercepcion::text, '') IS NULL)
EXECUTE PROCEDURE trigger_fct_cfdi2percepcionesdet_seq_tr();
