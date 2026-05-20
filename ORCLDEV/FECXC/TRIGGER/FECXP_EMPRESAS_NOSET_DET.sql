-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : fecxp_empresas_noset_det
SET search_path = fecxc,oracle,dmap_extension,public;
DROP TRIGGER IF EXISTS fecxp_empresas_noset_det ON fecxp_emp_no_set CASCADE;
-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : fecxp_empresas_noset_det
SET search_path = fecxc,oracle,dmap_extension,public;
CREATE TRIGGER "fecxp_empresas_noset_det"
AFTER INSERT OR UPDATE OF id_emp ON fecxp_emp_no_set FOR EACH ROW
EXECUTE PROCEDURE trigger_fct_fecxp_empresas_noset_det();
