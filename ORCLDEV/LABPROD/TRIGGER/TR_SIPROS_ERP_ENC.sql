-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : tr_sipros_erp_enc
SET search_path = labprod,oracle,dmap_extension,public;
DROP TRIGGER IF EXISTS tr_sipros_erp_enc ON sipros_erp_enc CASCADE;
-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : tr_sipros_erp_enc
SET search_path = labprod,oracle,dmap_extension,public;
CREATE TRIGGER "tr_sipros_erp_enc"
AFTER UPDATE OF ape_status ON sipros_erp_enc FOR EACH ROW
EXECUTE PROCEDURE trigger_fct_tr_sipros_erp_enc();
