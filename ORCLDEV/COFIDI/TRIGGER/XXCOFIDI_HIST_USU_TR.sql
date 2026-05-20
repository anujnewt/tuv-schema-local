-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : xxcofidi_hist_usu_tr
SET search_path = cofidi,oracle,dmap_extension,public;
DROP TRIGGER IF EXISTS xxcofidi_hist_usu_tr ON xxcofidi_historico_usuario_tab CASCADE;
-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : xxcofidi_hist_usu_tr
SET search_path = cofidi,oracle,dmap_extension,public;
CREATE TRIGGER "xxcofidi_hist_usu_tr"
BEFORE INSERT ON xxcofidi_historico_usuario_tab FOR EACH ROW
EXECUTE PROCEDURE trigger_fct_xxcofidi_hist_usu_tr();
