-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : dercorp_cat_acc_emp_tr
SET search_path = usrdrc,oracle,dmap_extension,public;
DROP TRIGGER IF EXISTS dercorp_cat_acc_emp_tr ON dercorp_add_campo_cat_val_tab CASCADE;
-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : dercorp_cat_acc_emp_tr
SET search_path = usrdrc,oracle,dmap_extension,public;
CREATE TRIGGER "dercorp_cat_acc_emp_tr"
BEFORE UPDATE ON usrdrc.dercorp_add_campo_cat_val_tab FOR EACH ROW
WHEN (NEW.id_catalogo =40)
EXECUTE PROCEDURE trigger_fct_dercorp_cat_acc_emp_tr();
