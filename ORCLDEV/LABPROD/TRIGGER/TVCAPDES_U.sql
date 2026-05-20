-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : tvcapdes_u
SET search_path = labprod,oracle,dmap_extension,public;
DROP TRIGGER IF EXISTS tvcapdes_u ON tvcapdes CASCADE;
-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : tvcapdes_u
SET search_path = labprod,oracle,dmap_extension,public;
CREATE TRIGGER "tvcapdes_u"
BEFORE UPDATE ON tvcapdes FOR EACH ROW
EXECUTE PROCEDURE trigger_fct_tvcapdes_u();
