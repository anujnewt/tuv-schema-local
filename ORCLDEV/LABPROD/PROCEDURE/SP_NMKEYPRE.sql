CREATE OR REPLACE NONEDITIONABLE PROCEDURE "LABPROD"."SP_NMKEYPRE" (ws_ide_pcc IN VARCHAR2 ) IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
	wn_fec_mov NUMBER(10);
		wn_hor_mov NUMBER(10);
		wn_min_mov NUMBER(10);
		wn_seg_mov NUMBER(10);
		wn_tot_mov NUMBER(16,6);
		wd_fec_dia DATE;
		ws_hor_dia VARCHAR2(8);
		BEGIN
	sp_glfechor(wd_fec_dia, ws_hor_dia);
	wn_fec_mov := TO_NUMBER(TO_CHAR(wd_fec_dia,'J'));
	wn_hor_mov:= SUBSTR(ws_hor_dia,1,2);
	wn_min_mov:= SUBSTR(ws_hor_dia,4,2);
	wn_seg_mov:= SUBSTR(ws_hor_dia,7,2);
	wn_tot_mov:=((wn_hor_mov*3600)+(wn_min_mov*60));
	wn_tot_mov:=(wn_tot_mov+wn_seg_mov);
	wn_tot_mov:=(wn_tot_mov/100000.0);
	wn_tot_mov:=(wn_tot_mov+wn_fec_mov);
	DELETE FROM glwkcrys
	WHERE cry_idepcc=ws_ide_pcc
	AND cry_nomrep='KEYPRE'
	AND cry_nomrep IS NOT NULL ;
		INSERT INTO glwkcrys( cry_nomrep,cry_idepcc,cry_dec001)
		VALUES('KEYPRE',ws_ide_pcc,wn_tot_mov);
		END;
/
