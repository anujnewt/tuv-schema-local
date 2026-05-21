-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : fecxp_borrar_registros
SET search_path = fecxc,oracle,dmap_extension,public;
DROP TRIGGER IF EXISTS fecxp_borrar_registros ON fecxp_imp_dat_hist CASCADE;
-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : fecxp_borrar_registros
SET search_path = fecxc,oracle,dmap_extension,public;
CREATE TRIGGER "fecxp_borrar_registros"
BEFORE DELETE ON fecxp_imp_dat_hist FOR EACH ROW
EXECUTE PROCEDURE trigger_fct_fecxp_borrar_registros();
