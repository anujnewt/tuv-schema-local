-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : pend_update_contacto_tr
SET search_path = usrdrc,oracle,dmap_extension,public;
DROP TRIGGER IF EXISTS pend_update_contacto_tr ON dercorp_add_campo_cat_val_tab CASCADE;
-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : pend_update_contacto_tr
SET search_path = usrdrc,oracle,dmap_extension,public;
CREATE TRIGGER "pend_update_contacto_tr"
AFTER UPDATE
ON USRDRC.DERCORP_ADD_CAMPO_CAT_VAL_TAB
FOR EACH ROW
EXECUTE PROCEDURE trigger_fct_pend_update_contacto_tr();
