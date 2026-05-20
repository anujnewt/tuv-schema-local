-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : cfdi2nomina_seq_tr
SET search_path = labconf,oracle,dmap_extension,public;
DROP TRIGGER IF EXISTS cfdi2nomina_seq_tr ON cfdi2nomina CASCADE;
-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : cfdi2nomina_seq_tr
SET search_path = labconf,oracle,dmap_extension,public;
CREATE TRIGGER "cfdi2nomina_seq_tr"
BEFORE INSERT ON labconf.cfdi2nomina FOR EACH ROW
WHEN (NULLIF(NEW.idNomina::text, '') IS NULL)
EXECUTE PROCEDURE trigger_fct_cfdi2nomina_seq_tr();
