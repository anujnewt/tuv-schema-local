CREATE OR REPLACE EDITIONABLE PROCEDURE "USRSIHO"."SP_NMLSTDFI" (ws_nom_rep IN VARCHAR2,ws_ide_pcc IN VARCHAR2,wn_key_usu IN  NUMBER,ws_key_men IN VARCHAR2,ws_hor_reg IN VARCHAR2 ) IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
	wn_key_emp NUMBER(10);
		ws_key_con VARCHAR2(40);
		wn_key_pro NUMBER(10);
		ws_key_dep VARCHAR2(16);
		ws_dfi_pue VARCHAR2(8);
		wd_dfi_fec DATE;
		wn_dfi_can NUMBER(12,2);
		wn_dfi_imp NUMBER(12,2);
		ws_per_eje VARCHAR2(7);
		wd_fec_ini DATE;
		wd_fec_fin DATE;
		ws_nom_emp VARCHAR2(60);
		ws_nom_dep VARCHAR2(40);
		ws_des_con VARCHAR2(40);
		ws_des_pro VARCHAR2(40);
		ws_key_cia VARCHAR2(2);
		wn_pri_mer NUMBER(10);
		ws_des_cor VARCHAR2(60);
		ws_des_lis VARCHAR2(50);
		ws_des_etq VARCHAR2(10);
		ws_etq_001 VARCHAR2(8);
		ws_etq_002 VARCHAR2(8);
		ws_etq_003 VARCHAR2(8);
		ws_etq_004 VARCHAR2(8);
		ws_etq_005 VARCHAR2(8);
		ws_etq_006 VARCHAR2(8);
		ws_etq_007 VARCHAR2(8);
		ws_etq_008 VARCHAR2(20);
		ws_etq_009 VARCHAR2(20);
		ws_etq_010 VARCHAR2(20);
		ws_etq_011 VARCHAR2(8);
		ws_etq_012 VARCHAR2(20);
		ws_key_cam VARCHAR2(20);
		ws_dsp_cam VARCHAR2(20);
		wn_dsp_001 NUMBER(5);
		wn_dsp_002 NUMBER(5);
		wn_dsp_003 NUMBER(5);
		wn_dsp_004 NUMBER(5);
		wn_dsp_005 NUMBER(5);
		wn_ant_emp NUMBER(10);
		ws_ant_con VARCHAR2(3);
		wn_ant_pro NUMBER(10);
		ws_ant_dep VARCHAR2(16);
		wn_tot_reg NUMBER(10);
		wn_num_reg NUMBER(10);
		wn_pct_reg NUMBER(6,2);
		wn_pct_act NUMBER(5);
		ws_hor_act VARCHAR2(8);
		ws_dia_act DATE;
		wn_num_tem NUMBER(10);
		ws_des_eti VARCHAR2(40);
		BEGIN
	BEGIN SELECT  COUNT(* ) alias1
	INTO wn_tot_reg FROM USRSIHO.nmlodfij
	WHERE dfi_keydep IN (
	SELECT ran_keydep FROM USRSIHO.glwkrang
	WHERE ran_nomrep = ws_nom_rep
	AND ran_idepcc = ws_ide_pcc
	AND ran_keyusu = wn_key_usu
	AND ran_keydep IS NOT NULL )
	AND dfi_keyemp IN (
	SELECT ran_keyemp FROM USRSIHO.glwkrang
	WHERE ran_nomrep = ws_nom_rep
	AND ran_idepcc = ws_ide_pcc
	AND ran_keyusu = wn_key_usu
	AND ran_keyemp IS NOT NULL )
	AND dfi_keycon IN (
	SELECT ran_keycon FROM USRSIHO.glwkrang
	WHERE ran_nomrep = ws_nom_rep
	AND ran_idepcc = ws_ide_pcc
	AND ran_keyusu = wn_key_usu
	AND ran_keycon IS NOT NULL )
	AND dfi_keypro IN (
	SELECT ran_keypro FROM USRSIHO.glwkrang
	WHERE ran_nomrep = ws_nom_rep
	AND ran_idepcc = ws_ide_pcc
	AND ran_keyusu = wn_key_usu
	AND ran_keypro IS NOT NULL );
EXCEPTION
 WHEN NO_DATA_FOUND THEN
  NULL;
  END;
  USRSIHO.sp_glfechor(ws_dia_act, ws_hor_act);
	INSERT INTO USRSIHO.glcoresu( res_idepro,res_idepcc,res_keyusu,res_fecini,res_horini,res_horreg,res_totreg,res_status)
		VALUES(ws_nom_rep,ws_ide_pcc,wn_key_usu,ws_dia_act,ws_hor_act,ws_hor_reg,wn_tot_reg,'P'); COMMIT;
		DELETE FROM USRSIHO.glwkcrys
	WHERE cry_nomrep = ws_nom_rep
	AND cry_idepcc = ws_ide_pcc
	AND cry_keyusu = wn_key_usu; COMMIT;
		ws_des_cor:='CORPORATIVO NO REGISTRADO ..';
	BEGIN SELECT cor_descor
	INTO ws_des_cor FROM USRSIHO.glcocorp;
EXCEPTION
 WHEN NO_DATA_FOUND THEN
  NULL;
  END;
  ws_des_lis:='No existe Nombre del Reporte';
	BEGIN SELECT lis_deslis
	INTO ws_des_lis FROM USRSIHO.glcolist
	WHERE lis_keylis = ws_nom_rep;
EXCEPTION
 WHEN NO_DATA_FOUND THEN
  NULL;
  END;
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
	FOR c_etiqueta IN ( SELECT cam_keycam, cam_descor, cam_descam FROM USRSIHO.glcocamp
	WHERE cam_keytab IN ('nmlodfij','nmloproc','nmloperi','nmloconc','nmcoempl')
	AND cam_keycam IN ('dfi_keyemp','dfi_keycon','dfi_keypro','dfi_cantid','dfi_import','dfi_fecmov','dfi_keydep','dfi_keypue','con_descon','emp_nomemp','pro_pereje') ) LOOP
		ws_key_cam :=c_etiqueta.cam_keycam;
			ws_des_etq :=c_etiqueta.cam_descor;
			ws_des_eti :=c_etiqueta.cam_descam;
	IF (ws_key_cam='dfi_keyemp' ) THEN
	ws_etq_001:=ws_des_etq;
	 ELSE
	IF (ws_key_cam='dfi_keycon' ) THEN
	ws_etq_002:=ws_des_etq;
	 ELSE
	IF (ws_key_cam='dfi_keypro' ) THEN
	ws_etq_003:=ws_des_etq;
	 ELSE
	IF (ws_key_cam='dfi_cantid' ) THEN
	ws_etq_004:=ws_des_etq;
	 ELSE
	IF (ws_key_cam='dfi_import' ) THEN
	ws_etq_005:=ws_des_etq;
	 ELSE
	IF (ws_key_cam='dfi_fecmov' ) THEN
	ws_etq_006:=ws_des_etq;
	 ELSE
	IF (ws_key_cam='dfi_keydep' ) THEN
	ws_etq_007:=ws_des_etq;
	ws_etq_012:= SUBSTR(ws_des_eti,1,20);
	 ELSE
	IF (ws_key_cam='dfi_keypue' ) THEN
	ws_etq_008:= SUBSTR(ws_des_eti,1,20);
	 ELSE
	IF (ws_key_cam='con_descon' ) THEN
	ws_etq_009:= SUBSTR(ws_des_eti,1,20);
	 ELSE
	IF (ws_key_cam='emp_nomemp' ) THEN
	ws_etq_010:= SUBSTR(ws_des_eti,1,20);
	 ELSE
	IF (ws_key_cam='pro_pereje' ) THEN
	ws_etq_011:=ws_des_etq;
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
	USRSIHO.sp_glnewdsp('nmlodfij', 'dfi_cantid', ws_key_men,wn_dsp_001);
	USRSIHO.sp_glnewdsp('nmlodfij', 'dfi_import', ws_key_men,wn_dsp_002);
	USRSIHO.sp_glnewdsp('nmlodfij', 'dfi_fecmov', ws_key_men,wn_dsp_003);
	USRSIHO.sp_glnewdsp('nmlodfij', 'dfi_keypro', ws_key_men,wn_dsp_004);
	USRSIHO.sp_glnewdsp('nmlodfij', 'dfi_keypue', ws_key_men,wn_dsp_005);
	USRSIHO.sp_glnewdsp('nmlodfij', 'dfi_cantid', ws_key_men,wn_dsp_001);
	wn_ant_emp:=-0000;
	ws_ant_con:='@@@';
	wn_ant_pro:=-0000;
	ws_ant_dep:=0;
	wn_num_reg:=1;
	wn_pct_act:=(wn_tot_reg/10.0);
	wn_pri_mer:=0;
	FOR c_nmlstdfi IN ( SELECT dfi_keydep, dfi_keyemp, dfi_keycon, dfi_keypro, dfi_fecmov, dfi_cantid, dfi_import, dfi_keypue FROM USRSIHO.nmlodfij
	WHERE dfi_keyemp IN (
	SELECT ran_keyemp FROM USRSIHO.glwkrang
	WHERE ran_nomrep = ws_nom_rep
	AND ran_idepcc = ws_ide_pcc
	AND ran_keyusu = wn_key_usu
	AND ran_keyemp IS NOT NULL )
	AND dfi_keycon IN (
	SELECT ran_keycon FROM USRSIHO.glwkrang
	WHERE ran_nomrep = ws_nom_rep
	AND ran_idepcc = ws_ide_pcc
	AND ran_keyusu = wn_key_usu
	AND ran_keycon IS NOT NULL )
	AND dfi_keypro IN (
	SELECT ran_keypro FROM USRSIHO.glwkrang
	WHERE ran_nomrep = ws_nom_rep
	AND ran_idepcc = ws_ide_pcc
	AND ran_keyusu = wn_key_usu
	AND ran_keypro IS NOT NULL )
	ORDER BY dfi_keydep,dfi_keyemp,dfi_keycon,dfi_keypro ) LOOP
		ws_key_dep :=c_nmlstdfi.dfi_keydep;
			wn_key_emp :=c_nmlstdfi.dfi_keyemp;
			ws_key_con :=c_nmlstdfi.dfi_keycon;
			wn_key_pro :=c_nmlstdfi.dfi_keypro;
			wd_dfi_fec :=c_nmlstdfi.dfi_fecmov;
			wn_dfi_can :=c_nmlstdfi.dfi_cantid;
			wn_dfi_imp :=c_nmlstdfi.dfi_import;
			ws_dfi_pue :=c_nmlstdfi.dfi_keypue;
	IF (wn_pri_mer=0 ) THEN
	ws_des_cor:='CORPORATIVO NO REGISTRADO';
	ws_key_cia:='*';
	BEGIN SELECT pro_keycia, cia_descia
	INTO ws_key_cia, ws_des_cor FROM USRSIHO.nmloproc,USRSIHO.nmlocias
	WHERE pro_keypro = wn_key_pro
	AND pro_keycia = cia_keycia;
EXCEPTION
 WHEN NO_DATA_FOUND THEN
  NULL;
  END;
  wn_pri_mer:=(wn_pri_mer+1);
	END IF;
		wn_num_reg:=(wn_num_reg+1);
	wn_num_tem:=(wn_pct_reg*wn_pct_act);
	IF (wn_num_reg>=wn_num_tem ) THEN
	UPDATE USRSIHO.glcoresu SET res_numreg=wn_num_reg
	WHERE res_idepro = ws_nom_rep
	AND res_idepcc = ws_ide_pcc
	AND res_keyusu = wn_key_usu
	AND res_fecini = ws_dia_act
	AND res_horreg = ws_hor_reg; COMMIT;
		wn_pct_act:=(wn_pct_act+1);
	END IF;
	IF (ws_key_dep IS NULL ) THEN
	ws_nom_dep:='Departamento No Existe.';
	 ELSE
	ws_nom_dep:='Departamento no Existe.';
	BEGIN SELECT dep_desdep
	INTO ws_nom_dep FROM USRSIHO.nmcodeps
	WHERE dep_keydep = ws_key_dep;
EXCEPTION
 WHEN NO_DATA_FOUND THEN
  NULL;
  END;
  ws_ant_dep:=ws_key_dep;
	END IF;
	IF (wn_key_emp IS NULL ) THEN
	ws_nom_emp:='Empleado No Existe..';
	 ELSE
	ws_nom_emp:='Empleado No Existe..';
	BEGIN SELECT emp_nomemp
	INTO ws_nom_emp FROM USRSIHO.nmcoempl
	WHERE emp_keyemp = wn_key_emp;
EXCEPTION
 WHEN NO_DATA_FOUND THEN
  NULL;
  END;
  wn_ant_emp:=wn_key_emp;
	ws_nom_emp:= SUBSTR(ws_nom_emp,1,40);
	END IF;
	IF (ws_key_con IS NULL ) THEN
	ws_des_con:='Concepto No Existe..';
	 ELSE
	ws_des_con:='Concepto No existe ..';
	BEGIN SELECT con_descon
	INTO ws_des_con FROM USRSIHO.nmloconc
	WHERE con_keycon = ws_key_con;
EXCEPTION
 WHEN NO_DATA_FOUND THEN
  NULL;
  END;
  ws_ant_con:=ws_key_con;
	END IF;
	IF (wn_key_pro IS NULL ) THEN
	ws_per_eje:=-00;
	wd_fec_ini:=ws_dia_act;
	wd_fec_fin:=ws_dia_act;
	 ELSE
	ws_per_eje:=-00;
	wd_fec_ini:=ws_dia_act;
	wd_fec_fin:=ws_dia_act;
	BEGIN SELECT pro_pereje, pro_despro
	INTO ws_per_eje, ws_des_pro FROM USRSIHO.nmloproc
	WHERE pro_keypro = wn_key_pro;
EXCEPTION
 WHEN NO_DATA_FOUND THEN
  NULL;
  END;
  BEGIN SELECT per_fecini, per_fecfin
	INTO wd_fec_ini, wd_fec_fin FROM USRSIHO.nmloproc,USRSIHO.nmloperi
	WHERE per_keypro = wn_key_pro
	AND pro_pereje = per_keyper
	AND pro_keypro = per_keypro;
EXCEPTION
 WHEN NO_DATA_FOUND THEN
  NULL;
  END;
  wn_ant_pro:=wn_key_pro;
	END IF;
	IF (wn_dsp_001=1 ) THEN
	wd_dfi_fec:=NULL;
	END IF;
	IF (wn_dsp_002=1 ) THEN
	wn_dfi_can:=NULL;
	END IF;
	IF (wn_dsp_003=1 ) THEN
	wn_dfi_imp:=NULL;
	END IF;
	IF (wn_dsp_004=1 ) THEN
	wn_key_pro:=NULL;
	END IF;
	IF (wn_dsp_005=1 ) THEN
	ws_dfi_pue:=NULL;
	END IF;
		INSERT INTO USRSIHO.glwkcrys( cry_nomrep,cry_idepcc,cry_keyusu,cry_chr001,cry_chr002,cry_dec006,cry_chr012,cry_dec007,cry_dat001,cry_dec001,cry_dec002,cry_chr013,cry_chr014,cry_chr015,cry_dat002,cry_dat003,cry_chr003,cry_chr004,cry_chr005,cry_chr006,cry_chr030,cry_chr031,cry_chr032,cry_chr033,cry_chr034,cry_chr035,cry_chr036,cry_chr008,cry_chr009,cry_chr010,cry_chr040,cry_chr011,cry_chr021,cry_dat004)
		VALUES(ws_nom_rep,ws_ide_pcc,wn_key_usu,ws_des_cor,ws_des_lis,wn_key_emp,ws_key_con,wn_key_pro,wd_dfi_fec,wn_dfi_can,wn_dfi_imp,ws_key_dep,ws_dfi_pue,ws_per_eje,wd_fec_ini,wd_fec_fin,ws_nom_emp,ws_des_con,ws_des_pro,ws_nom_dep,ws_etq_001,ws_etq_002,ws_etq_003,ws_etq_004,ws_etq_005,ws_etq_006,ws_etq_007,ws_etq_008,ws_etq_009,ws_etq_010,ws_etq_011,ws_etq_012,ws_hor_act,ws_dia_act); COMMIT;
	END LOOP;
	USRSIHO.sp_glfechor(ws_dia_act, ws_hor_act);
	UPDATE USRSIHO.glcoresu SET res_numreg=wn_num_reg,res_fecfin=ws_dia_act,res_horfin=ws_hor_act,res_status='T'
	WHERE res_idepro = ws_nom_rep
	AND res_idepcc = ws_ide_pcc
	AND res_keyusu = wn_key_usu
	AND res_fecini = ws_dia_act
	AND res_horreg = ws_hor_reg; COMMIT;
		END;
/
