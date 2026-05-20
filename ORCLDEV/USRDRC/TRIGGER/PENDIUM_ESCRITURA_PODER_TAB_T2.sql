-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : pendium_escritura_poder_tab_t2
SET search_path = usrdrc,oracle,dmap_extension,public;
DROP TRIGGER IF EXISTS pendium_escritura_poder_tab_t2 ON pendium_escritura_poder_tab CASCADE;
-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : pendium_escritura_poder_tab_t2
SET search_path = usrdrc,oracle,dmap_extension,public;
CREATE TRIGGER "pendium_escritura_poder_tab_t2"
BEFORE INSERT ON pendium_escritura_poder_tab FOR EACH ROW
EXECUTE PROCEDURE trigger_fct_pendium_escritura_poder_tab_t2();
