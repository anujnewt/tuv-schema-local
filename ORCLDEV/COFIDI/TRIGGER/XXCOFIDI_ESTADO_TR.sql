-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : xxcofidi_estado_tr
SET search_path = cofidi,oracle,dmap_extension,public;
DROP TRIGGER IF EXISTS xxcofidi_estado_tr ON xxcofidi_estado_ct_tab CASCADE;
-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : xxcofidi_estado_tr
SET search_path = cofidi,oracle,dmap_extension,public;
CREATE TRIGGER "xxcofidi_estado_tr"
BEFORE INSERT ON xxcofidi_estado_ct_tab FOR EACH ROW
EXECUTE PROCEDURE trigger_fct_xxcofidi_estado_tr();
