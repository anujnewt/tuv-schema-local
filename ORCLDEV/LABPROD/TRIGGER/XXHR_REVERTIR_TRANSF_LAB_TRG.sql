-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : xxhr_revertir_transf_lab_trg
SET search_path = labprod,oracle,dmap_extension,public;
DROP TRIGGER IF EXISTS xxhr_revertir_transf_lab_trg ON xxhr_revertir_transf_lab CASCADE;
-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : xxhr_revertir_transf_lab_trg
SET search_path = labprod,oracle,dmap_extension,public;
CREATE TRIGGER "xxhr_revertir_transf_lab_trg"
BEFORE INSERT ON xxhr_revertir_transf_lab FOR EACH ROW
EXECUTE PROCEDURE trigger_fct_xxhr_revertir_transf_lab_trg();
