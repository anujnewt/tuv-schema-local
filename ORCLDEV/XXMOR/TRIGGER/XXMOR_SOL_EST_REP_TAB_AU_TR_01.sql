-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : xxmor_sol_est_rep_tab_au_tr_01
SET search_path = xxmor,oracle,dmap_extension,public;
DROP TRIGGER IF EXISTS xxmor_sol_est_rep_tab_au_tr_01 ON xxmor_solicitudes_est_rep_tab CASCADE;
-- DMAP_OBJECT_GEN_TAG : TYPE : TRIGGER NAME : xxmor_sol_est_rep_tab_au_tr_01
SET search_path = xxmor,oracle,dmap_extension,public;
CREATE TRIGGER "xxmor_sol_est_rep_tab_au_tr_01"

AFTER UPDATE
OF ESTAT_REP
ON "XXMOR".XXMOR_SOLICITUDES_EST_REP_TAB
FOR EACH ROW
EXECUTE PROCEDURE trigger_fct_xxmor_sol_est_rep_tab_au_tr_01();
