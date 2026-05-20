CREATE OR REPLACE NONEDITIONABLE PROCEDURE "LABCONF"."SP_NMKEYPRE2" (ws_ide_pcc IN VARCHAR2,wn_tot_mov OUT NUMBER) IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
	wn_fec_mov NUMBER(10);
		wn_hor_mov NUMBER(10);
		wn_min_mov NUMBER(10);
		wn_seg_mov NUMBER(10);
		wd_fec_dia DATE;
		ws_hor_dia VARCHAR2(8);
		BEGIN
	--sp_glfechor(wd_fec_dia, ws_hor_dia);
  wd_fec_dia := SYSDATE;
  ws_hor_dia := TO_CHAR (SYSDATE, 'HH24:MI:SS');
	wn_fec_mov := TO_NUMBER(TO_CHAR(wd_fec_dia,'J'));
	wn_hor_mov:= SUBSTR(ws_hor_dia,1,2);
	wn_min_mov:= SUBSTR(ws_hor_dia,4,2);
	wn_seg_mov:= SUBSTR(ws_hor_dia,7,2);
	wn_tot_mov:=((wn_hor_mov*3600)+(wn_min_mov*60));
	wn_tot_mov:=(wn_tot_mov+wn_seg_mov);
	wn_tot_mov:=(wn_tot_mov/100000.0);
	wn_tot_mov:=(wn_tot_mov+wn_fec_mov);
		END;
/
