CREATE OR REPLACE EDITIONABLE PROCEDURE "LABCONF"."SP_NMHCECA1" (ws_nom_rep IN VARCHAR2,ws_ide_pcc IN VARCHAR2,wn_key_usu IN  NUMBER,ws_key_men IN VARCHAR2,ws_hor_reg  IN VARCHAR2,ws_lis_per  IN VARCHAR2,ws_lis_pro IN VARCHAR2,ws_lis_dep IN VARCHAR2 ) IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
	wn_his_dep NUMBER(5);
		wn_sum_pro NUMBER(10);
		wn_sum_per NUMBER(10);
		wn_his_emp NUMBER(10);
		ws_his_con VARCHAR2(3);
		ws_his_per VARCHAR2(7);
		wn_his_pro NUMBER(5);
		ws_cod_imp VARCHAR2(2);
		ws_his_cia VARCHAR2(2);
		ws_des_pro VARCHAR2(20);
		ws_des_nom VARCHAR2(20);
		ws_des_not VARCHAR2(40);
		ws_des_con VARCHAR2(40);
		ws_des_cia VARCHAR2(60);
		wd_fec_ini DATE;
		wd_fec_fin DATE;
		ws_des_lis VARCHAR2(50);
		ws_key_cia VARCHAR2(5);
		ws_des_dep VARCHAR2(40);
		ws_key_cam VARCHAR2(10);
		ws_des_etq VARCHAR2(10);
		ws_des_etq1 VARCHAR2(40);
		ws_etq_001 VARCHAR2(10);
		ws_etq_002 VARCHAR2(10);
		ws_etq_003 VARCHAR2(10);
		ws_etq_004 VARCHAR2(40);
		ws_etq_005 VARCHAR2(40);
		ws_etq_006 VARCHAR2(10);
		ws_etq_007 VARCHAR2(40);
		ws_etq_008 VARCHAR2(16);
		ws_dsp_cam VARCHAR2(20);
		wn_dsp_001 NUMBER(5);
		wn_dsp_002 NUMBER(5);
		wn_dsp_003 NUMBER(5);
		wn_dsp_004 NUMBER(5);
		wn_dsp_005 NUMBER(5);
		wn_dsp_006 NUMBER(5);
		wn_ant_pro NUMBER(5);
		ws_ant_per VARCHAR2(7);
		ws_ant_con VARCHAR2(3);
		wn_ant_nom NUMBER(5);
		ws_ant_cod VARCHAR2(2);
		wn_pri_mer NUMBER(10);
		wn_ant_emp NUMBER(10);
		ws_ant_dep VARCHAR2(16);
		ws_his_dep VARCHAR2(16);
		wn_tot_reg NUMBER(10);
		wn_num_reg NUMBER(10);
		ws_hor_act VARCHAR2(8);
		ws_dia_act  DATE;
		wn_con_tar NUMBER(10);
		wn_tot_emp NUMBER(10);
		wn_tot_can NUMBER(18,2);
		wn_tot_imp NUMBER(18,2);
		wn_tot_tra NUMBER(10);
		wn_his_nom NUMBER(5);
		BEGIN
	LABCONF.sp_glfechor(ws_dia_act, ws_hor_act);
	wn_tot_reg:=0;
	INSERT INTO LABCONF.glcoresu( res_idepro,res_idepcc,res_keyusu,res_fecini,res_horini, res_horreg,res_totreg,res_status)
		VALUES(ws_nom_rep,ws_ide_pcc,wn_key_usu,ws_dia_act,ws_hor_act,ws_hor_reg,wn_tot_reg,'P'); COMMIT;
		DELETE FROM LABCONF.glwkcrys
	WHERE cry_nomrep = ws_nom_rep
	AND cry_idepcc = ws_ide_pcc
	AND cry_keyusu = wn_key_usu; COMMIT;
		ws_des_lis:='No existe nombre del Reporte';
	BEGIN SELECT lis_deslis
	INTO ws_des_lis FROM LABCONF.glcolist
	WHERE lis_keylis = ws_nom_rep;
EXCEPTION
 WHEN NO_DATA_FOUND THEN
  NULL;
  END;
  ws_etq_001:='----------';
	ws_etq_002:='----------';
	ws_etq_003:='----------';
	ws_etq_004:='----------';
	ws_etq_005:='----------';
	ws_etq_006:='----------';
	ws_etq_007:='----------';
	ws_etq_008:='----------';
	wn_his_dep:=0;
	wn_dsp_001:=0;
	wn_dsp_002:=0;
	wn_dsp_003:=0;
	wn_dsp_004:=0;
	wn_dsp_005:=0;
	wn_dsp_006:=0;
	ws_ant_con:='@@@';
	wn_ant_nom:=-9999;
	ws_ant_per:='@@@';
	wn_ant_pro:=-999;
	ws_ant_cod:='@@';
	ws_ant_dep:='@@@@';
	ws_his_cia:='..';
	wn_num_reg:=0;
	wn_con_tar:=0;
	wn_tot_can:=0;
	wn_tot_imp:=0;
	wn_tot_tra:=0;
	wn_pri_mer:=0;
	wn_tot_tra:=0;
	FOR c_etiqueta IN ( SELECT cam_keycam, cam_descor FROM LABCONF.glcocamp
	WHERE cam_keytab = 'nmlohism' ) LOOP
		ws_key_cam :=c_etiqueta.cam_keycam;
			ws_des_etq :=c_etiqueta.cam_descor;
	IF (ws_key_cam='his_keypro' ) THEN
	ws_etq_001:=ws_des_etq;
	END IF;
	IF (ws_key_cam='his_keyper' ) THEN
	ws_etq_002:=ws_des_etq;
	END IF;
	IF (ws_key_cam='his_keycon' ) THEN
	ws_etq_003:=ws_des_etq;
	END IF;
	IF (ws_key_cam='his_ca1aux' ) THEN
	ws_etq_008:=ws_des_etq;
	END IF;
	IF (ws_key_cam='his_cantid' ) THEN
	ws_etq_004:=ws_des_etq;
	END IF;
	IF (ws_key_cam='his_import' ) THEN
	ws_etq_005:=ws_des_etq;
	END IF;
	END LOOP;
	FOR c_etiqueta2 IN ( SELECT cam_keycam, cam_descam FROM LABCONF.glcocamp
	WHERE cam_keytab = 'nmloconc' ) LOOP
		ws_key_cam :=c_etiqueta2.cam_keycam;
			ws_des_etq1 :=c_etiqueta2.cam_descam;
	IF (ws_key_cam='con_descon' ) THEN
	ws_etq_007:=ws_des_etq1;
	END IF;
	END LOOP;
	FOR c_des_nom IN ( SELECT cam_keycam, cam_descor FROM LABCONF.glcocamp
	WHERE cam_keytab = 'nmlonomi' ) LOOP
		ws_key_cam :=c_des_nom.cam_keycam;
			ws_des_etq :=c_des_nom.cam_descor;
	IF (ws_key_cam='nom_keynom' ) THEN
	ws_etq_006:=ws_des_etq;
	END IF;
	END LOOP;
	FOR c_desplieg IN ( SELECT rec_keycam, rec_despli FROM LABCONF.glcoreca
	WHERE rec_keytab = 'nmlohism'
	AND rec_keymen = ws_key_men ) LOOP
		ws_key_cam :=c_desplieg.rec_keycam;
			ws_des_etq1 :=c_desplieg.rec_despli;
	IF ((ws_key_cam='ms_his_pro') AND (ws_dsp_cam='N') ) THEN
	wn_dsp_001:=1;
	END IF;
	IF ((ws_key_cam='ws_his_per') AND (ws_dsp_cam='N') ) THEN
	wn_dsp_002:=1;
	END IF;
	IF ((ws_key_cam='wn_his_con') AND (ws_dsp_cam='N') ) THEN
	wn_dsp_003:=1;
	END IF;
	IF ((ws_key_cam='wn_tot_can') AND (ws_dsp_cam='N') ) THEN
	wn_dsp_004:=1;
	END IF;
	IF ((ws_key_cam='wn_tot_imp') AND (ws_dsp_cam='N') ) THEN
	wn_dsp_005:=1;
	END IF;
	END LOOP;
	FOR c_nmlsthis IN ( SELECT his_keypro, his_keyper, his_ca1aux, his_codimp, his_keycon,  SUM(his_cantid ) alias6,  SUM(his_import ) alias7,  COUNT(* ) alias8
	FROM LABCONF.nmlohism
	WHERE his_keypro IN (
	SELECT ran_keypro FROM LABCONF.glwkrang
	WHERE ran_nomrep = ws_nom_rep
	AND ran_idepcc = ws_ide_pcc
	AND ran_keyusu = wn_key_usu
	AND ran_keypro IS NOT NULL )
	AND his_keyper IN (
	SELECT ran_keyper FROM LABCONF.glwkrang
	WHERE ran_nomrep = ws_nom_rep
	AND ran_idepcc = ws_ide_pcc
	AND ran_keyusu = wn_key_usu
	AND ran_keydep IS NOT NULL )
	AND his_ca1aux IN (
	SELECT ran_keydep FROM LABCONF.glwkrang
	WHERE ran_nomrep = ws_nom_rep
	AND ran_idepcc = ws_ide_pcc
	AND ran_keyusu = wn_key_usu
	AND ran_keyper IS NOT NULL )
	GROUP BY his_ca1aux, his_keypro, his_keyper, his_codimp, his_keycon
	ORDER BY his_ca1aux, his_keypro, his_keyper, his_codimp, his_keycon ) LOOP
			wn_his_pro :=c_nmlsthis.his_keypro;
			ws_his_per :=c_nmlsthis.his_keyper;
			ws_his_dep :=c_nmlsthis.his_ca1aux;
			ws_cod_imp :=c_nmlsthis.his_codimp;
			ws_his_con :=c_nmlsthis.his_keycon;
			wn_tot_can :=c_nmlsthis.alias6;
			wn_tot_imp :=c_nmlsthis.alias7;
			wn_con_tar :=c_nmlsthis.alias8;
	IF ((ws_his_dep IS NULL) AND (ws_ant_dep=1) ) THEN
	wn_his_dep:=1;
	BEGIN SELECT  COUNT( DISTINCT his_keyemp ) alias1
	INTO wn_his_emp FROM LABCONF.nmlohism
	WHERE his_keyper IN (
	SELECT ran_keyper FROM LABCONF.glwkrang
	WHERE ran_nomrep = ws_nom_rep
	AND ran_idepcc = ws_ide_pcc
	AND ran_keyusu = wn_key_usu
	AND ran_keydep IS NOT NULL )
	AND his_keypro IN (
	SELECT ran_keypro FROM LABCONF.glwkrang
	WHERE ran_nomrep = ws_nom_rep
	AND ran_idepcc = ws_ide_pcc
	AND ran_keyusu = wn_key_usu
	AND ran_keypro IS NOT NULL )
	AND his_ca1aux IS NULL;
EXCEPTION
 WHEN NO_DATA_FOUND THEN
  NULL;
  END;
  BEGIN SELECT  COUNT( DISTINCT his_keyemp ) alias1
	INTO wn_sum_pro FROM LABCONF.nmlohism
	WHERE his_keyper IN (
	SELECT ran_keyper FROM LABCONF.glwkrang
	WHERE ran_nomrep = ws_nom_rep
	AND ran_idepcc = ws_ide_pcc
	AND ran_keyusu = wn_key_usu
	AND ran_keydep IS NOT NULL )
	AND his_keypro = wn_his_pro
	AND his_ca1aux IS NULL;
EXCEPTION
 WHEN NO_DATA_FOUND THEN
  NULL;
  END;
  BEGIN SELECT  COUNT( DISTINCT his_keyemp ) alias1
	INTO wn_sum_per FROM LABCONF.nmlohism
	WHERE his_keyper = ws_his_per
	AND his_keypro = wn_his_pro
	AND his_ca1aux IS NULL;
EXCEPTION
 WHEN NO_DATA_FOUND THEN
  NULL;
  END;
   ELSE
	IF (ws_his_dep != ws_ant_dep ) THEN
	BEGIN SELECT  COUNT( DISTINCT his_keyemp ) alias1
	INTO wn_his_emp FROM LABCONF.nmlohism
	WHERE his_keyper IN (
	SELECT ran_keyper FROM LABCONF.glwkrang
	WHERE ran_nomrep = ws_nom_rep
	AND ran_idepcc = ws_ide_pcc
	AND ran_keyusu = wn_key_usu
	AND ran_keydep IS NOT NULL )
	AND his_keypro IN (
	SELECT ran_keypro FROM LABCONF.glwkrang
	WHERE ran_nomrep = ws_nom_rep
	AND ran_idepcc = ws_ide_pcc
	AND ran_keyusu = wn_key_usu
	AND ran_keypro IS NOT NULL )
	AND his_ca1aux = ws_his_dep;
EXCEPTION
 WHEN NO_DATA_FOUND THEN
  NULL;
  END;
  BEGIN SELECT  COUNT( DISTINCT his_keyemp ) alias1
	INTO wn_sum_pro FROM LABCONF.nmlohism
	WHERE his_keyper IN (
	SELECT ran_keyper FROM LABCONF.glwkrang
	WHERE ran_nomrep = ws_nom_rep
	AND ran_idepcc = ws_ide_pcc
	AND ran_keyusu = wn_key_usu
	AND ran_keydep IS NOT NULL )
	AND his_keypro = wn_his_pro
	AND his_ca1aux = ws_his_dep;
EXCEPTION
 WHEN NO_DATA_FOUND THEN
  NULL;
  END;
  BEGIN SELECT  COUNT( DISTINCT his_keyemp ) alias1
	INTO wn_sum_per FROM LABCONF.nmlohism
	WHERE his_keyper = ws_his_per
	AND his_keypro = wn_his_pro
	AND his_ca1aux = ws_his_dep;
EXCEPTION
 WHEN NO_DATA_FOUND THEN
  NULL;
  END;
   ELSE
	IF (wn_his_pro != wn_ant_pro ) THEN
	BEGIN SELECT  COUNT( DISTINCT his_keyemp ) alias1
	INTO wn_sum_pro FROM LABCONF.nmlohism
	WHERE his_keyper IN (
	SELECT ran_keyper FROM LABCONF.glwkrang
	WHERE ran_nomrep = ws_nom_rep
	AND ran_idepcc = ws_ide_pcc
	AND ran_keyusu = wn_key_usu
	AND ran_keydep IS NOT NULL )
	AND his_keypro = wn_his_pro
	AND his_ca1aux = ws_his_dep;
EXCEPTION
 WHEN NO_DATA_FOUND THEN
  NULL;
  END;
  BEGIN SELECT  COUNT( DISTINCT his_keyemp ) alias1
	INTO wn_sum_per FROM LABCONF.nmlohism
	WHERE his_keyper = ws_his_per
	AND his_keypro = wn_his_pro
	AND his_ca1aux = ws_his_dep;
EXCEPTION
 WHEN NO_DATA_FOUND THEN
  NULL;
  END;
   ELSE
	IF (ws_his_per != ws_ant_per ) THEN
	BEGIN SELECT  COUNT( DISTINCT his_keyemp ) alias1
	INTO wn_sum_per FROM LABCONF.nmlohism
	WHERE his_keyper = ws_his_per
	AND his_keypro = wn_his_pro
	AND his_ca1aux = ws_his_dep;
EXCEPTION
 WHEN NO_DATA_FOUND THEN
  NULL;
  END;
  END IF;
		END IF;
		END IF;
		END IF;
	IF (ws_ant_dep IS NULL ) THEN
	ws_des_dep:='No Existe Departamento';
	 ELSE
	IF (ws_ant_dep != ws_his_dep ) THEN
	ws_des_dep:='No Existe';
	sp_nomdes(ws_his_dep, 1,ws_des_dep);
	ws_ant_dep:=ws_his_dep;
	END IF;
		END IF;
	IF (wn_ant_pro IS NULL ) THEN
	ws_des_cia:='Compania No existe...';
	ws_his_cia:='..';
	ws_des_pro:='No Existe Proceso...';
	 ELSE
	IF (wn_ant_pro != wn_his_pro ) THEN
	ws_des_pro:='No Existe Proceso...';
	ws_his_cia:='..';
	BEGIN SELECT pro_despro, pro_keycia
	INTO ws_des_pro, ws_his_cia FROM LABCONF.nmloproc
	WHERE pro_keypro = wn_his_pro;
EXCEPTION
 WHEN NO_DATA_FOUND THEN
  NULL;
  END;
  ws_des_cia:='Compania No existe...';
	BEGIN SELECT cia_descia
	INTO ws_des_cia FROM LABCONF.nmlocias
	WHERE cia_keycia = ws_his_cia;
EXCEPTION
 WHEN NO_DATA_FOUND THEN
  NULL;
  END;
  wn_ant_pro:=wn_his_pro;
	END IF;
		END IF;
	IF (ws_ant_con IS NULL ) THEN
	ws_des_con:='No Existe Concepto...';
	 ELSE
	IF (ws_ant_con != ws_his_con ) THEN
	ws_des_con:='No Existe Concepto...';
	BEGIN SELECT con_descon
	INTO ws_des_con FROM LABCONF.nmloconc
	WHERE con_keycon = ws_his_con;
EXCEPTION
 WHEN NO_DATA_FOUND THEN
  NULL;
  END;
  ws_ant_con:=ws_his_con;
	END IF;
		END IF;
	IF (ws_ant_cod != ws_cod_imp ) THEN
	ws_ant_cod:=ws_cod_imp;
	END IF;
	IF (ws_ant_per IS NULL ) THEN
	wd_fec_ini:=ws_dia_act;
	wd_fec_fin:=ws_dia_act;
	 ELSE
	IF (ws_ant_per != ws_his_per ) THEN
	wd_fec_ini:=ws_dia_act;
	wd_fec_fin:=ws_dia_act;
	BEGIN SELECT per_fecini, per_fecfin, per_keynom
	INTO wd_fec_ini, wd_fec_fin, wn_his_nom FROM LABCONF.nmloperi
	WHERE  per_keyper = ws_his_per
	AND per_keypro = wn_his_pro;
EXCEPTION
 WHEN NO_DATA_FOUND THEN
  NULL;
  END;
  ws_ant_per:=ws_his_per;
	END IF;
		END IF;
	IF (wn_ant_nom IS NULL ) THEN
	ws_des_nom:='No Existe Nomina.';
	 ELSE
	IF (wn_ant_nom != wn_his_nom ) THEN
	ws_des_nom:='No Existe Nomina...';
	BEGIN SELECT nom_destip
	INTO ws_des_not FROM LABCONF.nmlonomi
	WHERE nom_keynom = wn_his_nom;
EXCEPTION
 WHEN NO_DATA_FOUND THEN
  NULL;
  END;
  wn_ant_nom:=wn_his_nom;
	ws_des_nom:= SUBSTR(ws_des_not,1,20);
	END IF;
		END IF;
	IF (wn_dsp_001=1 ) THEN
	wn_his_pro:=Null;
	END IF;
	IF (wn_dsp_002=1 ) THEN
	ws_his_per:=Null;
	END IF;
	IF (wn_dsp_003=1 ) THEN
	ws_his_con:=Null;
	END IF;
	IF (wn_dsp_004=1 ) THEN
	wn_tot_can:=Null;
	END IF;
	IF (wn_dsp_005=1 ) THEN
	wn_tot_imp:=Null;
	END IF;
	IF (wn_dsp_006=1 ) THEN
	ws_his_dep:=Null;
	END IF;
	IF (wn_tot_can IS NULL ) THEN
	wn_tot_can:=0;
	END IF;
	IF (wn_tot_imp IS NULL ) THEN
	wn_tot_imp:=0;
	END IF;
	IF ((wn_tot_can != 0) OR (wn_tot_imp != 0) ) THEN
	INSERT INTO LABCONF.glwkcrys( cry_nomrep,cry_idepcc,cry_keyusu,cry_chr001,cry_chr008,cry_chr004,cry_chr017,cry_chr018,cry_chr019,cry_chr009,cry_chr010,cry_chr022,cry_chr024,cry_chr025,cry_chr005,cry_dec001,cry_dec002,cry_dec006,cry_chr026,cry_dec008,cry_dec009,cry_dat001,cry_dat002,cry_dat003,cry_chr027,cry_chr002,cry_chr028,cry_chr011,cry_dec010,cry_chr006,cry_chr007,cry_chr003,cry_dec007,cry_chr014,cry_chr015,cry_dec011,cry_dec012)
		VALUES(ws_nom_rep,ws_ide_pcc,wn_key_usu,ws_des_cia,ws_des_pro,ws_des_nom,ws_etq_001,ws_etq_002,ws_etq_003,ws_etq_007,ws_etq_004,ws_etq_006,ws_hor_act,ws_ant_con,ws_des_con,wn_tot_can,wn_tot_imp,wn_his_pro,ws_his_per,wn_his_nom,wn_con_tar,wd_fec_ini,wd_fec_fin,ws_dia_act,ws_ant_cod,ws_lis_per,ws_his_cia,ws_etq_005,wn_his_emp,ws_lis_pro,ws_des_dep,ws_des_lis,wn_his_emp,ws_ant_dep,ws_etq_008,wn_sum_pro,wn_sum_per); COMMIT;
		END IF;
	END LOOP;
	ws_hor_act:=ws_hor_act;
	UPDATE LABCONF.glcoresu SET  res_numreg=wn_num_reg,res_fecfin=ws_dia_act,res_horfin=ws_hor_act, res_status ='T'
	WHERE res_idepro = ws_nom_rep
	AND res_idepcc = ws_ide_pcc
	AND res_keyusu = wn_key_usu
	AND res_fecini = ws_dia_act
	AND res_horreg = ws_hor_reg; COMMIT;
END;
/
