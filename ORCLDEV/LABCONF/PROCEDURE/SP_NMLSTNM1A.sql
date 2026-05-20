CREATE OR REPLACE EDITIONABLE PROCEDURE "LABCONF"."SP_NMLSTNM1A" (ws_nom_rep IN VARCHAR2,ws_des_rep IN VARCHAR2,ws_ide_pcc IN VARCHAR2,wn_key_usu IN  NUMBER,ws_key_men IN VARCHAR2,ws_hor_reg IN VARCHAR2,wn_key_pro IN NUMBER,wn_tip_nom IN NUMBER ) IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
	ws_key_con VARCHAR2(3);
		wn_can_mov NUMBER(16,2);
		wn_imp_mov NUMBER(16,2);
		ws_cod_imp VARCHAR2(2);
		ws_key_loc VARCHAR2(16);
		wn_key_emp NUMBER(10);
		ws_nom_emp VARCHAR2(60);
		ws_key_dep VARCHAR2(16);
		ws_key_pue VARCHAR2(16);
		ws_reg_rfc VARCHAR2(13);
		wn_sal_dia NUMBER(12,6);
		wn_sal_int NUMBER(12,6);
		wd_fec_ing DATE;
		ws_tip_emp VARCHAR2(6);
		ws_key_ims VARCHAR2(5);
		ws_rfc_ims VARCHAR2(16);
		ws_rfc_uno VARCHAR2(8);
		ws_rfc_dos VARCHAR2(8);
		ws_rfc_c01 VARCHAR2(8);
		ws_rfc_c02 VARCHAR2(8);
		ws_rfc_cia VARCHAR2(16);
		ws_reg_ims VARCHAR2(12);
		ws_reg_im1 VARCHAR2(6);
		ws_reg_im2 VARCHAR2(6);
		ws_con_his VARCHAR2(3);
		ws_dep_his VARCHAR2(16);
		ws_pue_his VARCHAR2(16);
		ws_loc_his VARCHAR2(16);
		ws_opc_003 VARCHAR2(16);
		ws_opc_004 VARCHAR2(16);
		ws_opc_005 VARCHAR2(16);
		ws_opc_006 VARCHAR2(16);
		ws_opc_007 VARCHAR2(16);
		ws_des_nom VARCHAR2(40);
		ws_des_pro VARCHAR2(20);
		ws_des_con VARCHAR2(30);
		ws_des_cor VARCHAR2(60);
		ws_des_pue VARCHAR2(60);
		ws_des_dep VARCHAR2(60);
		ws_des_loc VARCHAR2(40);
		wd_fec_ini DATE;
		wd_fec_fin DATE;
		ws_des_lis VARCHAR2(40);
		ws_des_li1 VARCHAR2(50);
		ws_des_aux VARCHAR2(10);
		ws_key_cia VARCHAR2(5);
		ws_des_tip VARCHAR2(40);
		ws_key_tab VARCHAR2(4);
		ws_key_cam VARCHAR2(20);
		ws_des_etq VARCHAR2(8);
		ws_etq_001 VARCHAR2(8);
		ws_etq_002 VARCHAR2(8);
		ws_etq_003 VARCHAR2(8);
		ws_etq_004 VARCHAR2(8);
		ws_etq_005 VARCHAR2(8);
		ws_etq_006 VARCHAR2(8);
		ws_etq_007 VARCHAR2(8);
		ws_etq_008 VARCHAR2(8);
		ws_etq_009 VARCHAR2(8);
		ws_etq_010 VARCHAR2(8);
		ws_etq_011 VARCHAR2(8);
		ws_etq_012 VARCHAR2(8);
		ws_etq_013 VARCHAR2(8);
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
		wn_tot_reg NUMBER(10);
		wn_num_reg NUMBER(10);
		wn_pct_reg NUMBER(6,2);
		wn_pct_act NUMBER(5);
		ws_hor_act VARCHAR2(8);
		ws_fec_act DATE;
		wn_num_sec NUMBER(10);
		i NUMBER(10);
		j NUMBER(10);
		k NUMBER(10);
		wn_emp_ant NUMBER(10);
		BEGIN
	LABCONF.sp_glfechor(ws_fec_act, ws_hor_act);
	wn_tot_reg:=-1;
	wd_fec_ini:=NULL;
	wd_fec_fin:=NULL;
	INSERT INTO LABCONF.glcoresu( res_idepro,res_idepcc,res_keyusu,res_fecini,res_horini,res_horreg,res_totreg,res_status)
		VALUES(ws_nom_rep,ws_ide_pcc,wn_key_usu,ws_fec_act,ws_hor_act,ws_hor_reg,wn_tot_reg,'P'); COMMIT;
		ws_des_cor:='CORPORATIVO NO REGISTRADO';
	ws_key_cia:=NULL;
	BEGIN SELECT pro_keycia
	INTO ws_key_cia FROM LABCONF.nmloproc
	WHERE pro_keypro=wn_key_pro;
EXCEPTION
 WHEN NO_DATA_FOUND THEN
  NULL;
  END;
	IF ((ws_key_cia!=' ') AND (ws_key_cia IS NOT NULL ) ) THEN
	BEGIN SELECT substr(cia_descia,60), cia_rfccia
	INTO ws_des_cor, ws_rfc_cia FROM LABCONF.nmlocias
	WHERE cia_keycia=ws_key_cia;
EXCEPTION
 WHEN NO_DATA_FOUND THEN
  NULL;
  END;
  ws_rfc_c01:= SUBSTR(ws_rfc_cia,1,8);
	ws_rfc_c02:= SUBSTR(ws_rfc_cia,9,7);
	END IF;
		ws_key_tab:='';
	BEGIN SELECT pam_folini
	INTO ws_key_tab FROM LABCONF.glcopams
	WHERE pam_keypar = (
	SELECT pam_folini FROM LABCONF.glcopams
	WHERE pam_keypar='00'
	AND pam_cvesec='repnom')
	AND pam_cvesec='OPCI01';
EXCEPTION
 WHEN NO_DATA_FOUND THEN
  NULL;
  END;
  ws_con_his:='';
	BEGIN SELECT pam_folini
	INTO ws_con_his FROM LABCONF.glcopams
	WHERE pam_keypar = (
	SELECT pam_folini FROM LABCONF.glcopams
	WHERE pam_keypar='00'
	AND pam_cvesec='repnom')
	AND pam_cvesec='OPCI02';
EXCEPTION
 WHEN NO_DATA_FOUND THEN
  NULL;
  END;
  ws_opc_003:='';
	BEGIN SELECT pam_folini
	INTO ws_opc_003 FROM LABCONF.glcopams
	WHERE pam_keypar = (
	SELECT pam_folini FROM LABCONF.glcopams
	WHERE pam_keypar='00'
	AND pam_cvesec='repnom')
	AND pam_cvesec='OPCI03';
EXCEPTION
 WHEN NO_DATA_FOUND THEN
  NULL;
  END;
  ws_opc_004:='';
	BEGIN SELECT pam_folini
	INTO ws_opc_004 FROM LABCONF.glcopams
	WHERE pam_keypar = (
	SELECT pam_folini FROM LABCONF.glcopams
	WHERE pam_keypar='00'
	AND pam_cvesec='repnom')
	AND pam_cvesec='OPCI04';
EXCEPTION
 WHEN NO_DATA_FOUND THEN
  NULL;
  END;
  ws_opc_005:='';
	BEGIN SELECT pam_folini
	INTO ws_opc_005 FROM LABCONF.glcopams
	WHERE pam_keypar = (
	SELECT pam_folini FROM LABCONF.glcopams
	WHERE pam_keypar='00'
	AND pam_cvesec='repnom')
	AND pam_cvesec='OPCI05';
EXCEPTION
 WHEN NO_DATA_FOUND THEN
  NULL;
  END;
  ws_opc_006:='';
	BEGIN SELECT pam_folini
	INTO ws_opc_006 FROM LABCONF.glcopams
	WHERE pam_keypar = (
	SELECT pam_folini FROM LABCONF.glcopams
	WHERE pam_keypar='00'
	AND pam_cvesec='repnom')
	AND pam_cvesec='OPCI06';
EXCEPTION
 WHEN NO_DATA_FOUND THEN
  NULL;
  END;
  ws_opc_007:='';
	BEGIN SELECT pam_folini
	INTO ws_opc_007 FROM LABCONF.glcopams
	WHERE pam_keypar = (
	SELECT pam_folini FROM LABCONF.glcopams
	WHERE pam_keypar='00'
	AND pam_cvesec='repnom')
	AND pam_cvesec='OPCI07';
EXCEPTION
 WHEN NO_DATA_FOUND THEN
  NULL;
  END;
  ws_etq_001:='........';
	ws_etq_002:='........';
	ws_etq_003:='........';
	ws_etq_004:='........';
	ws_etq_005:='........';
	ws_etq_006:='R.F.C.';
	ws_etq_007:='NOMBRE';
	ws_etq_008:='SAL. DIA';
	ws_etq_009:='SAL. INT';
	ws_etq_010:='........';
	ws_etq_011:='........';
	ws_etq_012:='........';
	ws_etq_013:='Reg.IMSS';
	FOR c_etiqueta IN ( SELECT cam_keycam, cam_descor FROM LABCONF.glcocamp
	WHERE cam_keytab IN ('nmlohism','nmcoempl','nmloimss') ) LOOP
		ws_key_cam :=c_etiqueta.cam_keycam;
			ws_des_etq :=c_etiqueta.cam_descor;
	IF (ws_key_cam='his_keyemp' ) THEN
	ws_etq_001:=ws_des_etq;
	 ELSE
	IF (ws_key_cam='his_keyemp' ) THEN
	ws_etq_001:=ws_des_etq;
	END IF;
	IF (ws_key_cam='his_keydep' ) THEN
	ws_etq_002:=ws_des_etq;
	END IF;
	IF (ws_key_cam='his_keypue' ) THEN
	ws_etq_003:=ws_des_etq;
	END IF;
	IF (ws_key_cam='his_keynom' ) THEN
	ws_etq_004:=ws_des_etq;
	END IF;
	IF (ws_key_cam='his_keyper' ) THEN
	ws_etq_005:=ws_des_etq;
	END IF;
	IF (ws_key_cam='emp_regrfc' ) THEN
	ws_etq_006:=ws_des_etq;
	END IF;
	IF (ws_key_cam='emp_nomemp' ) THEN
	ws_etq_007:=ws_des_etq;
	END IF;
	IF (ws_key_cam='emp_sadia' ) THEN
	ws_etq_008:=ws_des_etq;
	END IF;
	IF (ws_key_cam='emp_salint' ) THEN
	ws_etq_009:=ws_des_etq;
	END IF;
	IF (ws_key_cam='his_keypro' ) THEN
	ws_etq_010:=ws_des_etq;
	END IF;
	IF (ws_key_cam='emp_tipemp' ) THEN
	ws_etq_011:=ws_des_etq;
	END IF;
	IF (ws_key_cam='his_ca2aux' ) THEN
	ws_etq_012:=ws_des_etq;
	END IF;
	IF (ws_key_cam='ims_rfcims' ) THEN
	ws_etq_013:=ws_des_etq;
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
	LABCONF.sp_glnewDsp('nmlohism', 'his_keyemp', ws_key_men,wn_dsp_001);
	LABCONF.sp_glnewdsp('nmlohism', 'his_keydep', ws_key_men,wn_dsp_002);
	LABCONF.sp_glnewdsp('nmlohism', 'his_keypue', ws_key_men,wn_dsp_003);
	LABCONF.sp_glnewdsp('nmlohism', 'his_keycon', ws_key_men,wn_dsp_004);
	LABCONF.sp_glnewdsp('nmlohism', 'his_keyper', ws_key_men,wn_dsp_005);
	LABCONF.sp_glnewdsp('nmlohism', 'his_keynom', ws_key_men,wn_dsp_006);
	LABCONF.sp_glnewdsp('nmlohism', 'his_cantid', ws_key_men,wn_dsp_007);
	LABCONF.sp_glnewdsp('nmlohism', 'his_import', ws_key_men,wn_dsp_008);
	LABCONF.sp_glnewdsp('nmlohism', 'emp_tipemp', ws_key_men,wn_dsp_009);
	LABCONF.sp_glnewdsp('nmlohism', 'emp_keyloc', ws_key_men,wn_dsp_010);
	wn_num_reg:=0;
	wn_pct_act:=1;
	wn_pct_reg:=(wn_tot_reg/10);
	wn_emp_ant:=-999999999;
	ws_des_nom:='NOMINA NO EXISTE ..';
	BEGIN SELECT nom_destip
	INTO ws_des_nom FROM LABCONF.nmlonomi
	WHERE nom_keynom=wn_tip_nom;
EXCEPTION
 WHEN NO_DATA_FOUND THEN
  NULL;
  END;
  ws_des_nom:= SUBSTR(ws_des_nom,1,20);
	ws_des_pro:='PROCESO NO EXISTE..';
	BEGIN SELECT pro_despro
	INTO ws_des_pro FROM LABCONF.nmloproc
	WHERE pro_keypro=wn_key_pro;
EXCEPTION
 WHEN NO_DATA_FOUND THEN
  NULL;
  END;
  ws_des_li1:='No existe nombre del Reporte';
	BEGIN SELECT lis_deslis
	INTO ws_des_li1 FROM LABCONF.glcolist
	WHERE lis_keylis=ws_des_rep;
EXCEPTION
 WHEN NO_DATA_FOUND THEN
  NULL;
  END;
  ws_des_lis:= SUBSTR(ws_des_li1,1,40);
	ws_des_aux:= SUBSTR(ws_des_li1,41,9);
	ws_key_dep:= 'HHHHHHHHH';
	k:=1;
	FOR c_nmlstnom IN ( SELECT his_keyemp, his_keycon,  SUM(his_cantid ) alias3,  SUM(his_import ) alias4, his_codimp FROM LABCONF.nmlohism
	WHERE his_keyemp IN (
	SELECT ran_keyemp FROM LABCONF.glwkrang
	WHERE ran_nomrep=ws_nom_rep
	AND ran_idepcc=ws_ide_pcc
	AND ran_keyusu=wn_key_usu
	AND ran_keyemp IS NOT NULL )
	AND his_keypro=wn_key_pro
	AND his_keyper IN (
	SELECT ran_keyper FROM LABCONF.glwkrang
	WHERE ran_nomrep=ws_nom_rep
	AND ran_idepcc=ws_ide_pcc
	AND ran_keyusu=wn_key_usu
	AND ran_keyper IS NOT NULL )
	AND ((his_codimp IN ('01','02')) OR (his_keycon IN (ws_opc_003,ws_opc_004,ws_opc_005,ws_opc_006,ws_opc_007)))
	GROUP BY his_keyemp,his_keycon,his_cantid,his_import,his_codimp
	ORDER BY his_keyemp,his_codimp,his_keycon ) LOOP
		wn_key_emp :=c_nmlstnom.his_keyemp;
			ws_key_con :=c_nmlstnom.his_keycon;
			wn_can_mov :=c_nmlstnom.alias3;
			wn_imp_mov :=c_nmlstnom.alias4;
			ws_cod_imp :=c_nmlstnom.his_codimp;
			wn_num_reg:=(wn_num_reg+1);
	IF (wn_key_emp IS NULL ) THEN
	ws_nom_emp:='EMPLEADO NO EXISTE ..';
	ws_reg_rfc:='NO EXISTE ..';
	wn_sal_dia:=NULL;
	wn_sal_int:=NULL;
	ws_key_dep:='NO EXISTE';
	ws_key_pue:='NO EXISTE';
	 ELSE
	IF (wn_emp_ant!=wn_key_emp ) THEN
	i:=0;
	j:=0;
	k:=1;
	BEGIN SELECT emp_nomemp, emp_regrfc, emp_saldia, emp_salint, emp_keydep, emp_keypue, emp_tipemp, emp_keyims, emp_keyloc, emp_regims
	INTO ws_nom_emp, ws_reg_rfc, wn_sal_dia, wn_sal_int, ws_key_dep, ws_key_pue, ws_tip_emp, ws_key_ims, ws_key_loc, ws_reg_ims FROM LABCONF.nmcoempl
	WHERE emp_keyemp=wn_key_emp;
EXCEPTION
 WHEN NO_DATA_FOUND THEN
  NULL;
  END;
    ws_dep_his:=NULL;
	ws_pue_his:=NULL;
	ws_loc_his:=NULL;
	ws_reg_im1:= SUBSTR(ws_reg_ims,1,6);
	ws_reg_im2:= SUBSTR(ws_reg_ims,7,5);
	IF (ws_con_his IS NOT NULL  ) THEN
	BEGIN SELECT his_keydep, his_keypue, his_ca2aux
	INTO ws_dep_his, ws_pue_his, ws_loc_his FROM LABCONF.nmlohism
	WHERE his_keyemp=wn_key_emp
	AND his_keypro=wn_key_pro
	AND his_keycon=ws_con_his;
EXCEPTION
 WHEN NO_DATA_FOUND THEN
  NULL;
  END;
	IF ((ws_dep_his IS NOT NULL ) AND (ws_dep_his!='') ) THEN
	ws_key_dep:=ws_dep_his;
	ws_key_pue:=ws_pue_his;
	ws_key_loc:=ws_loc_his;
	END IF;
		END IF;
		ws_des_dep:='DEPARTAMENTO NO EXISTE';
	BEGIN SELECT dep_desdep
	INTO ws_des_dep FROM LABCONF.nmcodeps
	WHERE dep_keydep=ws_key_dep;
EXCEPTION
 WHEN NO_DATA_FOUND THEN
  NULL;
  END;
  ws_des_pue:='PUESTO NO EXISTE';
	BEGIN SELECT pue_despue
	INTO ws_des_pue FROM LABCONF.nmcopues
	WHERE pue_keypue=ws_key_pue;
EXCEPTION
 WHEN NO_DATA_FOUND THEN
  NULL;
  END;
  ws_des_loc:='LOCALIDAD NO EXISTE';
	BEGIN SELECT loc_desloc
	INTO ws_des_loc FROM LABCONF.nmlolocp
	WHERE loc_keyloc=ws_key_loc;
EXCEPTION
 WHEN NO_DATA_FOUND THEN
  NULL;
  END;
  ws_des_loc:= SUBSTR(ws_des_loc,1,16);
	wn_emp_ant:=wn_key_emp;
	ws_des_tip:='NO EXISTE';
	BEGIN SELECT pam_nompar
	INTO ws_des_tip FROM LABCONF.glcopams
	WHERE pam_keypar=ws_key_tab
	AND pam_cvesec=ws_tip_emp;
EXCEPTION
 WHEN NO_DATA_FOUND THEN
  NULL;
  END;
  ws_rfc_ims:='';
	BEGIN SELECT ims_rfcims
	INTO ws_rfc_ims FROM LABCONF.nmloimss
	WHERE ims_keyims=ws_key_ims;
EXCEPTION
 WHEN NO_DATA_FOUND THEN
  NULL;
  END;
  ws_rfc_uno:= SUBSTR(ws_rfc_ims,1,8);
	ws_rfc_dos:= SUBSTR(ws_rfc_ims,9,7);
	IF (wn_dsp_001=1 ) THEN
	wn_key_emp:=NULL;
	ws_nom_emp:=NULL;
	ws_reg_rfc:=NULL;
	wn_sal_dia:=NULL;
	wn_sal_int:=NULL;
	END IF;
	IF (wn_dsp_002=1 ) THEN
	ws_key_dep:=NULL;
	ws_des_dep:=NULL;
	END IF;
	IF (wn_dsp_003=1 ) THEN
	ws_key_pue:=NULL;
	ws_des_pue:=NULL;
	END IF;
	IF (wn_dsp_009=1 ) THEN
	ws_tip_emp:=NULL;
	ws_des_tip:=NULL;
	END IF;
	IF (wn_dsp_010=1 ) THEN
	ws_key_loc:=NULL;
	ws_des_loc:=NULL;
	END IF;
		END IF;
		END IF;
		ws_des_con:='CONCEPTO NO EXISTE..';
	BEGIN SELECT con_descor
	INTO ws_des_con FROM LABCONF.nmloconc
	WHERE con_keycon=ws_key_con;
EXCEPTION
 WHEN NO_DATA_FOUND THEN
  NULL;
  END;
	IF (ws_cod_imp='01' ) THEN
	IF (wn_dsp_004=1 ) THEN
	ws_key_con:=NULL;
	ws_des_con:=NULL;
	END IF;
	IF (wn_dsp_005=1 ) THEN
	wd_fec_ini:=NULL;
	wd_fec_fin:=NULL;
	END IF;
	IF (wn_dsp_006=1 ) THEN
	ws_des_nom:=NULL;
	END IF;
	IF (wn_dsp_007=1 ) THEN
	wn_can_mov:=NULL;
	END IF;
	IF (wn_dsp_008=1 ) THEN
	wn_imp_mov:=NULL;
	END IF;
		i:=(i+1);
	INSERT INTO LABCONF.glwkcrys( cry_nomrep,cry_idepcc,cry_keyusu,cry_numsec,cry_chr001,cry_dec006,cry_chr009,cry_chr017,cry_dat001,cry_dat002,cry_dec007,cry_chr002,cry_chr012,cry_chr013,cry_chr004,cry_chr014,cry_chr005,cry_dec011,cry_dec012,cry_chr018,cry_chr006,cry_dec001,cry_dec002,cry_chr019,cry_chr020,cry_chr021,cry_chr022,cry_chr023,cry_chr024,cry_chr025,cry_chr026,cry_chr027,cry_chr028,cry_dat003,cry_chr016,cry_chr029,cry_chr007,cry_dec003,cry_dec004,cry_chr015,cry_chr030,cry_dec008,cry_chr008,cry_chr033,cry_chr031,cry_chr010,cry_chr032,cry_chr034,cry_chr035,cry_chr036,cry_chr039,cry_chr044,cry_chr045,cry_chr042,cry_chr043,cry_chr037,cry_dec014,cry_dec016)
		VALUES(ws_nom_rep,ws_ide_pcc,wn_key_usu,i,ws_des_cor,wn_tip_nom,ws_des_nom,NULL,wd_fec_ini,wd_fec_fin,wn_key_emp,ws_nom_emp,ws_reg_rfc,ws_key_dep,ws_des_dep,ws_key_pue,ws_des_pue,wn_sal_dia,wn_sal_int,ws_key_con,ws_des_con,wn_can_mov,wn_imp_mov,ws_etq_001,ws_etq_002,ws_etq_003,ws_etq_004,ws_etq_005,ws_etq_006,ws_etq_007,ws_etq_008,ws_etq_009,ws_hor_act,ws_fec_act,ws_des_loc,NULL,NULL,NULL,NULL,ws_key_loc,ws_etq_010,wn_key_pro,ws_des_pro,ws_etq_012,ws_tip_emp,ws_des_tip,ws_etq_011,ws_etq_013,ws_rfc_uno,ws_rfc_dos,ws_key_ims,ws_rfc_c01,ws_rfc_c02,ws_reg_im1,ws_reg_im2,'NOMINA',wn_imp_mov,0); COMMIT;
		END IF;
	IF (ws_cod_imp='02' ) THEN
	IF (wn_dsp_004=1 ) THEN
	ws_key_con:=NULL;
	ws_des_con:=NULL;
	END IF;
	IF (wn_dsp_005=1 ) THEN
	wd_fec_ini:=NULL;
	wd_fec_fin:=NULL;
	END IF;
	IF (wn_dsp_006=1 ) THEN
	ws_des_nom:=NULL;
	END IF;
	IF (wn_dsp_007=1 ) THEN
	wn_can_mov:=NULL;
	END IF;
	IF (wn_dsp_008=1 ) THEN
	wn_imp_mov:=NULL;
	END IF;
		j:=(j+1);
	IF (j>i ) THEN
	INSERT INTO LABCONF.glwkcrys( cry_nomrep,cry_idepcc,cry_keyusu,cry_numsec,cry_chr001,cry_dec006,cry_chr009,cry_chr017,cry_dat001,cry_dat002,cry_dec007,cry_chr002,cry_chr012,cry_chr013,cry_chr004,cry_chr014,cry_chr005,cry_dec011,cry_dec012,cry_chr018,cry_chr006,cry_dec001,cry_dec002,cry_chr019,cry_chr020,cry_chr021,cry_chr022,cry_chr023,cry_chr024,cry_chr025,cry_chr026,cry_chr027,cry_chr028,cry_dat003,cry_chr016,cry_chr029,cry_chr007,cry_dec003,cry_dec004,cry_chr015,cry_chr030,cry_dec008,cry_chr008,cry_chr033,cry_chr031,cry_chr010,cry_chr032,cry_chr034,cry_chr035,cry_chr036,cry_chr039,cry_chr044,cry_chr045,cry_chr042,cry_chr043,cry_chr037,cry_dec014,cry_dec016)
		VALUES(ws_nom_rep,ws_ide_pcc,wn_key_usu,j,ws_des_cor,wn_tip_nom,ws_des_nom,NULL,wd_fec_ini,wd_fec_fin,wn_key_emp,ws_nom_emp,ws_reg_rfc,ws_key_dep,ws_des_dep,ws_key_pue,ws_des_pue,wn_sal_dia,wn_sal_int,NULL,NULL,NULL,NULL,ws_etq_001,ws_etq_002,ws_etq_003,ws_etq_004,ws_etq_005,ws_etq_006,ws_etq_007,ws_etq_008,ws_etq_009,ws_hor_act,ws_fec_act,ws_des_loc,ws_key_con,ws_des_con,wn_can_mov,wn_imp_mov,ws_key_loc,ws_etq_010,wn_key_pro,ws_des_pro,ws_etq_012,ws_tip_emp,ws_des_tip,ws_etq_011,ws_etq_013,ws_rfc_uno,ws_rfc_dos,ws_key_ims,ws_rfc_c01,ws_rfc_c02,ws_reg_im1,ws_reg_im2,'NOMINA',0,wn_imp_mov); COMMIT;
		 ELSE
	UPDATE LABCONF.glwkcrys SET cry_chr029=ws_key_con,cry_chr007=ws_des_con,cry_dec003=wn_can_mov,cry_dec004=wn_imp_mov,cry_dec016=wn_imp_mov
	WHERE cry_nomrep=ws_nom_rep
	AND cry_idepcc=ws_ide_pcc
	AND cry_keyusu=wn_key_usu
	AND cry_numsec=j
	AND cry_dec007=wn_key_emp
	AND cry_chr037='NOMINA'; COMMIT;
		END IF;
		END IF;
	IF (ws_cod_imp='03' ) THEN
	IF (wn_dsp_004=1 ) THEN
	ws_key_con:=NULL;
	ws_des_con:=NULL;
	END IF;
	IF (wn_dsp_005=1 ) THEN
	wd_fec_ini:=NULL;
	wd_fec_fin:=NULL;
	END IF;
	IF (wn_dsp_006=1 ) THEN
	ws_des_nom:=NULL;
	END IF;
	IF (wn_dsp_007=1 ) THEN
	wn_can_mov:=NULL;
	END IF;
	IF (wn_dsp_008=1 ) THEN
	wn_imp_mov:=NULL;
	END IF;
	IF (k=1 ) THEN
	INSERT INTO LABCONF.glwkcrys( cry_nomrep,cry_idepcc,cry_keyusu,cry_numsec,cry_chr001,cry_dec006,cry_chr009,cry_chr017,cry_dat001,cry_dat002,cry_dec007,cry_chr002,cry_chr012,cry_chr013,cry_chr004,cry_chr014,cry_chr005,cry_dec011,cry_dec012,cry_chr018,cry_chr006,cry_dec001,cry_dec002,cry_chr019,cry_chr020,cry_chr021,cry_chr022,cry_chr023,cry_chr024,cry_chr025,cry_chr026,cry_chr027,cry_chr028,cry_dat003,cry_chr016,cry_chr029,cry_chr007,cry_dec003,cry_dec004,cry_chr015,cry_chr030,cry_dec008,cry_chr008,cry_chr033,cry_chr031,cry_chr010,cry_chr032,cry_chr034,cry_chr035,cry_chr036,cry_chr039,cry_chr044,cry_chr045,cry_chr042,cry_chr043,cry_chr037,cry_dec014,cry_dec016)
		VALUES(ws_nom_rep,ws_ide_pcc,wn_key_usu,-1,ws_des_cor,wn_tip_nom,ws_des_nom,NULL,wd_fec_ini,wd_fec_fin,wn_key_emp,ws_nom_emp,ws_reg_rfc,ws_key_dep,ws_des_dep,ws_key_pue,ws_des_pue,wn_sal_dia,wn_sal_int,ws_key_con,ws_des_con,NULL,wn_imp_mov,ws_etq_001,ws_etq_002,ws_etq_003,ws_etq_004,ws_etq_005,ws_etq_006,ws_etq_007,ws_etq_008,ws_etq_009,ws_hor_act,ws_fec_act,ws_des_loc,NULL,NULL,NULL,NULL,ws_key_loc,ws_etq_010,wn_key_pro,ws_des_pro,ws_etq_012,ws_tip_emp,ws_des_tip,ws_etq_011,ws_etq_013,ws_rfc_uno,ws_rfc_dos,ws_key_ims,ws_rfc_c01,ws_rfc_c02,ws_reg_im1,ws_reg_im2,'AUXILIAR',0,0); COMMIT;
		END IF;
	IF (k=2 ) THEN
	UPDATE LABCONF.glwkcrys SET cry_chr029=ws_key_con,cry_dec004=wn_imp_mov,cry_dec003=NULL,cry_chr007=ws_des_con
	WHERE cry_nomrep=ws_nom_rep
	AND cry_idepcc=ws_ide_pcc
	AND cry_keyusu=wn_key_usu
	AND cry_numsec=-1
	AND cry_dec007=wn_key_emp
	AND cry_chr037='AUXILIAR'; COMMIT;
		END IF;
	IF (k=3 ) THEN
	UPDATE LABCONF.glwkcrys SET cry_chr011=ws_key_con,cry_dec015=wn_imp_mov,cry_chr003=ws_des_con
	WHERE cry_nomrep=ws_nom_rep
	AND cry_idepcc=ws_ide_pcc
	AND cry_keyusu=wn_key_usu
	AND cry_numsec=-1
	AND cry_dec007=wn_key_emp
	AND cry_chr037='AUXILIAR'; COMMIT;
		END IF;
	IF (k=4 ) THEN
	INSERT INTO LABCONF.glwkcrys( cry_nomrep,cry_idepcc,cry_keyusu,cry_numsec,cry_chr001,cry_dec006,cry_chr009,cry_chr017,cry_dat001,cry_dat002,cry_dec007,cry_chr002,cry_chr012,cry_chr013,cry_chr004,cry_chr014,cry_chr005,cry_dec011,cry_dec012,cry_chr018,cry_chr006,cry_dec001,cry_dec002,cry_chr019,cry_chr020,cry_chr021,cry_chr022,cry_chr023,cry_chr024,cry_chr025,cry_chr026,cry_chr027,cry_chr028,cry_dat003,cry_chr016,cry_chr029,cry_chr007,cry_dec003,cry_dec004,cry_chr015,cry_chr030,cry_dec008,cry_chr008,cry_chr033,cry_chr031,cry_chr010,cry_chr032,cry_chr034,cry_chr035,cry_chr036,cry_chr039,cry_chr044,cry_chr045,cry_chr042,cry_chr043,cry_chr037,cry_dec014,cry_dec016)
		VALUES(ws_nom_rep,ws_ide_pcc,wn_key_usu,0,ws_des_cor,wn_tip_nom,ws_des_nom,NULL,wd_fec_ini,wd_fec_fin,wn_key_emp,ws_nom_emp,ws_reg_rfc,ws_key_dep,ws_des_dep,ws_key_pue,ws_des_pue,wn_sal_dia,wn_sal_int,ws_key_con,ws_des_con,NULL,wn_imp_mov,ws_etq_001,ws_etq_002,ws_etq_003,ws_etq_004,ws_etq_005,ws_etq_006,ws_etq_007,ws_etq_008,ws_etq_009,ws_hor_act,ws_fec_act,ws_des_loc,NULL,NULL,NULL,NULL,ws_key_loc,ws_etq_010,wn_key_pro,ws_des_pro,ws_etq_012,ws_tip_emp,ws_des_tip,ws_etq_011,ws_etq_013,ws_rfc_uno,ws_rfc_dos,ws_key_ims,ws_rfc_c01,ws_rfc_c02,ws_reg_im1,ws_reg_im2,'AUXILIAR',0,0); COMMIT;
		END IF;
	IF (k=5 ) THEN
	UPDATE LABCONF.glwkcrys SET cry_chr029=ws_key_con,cry_dec004=wn_imp_mov,cry_dec003=NULL,cry_chr007=ws_des_con
	WHERE cry_nomrep=ws_nom_rep
	AND cry_idepcc=ws_ide_pcc
	AND cry_keyusu=wn_key_usu
	AND cry_numsec=0
	AND cry_dec007=wn_key_emp
	AND cry_chr037='AUXILIAR'; COMMIT;
		END IF;
		k:=(k+1);
	END IF;
	END LOOP;
	LABCONF.sp_glfechor(ws_fec_act, ws_hor_act);
	UPDATE LABCONF.glcoresu SET res_numreg=wn_num_reg,res_fecfin=ws_fec_act,res_horfin=ws_hor_act,res_status='T'
	WHERE res_idepro=ws_nom_rep
	AND res_idepcc=ws_ide_pcc
	AND res_keyusu=wn_key_usu
	AND res_fecini=ws_fec_act
	AND res_horreg=ws_hor_reg; COMMIT;
		END;
/
