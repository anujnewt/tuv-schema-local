CREATE OR REPLACE NONEDITIONABLE PROCEDURE "LABCONF"."SP_NMLSTACU" (ws_nom_rep IN VARCHAR2,ws_ide_pcc IN VARCHAR2,wn_key_usu IN  NUMBER,ws_key_men IN VARCHAR2,ws_hor_reg IN VARCHAR2, wn_ani_oac IN NUMBER ) IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
	wn_key_emp NUMBER(10);
		ws_key_con VARCHAR2(3);
		wn_uni_uno NUMBER(14,2);
		wn_uni_dos NUMBER(14,2);
		wn_uni_tre NUMBER(14,2);
		wn_uni_cua NUMBER(14,2);
		wn_uni_cin NUMBER(14,2);
		wn_uni_sei NUMBER(14,2);
		wn_uni_sie NUMBER(14,2);
		wn_uni_och NUMBER(14,2);
		wn_uni_nue NUMBER(14,2);
		wn_uni_die NUMBER(14,2);
		wn_uni_onc NUMBER(14,2);
		wn_uni_doc NUMBER(14,2);
		wn_uni_013 NUMBER(14,2);
		wn_uni_cat NUMBER(14,2);
		wn_uni_qui NUMBER(14,2);
		wn_imp_uno NUMBER(14,2);
		wn_imp_dos NUMBER(14,2);
		wn_imp_tre NUMBER(14,2);
		wn_imp_cua NUMBER(14,2);
		wn_imp_cin NUMBER(14,2);
		wn_imp_sei NUMBER(14,2);
		wn_imp_sie NUMBER(14,2);
		wn_imp_och NUMBER(14,2);
		wn_imp_nue NUMBER(14,2);
		wn_imp_die NUMBER(14,2);
		wn_imp_onc NUMBER(14,2);
		wn_imp_doc NUMBER(14,2);
		wn_imp_013 NUMBER(14,2);
		wn_imp_cat NUMBER(14,2);
		wn_imp_qui NUMBER(14,2);
		ws_des_lis VARCHAR2(50);
		ws_des_cor VARCHAR2(60);
		ws_des_con VARCHAR2(40);
		ws_nom_emp VARCHAR2(60);
		wn_emp_ant NUMBER(10);
		ws_con_ant VARCHAR2(3);
		ws_key_cam VARCHAR2(20);
		ws_des_etq VARCHAR2(8);
		ws_etq_001 VARCHAR2(8);
		ws_etq_002 VARCHAR2(8);
		ws_etq_003 VARCHAR2(8);
		ws_etq_004 VARCHAR2(8);
		ws_etq_005 VARCHAR2(8);
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
		wn_dsp_010 NUMBER(5);
		wn_dsp_011 NUMBER(5);
		wn_dsp_012 NUMBER(5);
		wn_dsp_013 NUMBER(5);
		wn_dsp_014 NUMBER(5);
		wn_dsp_015 NUMBER(5);
		wn_dsp_016 NUMBER(5);
		wn_dsp_017 NUMBER(5);
		wn_dsp_018 NUMBER(5);
		wn_dsp_019 NUMBER(5);
		wn_dsp_020 NUMBER(5);
		wn_dsp_021 NUMBER(5);
		wn_dsp_022 NUMBER(5);
		wn_dsp_023 NUMBER(5);
		wn_dsp_024 NUMBER(5);
		wn_dsp_025 NUMBER(5);
		wn_dsp_026 NUMBER(5);
		wn_dsp_027 NUMBER(5);
		wn_dsp_028 NUMBER(5);
		wn_dsp_029 NUMBER(5);
		wn_dsp_030 NUMBER(5);
		wn_dsp_031 NUMBER(5);
		wn_dsp_032 NUMBER(5);
		wn_tot_reg NUMBER(10);
		wn_num_reg NUMBER(10);
		wn_pct_reg NUMBER(6,2);
		wn_pct_act NUMBER(5);
		ws_hor_act VARCHAR2(8);
		wd_fec_act DATE;
		wn_num_tem NUMBER(10);
		wn_key_pro NUMBER(10);
		ws_des_pro VARCHAR2(20);
		wn_pro_ant NUMBER(10);
		BEGIN
	BEGIN SELECT  COUNT(* ) alias1
	INTO wn_tot_reg FROM LABCONF.nmloacum
	WHERE acu_keypro IN (
	SELECT ran_keypro FROM LABCONF.glwkrang
	WHERE ran_nomrep = ws_nom_rep
	AND ran_idepcc = ws_ide_pcc
	AND ran_keyusu = wn_key_usu
	AND ran_keypro IS NOT NULL )
	AND acu_keyemp IN (
	SELECT ran_keyemp FROM LABCONF.glwkrang
	WHERE ran_nomrep = ws_nom_rep
	AND ran_idepcc = ws_ide_pcc
	AND ran_keyusu = wn_key_usu
	AND ran_keyemp IS NOT NULL )
	AND acu_keycon IN (
	SELECT ran_keycon FROM LABCONF.glwkrang
	WHERE ran_nomrep = ws_nom_rep
	AND ran_idepcc = ws_ide_pcc
	AND ran_keyusu = wn_key_usu
	AND ran_keycon IS NOT NULL )
  AND acu_anioac = wn_ani_oac;
EXCEPTION
 WHEN NO_DATA_FOUND THEN
  NULL;
  END;
  LABCONF.sp_glfechor(wd_fec_act, ws_hor_act);
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
  ws_des_lis:='No existe Nombre del Reporte ...';
	BEGIN SELECT lis_deslis
	INTO ws_des_lis FROM LABCONF.glcolist
	WHERE lis_keylis = ws_nom_rep;
EXCEPTION
 WHEN NO_DATA_FOUND THEN
  NULL;
  END;
  ws_etq_001:='Empleado';
	ws_etq_003:='Nombre';
	ws_etq_002:='Concepto';
	ws_etq_005:='Proceso';
	FOR c_etiqueta IN ( SELECT cam_keycam, cam_descor FROM LABCONF.glcocamp
	WHERE cam_keytab IN ('nmloacum','nmcoempl','nmloconc')
	AND cam_keycam IN ('acu_keyemp','acu_keycon','acu_keypro','emp_nomemp','con_descon') ) LOOP
		ws_key_cam :=c_etiqueta.cam_keycam;
			ws_des_etq :=c_etiqueta.cam_descor;
	IF (ws_key_cam='acu_keyemp' ) THEN
	ws_etq_001:=ws_des_etq;
	 ELSE
	IF (ws_key_cam='acu_keycon' ) THEN
	ws_etq_002:=ws_des_etq;
	 ELSE
	IF (ws_key_cam='emp_nomemp' ) THEN
	ws_etq_003:=ws_des_etq;
	 ELSE
	IF (ws_key_cam='con_descon' ) THEN
	ws_etq_004:=ws_des_etq;
	 ELSE
	IF (ws_key_cam='acu_keypro' ) THEN
	ws_etq_005:=ws_des_etq;
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
	wn_dsp_010:=0;
	wn_dsp_011:=0;
	wn_dsp_012:=0;
	wn_dsp_013:=0;
	wn_dsp_014:=0;
	wn_dsp_015:=0;
	wn_dsp_016:=0;
	wn_dsp_017:=0;
	wn_dsp_018:=0;
	wn_dsp_019:=0;
	wn_dsp_020:=0;
	wn_dsp_021:=0;
	wn_dsp_022:=0;
	wn_dsp_023:=0;
	wn_dsp_024:=0;
	wn_dsp_025:=0;
	wn_dsp_026:=0;
	wn_dsp_027:=0;
	wn_dsp_028:=0;
	wn_dsp_029:=0;
	wn_dsp_030:=0;
	wn_dsp_031:=0;
	wn_dsp_032:=0;
	LABCONF.sp_glnewdsp('nmloacum',  'acu_keyemp' , ws_key_men,wn_dsp_001);
	LABCONF.sp_glnewdsp('nmloacum',  'acu_keycon' , ws_key_men,wn_dsp_002);
	LABCONF.sp_glnewdsp('nmloacum',  'acu_uniuno' , ws_key_men,wn_dsp_003);
	LABCONF.sp_glnewdsp('nmloacum',  'acu_unidos' , ws_key_men,wn_dsp_004);
	LABCONF.sp_glnewdsp('nmloacum',  'acu_unitre' , ws_key_men,wn_dsp_005);
	LABCONF.sp_glnewdsp('nmloacum',  'acu_unicua' , ws_key_men,wn_dsp_006);
	LABCONF.sp_glnewdsp('nmloacum',  'acu_unicin' , ws_key_men,wn_dsp_007);
	LABCONF.sp_glnewdsp('nmloacum',  'acu_unisei' , ws_key_men,wn_dsp_008);
	LABCONF.sp_glnewdsp('nmloacum',  'acu_unisie' , ws_key_men,wn_dsp_009);
	LABCONF.sp_glnewdsp('nmloacum',  'acu_unioch' , ws_key_men,wn_dsp_010);
	LABCONF.sp_glnewdsp('nmloacum',  'acu_uninue' , ws_key_men,wn_dsp_011);
	LABCONF.sp_glnewdsp('nmloacum',  'acu_unidie' , ws_key_men,wn_dsp_012);
	LABCONF.sp_glnewdsp('nmloacum',  'acu_unionc' , ws_key_men,wn_dsp_013);
	LABCONF.sp_glnewdsp('nmloacum',  'acu_unidoc' , ws_key_men,wn_dsp_014);
	LABCONF.sp_glnewdsp('nmloacum',  'acu_unitre' , ws_key_men,wn_dsp_015);
	LABCONF.sp_glnewdsp('nmloacum',  'acu_unicua' , ws_key_men,wn_dsp_016);
	LABCONF.sp_glnewdsp('nmloacum',  'acu_unicat' , ws_key_men,wn_dsp_017);
	LABCONF.sp_glnewdsp('nmloacum',  'acu_uniqui' , ws_key_men,wn_dsp_018);
	LABCONF.sp_glnewdsp('nmloacum',  'acu_impuno' , ws_key_men,wn_dsp_019);
	LABCONF.sp_glnewdsp('nmloacum',  'acu_impdos' , ws_key_men,wn_dsp_020);
	LABCONF.sp_glnewdsp('nmloacum',  'acu_imptre' , ws_key_men,wn_dsp_021);
	LABCONF.sp_glnewdsp('nmloacum',  'acu_impcua' , ws_key_men,wn_dsp_022);
	LABCONF.sp_glnewdsp('nmloacum',  'acu_impcin' , ws_key_men,wn_dsp_023);
	LABCONF.sp_glnewdsp('nmloacum',  'acu_impsei' , ws_key_men,wn_dsp_024);
	LABCONF.sp_glnewdsp('nmloacum',  'acu_impoch' , ws_key_men,wn_dsp_025);
	LABCONF.sp_glnewdsp('nmloacum',  'acu_impnue' , ws_key_men,wn_dsp_026);
	LABCONF.sp_glnewdsp('nmloacum',  'acu_impdie' , ws_key_men,wn_dsp_027);
	LABCONF.sp_glnewdsp('nmloacum',  'acu_imponc' , ws_key_men,wn_dsp_028);
	LABCONF.sp_glnewdsp('nmloacum',  'acu_impdoc' , ws_key_men,wn_dsp_029);
	LABCONF.sp_glnewdsp('nmloacum',  'acu_imptre' , ws_key_men,wn_dsp_030);
	LABCONF.sp_glnewdsp('nmloacum',  'acu_impcat' , ws_key_men,wn_dsp_031);
	LABCONF.sp_glnewdsp('nmloacum',  'acu_impqui' , ws_key_men,wn_dsp_032);
	ws_con_ant:='@@@';
	wn_emp_ant:=-999999999;
	wn_pro_ant:=-999999999;
	wn_num_reg:=0;
	wn_pct_act:=1;
	wn_pct_reg:=(wn_tot_reg/10.0);
	FOR c_nmlstacu IN ( SELECT acu_keyemp, acu_keycon, acu_uniuno, acu_unidos, acu_unitre, acu_unicua, acu_unicin, acu_unisei, acu_unisie, acu_unioch, acu_uninue, acu_unidie, acu_unionc, acu_unidoc, acu_unitrc, acu_unicat, acu_uniqui, acu_impuno, acu_impdos, acu_imptre, acu_impcua, acu_impcin, acu_impsei, acu_impsie, acu_impoch, acu_impnue, acu_impdie, acu_imponc, acu_impdoc, acu_imptrc, acu_impcat, acu_impqui, acu_keypro
  FROM LABCONF.nmloacum, LABCONF.glwkrang
	WHERE ran_nomrep = ws_nom_rep
	AND ran_idepcc = ws_ide_pcc
	AND ran_keyusu = wn_key_usu
	AND acu_keypro = ran_keypro
	AND acu_keyemp = ran_keyemp
	AND acu_keycon = ran_keycon
  AND acu_anioac = wn_ani_oac
	AND ran_keypro IS NOT NULL
	AND ran_keyemp IS NOT NULL
	AND ran_keycon IS NOT NULL
  AND ran_keyper = wn_ani_oac
	ORDER BY acu_keypro,acu_keyemp,acu_keycon ) LOOP
		wn_key_emp :=c_nmlstacu.acu_keyemp;
			ws_key_con :=c_nmlstacu.acu_keycon;
			wn_uni_uno :=c_nmlstacu.acu_uniuno;
			wn_uni_dos :=c_nmlstacu.acu_unidos;
			wn_uni_tre :=c_nmlstacu.acu_unitre;
			wn_uni_cua :=c_nmlstacu.acu_unicua;
			wn_uni_cin :=c_nmlstacu.acu_unicin;
			wn_uni_sei :=c_nmlstacu.acu_unisei;
			wn_uni_sie :=c_nmlstacu.acu_unisie;
			wn_uni_och :=c_nmlstacu.acu_unioch;
			wn_uni_nue :=c_nmlstacu.acu_uninue;
			wn_uni_die :=c_nmlstacu.acu_unidie;
			wn_uni_onc :=c_nmlstacu.acu_unionc;
			wn_uni_doc :=c_nmlstacu.acu_unidoc;
			wn_uni_013 :=c_nmlstacu.acu_unitrc;
			wn_uni_cat :=c_nmlstacu.acu_unicat;
			wn_uni_qui :=c_nmlstacu.acu_uniqui;
			wn_imp_uno :=c_nmlstacu.acu_impuno;
			wn_imp_dos :=c_nmlstacu.acu_impdos;
			wn_imp_tre :=c_nmlstacu.acu_imptre;
			wn_imp_cua :=c_nmlstacu.acu_impcua;
			wn_imp_cin :=c_nmlstacu.acu_impcin;
			wn_imp_sei :=c_nmlstacu.acu_impsei;
			wn_imp_sie :=c_nmlstacu.acu_impsie;
			wn_imp_och :=c_nmlstacu.acu_impoch;
			wn_imp_nue :=c_nmlstacu.acu_impnue;
			wn_imp_die :=c_nmlstacu.acu_impdie;
			wn_imp_onc :=c_nmlstacu.acu_imponc;
			wn_imp_doc :=c_nmlstacu.acu_impdoc;
			wn_imp_013 :=c_nmlstacu.acu_imptrc;
			wn_imp_cat :=c_nmlstacu.acu_impcat;
			wn_imp_qui :=c_nmlstacu.acu_impqui;
			wn_key_pro :=c_nmlstacu.acu_keypro;
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
	END IF;
	IF (wn_key_pro IS NULL ) THEN
	ws_des_pro:='PROCESO NO EXISTE';
	 ELSE
	IF (wn_key_pro != wn_pro_ant ) THEN
	BEGIN SELECT pro_despro
	INTO ws_des_pro FROM LABCONF.nmloproc
	WHERE pro_keypro = wn_key_pro;
EXCEPTION
 WHEN NO_DATA_FOUND THEN
  NULL;
  END;
  BEGIN SELECT cia_descia
	INTO ws_des_cor FROM LABCONF.nmloproc, LABCONF.nmlocias
	WHERE pro_keypro = wn_key_pro
	AND pro_keycia = cia_keycia;
EXCEPTION
 WHEN NO_DATA_FOUND THEN
  NULL;
  END;
  wn_pro_ant:=wn_key_pro;
	END IF;
		END IF;
	IF (wn_key_emp IS NULL ) THEN
	ws_nom_emp:='EMPLEADO NO EXISTE';
	 ELSE
	IF (wn_key_emp != wn_emp_ant ) THEN
	BEGIN SELECT emp_nomemp
	INTO ws_nom_emp FROM LABCONF.nmcoempl
	WHERE emp_keyemp = wn_key_emp;
EXCEPTION
 WHEN NO_DATA_FOUND THEN
  NULL;
  END;
  wn_emp_ant:=wn_key_emp;
	END IF;
		END IF;
	IF (ws_key_con IS NULL ) THEN
	ws_des_con:='CONCEPTO NO EXISTE';
	 ELSE
	IF (ws_key_con != ws_con_ant ) THEN
	BEGIN SELECT con_descon
	INTO ws_des_con FROM LABCONF.nmloconc
	WHERE con_keycon = ws_key_con;
EXCEPTION
 WHEN NO_DATA_FOUND THEN
  NULL;
  END;
  ws_con_ant:=ws_key_con;
	END IF;
		END IF;
	IF (wn_dsp_001=1 ) THEN
	wn_key_emp:=NULL;
	ws_nom_emp:=NULL;
	END IF;
	IF (wn_dsp_002=1 ) THEN
	ws_key_con:=NULL;
	ws_des_con:=NULL;
	END IF;
	IF (wn_dsp_003=1 ) THEN
	wn_uni_uno:=NULL;
	END IF;
	IF (wn_dsp_004=1 ) THEN
	wn_uni_dos:=NULL;
	END IF;
	IF (wn_dsp_005=1 ) THEN
	wn_uni_tre:=NULL;
	END IF;
	IF (wn_dsp_006=1 ) THEN
	wn_uni_cua:=NULL;
	END IF;
	IF (wn_dsp_007=1 ) THEN
	wn_uni_cin:=NULL;
	END IF;
	IF (wn_dsp_008=1 ) THEN
	wn_uni_sei:=NULL;
	END IF;
	IF (wn_dsp_009=1 ) THEN
	wn_uni_sie:=NULL;
	END IF;
	IF (wn_dsp_010=1 ) THEN
	wn_uni_och:=NULL;
	END IF;
	IF (wn_dsp_011=1 ) THEN
	wn_uni_nue:=NULL;
	END IF;
	IF (wn_dsp_012=1 ) THEN
	wn_uni_die:=NULL;
	END IF;
	IF (wn_dsp_013=1 ) THEN
	wn_uni_onc:=NULL;
	END IF;
	IF (wn_dsp_014=1 ) THEN
	wn_uni_doc:=NULL;
	END IF;
	IF (wn_dsp_015=1 ) THEN
	wn_uni_013:=NULL;
	END IF;
	IF (wn_dsp_016=1 ) THEN
	wn_uni_cat:=NULL;
	END IF;
	IF (wn_dsp_017=1 ) THEN
	wn_uni_qui:=NULL;
	END IF;
	IF (wn_dsp_018=1 ) THEN
	wn_imp_uno:=NULL;
	END IF;
	IF (wn_dsp_019=1 ) THEN
	wn_imp_dos:=NULL;
	END IF;
	IF (wn_dsp_020=1 ) THEN
	wn_imp_tre:=NULL;
	END IF;
	IF (wn_dsp_021=1 ) THEN
	wn_imp_cua:=NULL;
	END IF;
	IF (wn_dsp_022=1 ) THEN
	wn_imp_cin:=NULL;
	END IF;
	IF (wn_dsp_023=1 ) THEN
	wn_imp_sei:=NULL;
	END IF;
	IF (wn_dsp_024=1 ) THEN
	wn_imp_sie:=NULL;
	END IF;
	IF (wn_dsp_025=1 ) THEN
	wn_imp_och:=NULL;
	END IF;
	IF (wn_dsp_026=1 ) THEN
	wn_imp_nue:=NULL;
	END IF;
	IF (wn_dsp_027=1 ) THEN
	wn_imp_die:=NULL;
	END IF;
	IF (wn_dsp_028=1 ) THEN
	wn_imp_onc:=NULL;
	END IF;
	IF (wn_dsp_029=1 ) THEN
	wn_imp_doc:=NULL;
	END IF;
	IF (wn_dsp_030=1 ) THEN
	wn_imp_013:=NULL;
	END IF;
	IF (wn_dsp_031=1 ) THEN
	wn_imp_cat:=NULL;
	END IF;
	IF (wn_dsp_032=1 ) THEN
	wn_imp_qui:=NULL;
	END IF;
		INSERT INTO LABCONF.glwkcrys( cry_nomrep,cry_idepcc,cry_keyusu,cry_chr001,cry_dec013,cry_chr012,cry_chr003,cry_chr002,cry_dec001,cry_dec002,cry_dec003,cry_dec004,cry_dec005,cry_dec011,cry_dec012,cry_chr004,cry_dec014,cry_dec015,cry_chr005,cry_chr006,cry_chr007,cry_dec025,cry_chr009,cry_chr010,cry_chr011,cry_dec024,cry_chr013,cry_chr014,cry_chr015,cry_chr016,cry_dec016,cry_dec017,cry_dec018,cry_dec019,cry_dec020,cry_dec021,cry_dec022,cry_dec023,cry_chr017,cry_chr018,cry_chr019,cry_chr020,cry_chr021,cry_chr036,cry_dat001,cry_dec006,cry_chr008,cry_dec007)
		VALUES(ws_nom_rep,ws_ide_pcc,wn_key_usu,ws_des_cor,wn_key_emp,ws_key_con,ws_des_con,ws_nom_emp,wn_uni_uno,wn_uni_dos,wn_uni_tre,wn_uni_cua,wn_uni_cin,wn_uni_sei,wn_uni_sie,wn_uni_och,wn_uni_nue,wn_uni_die,wn_uni_onc,wn_uni_doc,wn_uni_013,wn_uni_cat,wn_uni_qui,wn_imp_uno,wn_imp_dos,wn_imp_tre,wn_imp_cua,wn_imp_cin,wn_imp_sei,wn_imp_sie,wn_imp_och,wn_imp_nue,wn_imp_die,wn_imp_onc,wn_imp_doc,wn_imp_013,wn_imp_cat,wn_imp_qui,ws_etq_001,ws_etq_002,ws_etq_003,ws_etq_004,ws_etq_005,ws_hor_act,wd_fec_act,wn_key_pro,ws_des_pro,wn_ani_oac); COMMIT;
	END LOOP;
	LABCONF.sp_glfechor(wd_fec_act, ws_hor_act);
	UPDATE LABCONF.glcoresu SET res_numreg=wn_num_reg,res_fecfin=wd_fec_act,res_horfin=ws_hor_act,res_status='T'
	WHERE res_idepro = ws_nom_rep
	AND res_idepcc = ws_ide_pcc
	AND res_keyusu = wn_key_usu
	AND res_fecini = wd_fec_act
	AND res_horreg = ws_hor_reg; COMMIT;
END;
/
