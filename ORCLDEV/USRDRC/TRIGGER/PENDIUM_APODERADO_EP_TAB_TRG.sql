-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : pendium_apoderado_ep_tab_trg
SET search_path = usrdrc,oracle,dmap_extension,public;
DROP TRIGGER IF EXISTS pendium_apoderado_ep_tab_trg ON pendium_apoderado_ep_tab CASCADE;
-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : pendium_apoderado_ep_tab_trg
SET search_path = usrdrc,oracle,dmap_extension,public;
CREATE TRIGGER "pendium_apoderado_ep_tab_trg"
BEFORE INSERT ON pendium_apoderado_ep_tab FOR EACH ROW
EXECUTE PROCEDURE trigger_fct_pendium_apoderado_ep_tab_trg();
