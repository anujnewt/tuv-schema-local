-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : pendium_facultades_ep_tab_trg1
SET search_path = usrdrc,oracle,dmap_extension,public;
DROP TRIGGER IF EXISTS pendium_facultades_ep_tab_trg1 ON pendium_facultades_ep_tab CASCADE;
-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : pendium_facultades_ep_tab_trg1
SET search_path = usrdrc,oracle,dmap_extension,public;
CREATE TRIGGER "pendium_facultades_ep_tab_trg1"
BEFORE INSERT ON pendium_facultades_ep_tab FOR EACH ROW
EXECUTE PROCEDURE trigger_fct_pendium_facultades_ep_tab_trg1();
