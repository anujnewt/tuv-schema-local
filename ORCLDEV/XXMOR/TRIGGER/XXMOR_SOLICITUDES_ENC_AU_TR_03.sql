-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : xxmor_solicitudes_enc_au_tr_03
SET search_path = xxmor,oracle,dmap_extension,public;
DROP TRIGGER IF EXISTS xxmor_solicitudes_enc_au_tr_03 ON xxmor_solicitudes_enc_tab CASCADE;
-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : xxmor_solicitudes_enc_au_tr_03
SET search_path = xxmor,oracle,dmap_extension,public;
CREATE TRIGGER "xxmor_solicitudes_enc_au_tr_03"

BEFORE UPDATE
ON XXMOR.XXMOR_SOLICITUDES_ENC_TAB
FOR EACH ROW
EXECUTE PROCEDURE trigger_fct_xxmor_solicitudes_enc_au_tr_03();
