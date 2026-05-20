CREATE OR REPLACE NONEDITIONABLE PROCEDURE "LABPROD"."SP_ACTUALIZAPRESTAMO" (ws_rec_urp in varchar, ws_cve_ref in varchar, ws_key_con in varchar, wn_res_pue out number) IS
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
      LABPROD.SP_ACTUALIZAPRESTAMO_LOCAL (ws_rec_urp, ws_cve_ref, ws_key_con, wn_res_pue);
    /*
    APSI 231017
    ELSE
      LABPROD.SP_ACTUALIZAPRESTAMO_LOCAL@RTELECOM (ws_rec_urp, ws_cve_ref, ws_key_con, wn_res_pue);
    */
    END IF;
END;
/
