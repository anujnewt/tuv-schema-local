-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : dercorp_esc_cons_tr
SET search_path = usrdrc,oracle,dmap_extension,public;
DROP TRIGGER IF EXISTS dercorp_esc_cons_tr ON dercorp_add_campo_valor_tab CASCADE;
-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : dercorp_esc_cons_tr
SET search_path = usrdrc,oracle,dmap_extension,public;
CREATE TRIGGER "dercorp_esc_cons_tr"
BEFORE UPDATE OF VAL_VALOR ON usrdrc.dercorp_add_campo_valor_tab FOR EACH ROW
WHEN (NEW.ID_ADD_CAMPO  =551)
EXECUTE PROCEDURE trigger_fct_dercorp_esc_cons_tr();
