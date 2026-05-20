-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : xxcofidi_historico_clave_tr
SET search_path = cofidi,oracle,dmap_extension,public;
DROP TRIGGER IF EXISTS xxcofidi_historico_clave_tr ON xxcofidi_historico_clave_tab CASCADE;
-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : xxcofidi_historico_clave_tr
SET search_path = cofidi,oracle,dmap_extension,public;
CREATE TRIGGER "xxcofidi_historico_clave_tr"
BEFORE INSERT ON xxcofidi_historico_clave_tab FOR EACH ROW
EXECUTE PROCEDURE trigger_fct_xxcofidi_historico_clave_tr();
