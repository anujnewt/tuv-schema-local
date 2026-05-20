-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : xxcofidi_parametro_tr
SET search_path = cofidi,oracle,dmap_extension,public;
DROP TRIGGER IF EXISTS xxcofidi_parametro_tr ON xxcofidi_parametro_ct_tab CASCADE;
-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : xxcofidi_parametro_tr
SET search_path = cofidi,oracle,dmap_extension,public;
CREATE TRIGGER "xxcofidi_parametro_tr"
BEFORE INSERT ON xxcofidi_parametro_ct_tab FOR EACH ROW
EXECUTE PROCEDURE trigger_fct_xxcofidi_parametro_tr();
