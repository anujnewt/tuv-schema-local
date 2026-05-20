CREATE OR REPLACE NONEDITIONABLE PROCEDURE "LABPROD"."SP_GLNEWDSP" (ws_key_tab IN VARCHAR2,ws_key_cam IN VARCHAR2,ws_key_men IN VARCHAR2,wn_val_dsp OUT NUMBER ) IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
	ws_dsp_cam VARCHAR2(1);
		BEGIN
	wn_val_dsp:=0;
	FOR cur01 IN ( SELECT rec_despli FROM glcoreca
	WHERE rec_keytab=ws_key_tab
	AND rec_keycam=ws_key_cam
	AND rec_keymen=ws_key_men ) LOOP
		ws_dsp_cam :=cur01.rec_despli;
	IF (ws_dsp_cam='N' ) THEN
	wn_val_dsp:=1;
	RETURN;END IF;
	END LOOP;
	END;
/
