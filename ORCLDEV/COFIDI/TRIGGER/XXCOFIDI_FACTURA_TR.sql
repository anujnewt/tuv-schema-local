-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : xxcofidi_factura_tr
SET search_path = cofidi,oracle,dmap_extension,public;
DROP TRIGGER IF EXISTS xxcofidi_factura_tr ON xxcofidi_factura_tab CASCADE;
-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : xxcofidi_factura_tr
SET search_path = cofidi,oracle,dmap_extension,public;
CREATE TRIGGER "xxcofidi_factura_tr"
BEFORE INSERT ON xxcofidi_factura_tab FOR EACH ROW
EXECUTE PROCEDURE trigger_fct_xxcofidi_factura_tr();
