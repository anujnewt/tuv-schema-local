-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : xxcofidi_bitacora_tr
SET search_path = cofidi,oracle,dmap_extension,public;
DROP TRIGGER IF EXISTS xxcofidi_bitacora_tr ON xxcofidi_bitacora_tab CASCADE;
-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : xxcofidi_bitacora_tr
SET search_path = cofidi,oracle,dmap_extension,public;
CREATE TRIGGER "xxcofidi_bitacora_tr"
BEFORE INSERT ON xxcofidi_bitacora_tab FOR EACH ROW
EXECUTE PROCEDURE trigger_fct_xxcofidi_bitacora_tr();
