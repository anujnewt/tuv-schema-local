-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : xxhr_rever_emp_lab_trg
SET search_path = labprod,oracle,dmap_extension,public;
DROP TRIGGER IF EXISTS xxhr_rever_emp_lab_trg ON xxhr_rever_emp_lab CASCADE;
-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : xxhr_rever_emp_lab_trg
SET search_path = labprod,oracle,dmap_extension,public;
CREATE TRIGGER "xxhr_rever_emp_lab_trg"
BEFORE INSERT ON xxhr_rever_emp_lab FOR EACH ROW
EXECUTE PROCEDURE trigger_fct_xxhr_rever_emp_lab_trg();
