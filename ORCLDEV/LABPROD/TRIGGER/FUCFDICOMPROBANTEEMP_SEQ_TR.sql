-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : fucfdicomprobanteemp_seq_tr
SET search_path = labprod,oracle,dmap_extension,public;
DROP TRIGGER IF EXISTS fucfdicomprobanteemp_seq_tr ON fucfdicomprobanteemp CASCADE;
-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : fucfdicomprobanteemp_seq_tr
SET search_path = labprod,oracle,dmap_extension,public;
CREATE TRIGGER "fucfdicomprobanteemp_seq_tr"  BEFORE
INSERT ON labprod.fucfdicomprobanteemp FOR EACH ROW
WHEN (NULLIF(NEW.idComprobanteEmp::text, '') IS NULL)
EXECUTE PROCEDURE trigger_fct_fucfdicomprobanteemp_seq_tr();
