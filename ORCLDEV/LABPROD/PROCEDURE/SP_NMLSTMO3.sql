CREATE OR REPLACE NONEDITIONABLE PROCEDURE "LABPROD"."SP_NMLSTMO3" (ws_nom_rep IN VARCHAR2,ws_ide_pcc IN VARCHAR2,wn_key_usu IN  NUMBER,ws_key_men IN VARCHAR2,ws_hor_reg IN VARCHAR2,wn_key_pro IN NUMBER,ws_key_per IN VARCHAR2,wn_tip_rep IN NUMBER,ws_nom_rp1 IN VARCHAR2 ) IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
	ws_key_cia VARCHAR2(5);
		wn_dsp_001 NUMBER(5);
		wn_dsp_002 NUMBER(5);
		wn_ant_emp NUMBER(10);
		ws_ant_con VARCHAR2(3);
		wn_can_tid NUMBER(18,6);
		wn_can_ti2 NUMBER(18,6);
		wn_imp_ort NUMBER(18,6);
		wn_imp_or2 NUMBER(18,6);
		ws_des_con VARCHAR2(40);
		ws_des_co2 VARCHAR2(40);
		ws_des_cor VARCHAR2(100);
		ws_des_lis VARCHAR2(40);
		ws_key_cam VARCHAR2(18);
		ws_des_lar VARCHAR2(40);
		ws_des_etq VARCHAR2(40);
		ws_etq_001 VARCHAR2(40);
		ws_etq_002 VARCHAR2(40);
		ws_etq_003 VARCHAR2(40);
		ws_etq_004 VARCHAR2(40);
		ws_etq_005 VARCHAR2(40);
		ws_etq_006 VARCHAR2(40);
		wd_fec_act DATE;
		ws_hor_act VARCHAR2(8);
		ws_key_con VARCHAR2(3);
		ws_key_co2 VARCHAR2(3);
		ws_nom_emp VARCHAR2(60);
		wn_con_reg NUMBER(5);
		wn_lim_ite NUMBER(5);
		wn_key_emp NUMBER(10);
		ws_cod_imp VARCHAR2(2);
		ws_eli_glw VARCHAR2(1);
		ws_des_imp VARCHAR2(16);
    wd_fec_antig DATE;
    wd_fec_baj DATE;
    wd_de_baja DATE;
    wn_sal_mov NUMBER(10,2);
    wd_fec_mov DATE;
    wn_tip_fin INTEGER;
    wn_tip_fin2 INTEGER;
    ws_opc_009 VARCHAR2(16);
    wn_key_nom INTEGER;
		BEGIN
	LABPROD.sp_glNewdsp('nmwkmovt', 'mov_cantid', ws_key_men,wn_dsp_001);
	LABPROD.sp_glNewdsp('nmwkmovt', 'mov_import', ws_key_men,wn_dsp_002);
	LABPROD.sp_glfechor(wd_fec_act, ws_hor_act);
	ws_key_co2:=NULL;
	ws_des_co2:=NULL;
	wn_can_ti2:=0;
	wn_imp_or2:=0;
	ws_key_con:=NULL;
	ws_des_con:=NULL;
	wn_imp_ort:=0;
	wn_can_tid:=0;
	ws_key_cia:='..';
	wn_ant_emp:=-9999;
	ws_ant_con:='...';
	ws_des_lis:='No existe nombre del Reporte';
	BEGIN SELECT lis_deslis
	INTO ws_des_lis FROM LABPROD.glcolist
	WHERE lis_keylis = ws_nom_rp1;
EXCEPTION
 WHEN NO_DATA_FOUND THEN
  NULL;
  END;
  ws_etq_001:='........';
	ws_etq_002:='........';
	ws_etq_003:='........';
	ws_etq_004:='........';
	ws_etq_005:='........';
	ws_etq_006:='........';
	FOR c_etiqueta IN ( SELECT cam_keycam, cam_descor, cam_descam FROM LABPROD.glcocamp
	WHERE cam_keytab IN ('nmwkmovt','nmcoempl','nmloconc')
	AND cam_keycam IN ('mov_keyemp','mov_keycon','mov_cantid','mov_import','emp_nomemp','con_descon') ) LOOP
		ws_key_cam :=c_etiqueta.cam_keycam;
			ws_des_etq :=c_etiqueta.cam_descor;
			ws_des_lar :=c_etiqueta.cam_descam;
	IF (ws_key_cam='mov_keyemp' ) THEN
	ws_etq_001:=ws_des_etq;
	 ELSE
	IF (ws_key_cam='emp_nomemp' ) THEN
	ws_etq_002:=ws_des_etq;
	 ELSE
	IF (ws_key_cam='mov_keycon' ) THEN
	ws_etq_003:=ws_des_lar;
	 ELSE
	IF (ws_key_cam='con_descon' ) THEN
	ws_etq_004:=ws_des_lar;
	 ELSE
	IF (ws_key_cam='mov_cantid' ) THEN
	ws_etq_005:= SUBSTR(ws_des_lar,1,20);
	 ELSE
	IF (ws_key_cam='mov_import' ) THEN
	ws_etq_006:= SUBSTR(ws_des_lar,1,20);
	END IF;
		END IF;
		END IF;
		END IF;
		END IF;
		END IF;
	END LOOP;
	BEGIN SELECT cia_descia
	INTO ws_des_cor FROM LABPROD.nmlocias
	WHERE cia_keycia IN (
	SELECT pro_keycia FROM LABPROD.nmloproc
	WHERE pro_keypro = wn_key_pro);
EXCEPTION
 WHEN NO_DATA_FOUND THEN
  NULL;
  END;
  BEGIN SELECT pam_folini,pam_folfin
         INTO wn_tip_fin, wn_tip_fin2
        FROM LABPROD.glcopams
        WHERE pam_keypar = (SELECT pam_folini FROM LABPROD.glcopams WHERE pam_keypar = '00' AND pam_cvesec = 'calfin')
          AND pam_cvesec = 'OPCI03';
  EXCEPTION
  WHEN NO_DATA_FOUND THEN
    wn_tip_fin:= 0;
    wn_tip_fin2:= 0;
  END;
  ws_opc_009:='';
	BEGIN
    SELECT pam_folini INTO ws_opc_009 FROM LABPROD.glcopams
      WHERE pam_keypar = (SELECT pam_folini FROM LABPROD.glcopams WHERE pam_keypar='00' AND pam_cvesec='repnom')
        AND pam_cvesec='OPCI09';
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      NULL;
  END;
  FOR c_nmlstcic IN ( SELECT mov_keyemp, mov_keycon, mov_cantid, mov_import, mov_codimp,mov_fecmov,mov_keynom FROM nmwkmovt
	WHERE mov_keyemp IN (
	SELECT ran_keyemp FROM LABPROD.glwkrang
	WHERE ran_nomrep = ws_nom_rep
	AND ran_idepcc = ws_ide_pcc
	AND ran_keyusu = wn_key_usu
	AND ran_keyemp IS NOT NULL )
	AND mov_keypro = wn_key_pro
	AND mov_keyper = ws_key_per
	ORDER BY mov_keyemp, mov_keycon, mov_codimp ) LOOP
		wn_key_emp :=c_nmlstcic.mov_keyemp;
			ws_key_con :=c_nmlstcic.mov_keycon;
			wn_can_tid :=c_nmlstcic.mov_cantid;
			wn_imp_ort :=c_nmlstcic.mov_import;
			ws_cod_imp :=c_nmlstcic.mov_codimp;
      wd_fec_mov :=c_nmlstcic.mov_fecmov;
      wn_key_nom :=c_nmlstcic.mov_keynom;
	IF (ws_cod_imp='01' ) THEN
	ws_des_imp:='Percepciones';
	END IF;
	IF (ws_cod_imp='02' ) THEN
	ws_des_imp:='Deducciones';
	END IF;
	IF (ws_cod_imp='03' ) THEN
	ws_des_imp:='Auxiliar';
	END IF;
	IF (ws_cod_imp='04' ) THEN
	ws_des_imp:='No aplica';
	END IF;
	IF (wn_key_emp IS NULL ) THEN
	ws_nom_emp:='Empleado No Existe ...';
	 ELSE
	IF (wn_ant_emp != wn_key_emp ) THEN
	ws_nom_emp:='';
	wn_ant_emp:=wn_key_emp;
	BEGIN SELECT emp_nomemp,emp_fecaux,emp_fecbaj
	INTO ws_nom_emp,wd_fec_antig,wd_fec_baj FROM LABPROD.nmcoempl
	WHERE emp_keyemp = wn_key_emp;
EXCEPTION
 WHEN NO_DATA_FOUND THEN
  NULL;
  END;
  IF wd_fec_baj is NULL THEN
    wd_de_baja:=wd_fec_mov;
  ELSE
    wd_de_baja:=wd_fec_baj;
  END IF;
  IF (wn_key_nom = wn_tip_fin OR wn_key_nom = wn_tip_fin2) THEN
    BEGIN SELECT mov_import INTO wn_sal_mov
      FROM LABPROD.nmwkmovt
      WHERE mov_keypro=wn_key_pro
        AND mov_keyper=ws_key_per
        AND mov_keycon=ws_opc_009
        AND mov_keyemp=wn_key_emp;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        NULL;
    END;
  END IF;
  END IF;
		END IF;
	IF (ws_key_con IS NULL ) THEN
	ws_des_con:='Concepto No Existe ...';
	 ELSE
	IF (ws_ant_con != ws_key_con ) THEN
	ws_des_con:='';
	ws_ant_con:=ws_key_con;
	BEGIN SELECT con_descon
	INTO ws_des_con FROM LABPROD.nmloconc
	WHERE con_keycon = ws_key_con;
EXCEPTION
 WHEN NO_DATA_FOUND THEN
  NULL;
  END;
  END IF;
		END IF;
	IF ((ws_cod_imp='02') AND (wn_tip_rep=1) ) THEN
	wn_imp_ort:=(wn_imp_ort*-1);
	END IF;
	IF (wn_tip_rep=1 ) THEN
	IF ((ws_cod_imp='03') OR (ws_cod_imp='04') ) THEN
	ws_key_co2:=ws_key_con;
	ws_des_co2:=ws_des_con;
	wn_can_ti2:=wn_can_tid;
	wn_imp_or2:=wn_imp_ort;
	ws_key_con:=NULL;
	ws_des_con:=NULL;
	wn_imp_ort:=NULL;
	wn_can_tid:=NULL;
	END IF;
		END IF;
	IF (wn_dsp_001=1 ) THEN
	wn_can_tid:=NULL;
	END IF;
	IF (wn_dsp_002=1 ) THEN
	wn_imp_ort:=NULL;
	END IF;
		INSERT INTO LABPROD.glwkcrys( cry_nomrep,cry_idepcc,cry_keyusu,cry_chr001,cry_chr017,cry_chr003,cry_dec006,cry_chr002,cry_dec001,cry_dec002,cry_chr006,cry_chr007,cry_chr008,cry_chr009,cry_chr010,cry_chr011,cry_dat001,cry_chr024,cry_chr025,cry_chr004,cry_dec003,cry_dec004,cry_chr005,cry_chr018,cry_chr016,cry_dec013,cry_dat004,cry_dat005)
		VALUES(ws_nom_rep,ws_ide_pcc,wn_key_usu,substr(ws_des_cor,1,60),ws_key_con,ws_des_con,wn_key_emp,ws_nom_emp,wn_can_tid,wn_imp_ort,ws_etq_003,ws_etq_004,ws_etq_001,ws_etq_002,ws_etq_005,ws_etq_006,wd_fec_act,ws_hor_act,ws_key_co2,ws_des_co2,wn_can_ti2,wn_imp_or2,ws_des_lis,ws_cod_imp,ws_des_imp,wn_sal_mov,wd_fec_antig,wd_de_baja); COMMIT;
		ws_key_co2:=NULL;
	ws_des_co2:=NULL;
	wn_can_ti2:=NULL;
	wn_imp_or2:=NULL;
	END LOOP;
END;
/
