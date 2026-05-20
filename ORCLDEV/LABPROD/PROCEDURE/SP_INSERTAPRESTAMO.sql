CREATE OR REPLACE NONEDITIONABLE PROCEDURE "LABPROD"."SP_INSERTAPRESTAMO" (ws_rec_urp in varchar, wn_tot_sol in number, wn_imp_des in number,
wn_tot_int in number, wn_int_des in number, ws_cve_cli in varchar, ws_cve_ref in varchar, ws_key_con in varchar,
wn_res_pue out number) IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
total NUMBER;
base VARCHAR2(10);
BEGIN
  --busca el empleado en tvnomdes
    BASE := LABPROD.FN_BASEDATOS_CURP(ws_rec_urp);
    IF BASE = 'TVNOMINA' THEN
      LABPROD.SP_INSERTAPRESTAMO_LOCAL (ws_rec_urp, wn_tot_sol, wn_imp_des, wn_tot_int, wn_int_des, ws_cve_cli, ws_cve_ref, ws_key_con, wn_res_pue);
    /*
    APSI 231017
    ELSE
      SP_INSERTAPRESTAMO_LOCAL@RTELECOM (ws_rec_urp, wn_tot_sol, wn_imp_des, wn_tot_int, wn_int_des, ws_cve_cli, ws_cve_ref, ws_key_con, wn_res_pue);
    */
    END IF;
END;
/
