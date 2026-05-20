-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : xxmor_concom_rpta_ai_tr_01
SET search_path = xxmor,oracle,dmap_extension,public;
DROP TRIGGER IF EXISTS xxmor_concom_rpta_ai_tr_01 ON xxmor_concom_rpta_tab CASCADE;
-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : xxmor_concom_rpta_ai_tr_01
SET search_path = xxmor,oracle,dmap_extension,public;
CREATE TRIGGER "xxmor_concom_rpta_ai_tr_01"

AFTER INSERT
ON XXMOR.XXMOR_CONCOM_RPTA_TAB
FOR EACH ROW
EXECUTE PROCEDURE trigger_fct_xxmor_concom_rpta_ai_tr_01();
