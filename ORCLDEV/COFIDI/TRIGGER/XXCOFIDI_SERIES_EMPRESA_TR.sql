-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : xxcofidi_series_empresa_tr
SET search_path = cofidi,oracle,dmap_extension,public;
DROP TRIGGER IF EXISTS xxcofidi_series_empresa_tr ON xxcofidi_series_empresa_tab CASCADE;
-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : xxcofidi_series_empresa_tr
SET search_path = cofidi,oracle,dmap_extension,public;
CREATE TRIGGER "xxcofidi_series_empresa_tr"
BEFORE INSERT ON xxcofidi_series_empresa_tab FOR EACH ROW
EXECUTE PROCEDURE trigger_fct_xxcofidi_series_empresa_tr();
