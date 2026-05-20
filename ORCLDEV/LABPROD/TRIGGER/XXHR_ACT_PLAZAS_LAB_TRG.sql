-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : xxhr_act_plazas_lab_trg
SET search_path = labprod,oracle,dmap_extension,public;
DROP TRIGGER IF EXISTS xxhr_act_plazas_lab_trg ON xxhr_act_plazas_lab CASCADE;
-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : xxhr_act_plazas_lab_trg
SET search_path = labprod,oracle,dmap_extension,public;
CREATE TRIGGER "xxhr_act_plazas_lab_trg"
BEFORE INSERT ON xxhr_act_plazas_lab FOR EACH ROW
EXECUTE PROCEDURE trigger_fct_xxhr_act_plazas_lab_trg();
