-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : log_flash
SET search_path = usrdrc,oracle,dmap_extension,public;
DROP TRIGGER IF EXISTS log_flash ON dercorp_add_campo_valor_tab CASCADE;
-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : log_flash
SET search_path = usrdrc,oracle,dmap_extension,public;
CREATE TRIGGER "log_flash"
BEFORE UPDATE OF VAL_VALOR ON usrdrc.dercorp_add_campo_valor_tab FOR EACH ROW
WHEN (NEW.id_add_campo = 500)
EXECUTE PROCEDURE trigger_fct_log_flash();
