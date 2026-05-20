-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : xxcofidi_serie_tr
SET search_path = cofidi,oracle,dmap_extension,public;
DROP TRIGGER IF EXISTS xxcofidi_serie_tr ON xxcofidi_serie_ct_tab CASCADE;
-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : xxcofidi_serie_tr
SET search_path = cofidi,oracle,dmap_extension,public;
CREATE TRIGGER "xxcofidi_serie_tr"
BEFORE INSERT ON xxcofidi_serie_ct_tab FOR EACH ROW
EXECUTE PROCEDURE trigger_fct_xxcofidi_serie_tr();
