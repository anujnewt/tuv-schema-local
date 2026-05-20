-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : xxcofidi_documento_tr
SET search_path = cofidi,oracle,dmap_extension,public;
DROP TRIGGER IF EXISTS xxcofidi_documento_tr ON xxcofidi_documento_tab CASCADE;
-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : xxcofidi_documento_tr
SET search_path = cofidi,oracle,dmap_extension,public;
CREATE TRIGGER "xxcofidi_documento_tr"
BEFORE INSERT ON xxcofidi_documento_tab FOR EACH ROW
EXECUTE PROCEDURE trigger_fct_xxcofidi_documento_tr();
