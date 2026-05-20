CREATE OR REPLACE NONEDITIONABLE PROCEDURE "LABPROD"."SP_NMCIHDEP" (ws_nom_rep IN VARCHAR2,ws_ide_pcc IN VARCHAR2,ws_key_usu IN  NUMBER,ws_key_men IN VARCHAR2,ws_hor_reg IN VARCHAR2,ws_lis_per IN VARCHAR2,ws_dep_pri IN VARCHAR2,ws_key_est IN VARCHAR2 ) IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
	wn_mov_emp NUMBER(10);
		ws_mov_con VARCHAR2(3);
		wn_mov_nom NUMBER(5);
		ws_mov_per VARCHAR2(7);
		wn_mov_pro NUMBER(5);
		ws_cod_imp VARCHAR2(2);
		ws_mov_cia VARCHAR2(2);
		ws_cod_niv VARCHAR2(80);
		ws_cod_pri VARCHAR2(80);
		ws_key_dep VARCHAR2(16);
		ws_des_pro VARCHAR2(20);
		ws_des_dep VARCHAR2(40);
		ws_des_nom VARCHAR2(20);
		ws_des_con VARCHAR2(40);
		ws_des_cor VARCHAR2(60);
		ws_des_cia VARCHAR2(60);
		wd_fec_ini DATE;
		wd_fec_fin DATE;
		ws_lis_pro VARCHAR2(50);
		ws_lis_pr2 VARCHAR2(16);
		ws_lis_pr3 VARCHAR2(16);
		ws_lis_nom VARCHAR2(40);
		ws_des_lis VARCHAR2(50);
		ws_key_cia VARCHAR2(5);
		ws_key_cam VARCHAR2(10);
		ws_des_etq VARCHAR2(10);
		ws_etq_001 VARCHAR2(10);
		ws_etq_002 VARCHAR2(10);
		ws_etq_003 VARCHAR2(10);
		ws_etq_004 VARCHAR2(40);
		ws_etq_005 VARCHAR2(40);
		ws_etq_006 VARCHAR2(10);
		ws_etq_007 VARCHAR2(40);
		ws_etq_008 VARCHAR2(40);
		ws_dsp_cam VARCHAR2(20);
		wn_dsp_001 NUMBER(5);
		wn_dsp_002 NUMBER(5);
		wn_dsp_003 NUMBER(5);
		wn_dsp_004 NUMBER(5);
		wn_dsp_005 NUMBER(5);
		wn_dsp_006 NUMBER(5);
		wn_dsp_007 NUMBER(5);
		wn_ant_pro NUMBER(5);
		ws_ant_per VARCHAR2(7);
		ws_ant_con VARCHAR2(3);
		wn_ant_nom NUMBER(5);
		ws_ant_cod VARCHAR2(2);
		wn_pri_mer NUMBER(10);
		wn_tot_reg NUMBER(10);
		wn_num_reg NUMBER(10);
		ws_hor_act VARCHAR2(8);
		ws_dia_act DATE;
		wn_con_tar NUMBER(10);
		wn_tot_emp NUMBER(10);
		wn_tot_can NUMBER(18,2);
		wn_tot_imp NUMBER(18,2);
		wn_tot_tra NUMBER(10);
		BEGIN
	DELETE FROM LABPROD.glwkcrys
	WHERE cry_nomrep=ws_nom_rep
	AND cry_idepcc=ws_ide_pcc
	AND cry_keyusu=ws_key_usu; COMMIT;
		ws_des_lis:='No existe Nombre del Reporte ...';
	BEGIN SELECT lis_deslis
	INTO ws_des_lis FROM LABPROD.glcolist
	WHERE lis_keylis=ws_nom_rep;
EXCEPTION
 WHEN NO_DATA_FOUND THEN
  NULL;
  END;
  ws_etq_001:='......';
	ws_etq_002:='......';
	ws_etq_003:='......';
	ws_etq_004:='......';
	ws_etq_005:='......';
	ws_etq_006:='......';
	ws_etq_007:='......';
	ws_etq_008:='......';
	FOR c_etiqueta IN ( SELECT cam_keycam, cam_descor FROM LABPROD.glcocamp
	WHERE cam_keytab='nmlohism' ) LOOP
		ws_key_cam :=c_etiqueta.cam_keycam;
			ws_des_etq :=c_etiqueta.cam_descor;
			 IF ws_key_cam='his_keypro' THEN
			ws_etq_001:=ws_des_etq;
	ELSIF ws_key_cam='his_keyper' THEN
			ws_etq_002:=ws_des_etq;
	ELSIF ws_key_cam='his_keycon' THEN
			ws_etq_003:=ws_des_etq;
	ELSIF ws_key_cam='his_cantid' THEN
			ws_etq_004:=ws_des_etq;
	ELSIF ws_key_cam='his_import' THEN
			ws_etq_005:=ws_des_etq;
	ELSIF ws_key_cam='his_keydep' THEN
			ws_etq_008:=ws_des_etq;
	  END IF;
	END LOOP;
	FOR c_des_nom IN ( SELECT cam_keycam, cam_descor FROM LABPROD.glcocamp
	WHERE cam_keytab='nmlonomi' ) LOOP
		ws_key_cam :=c_des_nom.cam_keycam;
			ws_des_etq :=c_des_nom.cam_descor;
			 IF ws_key_cam='nom_keynom' THEN
			ws_etq_006:=ws_des_etq;
	ELSIF ws_key_cam='nom_destip' THEN
			ws_etq_007:=ws_des_etq;
	  END IF;
	END LOOP;
	wn_dsp_001:=0;
	wn_dsp_002:=0;
	wn_dsp_003:=0;
	wn_dsp_004:=0;
	wn_dsp_005:=0;
	wn_dsp_006:=0;
	wn_dsp_007:=0;
	FOR c_desplieg IN ( SELECT rec_keycam, rec_despli FROM LABPROD.glcoreca
	WHERE rec_keytab='nmlohismt'
	AND rec_keymen=ws_key_men ) LOOP
		ws_key_cam :=c_desplieg.rec_keycam;
			ws_dsp_cam :=c_desplieg.rec_despli;
	IF ((ws_key_cam='his_keypro') AND (ws_dsp_cam='N') ) THEN
	wn_dsp_001:=1;
	END IF;
	IF ((ws_key_cam='his_keyper') AND (ws_dsp_cam='N') ) THEN
	wn_dsp_002:=1;
	END IF;
	IF ((ws_key_cam='his_keycon') AND (ws_dsp_cam='N') ) THEN
	wn_dsp_003:=1;
	END IF;
	IF ((ws_key_cam='his_cantid') AND (ws_dsp_cam='N') ) THEN
	wn_dsp_004:=1;
	END IF;
	IF ((ws_key_cam='his_import') AND (ws_dsp_cam='N') ) THEN
	wn_dsp_005:=1;
	END IF;
	IF ((ws_key_cam='his_keydep') AND (ws_dsp_cam='N') ) THEN
	wn_dsp_007:=1;
	END IF;
	END LOOP;
	ws_ant_con:='@@@';
	wn_ant_nom:=-9999;
	ws_ant_per:='@@@';
	wn_ant_pro:=-9999;
	ws_ant_cod:='@@';
	ws_mov_cia:='..';
	wn_num_reg:=0;
	wn_con_tar:=0;
	wn_tot_can:=0;
	wn_tot_imp:=0;
	wn_pri_mer:=0;
	wn_tot_tra:=0;
	ws_cod_niv:='';
	ws_des_dep:=0;
	ws_lis_pro:='';
	wn_tot_emp:=0;
	wn_mov_emp:=0;
	wn_mov_nom:=0;
	sp_glfechor(ws_dia_act, ws_hor_act);
	BEGIN SELECT red_codniv
	INTO ws_cod_pri FROM LABPROD.eocorede
	WHERE red_hijdep=ws_dep_pri
	AND red_keyest=ws_key_est;
EXCEPTION
 WHEN NO_DATA_FOUND THEN
  NULL;
  END;
  FOR c_orgcon IN ( SELECT dep_keydep, red_codniv FROM LABPROD.nmcodeps, LABPROD.eocorede
	WHERE dep_tipdep='1'
	AND red_codniv LIKE ws_cod_pri
	AND red_hijdep=dep_keydep ) LOOP
		ws_key_dep :=c_orgcon.dep_keydep;
			ws_cod_niv :=c_orgcon.red_codniv;
			BEGIN SELECT dep_desdep
	INTO ws_des_dep FROM LABPROD.nmcodeps
	WHERE dep_keydep=ws_key_dep;
EXCEPTION
 WHEN NO_DATA_FOUND THEN
  NULL;
  END;
  BEGIN SELECT  COUNT( DISTINCT his_keyemp ) alias1
	INTO wn_mov_emp FROM LABPROD.nmlohism, LABPROD.eocorede
	WHERE red_hijdep=his_keydep
	AND red_codniv LIKE ws_cod_niv
	AND his_keyper IN (
	SELECT ran_keyper FROM LABPROD.glwkrang
	WHERE ran_nomrep=ws_nom_rep
	AND ran_idepcc=ws_ide_pcc
	AND ran_keyusu=ws_key_usu
	AND ran_keyper IS NOT NULL );
EXCEPTION
 WHEN NO_DATA_FOUND THEN
  NULL;
  END;
  FOR c_nmlstcic IN ( SELECT his_keycon,  SUM(his_cantid ) alias2,  SUM(his_import ) alias3, his_keypro, his_keyper, his_codimp,  COUNT(* ) alias7
  FROM LABPROD.nmlohism, LABPROD.eocorede
	WHERE his_keydep=red_hijdep
	AND red_codniv LIKE ws_cod_niv
	AND his_keyper IN (
	SELECT ran_keyper FROM LABPROD.glwkrang
	WHERE ran_nomrep=ws_nom_rep
	AND ran_idepcc=ws_ide_pcc
	AND ran_keyusu=ws_key_usu
	AND ran_keyper IS NOT NULL )
	GROUP BY his_keypro,his_keyper,his_codimp,his_keycon
	ORDER BY his_keypro,his_keyper,his_codimp,his_keycon ) LOOP
		ws_mov_con :=c_nmlstcic.his_keycon;
			wn_tot_can :=c_nmlstcic.alias2;
			wn_tot_imp :=c_nmlstcic.alias3;
			wn_mov_pro :=c_nmlstcic.his_keypro;
			ws_mov_per :=c_nmlstcic.his_keyper;
			ws_cod_imp :=c_nmlstcic.his_codimp;
			wn_con_tar :=c_nmlstcic.alias7;
	IF (wn_pri_mer=0 ) THEN
	ws_des_cor:='CORPORATIVO NO REGISTRADO';
	BEGIN SELECT cia_descia
	INTO ws_des_cor FROM LABPROD.nmlocias
	WHERE cia_keycia = (
	SELECT pro_keycia FROM LABPROD.nmloproc
	WHERE pro_keypro=wn_mov_pro);
EXCEPTION
 WHEN NO_DATA_FOUND THEN
  NULL;
  END;
  wn_pri_mer:=(wn_pri_mer+1);
	END IF;
	IF ((wn_ant_pro!=wn_mov_pro) AND (ws_ant_per!=ws_mov_per) ) THEN
	wn_num_reg:=(wn_num_reg+1);
	UPDATE LABPROD.glcoresu SET res_numreg=wn_num_reg
	WHERE res_idepro=ws_nom_rep
	AND res_idepcc=ws_key_usu
	AND res_keyusu=ws_key_usu
	AND res_fecini=ws_dia_act
	AND res_horreg=ws_hor_reg; COMMIT;
		END IF;
	IF (wn_ant_pro IS NULL ) THEN
	ws_des_cia:='Compania no existe ..';
	ws_mov_cia:='..';
	ws_des_pro:='No existe proceso ..';
	 ELSE
	IF (wn_ant_pro!=wn_mov_pro ) THEN
	ws_des_pro:='No Existe Proceso ...';
	ws_mov_cia:='..';
	BEGIN SELECT pro_despro, pro_keycia
	INTO ws_des_pro, ws_mov_cia FROM LABPROD.nmloproc
	WHERE pro_keypro=wn_mov_pro;
EXCEPTION
 WHEN NO_DATA_FOUND THEN
  NULL;
  END;
  ws_des_cia:='Compania no existe ..';
	BEGIN SELECT cia_descia
	INTO ws_des_cia FROM LABPROD.nmlocias
	WHERE cia_keycia=ws_mov_cia;
EXCEPTION
 WHEN NO_DATA_FOUND THEN
  NULL;
  END;
  BEGIN SELECT ran_keycen, ran_keypue, ran_keydep
	INTO ws_lis_pro, ws_lis_pr2, ws_lis_pr3 FROM LABPROD.glwkrang
	WHERE ran_keypro=wn_mov_pro
	AND ran_nomrep=ws_nom_rep
	AND ran_idepcc=ws_ide_pcc
	AND ran_keyusu=ws_key_usu;
EXCEPTION
 WHEN NO_DATA_FOUND THEN
  NULL;
  END;
  ws_lis_pro:= RTRIM(LTRIM(ws_lis_pro)) ||  RTRIM(LTRIM(ws_lis_pr2)) ||  RTRIM(LTRIM(ws_lis_pr3));
	ws_lis_pro:= SUBSTR(ws_lis_pro,1,40);
	BEGIN SELECT  COUNT( DISTINCT his_keyemp ) alias1
	INTO wn_tot_emp FROM LABPROD.nmlohism, LABPROD.eocorede
	WHERE his_keypro=wn_mov_pro
	AND his_keyper=ws_mov_per
	AND his_keydep=red_hijdep
	AND red_codniv LIKE ws_cod_niv;
EXCEPTION
 WHEN NO_DATA_FOUND THEN
  NULL;
  END;
  wn_ant_pro:=wn_mov_pro;
	END IF;
		END IF;
	IF (ws_ant_con IS NULL ) THEN
	ws_des_con:='No existe Concepto ..';
	 ELSE
	ws_des_con:='No Existe Concepto ..';
	BEGIN SELECT con_descon
	INTO ws_des_con FROM LABPROD.nmloconc
	WHERE con_keycon=ws_mov_con;
EXCEPTION
 WHEN NO_DATA_FOUND THEN
  NULL;
  END;
  ws_ant_con:=ws_mov_con;
	END IF;
	IF (ws_ant_cod!=ws_cod_imp ) THEN
	ws_ant_cod:=ws_cod_imp;
	END IF;
	IF (ws_ant_per IS NULL ) THEN
	wd_fec_ini:=ws_dia_act;
	wd_fec_fin:=ws_dia_act;
	 ELSE
	IF (ws_ant_per!=ws_mov_per ) THEN
	wd_fec_ini:=ws_dia_act;
	wd_fec_fin:=ws_dia_act;
	BEGIN SELECT per_fecini, per_fecfin, per_keynom
	INTO wd_fec_ini, wd_fec_fin, wn_mov_nom FROM LABPROD.nmloperi
	WHERE per_keyper=ws_mov_per
	AND per_keypro=ws_mov_per;
EXCEPTION
 WHEN NO_DATA_FOUND THEN
  NULL;
  END;
  BEGIN SELECT  COUNT( DISTINCT his_keyemp ) alias1
	INTO wn_tot_emp FROM LABPROD.nmlohism, LABPROD.eocorede
	WHERE his_keypro=wn_mov_pro
	AND his_keyper=ws_mov_per
	AND his_keydep=red_hijdep
	AND red_codniv LIKE ws_cod_niv;
EXCEPTION
 WHEN NO_DATA_FOUND THEN
  NULL;
  END;
  END IF;
		END IF;
	IF (wn_ant_nom IS NULL ) THEN
	ws_des_nom:='No Existe Nomina ..';
	 ELSE
	ws_des_nom:='No Existe Nomina ..';
	BEGIN SELECT nom_destip
	INTO ws_des_nom FROM LABPROD.nmlonomi
	WHERE nom_keynom=wn_mov_nom;
EXCEPTION
 WHEN NO_DATA_FOUND THEN
  NULL;
  END;
  BEGIN SELECT ran_keycat
	INTO ws_lis_nom FROM LABPROD.glwkrang
	WHERE ran_nomrep=ws_nom_rep
	AND ran_idepcc=ws_ide_pcc
	AND ran_keyusu=ws_key_usu;
EXCEPTION
 WHEN NO_DATA_FOUND THEN
  NULL;
  END;
  END IF;
	IF (wn_dsp_001=1 ) THEN
	wn_mov_pro:=NULL;
	END IF;
	IF (wn_dsp_002=1 ) THEN
	ws_mov_per:=NULL;
	END IF;
	IF (wn_dsp_003=1 ) THEN
	ws_mov_con:=NULL;
	END IF;
	IF (wn_dsp_004=1 ) THEN
	wn_tot_can:=NULL;
	END IF;
	IF (wn_dsp_005=1 ) THEN
	wn_tot_imp:=NULL;
	END IF;
	IF (wn_dsp_007=1 ) THEN
	ws_key_dep:=NULL;
	ws_des_dep:=NULL;
	END IF;
		INSERT INTO LABPROD.glwkcrys( cry_nomrep,cry_idepcc,cry_keyusu,cry_chr001,cry_chr003,cry_chr015,cry_chr017,cry_chr018,cry_chr019,cry_chr010,cry_chr011,cry_chr022,cry_chr024,cry_chr025,cry_chr005,cry_dec001,cry_dec002,cry_dec006,cry_chr026,cry_dec008,cry_dec009,cry_dat001,cry_dat002,cry_dat003,cry_chr027,cry_chr002,cry_chr028,cry_chr009,cry_dec010,cry_chr006,cry_chr007,cry_chr008,cry_chr012,cry_dec007,cry_chr016,cry_chr004,cry_chr029)
		VALUES(ws_nom_rep,ws_ide_pcc,ws_key_usu,ws_des_cor,ws_des_lis,ws_des_nom,ws_etq_001,ws_etq_002,ws_etq_003,ws_etq_004,ws_etq_005,ws_etq_006,ws_hor_act,ws_ant_con,ws_des_con,wn_tot_can,wn_tot_imp,wn_mov_pro,ws_mov_per,wn_mov_nom,wn_con_tar,wd_fec_ini,wd_fec_fin,ws_dia_act,ws_ant_cod,ws_des_cia,ws_mov_cia,ws_etq_007,wn_tot_emp,ws_lis_pro,ws_lis_per,ws_des_pro,ws_lis_nom,wn_mov_emp,ws_key_dep,ws_des_dep,ws_etq_008); COMMIT;
	END LOOP;
	END LOOP;
	LABPROD.sp_glfechor(ws_dia_act, ws_hor_act);
	UPDATE LABPROD.glcoresu SET res_numreg=wn_num_reg,res_fecfin=ws_dia_act,res_horfin=ws_hor_act,res_status='T'
	WHERE res_idepro=ws_nom_rep
	AND res_idepcc=ws_ide_pcc
	AND res_keyusu=ws_key_usu
	AND res_fecini=ws_dia_act
	AND res_horreg=ws_hor_reg; COMMIT;
END;
/
