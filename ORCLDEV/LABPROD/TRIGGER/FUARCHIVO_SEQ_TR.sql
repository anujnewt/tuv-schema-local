-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : fuarchivo_seq_tr
SET search_path = labprod,oracle,dmap_extension,public;
DROP TRIGGER IF EXISTS fuarchivo_seq_tr ON fuarchivo CASCADE;
-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : fuarchivo_seq_tr
SET search_path = labprod,oracle,dmap_extension,public;
CREATE TRIGGER "fuarchivo_seq_tr"  BEFORE
INSERT ON labprod.fuarchivo FOR EACH ROW
WHEN (NULLIF(NEW.IDARCHIVO::text, '') IS NULL)
EXECUTE PROCEDURE trigger_fct_fuarchivo_seq_tr();
