-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : trigger_ap_sipros
SET search_path = labprod,oracle,dmap_extension,public;
DROP TRIGGER IF EXISTS trigger_ap_sipros ON ap_sipros CASCADE;
-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : trigger_ap_sipros
SET search_path = labprod,oracle,dmap_extension,public;
CREATE TRIGGER "trigger_ap_sipros"
BEFORE INSERT ON ap_sipros "LABPROD"."TRIGGER_AP_SIPROS"
BEFORE INSERT
ON LABPROD.AP_SIPROS
REFERENCING NEW AS NEW
FOR EACH ROW
FOR EACH ROW
EXECUTE PROCEDURE trigger_fct_trigger_ap_sipros();
