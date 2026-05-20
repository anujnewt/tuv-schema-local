-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : xxcofidi_pac_tr
SET search_path = cofidi,oracle,dmap_extension,public;
DROP TRIGGER IF EXISTS xxcofidi_pac_tr ON xxcofidi_pac_ct_tab CASCADE;
-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : xxcofidi_pac_tr
SET search_path = cofidi,oracle,dmap_extension,public;
CREATE TRIGGER "xxcofidi_pac_tr"
BEFORE INSERT ON xxcofidi_pac_ct_tab FOR EACH ROW
EXECUTE PROCEDURE trigger_fct_xxcofidi_pac_tr();
