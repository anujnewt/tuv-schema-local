CREATE OR REPLACE NONEDITIONABLE PROCEDURE "LABCONF"."SP_NMLSTHIS" (ws_nom_rep IN VARCHAR2,ws_ide_pcc IN VARCHAR2,wn_key_usu IN  NUMBER,ws_key_men IN VARCHAR2,ws_hor_reg IN VARCHAR2,ws_lis_per IN VARCHAR2,ws_lis_pro IN VARCHAR2 ) IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
	wn_mov_pro NUMBER(5);
		wn_his_emp NUMBER(10);
		ws_his_con VARCHAR2(3);
		wn_his_nom NUMBER(5);
		ws_his_per VARCHAR2(7);
		wn_his_pro NUMBER(5);
		ws_cod_imp VARCHAR2(2);
		ws_des_pro VARCHAR2(20);
		ws_des_nom VARCHAR2(40);
		ws_des_con VARCHAR2(40);
		ws_des_cor VARCHAR2(100);
		ws_des_cia VARCHAR2(100);
		wd_fec_ini DATE;
		wd_fec_fin DATE;
		ws_des_lis VARCHAR2(50);
		ws_key_cia VARCHAR2(5);
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
		wn_tot_reg NUMBER(10);
		wn_num_reg NUMBER(10);
		ws_hor_act VARCHAR2(8);
		ws_fec_act DATE;
		ws_dia_act DATE;
		wn_con_tar NUMBER(10);
		wn_tot_emp NUMBER(10);
		wn_tot_can NUMBER(18,2);
		wn_tot_imp NUMBER(18,2);
		wn_tot_tra NUMBER(10);
		BEGIN
	BEGIN SELECT  COUNT(* ) alias1
	INTO wn_tot_reg FROM LABCONF.nmloperi
	WHERE per_keypro IN (
	SELECT ran_keypro FROM LABCONF.glwkrang
	WHERE ran_nomrep = ws_nom_rep
	AND ran_idepcc = ws_ide_pcc
	AND ran_keyusu = wn_key_usu
	AND ran_keypro IS NOT NULL )
	AND per_keyper IN (
	SELECT ran_keyper FROM LABCONF.glwkrang
	WHERE ran_nomrep = ws_nom_rep
	AND ran_idepcc = ws_ide_pcc
	AND ran_keyusu = wn_key_usu
	AND ran_keypro IS NOT NULL );
EXCEPTION
 WHEN NO_DATA_FOUND THEN
  NULL;
  END;
  LABCONF.sp_glfechor(ws_fec_act, ws_hor_act);
	wn_tot_reg:=-1;
	ws_dia_act:=ws_fec_act;
	DELETE FROM LABCONF.glwkcrys
	WHERE cry_nomrep = ws_nom_rep
	AND cry_idepcc = ws_ide_pcc
	AND cry_keyusu = wn_key_usu; COMMIT;
		ws_des_lis:='No existe nombre del Reporte';
	BEGIN SELECT lis_deslis
	INTO ws_des_lis FROM LABCONF.glcolist
	WHERE lis_keylis = 'nmcifhis';
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
	ws_etq_007:='........';
	FOR c_etiqueta IN ( SELECT cam_keycam, cam_descor FROM LABCONF.glcocamp
	WHERE cam_keytab IN ('nmlonomi','nmlohism') ) LOOP
		ws_key_cam :=c_etiqueta.cam_keycam;
			ws_des_etq :=c_etiqueta.cam_descor;
	IF (ws_key_cam='his_keypro' ) THEN
	ws_etq_001:=ws_des_etq;
	 ELSE
	IF (ws_key_cam='his_keyper' ) THEN
	ws_etq_002:=ws_des_etq;
	 ELSE
	IF (ws_key_cam='his_keycon' ) THEN
	ws_etq_003:=ws_des_etq;
	 ELSE
	IF (ws_key_cam='his_cantid' ) THEN
	ws_etq_004:=ws_des_etq;
	 ELSE
	IF (ws_key_cam='his_import' ) THEN
	ws_etq_005:=ws_des_etq;
	 ELSE
	IF (ws_key_cam='his_keynom' ) THEN
	ws_etq_006:=ws_des_etq;
	 ELSE
	IF (ws_key_cam='nom_destip' ) THEN
	ws_etq_007:=ws_des_etq;
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
	LABCONF.sp_glGetDsp('nmwkmovt', 'mov_keypro', ws_key_men,wn_dsp_001);
	LABCONF.sp_glGetDsp('nmwkmovt', 'mov_keyper', ws_key_men,wn_dsp_002);
	LABCONF.sp_glGetDsp('nmwkmovt', 'mov_keycon', ws_key_men,wn_dsp_003);
	LABCONF.sp_glGetDsp('nmwkmovt', 'mov_cantid', ws_key_men,wn_dsp_004);
	LABCONF.sp_glGetDsp('nmwkmovt', 'mov_import', ws_key_men,wn_dsp_005);
	LABCONF.sp_glGetDsp('nmwkmovt', 'mov_keynom', ws_key_men,wn_dsp_006);
	ws_ant_con:='@@@';
	wn_ant_nom:=-9999;
	ws_ant_per:='@@@';
	wn_ant_pro:=-9999;
	ws_ant_cod:='@@';
	ws_key_cia:='..';
	wn_num_reg:=0;
	wn_con_tar:=0;
	wn_tot_can:=0;
	wn_tot_imp:=0;
	wn_pri_mer:=0;
	wn_his_emp:=-999999;
	BEGIN SELECT  COUNT( DISTINCT his_keyemp ) alias1
	INTO wn_his_emp FROM LABCONF.nmlohism
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
	AND ran_keypro IS NOT NULL );
EXCEPTION
 WHEN NO_DATA_FOUND THEN
  NULL;
  END;
  FOR c_nmlstcic IN ( SELECT his_keycon,  SUM(his_cantid ) alias2,  SUM(his_import ) alias3, his_keypro, his_keyper, his_codimp,  COUNT(* ) alias7
    FROM LABCONF.nmlohism
	WHERE his_keypro IN (
	SELECT ran_keypro FROM LABCONF.glwkrang
	WHERE ran_nomrep = ws_nom_rep
	AND ran_idepcc = ws_ide_pcc
	AND ran_keyusu = wn_key_usu)
	AND his_keyper IN (
	SELECT ran_keyper FROM LABCONF.glwkrang
	WHERE ran_nomrep = ws_nom_rep
	AND ran_idepcc = ws_ide_pcc
	AND ran_keyusu = wn_key_usu)
	GROUP BY his_keypro,his_keyper,his_codimp,his_keycon
	ORDER BY his_keypro,his_keyper,his_codimp,his_keycon ) LOOP
		ws_his_con :=c_nmlstcic.his_keycon;
			wn_tot_can :=c_nmlstcic.alias2;
			wn_tot_imp :=c_nmlstcic.alias3;
			wn_his_pro :=c_nmlstcic.his_keypro;
			ws_his_per :=c_nmlstcic.his_keyper;
			ws_cod_imp :=c_nmlstcic.his_codimp;
			wn_con_tar :=c_nmlstcic.alias7;
	IF (wn_pri_mer=0 ) THEN
	ws_des_cor:='CORPORATIVO NO REGISTRADO';
	ws_key_cia:='*';
	BEGIN SELECT pro_keycia
	INTO ws_key_cia FROM LABCONF.nmloproc
	WHERE pro_keypro = wn_his_pro;
EXCEPTION
 WHEN NO_DATA_FOUND THEN
  NULL;
  END;
  BEGIN SELECT cia_descia
	INTO ws_des_cor FROM LABCONF.nmlocias
	WHERE cia_keycia = ws_key_cia;
EXCEPTION
 WHEN NO_DATA_FOUND THEN
  NULL;
  END;
  wn_pri_mer:=(wn_pri_mer+1);
	END IF;
	IF (wn_ant_pro IS NULL ) THEN
	ws_des_cia:='Compania No existe..';
	ws_des_cor:='Compania No existe..';
	ws_key_cia:='..';
	ws_des_pro:='No existe Proceso..';
	 ELSE
	IF (wn_ant_pro != wn_his_pro ) THEN
	ws_des_pro:='No Existe Proceso';
	ws_key_cia:='..';
	wn_ant_pro:=wn_his_pro;
	BEGIN SELECT pro_despro, pro_keycia
	INTO ws_des_pro, ws_key_cia FROM LABCONF.nmloproc
	WHERE pro_keypro = wn_his_pro;
EXCEPTION
 WHEN NO_DATA_FOUND THEN
  NULL;
  END;
  ws_des_cia:='Compania No existe..';
	ws_des_cor:='Compania No existe..';
	BEGIN SELECT cia_descia
	INTO ws_des_cor FROM LABCONF.nmlocias
	WHERE cia_keycia = ws_key_cia;
EXCEPTION
 WHEN NO_DATA_FOUND THEN
  NULL;
  END;
  ws_des_cia:=ws_des_cor;
	BEGIN SELECT  COUNT( DISTINCT his_keyemp ) alias1
	INTO wn_tot_emp FROM LABCONF.nmlohism
	WHERE his_keypro = wn_his_pro
	AND his_keyper = ws_his_per;
EXCEPTION
 WHEN NO_DATA_FOUND THEN
  NULL;
  END;
  END IF;
		END IF;
	IF (ws_ant_con IS NULL ) THEN
	ws_des_con:='No Existe Concepto ..';
	 ELSE
	IF (ws_ant_con != ws_his_con ) THEN
	ws_des_con:='No Existe Concepto ..';
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
	LABCONF.sp_glfechor(wd_fec_ini, ws_hor_act);
	wd_fec_fin:=wd_fec_ini;
	 ELSE
	IF (ws_ant_per != ws_his_per ) THEN
	LABCONF.sp_glfechor(wd_fec_ini, ws_hor_act);
	wd_fec_fin:=wd_fec_ini;
	BEGIN SELECT per_fecini, per_fecfin, per_keynom
	INTO wd_fec_ini, wd_fec_fin, wn_his_nom FROM LABCONF.nmloperi
	WHERE per_keyper = ws_his_per
	AND per_keypro = wn_his_pro;
EXCEPTION
 WHEN NO_DATA_FOUND THEN
  NULL;
  END;
  BEGIN SELECT  COUNT( DISTINCT his_keyemp ) alias1
	INTO wn_tot_emp FROM LABCONF.nmlohism
	WHERE his_keypro = wn_his_pro
	AND his_keyper = ws_his_per;
EXCEPTION
 WHEN NO_DATA_FOUND THEN
  NULL;
  END;
  ws_ant_per:=ws_his_per;
	END IF;
		END IF;
	IF (wn_ant_nom IS NULL ) THEN
	ws_des_nom:='No Existe Nomina ..';
	 ELSE
	IF (wn_ant_nom != wn_his_nom ) THEN
	ws_des_nom:='No Existe Nomina..';
	BEGIN SELECT nom_destip
	INTO ws_des_nom FROM LABCONF.nmlonomi
	WHERE nom_keynom = wn_his_nom;
EXCEPTION
 WHEN NO_DATA_FOUND THEN
  NULL;
  END;
  wn_ant_nom:=wn_his_nom;
	END IF;
		END IF;
	IF (wn_dsp_001=1 ) THEN
	wn_his_pro:=NULL;
	END IF;
	IF (wn_dsp_002=1 ) THEN
	ws_his_per:=NULL;
	END IF;
	IF (wn_dsp_003=1 ) THEN
	ws_his_con:=NULL;
	END IF;
	IF (wn_dsp_004=1 ) THEN
	wn_tot_can:=NULL;
	END IF;
	IF (wn_dsp_005=1 ) THEN
	wn_tot_imp:=NULL;
	END IF;
	IF ((wn_tot_can IS NULL) OR (wn_tot_can IS NULL) ) THEN
	wn_tot_can:=0;
	END IF;
	IF ((wn_tot_imp IS NULL) OR (wn_tot_imp IS NULL) ) THEN
	wn_tot_can:=0;
	END IF;
	IF ((wn_tot_can != 0) OR (wn_tot_imp != 0) AND (wn_tot_can IS NOT NULL ) OR (wn_tot_imp IS NOT NULL ) ) THEN
	INSERT INTO LABCONF.glwkcrys( cry_nomrep,cry_idepcc,cry_keyusu,cry_chr001,cry_chr008,cry_chr004,cry_chr017,cry_chr018,cry_chr019,cry_chr009,cry_chr010,cry_chr022,cry_chr024,cry_chr025,cry_chr005,cry_dec001,cry_dec002,cry_dec006,cry_chr026,cry_dec008,cry_dec009,cry_dat001,cry_dat002,cry_dat003,cry_chr027,cry_chr002,cry_chr028,cry_chr011,cry_dec010,cry_chr006,cry_chr007,cry_chr003,cry_dec007)
		VALUES(ws_nom_rep,ws_ide_pcc,wn_key_usu,substr(ws_des_cor,1,60), ws_des_pro,ws_des_nom,ws_etq_001,ws_etq_002,ws_etq_003,ws_etq_004,ws_etq_005,ws_etq_006,ws_hor_act,ws_ant_con,ws_des_con,wn_tot_can,wn_tot_imp,wn_his_pro,ws_his_per,wn_his_nom,wn_con_tar,wd_fec_ini,wd_fec_fin,ws_dia_act,ws_ant_cod,substr(ws_des_cia,1,60),ws_key_cia,ws_etq_007,wn_tot_emp,ws_lis_pro,ws_lis_per,ws_des_lis,wn_his_emp); COMMIT;
		END IF;
	END LOOP;
END;
/
