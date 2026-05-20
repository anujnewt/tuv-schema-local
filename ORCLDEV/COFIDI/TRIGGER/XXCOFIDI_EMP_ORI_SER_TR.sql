-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : xxcofidi_emp_ori_ser_tr
SET search_path = cofidi,oracle,dmap_extension,public;
DROP TRIGGER IF EXISTS xxcofidi_emp_ori_ser_tr ON xxcofidi_emp_ori_ser_tab CASCADE;
-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : xxcofidi_emp_ori_ser_tr
SET search_path = cofidi,oracle,dmap_extension,public;
CREATE TRIGGER "xxcofidi_emp_ori_ser_tr"
BEFORE INSERT ON xxcofidi_emp_ori_ser_tab FOR EACH ROW
EXECUTE PROCEDURE trigger_fct_xxcofidi_emp_ori_ser_tr();
