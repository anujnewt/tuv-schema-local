CREATE OR REPLACE NONEDITIONABLE PROCEDURE "LABPROD"."SP_NMLSTNOMA" (ws_nom_rep IN VARCHAR2,ws_des_rep IN VARCHAR2,ws_ide_pcc IN VARCHAR2,wn_key_usu IN  NUMBER,ws_key_men IN VARCHAR2,ws_hor_reg IN VARCHAR2,wn_key_pro IN NUMBER,wn_tip_nom IN NUMBER,ws_key_per IN VARCHAR2 ) IS
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
    ws_rec_urp VARCHAR2(20);
    wn_sal_dia NUMBER(12,6);
    wn_sal_int NUMBER(12,6);
    wd_fec_ing DATE;
    wd_fec_rei DATE;
    wd_var_fec DATE;
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
    ws_opc_009 VARCHAR2(16);
    ws_des_nom VARCHAR2(40);
    ws_des_pro VARCHAR2(20);
    ws_des_con VARCHAR2(30);
    ws_des_cor VARCHAR2(60);
    ws_des_pue VARCHAR2(60);
    ws_des_dep VARCHAR2(60);
    ws_des_loc VARCHAR2(40);
    wd_fec_ini DATE;
    wd_fec_fin DATE;
    ws_des_lis VARCHAR2(50);
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
    wd_fec_antig DATE;
    wd_fec_baj DATE;
    wd_de_baja DATE;
    wn_sal_mov NUMBER(10,2);
    wd_fec_mov DATE;
    wn_tip_fin INTEGER;
    wn_tip_fin2 INTEGER;
	BEGIN
    wn_tot_reg:=-1;
	INSERT INTO LABPROD.glcoresu( res_idepro,res_idepcc,res_keyusu,res_fecini,res_horini,res_horreg,res_totreg,res_status)
		VALUES(ws_nom_rep,ws_ide_pcc,wn_key_usu,ws_fec_act,ws_hor_act,ws_hor_reg,wn_tot_reg,'P'); COMMIT;
		ws_des_cor:='CORPORATIVO NO REGISTRADO';
	ws_key_cia:=NULL;
	BEGIN SELECT pro_keycia
	INTO ws_key_cia FROM LABPROD.nmloproc
	WHERE pro_keypro=wn_key_pro;
EXCEPTION
 WHEN NO_DATA_FOUND THEN
  NULL;
  END;
	IF ((ws_key_cia!=' ') AND (ws_key_cia IS NOT NULL ) ) THEN
	BEGIN SELECT substr(cia_descia,1,60) , cia_rfccia
	INTO ws_des_cor, ws_rfc_cia FROM LABPROD.nmlocias
	WHERE cia_keycia=ws_key_cia;
EXCEPTION
 WHEN NO_DATA_FOUND THEN
  NULL;
  END;
  BEGIN SELECT pam_folini,pam_folfin
         INTO wn_tip_fin, wn_tip_fin2
        FROM LABPROD. glcopams
        WHERE pam_keypar = (SELECT pam_folini FROM LABPROD.glcopams WHERE pam_keypar = '00' AND pam_cvesec = 'calfin')
          AND pam_cvesec = 'OPCI03';
  EXCEPTION
  WHEN NO_DATA_FOUND THEN
    wn_tip_fin:= 0;
    wn_tip_fin2:= 0;
  END;
  ws_rfc_c01:= SUBSTR(ws_rfc_cia,1,8);
	ws_rfc_c02:= SUBSTR(ws_rfc_cia,9,7);
	END IF;
		ws_key_tab:='';
	BEGIN SELECT pam_folini
	INTO ws_key_tab FROM LABPROD.glcopams
	WHERE pam_keypar = (
	SELECT pam_folini FROM LABPROD.glcopams
	WHERE pam_keypar='00'
	AND pam_cvesec='repnom')
	AND pam_cvesec='OPCI01';
EXCEPTION
 WHEN NO_DATA_FOUND THEN
  NULL;
  END;
  ws_con_his:='';
	BEGIN SELECT pam_folini
	INTO ws_con_his FROM LABPROD.glcopams
	WHERE pam_keypar = (
	SELECT pam_folini FROM LABPROD.glcopams
	WHERE pam_keypar='00'
	AND pam_cvesec='repnom')
	AND pam_cvesec='OPCI02';
EXCEPTION
 WHEN NO_DATA_FOUND THEN
  NULL;
  END;
  ws_opc_003:='';
	BEGIN SELECT pam_folini
	INTO ws_opc_003 FROM LABPROD.glcopams
	WHERE pam_keypar = (
	SELECT pam_folini FROM LABPROD.glcopams
	WHERE pam_keypar='00'
	AND pam_cvesec='repnom')
	AND pam_cvesec='OPCI03';
EXCEPTION
 WHEN NO_DATA_FOUND THEN
  NULL;
  END;
  ws_opc_004:='';
	BEGIN SELECT pam_folini
	INTO ws_opc_004 FROM LABPROD.glcopams
	WHERE pam_keypar = (
	SELECT pam_folini FROM LABPROD.glcopams
	WHERE pam_keypar='00'
	AND pam_cvesec='repnom')
	AND pam_cvesec='OPCI04';
EXCEPTION
 WHEN NO_DATA_FOUND THEN
  NULL;
  END;
  ws_opc_005:='';
	BEGIN SELECT pam_folini
	INTO ws_opc_005 FROM LABPROD.glcopams
	WHERE pam_keypar = (
	SELECT pam_folini FROM LABPROD.glcopams
	WHERE pam_keypar='00'
	AND pam_cvesec='repnom')
	AND pam_cvesec='OPCI05';
EXCEPTION
 WHEN NO_DATA_FOUND THEN
  NULL;
  END;
  ws_opc_006:='';
	BEGIN SELECT pam_folini
	INTO ws_opc_006 FROM LABPROD.glcopams
	WHERE pam_keypar = (
	SELECT pam_folini FROM LABPROD.glcopams
	WHERE pam_keypar='00'
	AND pam_cvesec='repnom')
	AND pam_cvesec='OPCI06';
EXCEPTION
 WHEN NO_DATA_FOUND THEN
  NULL;
  END;
  ws_opc_007:='';
	BEGIN SELECT pam_folini
	INTO ws_opc_007 FROM LABPROD.glcopams
	WHERE pam_keypar = (
	SELECT pam_folini FROM LABPROD.glcopams
	WHERE pam_keypar='00'
	AND pam_cvesec='repnom')
	AND pam_cvesec='OPCI07';
EXCEPTION
 WHEN NO_DATA_FOUND THEN
  NULL;
  END;
  ws_opc_009:='';
	BEGIN SELECT pam_folini
	INTO ws_opc_009 FROM LABPROD.glcopams
	WHERE pam_keypar = (
	SELECT pam_folini FROM LABPROD.glcopams
	WHERE pam_keypar='00'
	AND pam_cvesec='repnom')
	AND pam_cvesec='OPCI09';
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
	FOR c_etiqueta IN ( SELECT cam_keycam, cam_descor FROM LABPROD.glcocamp
	WHERE cam_keytab IN ('nmwkmovt','nmcoempl','nmloimss') ) LOOP
		ws_key_cam :=c_etiqueta.cam_keycam;
			ws_des_etq :=c_etiqueta.cam_descor;
	IF (ws_key_cam='mov_keyemp' ) THEN
	ws_etq_001:=ws_des_etq;
	END IF;
	IF (ws_key_cam='mov_keydep' ) THEN
	ws_etq_002:=ws_des_etq;
	END IF;
	IF (ws_key_cam='mov_keypue' ) THEN
	ws_etq_003:=ws_des_etq;
	END IF;
	IF (ws_key_cam='mov_keynom' ) THEN
	ws_etq_004:=ws_des_etq;
	END IF;
	IF (ws_key_cam='mov_keyper' ) THEN
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
	IF (ws_key_cam='mov_keypro' ) THEN
	ws_etq_010:=ws_des_etq;
	END IF;
	IF (ws_key_cam='emp_tipemp' ) THEN
	ws_etq_011:=ws_des_etq;
	END IF;
	IF (ws_key_cam='mov_ca2aux' ) THEN
	ws_etq_012:=ws_des_etq;
	END IF;
	IF (ws_key_cam='ims_rfcims' ) THEN
	ws_etq_013:=ws_des_etq;
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
	LABPROD.sp_glnewdsp('nmwkmovt', 'mov_keyemp', ws_key_men,wn_dsp_001);
	LABPROD.sp_glnewdsp('nmwkmovt', 'mov_keydep', ws_key_men,wn_dsp_002);
	LABPROD.sp_glnewdsp('nmwkmovt', 'mov_keypue', ws_key_men,wn_dsp_003);
	LABPROD.sp_glnewdsp('nmwkmovt', 'mov_keycon', ws_key_men,wn_dsp_004);
	LABPROD.sp_glnewdsp('nmwkmovt', 'mov_keyper', ws_key_men,wn_dsp_005);
	LABPROD.sp_glnewdsp('nmwkmovt', 'mov_keynom', ws_key_men,wn_dsp_006);
	LABPROD.sp_glnewdsp('nmwkmovt', 'mov_cantid', ws_key_men,wn_dsp_007);
	LABPROD.sp_glnewdsp('nmwkmovt', 'mov_import', ws_key_men,wn_dsp_008);
	LABPROD.sp_glnewdsp('nmwkmovt', 'emp_tipemp', ws_key_men,wn_dsp_009);
	LABPROD.sp_glnewdsp('nmwkmovt', 'emp_keyloc', ws_key_men,wn_dsp_010);
	wn_num_reg:=0;
	wn_pct_act:=1;
	wn_pct_reg:=(wn_tot_reg/10);
	wn_emp_ant:=-999999999;
	ws_des_nom:='NOMINA NO EXISTE ..';
	BEGIN SELECT nom_destip
	INTO ws_des_nom FROM LABPROD.nmlonomi
	WHERE nom_keynom=wn_tip_nom;
EXCEPTION
 WHEN NO_DATA_FOUND THEN
  NULL;
  END;
  ws_des_nom:= SUBSTR(ws_des_nom,1,20);
	ws_des_pro:='PROCESP NO EXISTE..';
	BEGIN SELECT pro_despro
	INTO ws_des_pro FROM LABPROD.nmloproc
	WHERE pro_keypro=wn_key_pro;
EXCEPTION
 WHEN NO_DATA_FOUND THEN
  NULL;
  END;
  BEGIN SELECT per_fecini, per_fecfin
	INTO wd_fec_ini, wd_fec_fin FROM LABPROD.nmloperi
	WHERE per_keyper=ws_key_per
	AND per_keypro=wn_key_pro;
EXCEPTION
 WHEN NO_DATA_FOUND THEN
  NULL;
  END;
  ws_des_lis:='No existe nombre del Reporte';
	BEGIN SELECT lis_deslis
	INTO ws_des_lis FROM LABPROD.glcolist
	WHERE lis_keylis=ws_des_rep;
EXCEPTION
 WHEN NO_DATA_FOUND THEN
  NULL;
  END;
  ws_des_aux:= SUBSTR(ws_des_lis,41,9);
	ws_key_dep:= 'HHHHHHHHH';
	k:=1;
	FOR c_nmlstnom IN ( SELECT mov_keyemp, mov_keycon, mov_cantid, mov_import, mov_codimp,mov_fecmov FROM LABPROD.nmwkmovt
	WHERE mov_keyemp IN (
	SELECT ran_keyemp FROM LABPROD.glwkrang
	WHERE ran_nomrep=ws_nom_rep
	AND ran_idepcc=ws_ide_pcc
	AND ran_keyusu=wn_key_usu
	AND ran_keyemp IS NOT NULL )
	AND mov_keypro=wn_key_pro
	AND mov_keyper=ws_key_per
	AND ((mov_codimp IN ('01','02')) OR (mov_keycon IN (ws_opc_003,ws_opc_004,ws_opc_005,ws_opc_006,ws_opc_007)))
	ORDER BY mov_keyemp,mov_codimp,mov_keycon ) LOOP
		wn_key_emp :=c_nmlstnom.mov_keyemp;
			ws_key_con :=c_nmlstnom.mov_keycon;
			wn_can_mov :=c_nmlstnom.mov_cantid;
			wn_imp_mov :=c_nmlstnom.mov_import;
			ws_cod_imp :=c_nmlstnom.mov_codimp;
			wn_num_reg:=(wn_num_reg+1);
      wd_fec_mov := c_nmlstnom.mov_fecmov;
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
	BEGIN SELECT emp_nomemp, emp_regrfc, emp_saldia, emp_salint, emp_keydep, emp_keypue, emp_tipemp, emp_keyims, emp_keyloc, emp_regims,emp_fecaux,emp_fecbaj,emp_recurp,emp_fecing,emp_fecrei
	INTO ws_nom_emp, ws_reg_rfc, wn_sal_dia, wn_sal_int, ws_key_dep, ws_key_pue, ws_tip_emp, ws_key_ims, ws_key_loc, ws_reg_ims,wd_fec_antig,wd_fec_baj,ws_rec_urp,wd_fec_ing,wd_fec_rei FROM LABPROD.nmcoempl
	WHERE emp_keyemp=wn_key_emp;
EXCEPTION
 WHEN NO_DATA_FOUND THEN
  NULL;
  END;
  IF wd_fec_baj is NULL THEN
    wd_de_baja:=wd_fec_mov;
  ELSE
    wd_de_baja:=wd_fec_baj;
  END IF;
  IF wd_fec_rei IS NULL THEN
    wd_var_fec:=wd_fec_ing;
  ELSE
    wd_var_fec:=wd_fec_rei;
  END IF;
  IF (wn_tip_nom = wn_tip_fin OR wn_tip_nom = wn_tip_fin2) THEN
    BEGIN SELECT SUM(mov_import) INTO wn_sal_mov
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
  ws_dep_his:=NULL;
	ws_pue_his:=NULL;
	ws_loc_his:=NULL;
	ws_reg_im1:= SUBSTR(ws_reg_ims,1,6);
	ws_reg_im2:= SUBSTR(ws_reg_ims,7,5);
	IF (ws_con_his IS NOT NULL  ) THEN
	BEGIN SELECT mov_keydep, mov_keypue, mov_ca2aux
	INTO ws_dep_his, ws_pue_his, ws_loc_his FROM LABPROD.nmwkmovt
	WHERE mov_keyemp=wn_key_emp
	AND mov_keypro=wn_key_pro
	AND mov_keyper=ws_key_per
	AND mov_keycon=ws_con_his;
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
	INTO ws_des_dep FROM LABPROD.nmcodeps
	WHERE dep_keydep=ws_key_dep;
EXCEPTION
 WHEN NO_DATA_FOUND THEN
  NULL;
  END;
  ws_des_pue:='PUESTO NO EXISTE';
	BEGIN SELECT pue_despue
	INTO ws_des_pue FROM LABPROD.nmcopues
	WHERE pue_keypue=ws_key_pue;
EXCEPTION
 WHEN NO_DATA_FOUND THEN
  NULL;
  END;
  ws_des_loc:='LOCALIDAD NO EXISTE';
	BEGIN SELECT loc_desloc
	INTO ws_des_loc FROM LABPROD.nmlolocp
	WHERE loc_keyloc=ws_key_loc;
EXCEPTION
 WHEN NO_DATA_FOUND THEN
  NULL;
  END;
  ws_des_loc:= SUBSTR(ws_des_loc,1,16);
	wn_emp_ant:=wn_key_emp;
	ws_des_tip:='NO EXISTE';
	BEGIN SELECT pam_nompar
	INTO ws_des_tip FROM LABPROD.glcopams
	WHERE pam_keypar=ws_key_tab
	AND pam_cvesec=ws_tip_emp;
EXCEPTION
 WHEN NO_DATA_FOUND THEN
  NULL;
  END;
  ws_rfc_ims:='';
	BEGIN SELECT ims_rfcims
	INTO ws_rfc_ims FROM LABPROD.nmloimss
	WHERE ims_keyims=ws_key_ims;
EXCEPTION
 WHEN NO_DATA_FOUND THEN
  NULL;
  END;
  ws_rfc_uno:= SUBSTR(ws_rfc_ims,1,8);
	ws_rfc_dos:= SUBSTR(ws_rfc_ims,9,7);
	wn_emp_ant:=wn_key_emp;
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
	INTO ws_des_con FROM LABPROD.nmloconc
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
	wn_can_mov:=0;
	END IF;
	IF (wn_dsp_008=1 ) THEN
	wn_imp_mov:=0;
	END IF;
		i:=(i+1);
	INSERT INTO LABPROD.glwkcrys( cry_nomrep,cry_idepcc,cry_keyusu,cry_numsec,cry_chr001,cry_dec006,cry_chr009,cry_chr017,cry_dat001,cry_dat002,cry_dec007,cry_chr002,cry_chr012,cry_chr013,cry_chr004,cry_chr014,cry_chr005,cry_dec011,cry_dec012,cry_chr018,cry_chr006,cry_dec001,cry_dec002,cry_chr019,cry_chr020,cry_chr021,cry_chr022,cry_chr023,cry_chr024,cry_chr025,cry_chr026,cry_chr027,cry_chr028,cry_dat003,cry_chr016,cry_chr029,cry_chr007,cry_dec003,cry_dec004,cry_chr015,cry_chr030,cry_dec008,cry_chr008,cry_chr033,cry_chr031,cry_chr010,cry_chr032,cry_chr034,cry_chr035,cry_chr036,cry_chr039,cry_chr044,cry_chr045,cry_chr042,cry_chr043,cry_chr037,cry_dec014,cry_dec016,cry_dec013,cry_dat004,  cry_dat005,cry_chr011)
		VALUES(             ws_nom_rep,ws_ide_pcc,wn_key_usu,i,         ws_des_cor,wn_tip_nom,ws_des_nom,NULL,      wd_fec_ini,wd_fec_fin,wn_key_emp,ws_nom_emp,ws_reg_rfc,ws_key_dep,ws_des_dep,ws_key_pue,ws_des_pue,wn_sal_dia,wn_sal_int,ws_key_con,ws_des_con,wn_can_mov,wn_imp_mov,ws_etq_001,ws_etq_002,ws_etq_003,ws_etq_004,ws_etq_005,ws_etq_006,ws_etq_007,ws_etq_008,ws_etq_009,ws_hor_act,wd_de_baja,ws_des_loc,NULL      ,NULL      ,NULL      ,NULL      ,ws_key_loc,ws_etq_010,wn_key_pro,ws_des_pro,ws_etq_012,ws_tip_emp,ws_des_tip,ws_etq_011,ws_etq_013,ws_rfc_uno,ws_rfc_dos,ws_key_ims,ws_rfc_c01,ws_rfc_c02,ws_reg_im1,ws_reg_im2,'NOMINA'  ,wn_imp_mov,0         ,wn_sal_mov,wd_fec_antig,wd_var_fec,ws_rec_urp); COMMIT;
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
	wn_can_mov:=0;
	END IF;
	IF (wn_dsp_008=1 ) THEN
	wn_imp_mov:=0;
	END IF;
		j:=(j+1);
	IF (j>i ) THEN
	INSERT INTO LABPROD.glwkcrys( cry_nomrep,cry_idepcc,cry_keyusu,cry_numsec,cry_chr001,cry_dec006,cry_chr009,cry_chr017,cry_dat001,cry_dat002,cry_dec007,cry_chr002,cry_chr012,cry_chr013,cry_chr004,cry_chr014,cry_chr005,cry_dec011,cry_dec012,cry_chr018,cry_chr006,cry_dec001,cry_dec002,cry_chr019,cry_chr020,cry_chr021,cry_chr022,cry_chr023,cry_chr024,cry_chr025,cry_chr026,cry_chr027,cry_chr028,cry_dat003,cry_chr016,cry_chr029,cry_chr007,cry_dec003,cry_dec004,cry_chr015,cry_chr030,cry_dec008,cry_chr008,cry_chr033,cry_chr031,cry_chr010,cry_chr032,cry_chr034,cry_chr035,cry_chr036,cry_chr039,cry_chr044,cry_chr045,cry_chr042,cry_chr043,cry_chr037,cry_dec014,cry_dec016,cry_dec013,cry_dat004,cry_dat005,cry_chr011)
		VALUES(             ws_nom_rep,ws_ide_pcc,wn_key_usu,j,         ws_des_cor,wn_tip_nom,ws_des_nom,NULL,      wd_fec_ini,wd_fec_fin,wn_key_emp,ws_nom_emp,ws_reg_rfc,ws_key_dep,ws_des_dep,ws_key_pue,ws_des_pue,wn_sal_dia,wn_sal_int,NULL,      NULL,      NULL,      NULL,         ws_etq_001,ws_etq_002,ws_etq_003,ws_etq_004,ws_etq_005,ws_etq_006,ws_etq_007,ws_etq_008,ws_etq_009,ws_hor_act,ws_fec_act,ws_des_loc,ws_key_con,ws_des_con,wn_can_mov,wn_imp_mov,ws_key_loc,ws_etq_010,wn_key_pro,ws_des_pro,ws_etq_012,ws_tip_emp,ws_des_tip,ws_etq_011,ws_etq_013,ws_rfc_uno,ws_rfc_dos,ws_key_ims,ws_rfc_c01,ws_rfc_c02,ws_reg_im1,ws_reg_im2,'NOMINA',0,wn_imp_mov,wn_sal_mov,wd_fec_antig,wd_var_fec,ws_rec_urp); COMMIT;
		 ELSE
	UPDATE LABPROD.glwkcrys SET cry_chr029=ws_key_con,cry_chr007=ws_des_con,cry_dec003=wn_can_mov,cry_dec004=wn_imp_mov,cry_dec016=wn_imp_mov
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
	INSERT INTO LABPROD.glwkcrys( cry_nomrep,cry_idepcc,cry_keyusu,cry_numsec,cry_chr001,cry_dec006,cry_chr009,cry_chr017,cry_dat001,cry_dat002,cry_dec007,cry_chr002,cry_chr012,cry_chr013,cry_chr004,cry_chr014,cry_chr005,cry_dec011,cry_dec012,cry_chr018,cry_chr006,cry_dec001,cry_dec002,cry_chr019,cry_chr020,cry_chr021,cry_chr022,cry_chr023,cry_chr024,cry_chr025,cry_chr026,cry_chr027,cry_chr028,cry_dat003,cry_chr016,cry_chr029,cry_chr007,cry_dec003,cry_dec004,cry_chr015,cry_chr030,cry_dec008,cry_chr008,cry_chr033,cry_chr031,cry_chr010,cry_chr032,cry_chr034,cry_chr035,cry_chr036,cry_chr039,cry_chr044,cry_chr045,cry_chr042,cry_chr043,cry_chr037,cry_dec014,cry_dec016,cry_dat005,cry_chr011)
		VALUES(             ws_nom_rep,ws_ide_pcc,wn_key_usu,-1,        ws_des_cor,wn_tip_nom,ws_des_nom,NULL,      wd_fec_ini,wd_fec_fin,wn_key_emp,ws_nom_emp,ws_reg_rfc,ws_key_dep,ws_des_dep,ws_key_pue,ws_des_pue,wn_sal_dia,wn_sal_int,ws_key_con,ws_des_con,0   ,      wn_imp_mov,ws_etq_001,ws_etq_002,ws_etq_003,ws_etq_004,ws_etq_005,ws_etq_006,ws_etq_007,ws_etq_008,ws_etq_009,ws_hor_act,wd_de_baja,ws_des_loc,NULL,      NULL,      0,         0,         ws_key_loc,ws_etq_010,wn_key_pro,ws_des_pro,ws_etq_012,ws_tip_emp,ws_des_tip,ws_etq_011,ws_etq_013,ws_rfc_uno,ws_rfc_dos,ws_key_ims,ws_rfc_c01,ws_rfc_c02,ws_reg_im1,ws_reg_im2,'AUXILIAR',0,0,wd_var_fec,ws_rec_urp); COMMIT;
		END IF;
	IF (k=2 ) THEN
	UPDATE LABPROD.glwkcrys SET cry_chr029=ws_key_con,cry_dec004=wn_imp_mov,cry_dec003=NULL,cry_chr007=ws_des_con
	WHERE cry_nomrep=ws_nom_rep
	AND cry_idepcc=ws_ide_pcc
	AND cry_keyusu=wn_key_usu
	AND cry_numsec=-1
	AND cry_dec007=wn_key_emp
	AND cry_chr037='AUXILIAR'; COMMIT;
		END IF;
	IF (k=3 ) THEN
	UPDATE LABPROD.glwkcrys SET cry_chr038=ws_key_con,cry_dec015=wn_imp_mov,cry_chr003=ws_des_con
	WHERE cry_nomrep=ws_nom_rep
	AND cry_idepcc=ws_ide_pcc
	AND cry_keyusu=wn_key_usu
	AND cry_numsec=-1
	AND cry_dec007=wn_key_emp
	AND cry_chr037='AUXILIAR'; COMMIT;
		END IF;
	IF (k=4 ) THEN
	INSERT INTO LABPROD.glwkcrys( cry_nomrep,cry_idepcc,cry_keyusu,cry_numsec,cry_chr001,cry_dec006,cry_chr009,cry_chr017,cry_dat001,cry_dat002,cry_dec007,cry_chr002,cry_chr012,cry_chr013,cry_chr004,cry_chr014,cry_chr005,cry_dec011,cry_dec012,cry_chr018,cry_chr006,cry_dec001,cry_dec002,cry_chr019,cry_chr020,cry_chr021,cry_chr022,cry_chr023,cry_chr024,cry_chr025,cry_chr026,cry_chr027,cry_chr028,cry_dat003,cry_chr016,cry_chr029,cry_chr007,cry_dec003,cry_dec004,cry_chr015,cry_chr030,cry_dec008,cry_chr008,cry_chr033,cry_chr031,cry_chr010,cry_chr032,cry_chr034,cry_chr035,cry_chr036,cry_chr039,cry_chr044,cry_chr045,cry_chr042,cry_chr043,cry_chr037,cry_dec014,cry_dec016,cry_dat005,cry_chr011)
		VALUES(             ws_nom_rep,ws_ide_pcc,wn_key_usu,0,         ws_des_cor,wn_tip_nom,ws_des_nom,NULL,      wd_fec_ini,wd_fec_fin,wn_key_emp,ws_nom_emp,ws_reg_rfc,ws_key_dep,ws_des_dep,ws_key_pue,ws_des_pue,wn_sal_dia,wn_sal_int,ws_key_con,ws_des_con,0,         wn_imp_mov,ws_etq_001,ws_etq_002,ws_etq_003,ws_etq_004,ws_etq_005,ws_etq_006,ws_etq_007,ws_etq_008,ws_etq_009,ws_hor_act,wd_de_baja,ws_des_loc,NULL,      NULL,      0,         0,         ws_key_loc,ws_etq_010,wn_key_pro,ws_des_pro,ws_etq_012,ws_tip_emp,ws_des_tip,ws_etq_011,ws_etq_013,ws_rfc_uno,ws_rfc_dos,ws_key_ims,ws_rfc_c01,ws_rfc_c02,ws_reg_im1,ws_reg_im2,'AUXILIAR',0,0,wd_var_fec,ws_rec_urp); COMMIT;
		END IF;
	IF (k=5 ) THEN
	UPDATE LABPROD.glwkcrys SET cry_chr029=ws_key_con,cry_dec004=wn_imp_mov,cry_dec003=NULL,cry_chr007=ws_des_con
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
-- -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  -- ELJM 21.08.2023
  -- APLICAR UPDATE CONCEPTOS A UNIDADES
	-- SE AGREGAN COLUMNAS QUE ESTABAN COMO NULAS
	-- INSERT INTO LABPROD.glwkcrys (cry_nomrep,cry_idepcc,cry_keyusu,cry_numsec,cry_chr001,cry_chr002,cry_chr037,cry_dec007,cry_chr040,cry_chr006,cry_dec005,cry_chr030,cry_dec004)
	INSERT INTO LABPROD.glwkcrys (cry_nomrep,cry_idepcc,cry_keyusu,cry_numsec,cry_chr001,cry_chr002,cry_chr037,cry_dec007,cry_chr040,cry_chr006,cry_dec005,cry_chr030,cry_dec004,
			cry_chr004,cry_chr005, cry_chr008,cry_chr009,cry_chr010,cry_chr011,cry_chr012,cry_chr013,cry_chr014,cry_chr015,cry_chr016,
			cry_chr019,cry_chr020,cry_chr021,cry_chr022,cry_chr023,cry_chr024,cry_chr025,cry_chr026,cry_chr027,cry_chr031,
			cry_chr032,cry_chr033,cry_chr034,cry_chr035,cry_chr036,
			cry_chr039,cry_chr042,cry_chr043,cry_chr044,cry_chr045, cry_dat001,cry_dat002,cry_dat003,cry_dat004,cry_dat005,cry_dec011,cry_dec012)
	SELECT 	ws_nom_rep,ws_ide_pcc,wn_key_usu,rownum + j,ws_des_cor,emp_nomemp,'SAL.INT.',mov_keyemp,mov_keycon,con_descon,mov_import,'Proceso',mov_cantid,
			ws_des_dep,ws_des_pue, ws_des_pro, ws_des_nom, ws_des_tip, ws_rec_urp, ws_reg_rfc,ws_key_dep,ws_key_pue, ws_key_loc, ws_des_loc,
			ws_etq_001,ws_etq_002,ws_etq_003,ws_etq_004,ws_etq_005,ws_etq_006,ws_etq_007,ws_etq_008,ws_etq_009,ws_tip_emp,
			ws_etq_011,ws_etq_012,ws_etq_013,ws_rfc_uno,ws_rfc_dos,
			ws_key_ims,ws_reg_im1,ws_reg_im2,ws_rfc_c01,ws_rfc_c02,wd_fec_ini,wd_fec_fin,wd_de_baja,wd_fec_antig,wd_var_fec, wn_sal_dia,wn_sal_int
	FROM 	LABPROD.nmwkmovt
			INNER JOIN LABPROD.nmloconc ON mov_keycon = con_keycon
			INNER JOIN LABPROD.nmcoempl ON mov_keyemp = emp_keyemp
	WHERE	mov_keypro = wn_key_pro
	AND 	mov_keyper = ws_key_per
	AND 	MOV_KEYEMP IN (SELECT ran_keyemp FROM LABPROD.glwkrang
						WHERE ran_nomrep=ws_nom_rep
						AND ran_idepcc = ws_ide_pcc
						AND ran_keyusu = wn_key_usu
						AND ran_keyemp IS NOT NULL )
	-- AND 	mov_keycon in ('014','016','022','023','028','039','051','073','092','101','255','355','356','639','652','62B','63B','C23','H16','M01','M03','M07','M08','M61','M74')
	-- AND 	mov_keycon in ('014','016','022','023','028','039','051','073','092','101','255','355','356','639','62B','63B','C23','H16','M01','M03','M07','M08','M61','M74')
    -- AND 	mov_keycon in ('014','016','022','023','028','039','051','073','092','101','255','355','356','639','62B','63B','C23','H16','M01','M03','M07','M08','M61','M74','M79','652')
	AND 	mov_keycon IN (SELECT PAM_FOLINI FROM LABPROD.GLCOPAMS WHERE PAM_KEYPAR = 'SINC')
    -- AND 	mov_import <> 0
	ORDER BY mov_keycon;
	UPDATE 	LABPROD.glwkcrys
	SET 	cry_dec005 = cry_dec004
	WHERE 	cry_nomrep = ws_nom_rep
	AND 	cry_idepcc = ws_ide_pcc
	AND 	cry_keyusu = wn_key_usu
	AND 	cry_chr037 = 'SAL.INT.'
	-- AND 	cry_chr040 IN ('028','092','355','356','639','H16','M01','M03','M07','M08','M61','M74');
	-- AND 	cry_chr040 IN ('028','092','355','356','639','H16','M01','M03','M07','M08','M61');
    -- AND 	cry_chr040 IN ('028','092','355','356','639','H16','M01','M03','M07','M08','M61','M79','652');
	 AND 	cry_chr040 IN (SELECT PAM_FOLINI FROM LABPROD.GLCOPAMS WHERE PAM_KEYPAR = 'SINU');
	UPDATE 	LABPROD.glwkcrys
	SET 	cry_dec004 = NULL
	WHERE 	cry_nomrep = ws_nom_rep
	AND 	cry_idepcc = ws_ide_pcc
	AND 	cry_keyusu = wn_key_usu
	AND 	cry_chr037 = 'SAL.INT.';
-- -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	LABPROD.sp_glfechor(ws_fec_act, ws_hor_act);
	UPDATE LABPROD.glcoresu SET res_numreg=wn_num_reg,res_fecfin=ws_fec_act,res_horfin=ws_hor_act,res_status='T'
	WHERE res_idepro=ws_nom_rep
	AND res_idepcc=ws_ide_pcc
	AND res_keyusu=wn_key_usu
	AND res_fecini=ws_fec_act
	AND res_horreg=ws_hor_reg;
    COMMIT;
END;
/
