-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : xxhr_act_asig_empleados_lab_tr
SET search_path = labprod,oracle,dmap_extension,public;
DROP TRIGGER IF EXISTS xxhr_act_asig_empleados_lab_tr ON xxhr_act_asig_empleados_lab CASCADE;
-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : xxhr_act_asig_empleados_lab_tr
SET search_path = labprod,oracle,dmap_extension,public;
CREATE TRIGGER "xxhr_act_asig_empleados_lab_tr"
BEFORE INSERT ON xxhr_act_asig_empleados_lab FOR EACH ROW
EXECUTE PROCEDURE trigger_fct_xxhr_act_asig_empleados_lab_tr();
