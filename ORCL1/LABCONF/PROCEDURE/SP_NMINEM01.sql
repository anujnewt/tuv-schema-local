CREATE OR REPLACE NONEDITIONABLE PROCEDURE "LABCONF"."SP_NMINEM01" (ws_nom_rep IN VARCHAR2,ws_ide_pcc IN VARCHAR2,wn_key_usu IN  NUMBER,ws_key_men IN VARCHAR2,ws_hor_reg IN VARCHAR2,ws_nom_ran IN VARCHAR2 ) IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
	wn_ant_pro NUMBER(5);
		ws_ant_per VARCHAR2(7);
		ws_ant_dep VARCHAR2(16);
		wn_ant_emp NUMBER(10);
		ws_ant_con VARCHAR2(3);
		ws_ant_fol VARCHAR2(10);
		wn_row_ide NUMBER(10);
		ws_key_cia VARCHAR2(5);
		ws_key_cam VARCHAR2(20);
		ws_des_eti VARCHAR2(40);
		ws_des_etq VARCHAR2(8);
		ws_dsp_cam VARCHAR2(1);
		wn_dsp_001 NUMBER(5);
		wn_dsp_002 NUMBER(5);
		wn_dsp_003 NUMBER(5);
		wn_dsp_004 NUMBER(5);
		wn_dsp_005 NUMBER(5);
		wn_dsp_006 NUMBER(5);
		wn_dsp_007 NUMBER(5);
		wn_dsp_008 NUMBER(5);
		wn_dsp_009 NUMBER(5);
		wn_tot_reg NUMBER(10);
		wn_num_reg NUMBER(10);
		wn_pct_reg NUMBER(6,2);
		wn_pct_act NUMBER(5);
		wn_num_tem NUMBER(5);
		ws_des_cor VARCHAR2(100);
		wn_key_emp NUMBER(10);
		ws_key_con VARCHAR2(16);
		wn_can_tid NUMBER(18,6);
		wn_imp_ort NUMBER(18,6);
		wd_fec_mov DATE;
		ws_key_dep VARCHAR2(16);
		ws_key_pue VARCHAR2(16);
		wn_key_pro NUMBER(5);
		ws_key_per VARCHAR2(8);
		ws_des_con VARCHAR2(40);
		ws_nom_emp VARCHAR2(60);
		ws_des_pro VARCHAR2(20);
		wd_fec_ini DATE;
		wd_fec_fin DATE;
		ws_num_fol VARCHAR2(16);
		ws_nom_usu VARCHAR2(40);
		wd_fec_act DATE;
		ws_hor_act VARCHAR2(8);
		ws_etq_003 VARCHAR2(8);
		ws_etq_004 VARCHAR2(8);
		ws_etq_005 VARCHAR2(8);
		ws_etq_006 VARCHAR2(8);
		ws_etq_007 VARCHAR2(8);
		ws_etq_008 VARCHAR2(8);
		ws_etq_009 VARCHAR2(8);
		ws_etq_010 VARCHAR2(8);
		ws_etq_011 VARCHAR2(8);
		ws_etq_001 VARCHAR2(8);
		ws_etq_002 VARCHAR2(8);
		ws_etq_012 VARCHAR2(8);
		ws_des_dep VARCHAR2(40);
		ws_des_lis VARCHAR2(60);
		wn_con_reg NUMBER(5);
		wn_lim_ite NUMBER(5);
		ws_ca1_aux VARCHAR2(10);
		BEGIN
	LABCONF.sp_glfechor(wd_fec_act, ws_hor_act);
	wn_ant_pro:=-32760;
	ws_ant_per:='@@@@@@@';
	ws_ant_dep:='@@@@@@@@@@@@@@@@';
	wn_ant_emp:=-999999999;
	ws_ant_con:='@@@';
	ws_ant_fol:='@@@@@@@@@@';
	wn_num_reg:=0;
	wn_pct_act:=1;
	wn_con_reg:=0;
	wn_lim_ite:=100;
	BEGIN SELECT  COUNT(* ) alias1
	INTO wn_tot_reg FROM LABCONF.nmcoinci
	WHERE inc_keyinc IN (
	SELECT cry_dec001 FROM LABCONF.glwkcrys
	WHERE cry_nomrep = ws_nom_ran
	AND cry_idepcc = ws_ide_pcc
	AND cry_keyusu = wn_key_usu
	AND cry_dec001 IS NOT NULL );
EXCEPTION
 WHEN NO_DATA_FOUND THEN
  NULL;
  END;
  INSERT INTO LABCONF.glcoresu( res_idepro,res_idepcc,res_keyusu,res_fecini,res_horini,res_horreg,res_totreg,res_status)
		VALUES(ws_nom_rep,ws_ide_pcc,wn_key_usu,wd_fec_act,ws_hor_act,ws_hor_reg,wn_tot_reg,'P'); COMMIT;
		DELETE FROM LABCONF.glwkcrys
	WHERE cry_nomrep = ws_nom_rep
	AND cry_idepcc = ws_ide_pcc
	AND cry_keyusu = wn_key_usu; COMMIT;
		ws_des_cor:='CORPORATIVO NO REGISTRADO ..';
	BEGIN SELECT cor_razsoc
	INTO ws_des_cor FROM LABCONF.glcocorp;
EXCEPTION
 WHEN NO_DATA_FOUND THEN
  NULL;
  END;
  ws_des_lis:='Reporte de Incidencias';
	FOR c_deslis IN ( SELECT lis_deslis FROM LABCONF.glcolist
	WHERE lis_keylis = ws_nom_rep ) LOOP
		ws_des_lis :=c_deslis.lis_deslis;
			ws_des_lis:= RTRIM(LTRIM(ws_des_lis));
	END LOOP;
	ws_etq_001:='.......';
	ws_etq_002:='.......';
	ws_etq_003:='.......';
	ws_etq_004:='.......';
	ws_etq_005:='.......';
	ws_etq_006:='.......';
	ws_etq_007:='.......';
	ws_etq_008:='.......';
	ws_etq_009:='.......';
	ws_etq_010:='.......';
	ws_etq_011:='.......';
	ws_etq_012:='.......';
	FOR c_etiqueta IN ( SELECT cam_keycam, cam_descor, cam_descam FROM LABCONF.glcocamp
	WHERE cam_keytab IN ('nmcoinci','nmcoempl','nmloconc') ) LOOP
		ws_key_cam :=c_etiqueta.cam_keycam;
			ws_des_etq :=c_etiqueta.cam_descor;
			ws_des_eti :=c_etiqueta.cam_descam;
	IF (ws_key_cam='inc_cantid' ) THEN
	ws_etq_003:=ws_des_etq;
	 ELSE
	IF (ws_key_cam='inc_import' ) THEN
	ws_etq_004:=ws_des_etq;
	 ELSE
	IF (ws_key_cam='inc_fecmov' ) THEN
	ws_etq_005:=ws_des_etq;
	 ELSE
	IF (ws_key_cam='inc_keydep' ) THEN
	ws_etq_006:=ws_des_etq;
	 ELSE
	IF (ws_key_cam='inc_keypue' ) THEN
	ws_etq_007:=ws_des_etq;
	 ELSE
	IF (ws_key_cam='inc_keypro' ) THEN
	ws_etq_008:=ws_des_etq;
	 ELSE
	IF (ws_key_cam='inc_keyper' ) THEN
	ws_etq_009:=ws_des_etq;
	 ELSE
	IF (ws_key_cam='emp_nomemp' ) THEN
	ws_etq_010:=ws_des_etq;
	 ELSE
	IF (ws_key_cam='con_descon' ) THEN
	ws_etq_011:=ws_des_etq;
	 ELSE
	IF (ws_key_cam='inc_keyemp' ) THEN
	ws_etq_001:=ws_des_etq;
	 ELSE
	IF (ws_key_cam='inc_keycon' ) THEN
	ws_etq_002:=ws_des_etq;
	 ELSE
	IF (ws_key_cam='inc_numfol' ) THEN
	ws_etq_012:=ws_des_etq;
	END IF;
		END IF;
		END IF;
		END IF;
		END IF;
		END IF;
		END IF;
		END IF;
		END IF;
		END IF;
		END IF;
		END IF;
	END LOOP;
	wn_dsp_001:=0;
	wn_dsp_002:=0;
	wn_dsp_003:=0;
	wn_dsp_004:=0;
	wn_dsp_005:=0;
	wn_dsp_006:=0;
	wn_dsp_007:=0;
	wn_dsp_008:=0;
	wn_dsp_009:=0;
	LABCONF.sp_glnewdsp('nmcoinci', 'inc_keypro', ws_key_men,wn_dsp_001);
	LABCONF.sp_glnewdsp('nmcoinci', 'inc_keyper', ws_key_men,wn_dsp_002);
	LABCONF.sp_glnewdsp('nmcoinci', 'inc_keyemp', ws_key_men,wn_dsp_003);
	LABCONF.sp_glnewdsp('nmcoinci', 'inc_keycon', ws_key_men,wn_dsp_004);
	LABCONF.sp_glnewdsp('nmcoinci', 'inc_cantid', ws_key_men,wn_dsp_005);
	LABCONF.sp_glnewdsp('nmcoinci', 'inc_import', ws_key_men,wn_dsp_006);
	LABCONF.sp_glnewdsp('nmcoinci', 'inc_fecmov', ws_key_men,wn_dsp_007);
	LABCONF.sp_glnewdsp('nmcoinci', 'inc_keydep', ws_key_men,wn_dsp_008);
	LABCONF.sp_glnewdsp('nmcoinci', 'inc_keypue', ws_key_men,wn_dsp_009);
	wn_ant_emp:=-0000;
	ws_ant_con:='@@@';
	wn_ant_pro:=-0000;
	ws_ant_dep:=0;
	wn_num_reg:=1;
	wn_pct_act:=(wn_tot_reg/10.0);
	FOR c_nmlstinc IN ( SELECT inc_keydep, inc_keyemp, inc_keycon, inc_keypro, inc_fecmov, inc_cantid, inc_import, inc_keypue, inc_keyper, inc_numfol
	FROM LABCONF.nmcoinci
	WHERE inc_keyinc IN (
	SELECT cry_dec001 FROM LABCONF.glwkcrys
	WHERE cry_nomrep = ws_nom_ran
	AND cry_idepcc = ws_ide_pcc
	AND cry_keyusu = wn_key_usu
	AND cry_dec001 IS NOT NULL )
	ORDER BY inc_keypro, inc_keyper, inc_keydep, inc_numfol, inc_keyemp ) LOOP
		ws_key_dep :=c_nmlstinc.inc_keydep;
			wn_key_emp :=c_nmlstinc.inc_keyemp;
			ws_key_con :=c_nmlstinc.inc_keycon;
			wn_key_pro :=c_nmlstinc.inc_keypro;
			wd_fec_mov :=c_nmlstinc.inc_fecmov;
			wn_can_tid :=c_nmlstinc.inc_cantid;
			wn_imp_ort :=c_nmlstinc.inc_import;
			ws_key_pue :=c_nmlstinc.inc_keypue;
			ws_key_per :=c_nmlstinc.inc_keyper;
			ws_num_fol :=c_nmlstinc.inc_numfol;
			wn_num_reg:=(wn_num_reg+1);
	wn_num_tem:=(wn_pct_reg*wn_pct_act);
	IF (wn_num_reg>=wn_num_tem ) THEN
	UPDATE LABCONF.glcoresu SET res_numreg=wn_num_reg
	WHERE res_idepro = ws_nom_rep
	AND res_idepcc = ws_ide_pcc
	AND res_keyusu = wn_key_usu
	AND res_fecini = wd_fec_act
	AND res_horreg = ws_hor_reg; COMMIT;
		wn_pct_act:=(wn_pct_act+1);
	wn_con_reg:=(wn_con_reg+1);
	END IF;
	IF (ws_num_fol IS NULL ) THEN
	ws_nom_usu:='USUARIO NO EXISTE ....';
	 ELSE
	IF (ws_num_fol != ws_ant_fol ) THEN
	ws_nom_usu:='Usuario no existe.';
	FOR c_nomusu IN ( SELECT usu_nomusu FROM LABCONF.glcousua
	WHERE usu_keyusu = ws_num_fol ) LOOP
		ws_nom_usu :=c_nomusu.usu_nomusu;
			ws_nom_usu:= RTRIM(LTRIM(ws_nom_usu));
	END LOOP;
	ws_ant_fol:=ws_num_fol;
	END IF;
		END IF;
	IF (ws_key_con IS NULL ) THEN
	ws_des_con:='Concepto No Existe..';
	 ELSE
	IF (ws_key_con != ws_ant_con ) THEN
	ws_des_con:='Concepto No existe ..';
	FOR c_descon IN ( SELECT con_descon FROM LABCONF.nmloconc
	WHERE con_keycon = ws_key_con ) LOOP
		ws_des_con :=c_descon.con_descon;
			ws_des_con:= RTRIM(LTRIM(ws_des_con));
	END LOOP;
	ws_ant_con:=ws_key_con;
	END IF;
		END IF;
	IF (wn_key_emp IS NULL ) THEN
	ws_ca1_aux:=NULL;
	ws_nom_emp:='Empleado No Existe..';
	 ELSE
	IF (wn_key_emp != wn_ant_emp ) THEN
	ws_ca1_aux:=NULL;
	ws_nom_emp:='Empleado No Existe..';
	FOR c_nomemp IN ( SELECT emp_ca1aux, emp_nomemp FROM LABCONF.nmcoempl
	WHERE emp_keyemp = wn_key_emp ) LOOP
		  ws_ca1_aux :=c_nomemp.emp_ca1aux;
			ws_nom_emp :=c_nomemp.emp_nomemp;
			ws_ca1_aux:= RTRIM(LTRIM(ws_ca1_aux));
	ws_nom_emp:= RTRIM(LTRIM(ws_nom_emp));
	END LOOP;
	wn_ant_emp:=wn_key_emp;
	END IF;
		END IF;
	IF (ws_key_dep IS NULL ) THEN
	ws_des_dep:='Departamento No Existe.';
	 ELSE
	IF (ws_key_dep != ws_ant_dep ) THEN
	ws_des_dep:='Departamento no Existe.';
	FOR c_desdep IN ( SELECT dep_desdep FROM LABCONF.nmcodeps
	WHERE dep_keydep = ws_key_dep ) LOOP
		ws_des_dep :=c_desdep.dep_desdep;
			ws_des_dep:= RTRIM(LTRIM(ws_des_dep));
	END LOOP;
	ws_ant_dep:=ws_key_dep;
	END IF;
		END IF;
	IF (wn_key_pro IS NULL ) THEN
	ws_des_pro:='Proceso No Existe.';
	 ELSE
	IF (wn_key_pro != wn_ant_pro ) THEN
	ws_des_pro:='Proceso No Existe.';
	ws_key_cia:='..';
	ws_des_cor:='CORPORATIVO NO REGISTRADO ...';
	FOR c_despro IN ( SELECT pro_despro, pro_keycia FROM LABCONF.nmloproc
	WHERE pro_keypro = wn_key_pro ) LOOP
		ws_des_pro :=c_despro.pro_despro;
			ws_key_cia :=c_despro.pro_keycia;
			ws_key_cia:= RTRIM(LTRIM(ws_key_cia));
	END LOOP;
	FOR c_descia IN ( SELECT cia_descia FROM LABCONF.nmlocias
	WHERE cia_keycia = ws_key_cia ) LOOP
		ws_des_cor :=substr(c_descia.cia_descia,60);
			ws_des_cor:= RTRIM(LTRIM(ws_des_cor));
	END LOOP;
	wn_ant_pro:=wn_key_pro;
	END IF;
		END IF;
	IF (ws_key_per IS NULL ) THEN
	wd_fec_ini:=NULL;
	wd_fec_fin:=NULL;
	 ELSE
	IF (ws_key_per != ws_ant_per ) THEN
	wd_fec_ini:=NULL;
	wd_fec_fin:=NULL;
	ws_ant_per:=ws_key_per;
	BEGIN SELECT per_fecini, per_fecfin
	INTO wd_fec_ini, wd_fec_fin FROM LABCONF.nmloperi
	WHERE per_keyper = ws_key_per
	AND per_keypro = wn_key_pro;
EXCEPTION
 WHEN NO_DATA_FOUND THEN
  NULL;
  END;
  END IF;
		END IF;
	IF (wn_dsp_001=1 ) THEN
	wn_key_pro:=NULL;
	ws_des_pro:=NULL;
	END IF;
	IF (wn_dsp_002=1 ) THEN
	ws_key_per:=NULL;
	wd_fec_ini:=NULL;
	wd_fec_fin:=NULL;
	END IF;
	IF (wn_dsp_003=1 ) THEN
	wn_key_emp:=NULL;
	ws_nom_emp:=NULL;
	END IF;
	IF (wn_dsp_004=1 ) THEN
	ws_key_con:=NULL;
	ws_des_con:=NULL;
	END IF;
	IF (wn_dsp_005=1 ) THEN
	wn_can_tid:=NULL;
	END IF;
	IF (wn_dsp_006=1 ) THEN
	wn_imp_ort:=NULL;
	END IF;
	IF (wn_dsp_007=1 ) THEN
	wd_fec_mov:=NULL;
	END IF;
	IF (wn_dsp_008=1 ) THEN
	ws_key_dep:=NULL;
	ws_des_dep:=NULL;
	END IF;
	IF (wn_dsp_009=1 ) THEN
	ws_key_pue:=NULL;
	END IF;
		INSERT INTO LABCONF.glwkcrys( cry_nomrep,cry_idepcc,cry_keyusu,cry_chr001,cry_dec006,cry_chr012,cry_dec001,cry_dec002,cry_dat001,cry_chr013,cry_chr014,cry_dec007,cry_chr031,cry_chr003,cry_chr004,cry_chr008,cry_dat002,cry_dat003,cry_dat004,cry_chr026,cry_chr027,cry_chr028,cry_chr017,cry_chr018,cry_chr019,cry_chr020,cry_chr021,cry_chr022,cry_chr023,cry_chr024,cry_chr025,cry_chr005,cry_chr002,cry_chr015,cry_chr006,cry_chr029,cry_chr016)
		VALUES(ws_nom_rep,ws_ide_pcc,wn_key_usu,ws_des_cor,wn_key_emp,ws_key_con,wn_can_tid,wn_imp_ort,wd_fec_mov,ws_key_dep,ws_key_pue,wn_key_pro,ws_key_per,ws_des_con,ws_nom_emp,ws_des_pro,wd_fec_ini,wd_fec_fin,wd_fec_act,ws_hor_act,ws_etq_001,ws_etq_002,ws_etq_003,ws_etq_004,ws_etq_005,ws_etq_006,ws_etq_007,ws_etq_008,ws_etq_009,ws_etq_010,ws_etq_011,ws_des_dep,ws_des_lis,ws_num_fol,ws_nom_usu,ws_etq_012,ws_ca1_aux); COMMIT;
	END LOOP;
	UPDATE LABCONF.glcoresu SET res_numreg=wn_num_reg,res_fecfin=wd_fec_act,res_horfin=ws_hor_act,res_status='T'
	WHERE res_idepro = ws_nom_rep
	AND res_idepcc = ws_ide_pcc
	AND res_keyusu = wn_key_usu
	AND res_fecini = wd_fec_act
	AND res_horreg = ws_hor_reg; COMMIT;
END;
/
