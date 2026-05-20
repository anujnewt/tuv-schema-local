-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : xxcofidi_usu_ori_emp_tr
SET search_path = cofidi,oracle,dmap_extension,public;
DROP TRIGGER IF EXISTS xxcofidi_usu_ori_emp_tr ON xxcofidi_usu_ori_emp_tab CASCADE;
-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : xxcofidi_usu_ori_emp_tr
SET search_path = cofidi,oracle,dmap_extension,public;
CREATE TRIGGER "xxcofidi_usu_ori_emp_tr"
BEFORE INSERT ON xxcofidi_usu_ori_emp_tab FOR EACH ROW
EXECUTE PROCEDURE trigger_fct_xxcofidi_usu_ori_emp_tr();
