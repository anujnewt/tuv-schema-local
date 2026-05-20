-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : trig_nmlofond
SET search_path = labprod,oracle,dmap_extension,public;
DROP TRIGGER IF EXISTS trig_nmlofond ON nmlofond CASCADE;
-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : trig_nmlofond
SET search_path = labprod,oracle,dmap_extension,public;
CREATE TRIGGER "trig_nmlofond"
BEFORE INSERT ON nmlofond FOR EACH ROW
EXECUTE PROCEDURE trigger_fct_trig_nmlofond();
