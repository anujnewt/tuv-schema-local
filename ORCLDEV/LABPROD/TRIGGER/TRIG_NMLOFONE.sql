-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : trig_nmlofone
SET search_path = labprod,oracle,dmap_extension,public;
DROP TRIGGER IF EXISTS trig_nmlofone ON nmlofone CASCADE;
-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : trig_nmlofone
SET search_path = labprod,oracle,dmap_extension,public;
CREATE TRIGGER "trig_nmlofone"
BEFORE INSERT ON nmlofone FOR EACH ROW
EXECUTE PROCEDURE trigger_fct_trig_nmlofone();
