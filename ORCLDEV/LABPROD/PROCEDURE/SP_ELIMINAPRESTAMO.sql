CREATE OR REPLACE NONEDITIONABLE PROCEDURE "LABPROD"."SP_ELIMINAPRESTAMO" (ws_rec_urp IN VARCHAR, ws_cve_ref IN VARCHAR, ws_key_con IN VARCHAR,
wn_res_pue OUT NUMBER) IS
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
      LABPROD.SP_ELIMINAPRESTAMO_LOCAL (ws_rec_urp, ws_cve_ref, ws_key_con, wn_res_pue);
    /*
    APSI 231017
    ELSE
      SP_ELIMINAPRESTAMO_LOCAL@RTELECOM (ws_rec_urp, ws_cve_ref, ws_key_con, wn_res_pue);
    */
    END IF;
END;
/
