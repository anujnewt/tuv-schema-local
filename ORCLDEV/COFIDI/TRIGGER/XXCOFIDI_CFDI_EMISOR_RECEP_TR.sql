-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : xxcofidi_cfdi_emisor_recep_tr
SET search_path = cofidi,oracle,dmap_extension,public;
DROP TRIGGER IF EXISTS xxcofidi_cfdi_emisor_recep_tr ON xxcofidi_cfdi_emisor_recep_tab CASCADE;
-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : xxcofidi_cfdi_emisor_recep_tr
SET search_path = cofidi,oracle,dmap_extension,public;
CREATE TRIGGER "xxcofidi_cfdi_emisor_recep_tr"
BEFORE INSERT ON xxcofidi_cfdi_emisor_recep_tab FOR EACH ROW
EXECUTE PROCEDURE trigger_fct_xxcofidi_cfdi_emisor_recep_tr();
