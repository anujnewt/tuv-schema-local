-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : t_nmcoempl_sdw
SET search_path = labprod,oracle,dmap_extension,public;
DROP TRIGGER IF EXISTS t_nmcoempl_sdw ON nmcoempl_sdw CASCADE;
-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : t_nmcoempl_sdw
SET search_path = labprod,oracle,dmap_extension,public;
CREATE TRIGGER "t_nmcoempl_sdw"
BEFORE INSERT ON nmcoempl_sdw "LABPROD"."T_NMCOEMPL_SDW"
BEFORE INSERT
ON LABPROD.nmcoempl_sdw
REFERENCING NEW AS NEW
FOR EACH ROW
FOR EACH ROW
EXECUTE PROCEDURE trigger_fct_t_nmcoempl_sdw();
