-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : tri_pppagrales
SET search_path = labconf,oracle,dmap_extension,public;
DROP TRIGGER IF EXISTS tri_pppagrales ON pppagrales CASCADE;
-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : tri_pppagrales
SET search_path = labconf,oracle,dmap_extension,public;
CREATE TRIGGER "tri_pppagrales"
BEFORE INSERT ON pppagrales FOR EACH ROW
EXECUTE PROCEDURE trigger_fct_tri_pppagrales();
