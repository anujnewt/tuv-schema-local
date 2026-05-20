-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : fuarchivodetalle_seq_tr
SET search_path = labprod,oracle,dmap_extension,public;
DROP TRIGGER IF EXISTS fuarchivodetalle_seq_tr ON fuarchivodetalle CASCADE;
-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : fuarchivodetalle_seq_tr
SET search_path = labprod,oracle,dmap_extension,public;
CREATE TRIGGER "fuarchivodetalle_seq_tr"  BEFORE
INSERT ON labprod.fuarchivodetalle FOR EACH ROW
WHEN (NULLIF(NEW.ID::text, '') IS NULL)
EXECUTE PROCEDURE trigger_fct_fuarchivodetalle_seq_tr();
