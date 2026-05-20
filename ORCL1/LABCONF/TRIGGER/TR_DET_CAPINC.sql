-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : tr_det_capinc
SET search_path = labconf,oracle,dmap_extension,public;
DROP TRIGGER IF EXISTS tr_det_capinc ON det_capinc CASCADE;
-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : tr_det_capinc
SET search_path = labconf,oracle,dmap_extension,public;
CREATE TRIGGER "tr_det_capinc"
BEFORE INSERT ON det_capinc FOR EACH ROW
EXECUTE PROCEDURE trigger_fct_tr_det_capinc();
