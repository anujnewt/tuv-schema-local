CREATE OR REPLACE NONEDITIONABLE PROCEDURE "LABPROD"."SP_NMREPPRE" (ws_nom_rep IN VARCHAR2,ws_ide_pcc IN VARCHAR2,wn_key_usu IN  NUMBER,ws_key_men IN VARCHAR2,ws_hor_reg IN VARCHAR2,ws_sta_tu1 IN VARCHAR2,ws_sta_tu2 IN VARCHAR2,ws_sta_tu3 IN VARCHAR2,ws_sta_tu4 IN VARCHAR2,wn_key_pro IN NUMBER,ws_des_pro IN VARCHAR2 ) IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
	wn_num_tem NUMBER(10);
		ws_key_con VARCHAR2(3);
		ws_des_con VARCHAR2(30);
		wn_key_emp NUMBER(10);
		ws_nom_emp VARCHAR2(60);
		ws_fec_reg DATE;
		wn_uni_pre NUMBER(12,2);
		wn_imp_pre NUMBER(12,2);
		wn_uni_sal NUMBER(12,2);
		wn_imp_sal NUMBER(12,2);
		wn_pla_zop NUMBER(10);
		wn_por_int NUMBER(6,4);
		wn_num_pag NUMBER(10);
		ws_per_ini VARCHAR2(7);
		ws_ref_ere VARCHAR2(20);
		ws_des_cor VARCHAR2(60);
		ws_des_lis VARCHAR2(50);
		ws_sta_tus VARCHAR2(1);
		ws_key_cia VARCHAR2(5);
		wn_uni_des NUMBER(12,2);
		wn_imp_des NUMBER(12,2);
		wn_uni_amo NUMBER(12,2);
		wn_imp_amo NUMBER(12,2);
		wn_gas_tos NUMBER(12,2);
		wn_cve_aut NUMBER(10);
		wd_fe1_aux DATE;
		wd_fe2_aux DATE;
		ws_fe2_aux VARCHAR2(15);
		wd_fec_hab DATE;
		wd_fec_aut DATE;
		ws_ca1_aux VARCHAR2(10);
		ws_ca2_aux VARCHAR2(10);
		ws_ca3_aux VARCHAR2(10);
		ws_ca4_aux VARCHAR2(10);
		wd_ult_act DATE;
		ws_ult_act VARCHAR2(15);
		wd_fec_ini DATE;
		ws_fec_ini VARCHAR2(15);
		ws_ctr_eve VARCHAR2(16);
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
		ws_etq_014 VARCHAR2(8);
		ws_etq_015 VARCHAR2(8);
		ws_etq_016 VARCHAR2(8);
		ws_etq_017 VARCHAR2(8);
		ws_etq_018 VARCHAR2(8);
		ws_etq_019 VARCHAR2(8);
		ws_etq_020 VARCHAR2(8);
		ws_etq_021 VARCHAR2(8);
		ws_etq_022 VARCHAR2(8);
		ws_etq_023 VARCHAR2(8);
		ws_etq_024 VARCHAR2(8);
		ws_etq_025 VARCHAR2(8);
		ws_etq_026 VARCHAR2(8);
		wn_dsp_001 NUMBER(5);
		wn_dsp_003 NUMBER(5);
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
		wn_tot_reg NUMBER(10);
		wn_num_reg NUMBER(10);
		wn_pct_reg NUMBER(6,2);
		wn_pct_act NUMBER(5);
		ws_hor_act VARCHAR2(8);
		wd_fec_act DATE;
		wn_pro_ant NUMBER(10);
		wn_nom_ant NUMBER(10);
		BEGIN
	BEGIN SELECT  COUNT(* ) alias1
	INTO wn_tot_reg FROM LABPROD.nmlopres
	WHERE pre_keypro = wn_key_pro
	AND pre_keycon IN (
	SELECT ran_keycon FROM LABPROD.glwkrang
	WHERE ran_nomrep = ws_nom_rep
	AND ran_idepcc = ws_ide_pcc
	AND ran_keyusu = wn_key_usu
	AND ran_keycon IS NOT NULL
	AND ran_keyemp IS NOT NULL )
	AND pre_keyemp IN (
	SELECT ran_keyemp FROM LABPROD.glwkrang
	WHERE ran_nomrep = ws_nom_rep
	AND ran_idepcc = ws_ide_pcc
	AND ran_keyusu = wn_key_usu
	AND ran_keyemp IS NOT NULL
	AND ran_keycon IS NOT NULL )
	AND ((pre_status = ws_sta_tu1) OR (pre_status = ws_sta_tu2) OR (pre_status = ws_sta_tu3) OR (pre_status = ws_sta_tu4));
EXCEPTION
 WHEN NO_DATA_FOUND THEN
  NULL;
  END;
  LABPROD.sp_glfechor(wd_fec_act, ws_hor_act);
	INSERT INTO LABPROD.glcoresu( res_idepro,res_idepcc,res_keyusu,res_fecini,res_horini,res_horreg,res_totreg,res_status)
		VALUES(ws_nom_rep,ws_ide_pcc,wn_key_usu,wd_fec_act,ws_hor_act,ws_hor_reg,wn_tot_reg,'P'); COMMIT;
		DELETE FROM LABPROD.glwkcrys
	WHERE cry_nomrep = ws_nom_rep
	AND cry_idepcc = ws_ide_pcc
	AND cry_keyusu = wn_key_usu; COMMIT;
		ws_key_cia:='*';
	BEGIN SELECT pro_keycia
	INTO ws_key_cia FROM LABPROD.nmloproc
	WHERE pro_keypro = wn_key_pro;
EXCEPTION
 WHEN NO_DATA_FOUND THEN
  NULL;
  END;
  ws_des_cor:='EMPRESA NO EXISTE ..';
	BEGIN SELECT cia_descia
	INTO ws_des_cor FROM LABPROD.nmlocias
	WHERE cia_keycia = ws_key_cia;
EXCEPTION
 WHEN NO_DATA_FOUND THEN
  NULL;
  END;
  ws_des_lis:='No existe nombre del Reporte';
	BEGIN SELECT lis_deslis
	INTO ws_des_lis FROM LABPROD.glcolist
	WHERE lis_keylis = ws_nom_rep;
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
	ws_etq_008:='........';
	ws_etq_009:='........';
	ws_etq_010:='........';
	ws_etq_011:='........';
	ws_etq_012:='........';
	ws_etq_013:='........';
	ws_etq_014:='........';
	ws_etq_015:='........';
	ws_etq_016:='........';
	ws_etq_017:='........';
	ws_etq_018:='........';
	ws_etq_019:='........';
	ws_etq_020:='........';
	ws_etq_021:='........';
	ws_etq_022:='........';
	ws_etq_023:='........';
	ws_etq_024:='........';
	ws_etq_025:='........';
	ws_etq_026:='........';
	FOR c_etiqueta IN ( SELECT cam_keycam, cam_descor FROM LABPROD.glcocamp
	WHERE cam_keytab IN ('nmlopres','nmloconc','nmcoempl') ) LOOP
		ws_key_cam :=c_etiqueta.cam_keycam;
			ws_des_etq :=c_etiqueta.cam_descor;
	IF (ws_key_cam='pre_keycon' ) THEN
	ws_etq_001:=ws_des_etq;
	 ELSE
	IF (ws_key_cam='con_descon' ) THEN
	ws_etq_002:=ws_des_etq;
	 ELSE
	IF (ws_key_cam='pre_keyemp' ) THEN
	ws_etq_003:=ws_des_etq;
	 ELSE
	IF (ws_key_cam='emp_nomemp' ) THEN
	ws_etq_004:=ws_des_etq;
	 ELSE
	IF (ws_key_cam='pre_fecreg' ) THEN
	ws_etq_005:=ws_des_etq;
	 ELSE
	IF (ws_key_cam='pre_unipre' ) THEN
	ws_etq_006:=ws_des_etq;
	 ELSE
	IF (ws_key_cam='pre_imppre' ) THEN
	ws_etq_007:=ws_des_etq;
	 ELSE
	IF (ws_key_cam='pre_unisal' ) THEN
	ws_etq_008:=ws_des_etq;
	 ELSE
	IF (ws_key_cam='pre_impsal' ) THEN
	ws_etq_009:=ws_des_etq;
	 ELSE
	IF (ws_key_cam='pre_plazop' ) THEN
	ws_etq_010:=ws_des_etq;
	 ELSE
	IF (ws_key_cam='pre_porint' ) THEN
	ws_etq_011:=ws_des_etq;
	 ELSE
	IF (ws_key_cam='pre_numpag' ) THEN
	ws_etq_012:=ws_des_etq;
	 ELSE
	IF (ws_key_cam='pre_perini' ) THEN
	ws_etq_013:=ws_des_etq;
	 ELSE
	IF (ws_key_cam='pre_status' ) THEN
	ws_etq_014:=ws_des_etq;
	 ELSE
	IF (ws_key_cam='pre_refere' ) THEN
	ws_etq_015:=ws_des_etq;
	 ELSE
	IF (ws_key_cam='pre_unides' ) THEN
	ws_etq_016:=ws_des_etq;
	 ELSE
	IF (ws_key_cam='pre_impdes' ) THEN
	ws_etq_017:=ws_des_etq;
	 ELSE
	IF (ws_key_cam='pre_uniamo' ) THEN
	ws_etq_018:=ws_des_etq;
	 ELSE
	IF (ws_key_cam='pre_impamo' ) THEN
	ws_etq_019:=ws_des_etq;
	 ELSE
	IF (ws_key_cam='pre_gastos' ) THEN
	ws_etq_020:=ws_des_etq;
	 ELSE
	IF (ws_key_cam='pre_fecini' ) THEN
	ws_etq_021:=ws_des_etq;
	 ELSE
	IF (ws_key_cam='pre_fecaut' ) THEN
	ws_etq_022:=ws_des_etq;
	 ELSE
	IF (ws_key_cam='pre_cveacut' ) THEN
	ws_etq_023:=ws_des_etq;
	 ELSE
	IF (ws_key_cam='pre_fechab' ) THEN
	ws_etq_024:=ws_des_etq;
	 ELSE
	IF (ws_key_cam='pre_fe1aux' ) THEN
	ws_etq_025:=ws_des_etq;
	 ELSE
	IF (ws_key_cam='pre_fe2aux' ) THEN
	ws_etq_026:=ws_des_etq;
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
		END IF;
		END IF;
	END LOOP;
	LABPROD.sp_glnewdsp('nmlopres', 'pre_keycon', ws_key_men,wn_dsp_001);
	LABPROD.sp_glnewdsp('nmlopres', 'pre_keyemp', ws_key_men,wn_dsp_003);
	LABPROD.sp_glnewdsp('nmlopres', 'pre_fecreg', ws_key_men,wn_dsp_005);
	LABPROD.sp_glnewdsp('nmlopres', 'pre_unipre', ws_key_men,wn_dsp_006);
	LABPROD.sp_glnewdsp('nmlopres', 'pre_imppre', ws_key_men,wn_dsp_007);
	LABPROD.sp_glnewdsp('nmlopres', 'pre_unisal', ws_key_men,wn_dsp_008);
	LABPROD.sp_glnewdsp('nmlopres', 'per_impsal', ws_key_men,wn_dsp_009);
	LABPROD.sp_glnewdsp('nmlopres', 'pre_plazop', ws_key_men,wn_dsp_010);
	LABPROD.sp_glnewdsp('nmlopres', 'pre_porint', ws_key_men,wn_dsp_011);
	LABPROD.sp_glnewdsp('nmlopres', 'pre_numpag', ws_key_men,wn_dsp_012);
	LABPROD.sp_glnewdsp('nmlopres', 'pre_perini', ws_key_men,wn_dsp_013);
	LABPROD.sp_glnewdsp('nmlopres', 'pre_status', ws_key_men,wn_dsp_014);
	LABPROD.sp_glnewdsp('nmlopres', 'pre_refere', ws_key_men,wn_dsp_015);
	LABPROD.sp_glnewdsp('nmlopres', 'pre_unides', ws_key_men,wn_dsp_016);
	LABPROD.sp_glnewdsp('nmlopres', 'pre_impdes', ws_key_men,wn_dsp_017);
	LABPROD.sp_glnewdsp('nmlopres', 'pre_uniamo', ws_key_men,wn_dsp_018);
	LABPROD.sp_glnewdsp('nmlopres', 'pre_impamo', ws_key_men,wn_dsp_019);
	LABPROD.sp_glnewdsp('nmlopres', 'pre_gastos', ws_key_men,wn_dsp_020);
	LABPROD.sp_glnewdsp('nmlopres', 'pre_fecini', ws_key_men,wn_dsp_021);
	LABPROD.sp_glnewdsp('nmlopres', 'pre_fecaut', ws_key_men,wn_dsp_022);
	LABPROD.sp_glnewdsp('nmlopres', 'pre_cveaut', ws_key_men,wn_dsp_023);
	LABPROD.sp_glnewdsp('nmlopres', 'pre_fechab', ws_key_men,wn_dsp_024);
	LABPROD.sp_glnewdsp('nmlopres', 'pre_fe1aux', ws_key_men,wn_dsp_025);
	LABPROD.sp_glnewdsp('nmlopres', 'pre_fe2aux', ws_key_men,wn_dsp_026);
	wn_pro_ant:=-32760;
	wn_nom_ant:=-32760;
	wn_num_reg:=0;
	wn_pct_act:=1;
	wn_pct_reg:=(wn_tot_reg/10.0);
	FOR c_nmlstpre IN ( SELECT pre_keycon, pre_keyemp, pre_fecreg, pre_unipre, pre_imppre, pre_unisal, pre_impsal, pre_plazop, pre_porint, pre_numpag, pre_perini, pre_status, pre_refere, pre_unides, pre_impdes, pre_uniamo, pre_impamo, pre_gastos, pre_cveaut, pre_fe1aux, pre_fe2aux, pre_fechab, pre_fecaut, pre_ca1aux, pre_ca2aux, pre_ca3aux, pre_ca4aux, pre_ultact, pre_fecini, pre_ctreve
	FROM LABPROD.nmlopres
	WHERE pre_keypro = wn_key_pro
	AND pre_keycon IN (
	SELECT ran_keycon FROM LABPROD.glwkrang
	WHERE ran_nomrep = ws_nom_rep
	AND ran_idepcc = ws_ide_pcc
	AND ran_keyusu = wn_key_usu
	AND ran_keycon IS NOT NULL
	AND ran_keyemp IS NOT NULL )
	AND pre_keyemp IN (
	SELECT ran_keyemp FROM LABPROD.glwkrang
	WHERE ran_nomrep = ws_nom_rep
	AND ran_idepcc = ws_ide_pcc
	AND ran_keyusu = wn_key_usu
	AND ran_keyemp IS NOT NULL
	AND ran_keycon IS NOT NULL )
	AND ((pre_status = ws_sta_tu1) OR (pre_status = ws_sta_tu2) OR (pre_status = ws_sta_tu3) OR (pre_status = ws_sta_tu4))
	ORDER BY pre_keycon,pre_keyemp ) LOOP
		ws_key_con :=c_nmlstpre.pre_keycon;
			wn_key_emp :=c_nmlstpre.pre_keyemp;
			ws_fec_reg :=c_nmlstpre.pre_fecreg;
			wn_uni_pre :=c_nmlstpre.pre_unipre;
			wn_imp_pre :=c_nmlstpre.pre_imppre;
			wn_uni_sal :=c_nmlstpre.pre_unisal;
			wn_imp_sal :=c_nmlstpre.pre_impsal;
			wn_pla_zop :=c_nmlstpre.pre_plazop;
			wn_por_int :=c_nmlstpre.pre_porint;
			wn_num_pag :=c_nmlstpre.pre_numpag;
			ws_per_ini :=c_nmlstpre.pre_perini;
			ws_sta_tus :=c_nmlstpre.pre_status;
			ws_ref_ere :=c_nmlstpre.pre_refere;
			wn_uni_des :=c_nmlstpre.pre_unides;
			wn_imp_des :=c_nmlstpre.pre_impdes;
			wn_uni_amo :=c_nmlstpre.pre_uniamo;
			wn_imp_amo :=c_nmlstpre.pre_impamo;
			wn_gas_tos :=c_nmlstpre.pre_gastos;
			wn_cve_aut :=c_nmlstpre.pre_cveaut;
			wd_fe1_aux :=c_nmlstpre.pre_fe1aux;
			wd_fe2_aux :=c_nmlstpre.pre_fe2aux;
			wd_fec_hab :=c_nmlstpre.pre_fechab;
			wd_fec_aut :=c_nmlstpre.pre_fecaut;
			ws_ca1_aux :=c_nmlstpre.pre_ca1aux;
			ws_ca2_aux :=c_nmlstpre.pre_ca2aux;
			ws_ca3_aux :=c_nmlstpre.pre_ca3aux;
			ws_ca4_aux :=c_nmlstpre.pre_ca4aux;
			wd_ult_act :=c_nmlstpre.pre_ultact;
			wd_fec_ini :=c_nmlstpre.pre_fecini;
			ws_ctr_eve :=c_nmlstpre.pre_ctreve;
			wn_num_reg:=(wn_num_reg+1);
	wn_num_tem:=(wn_pct_reg*wn_pct_act);
	IF (wn_num_reg>=wn_num_tem ) THEN
	UPDATE LABPROD.glcoresu SET res_numreg=wn_num_reg
	WHERE res_idepro = ws_nom_rep
	AND res_idepcc = ws_ide_pcc
	AND res_keyusu = wn_key_usu
	AND res_fecini = wd_fec_act
	AND res_horreg = ws_hor_reg; COMMIT;
		END IF;
		ws_des_con:='CONCEPTO NO EXISTE';
	BEGIN SELECT con_descon
	INTO ws_des_con FROM LABPROD.nmloconc
	WHERE con_keycon = ws_key_con;
EXCEPTION
 WHEN NO_DATA_FOUND THEN
  NULL;
  END;
  ws_nom_emp:='EMPLEADO NO EXISTE';
	BEGIN SELECT emp_nomemp
	INTO ws_nom_emp FROM LABPROD.nmcoempl
	WHERE emp_keyemp = wn_key_emp;
EXCEPTION
 WHEN NO_DATA_FOUND THEN
  NULL;
  END;
  ws_nom_emp:= SUBSTR(ws_nom_emp,1,40);
	IF (wn_dsp_001=1 ) THEN
	ws_key_con:=NULL;
	ws_des_con:=NULL;
	END IF;
	IF (wn_dsp_003=1 ) THEN
	wn_key_emp:=NULL;
	ws_nom_emp:=NULL;
	END IF;
		ws_fec_ini:= TO_CHAR(wd_fec_ini, 'mm/dd/yyyy');
	ws_fec_ini:=SUBSTR(ws_fec_ini,1,2) || SUBSTR(ws_fec_ini,4,2) || SUBSTR(ws_fec_ini,7,4);
	ws_fe2_aux:= TO_CHAR(wd_fec_ini, 'mm/dd/yyyy');
	ws_fe2_aux:=SUBSTR(ws_fe2_aux,1,2) || SUBSTR(ws_fe2_aux,4,2) || SUBSTR(ws_fe2_aux,7,4);
	ws_ult_act:= TO_CHAR(wd_fec_ini, 'mm/dd/yyyy');
	ws_ult_act:=SUBSTR(ws_ult_act,1,2) || SUBSTR(ws_ult_act,4,2) || SUBSTR(ws_ult_act,7,4);
	IF (wn_dsp_005=1 ) THEN
	ws_fec_reg:=NULL;
	END IF;
	IF (wn_dsp_006=1 ) THEN
	wn_uni_pre:=NULL;
	END IF;
	IF (wn_dsp_007=1 ) THEN
	wn_imp_pre:=NULL;
	END IF;
	IF (wn_dsp_008=1 ) THEN
	wn_uni_sal:=NULL;
	END IF;
	IF (wn_dsp_009=1 ) THEN
	wn_imp_sal:=NULL;
	END IF;
	IF (wn_dsp_010=1 ) THEN
	wn_pla_zop:=NULL;
	END IF;
	IF (wn_dsp_011=1 ) THEN
	wn_por_int:=NULL;
	END IF;
	IF (wn_dsp_012=1 ) THEN
	wn_num_pag:=NULL;
	END IF;
	IF (wn_dsp_013=1 ) THEN
	ws_per_ini:=NULL;
	END IF;
	IF (wn_dsp_014=1 ) THEN
	ws_sta_tus:=NULL;
	END IF;
	IF (wn_dsp_015=1 ) THEN
	ws_ref_ere:=NULL;
	END IF;
	IF (wn_dsp_016=1 ) THEN
	wn_uni_des:=NULL;
	END IF;
	IF (wn_dsp_017=1 ) THEN
	wn_imp_des:=NULL;
	END IF;
	IF (wn_dsp_018=1 ) THEN
	wn_uni_amo:=NULL;
	END IF;
	IF (wn_dsp_019=1 ) THEN
	wn_imp_amo:=NULL;
	END IF;
	IF (wn_dsp_020=1 ) THEN
	wn_gas_tos:=NULL;
	END IF;
	IF (wn_dsp_021=1 ) THEN
	ws_fec_ini:=NULL;
	END IF;
	IF (wn_dsp_022=1 ) THEN
	wd_fec_aut:=NULL;
	END IF;
	IF (wn_dsp_023=1 ) THEN
	wn_cve_aut:=NULL;
	END IF;
	IF (wn_dsp_024=1 ) THEN
	wd_fec_hab:=NULL;
	END IF;
	IF (wn_dsp_025=1 ) THEN
	wd_fe1_aux:=NULL;
	END IF;
	IF (wn_dsp_026=1 ) THEN
	ws_fe2_aux:=NULL;
	END IF;
		INSERT INTO LABPROD.glwkcrys( cry_nomrep,cry_idepcc,cry_keyusu,cry_chr001,cry_chr017,cry_chr003,cry_dec006,cry_chr004,cry_dat001,cry_dec001,cry_dec012,cry_dec013,cry_dec014,cry_dec007,cry_dec015,cry_dec008,cry_chr018,cry_chr019,cry_chr008,cry_chr020,cry_chr021,cry_chr022,cry_chr023,cry_chr024,cry_chr026,cry_chr027,cry_chr028,cry_chr029,cry_chr030,cry_chr031,cry_chr032,cry_chr033,cry_chr034,cry_chr035,cry_chr037,cry_chr038,cry_chr039,cry_chr040,cry_chr043,cry_chr041,cry_chr042,cry_chr044,cry_chr045,cry_chr025,cry_chr009,cry_dat002,cry_chr036,cry_chr002,cry_dec009,cry_chr010,cry_dec021,cry_dec022,cry_dec023,cry_dec024,cry_dec016,cry_dec010,cry_dat005,cry_chr011,cry_dat004,cry_dat003,cry_chr013,cry_chr014,cry_chr015,cry_chr016,cry_chr012,cry_chr007,cry_chr006)
		VALUES(ws_nom_rep,ws_ide_pcc,wn_key_usu,ws_des_cor,ws_key_con,ws_des_con,wn_key_emp,ws_nom_emp,ws_fec_reg,wn_uni_pre,wn_imp_pre,wn_uni_sal,wn_imp_sal,wn_pla_zop,wn_por_int,wn_num_pag,ws_per_ini,ws_sta_tus,ws_ref_ere,ws_etq_001,ws_etq_002,ws_etq_003,ws_etq_004,ws_etq_005,ws_etq_006,ws_etq_007,ws_etq_008,ws_etq_009,ws_etq_010,ws_etq_011,ws_etq_012,ws_etq_013,ws_etq_014,ws_etq_015,ws_etq_016,ws_etq_017,ws_etq_018,ws_etq_019,ws_etq_020,ws_etq_021,ws_etq_022,ws_etq_023,ws_etq_024,ws_etq_025,ws_etq_026,wd_fec_act,ws_hor_act,ws_des_lis,wn_key_pro,ws_des_pro,wn_uni_des,wn_imp_des,wn_uni_amo,wn_imp_amo,wn_gas_tos,wn_cve_aut,wd_fe1_aux,ws_fe2_aux,wd_fec_hab,wd_fec_aut,ws_ca1_aux,ws_ca2_aux,ws_ca3_aux,ws_ca4_aux,ws_ult_act,ws_fec_ini,ws_ctr_eve); COMMIT;
	END LOOP;
	LABPROD.sp_glfechor(wd_fec_act, ws_hor_act);
	UPDATE LABPROD.glcoresu SET res_numreg=wn_num_reg,res_fecfin=wd_fec_act,res_horfin=ws_hor_act,res_status='T'
	WHERE res_idepro = ws_nom_rep
	AND res_idepcc = ws_ide_pcc
	AND res_keyusu = wn_key_usu
	AND res_fecini = wd_fec_act
	AND res_horreg = ws_hor_reg; COMMIT;
END;
/
