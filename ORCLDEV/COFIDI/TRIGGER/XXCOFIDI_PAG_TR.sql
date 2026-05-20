-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : xxcofidi_pag_tr
SET search_path = cofidi,oracle,dmap_extension,public;
DROP TRIGGER IF EXISTS xxcofidi_pag_tr ON xxcofidi_paginacion_ct_tab CASCADE;
-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : xxcofidi_pag_tr
SET search_path = cofidi,oracle,dmap_extension,public;
CREATE TRIGGER "xxcofidi_pag_tr"
BEFORE INSERT ON xxcofidi_paginacion_ct_tab FOR EACH ROW
EXECUTE PROCEDURE trigger_fct_xxcofidi_pag_tr();
