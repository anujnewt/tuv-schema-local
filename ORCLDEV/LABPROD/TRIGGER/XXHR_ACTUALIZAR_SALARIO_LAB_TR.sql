-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : xxhr_actualizar_salario_lab_tr
SET search_path = labprod,oracle,dmap_extension,public;
DROP TRIGGER IF EXISTS xxhr_actualizar_salario_lab_tr ON xxhr_actualizar_salario_lab CASCADE;
-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : xxhr_actualizar_salario_lab_tr
SET search_path = labprod,oracle,dmap_extension,public;
CREATE TRIGGER "xxhr_actualizar_salario_lab_tr"
BEFORE INSERT ON xxhr_actualizar_salario_lab FOR EACH ROW
EXECUTE PROCEDURE trigger_fct_xxhr_actualizar_salario_lab_tr();
