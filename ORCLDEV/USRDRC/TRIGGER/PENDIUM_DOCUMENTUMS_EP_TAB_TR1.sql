-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : pendium_documentums_ep_tab_tr1
SET search_path = usrdrc,oracle,dmap_extension,public;
DROP TRIGGER IF EXISTS pendium_documentums_ep_tab_tr1 ON pendium_documentums_ep_tab CASCADE;
-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : pendium_documentums_ep_tab_tr1
SET search_path = usrdrc,oracle,dmap_extension,public;
CREATE TRIGGER "pendium_documentums_ep_tab_tr1"
BEFORE INSERT ON pendium_documentums_ep_tab FOR EACH ROW
EXECUTE PROCEDURE trigger_fct_pendium_documentums_ep_tab_tr1();
