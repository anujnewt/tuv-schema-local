-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : t_pppagrales
SET search_path = labppto,oracle,dmap_extension,public;
DROP TRIGGER IF EXISTS t_pppagrales ON pppagrales CASCADE;
-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : t_pppagrales
SET search_path = labppto,oracle,dmap_extension,public;
CREATE TRIGGER "t_pppagrales"
BEFORE INSERT ON pppagrales "LABPPTO"."T_PPPAGRALES" BEFORE
INSERT ON LABPPTO.pppagrales REFERENCING NEW AS NEW FOR EACH ROW  FOR EACH ROW
EXECUTE PROCEDURE trigger_fct_t_pppagrales();
