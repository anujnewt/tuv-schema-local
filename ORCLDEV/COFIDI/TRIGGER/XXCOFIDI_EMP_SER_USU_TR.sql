-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : xxcofidi_emp_ser_usu_tr
SET search_path = cofidi,oracle,dmap_extension,public;
DROP TRIGGER IF EXISTS xxcofidi_emp_ser_usu_tr ON xxcofidi_empresa_serie_usu_tab CASCADE;
-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : xxcofidi_emp_ser_usu_tr
SET search_path = cofidi,oracle,dmap_extension,public;
CREATE TRIGGER "xxcofidi_emp_ser_usu_tr"
BEFORE INSERT ON xxcofidi_empresa_serie_usu_tab FOR EACH ROW
EXECUTE PROCEDURE trigger_fct_xxcofidi_emp_ser_usu_tr();
