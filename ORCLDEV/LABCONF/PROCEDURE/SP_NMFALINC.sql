CREATE OR REPLACE EDITIONABLE PROCEDURE "LABCONF"."SP_NMFALINC" (ws_nom_rep IN VARCHAR2,ws_ide_pcc IN VARCHAR2,wn_key_usu IN  NUMBER,ws_key_men IN VARCHAR2,ws_hor_reg IN VARCHAR2,ws_fec_ha1 IN VARCHAR2,ws_fec_ha2 IN VARCHAR2 ) IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
	wn_key_emp NUMBER(10);
		ws_fec_ini DATE;
		ws_fec_exp DATE;
		wn_dia_inc NUMBER(5);
		ws_con_inc VARCHAR2(1);
		ws_num_inc VARCHAR2(14);
		ws_tip_ims VARCHAR2(2);
		ws_tip_emp VARCHAR2(6);
		wn_dia_noa NUMBER(5);
		ws_emi_inc VARCHAR2(20);
		ws_key_ims VARCHAR2(5);
		ws_ant_ims VARCHAR2(5);
		ws_des_ims VARCHAR2(40);
		ws_des_lis VARCHAR2(50);
		ws_var_xxx VARCHAR2(50);
		ws_rec_aid VARCHAR2(1);
		ws_cir_inc VARCHAR2(2);
		ws_pro_rie VARCHAR2(1);
		ws_tip_rie VARCHAR2(1);
		ws_tip_dic VARCHAR2(1);
		wn_por_val NUMBER(6,2);
		wn_fol_st1 NUMBER(10);
		wn_fol_st2 NUMBER(10);
		wn_fol_st3 NUMBER(10);
		wn_fol_st4 NUMBER(10);
		ws_des_tan VARCHAR2(40);
		ws_des_tab VARCHAR2(40);
		ws_des_cor VARCHAR2(60);
		ws_tab_ant NUMBER(5);
		wn_row_ide NUMBER(10);
		ws_key_cam VARCHAR2(10);
		ws_des_etq VARCHAR2(10);
		ws_eti_q01 VARCHAR2(10);
		ws_eti_q02 VARCHAR2(10);
		ws_eti_q03 VARCHAR2(10);
		ws_eti_q04 VARCHAR2(10);
		ws_eti_q05 VARCHAR2(10);
		ws_eti_q06 VARCHAR2(10);
		ws_eti_q07 VARCHAR2(10);
		ws_eti_q08 VARCHAR2(10);
		ws_eti_q09 VARCHAR2(10);
		ws_eti_q010 VARCHAR2(10);
		ws_eti_q011 VARCHAR2(10);
		ws_eti_q012 VARCHAR2(10);
		ws_eti_q013 VARCHAR2(10);
		ws_eti_q014 VARCHAR2(10);
		ws_eti_q015 VARCHAR2(10);
		ws_eti_q016 VARCHAR2(10);
		ws_eti_q017 VARCHAR2(10);
		ws_eti_q018 VARCHAR2(10);
		ws_eti_q019 VARCHAR2(10);
		ws_eti_q020 VARCHAR2(10);
		ws_eti_q021 VARCHAR2(10);
		ws_dsp_cam VARCHAR2(20);
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
		wn_tot_reg NUMBER(10);
		wn_num_reg NUMBER(10);
		wn_pct_reg NUMBER(6,2);
		wn_pct_act NUMBER(5);
		ws_hor_act VARCHAR2(8);
		ws_dia_act DATE;
		wn_ant_emp NUMBER(10);
		ws_des_emp VARCHAR2(60);
		wn_num_tem NUMBER(10);
		ws_fec_te1 VARCHAR2(10);
		ws_fec_te2 VARCHAR2(10);
		BEGIN
	IF (ws_fec_ha1='01/01/1700' ) THEN
	ws_fec_te1:='01/01/1900';
	ws_fec_te2:='12/31/2099';
	 ELSE
	ws_fec_te1:=ws_fec_ha1;
	ws_fec_te2:=ws_fec_ha2;
	END IF;
		BEGIN SELECT  COUNT(* ) alias1
	INTO wn_tot_reg FROM nmcofalt
	WHERE fal_keyims IN (
	SELECT ran_keyper FROM glwkrang
	WHERE ran_nomrep = ws_nom_rep
	AND ran_idepcc = ws_ide_pcc
	AND ran_keyusu = wn_key_usu
	AND ran_keyper IS NOT NULL )
	AND fal_keyemp IN (
	SELECT ran_keyemp FROM glwkrang
	WHERE ran_nomrep = ws_nom_rep
	AND ran_idepcc = ws_ide_pcc
	AND ran_keyusu = wn_key_usu
	AND ran_keyemp IS NOT NULL )
	AND fal_tipims IN (
	SELECT ran_keycon FROM glwkrang
	WHERE ran_nomrep = ws_nom_rep
	AND ran_idepcc = ws_ide_pcc
	AND ran_keyusu = wn_key_usu
	AND ran_keycon IS NOT NULL )
	AND fal_fecini BETWEEN ws_fec_te1 AND ws_fec_te2;
EXCEPTION
 WHEN NO_DATA_FOUND THEN
  NULL;
  END;
  sp_glfechor(ws_dia_act, ws_hor_act);
	INSERT INTO glcoresu( res_idepro,res_idepcc,res_keyusu,res_fecini,res_horini,res_horreg,res_totreg,res_status)
		VALUES(ws_nom_rep,ws_ide_pcc,wn_key_usu,ws_dia_act,ws_hor_act,ws_hor_reg,wn_tot_reg,'P'); COMMIT;
		DELETE FROM glwkcrys
	WHERE cry_nomrep = ws_nom_rep
	AND cry_idepcc = ws_ide_pcc
	AND cry_keyusu = wn_key_usu; COMMIT;
		ws_des_cor:='CORPORATIVO NO REGISTRADO';
	BEGIN SELECT cor_razsoc
	INTO ws_des_cor FROM glcocorp;
EXCEPTION
 WHEN NO_DATA_FOUND THEN
  NULL;
  END;
  ws_var_xxx:='No Existe Nombre del Reporte ..';
	BEGIN SELECT lis_deslis
	INTO ws_var_xxx FROM glcolist
	WHERE lis_keylis = ws_nom_rep;
EXCEPTION
 WHEN NO_DATA_FOUND THEN
  NULL;
  END;
  ws_des_lis:= SUBSTR(ws_var_xxx,1,40);
	FOR c_etiquetas IN ( SELECT cam_keycam, cam_descor FROM glcocamp
	WHERE cam_keytab = 'nmcofalt' ) LOOP
		ws_key_cam :=c_etiquetas.cam_keycam;
			ws_des_etq :=c_etiquetas.cam_descor;
	IF (ws_key_cam='fal_keyemp' ) THEN
	ws_eti_q01:=ws_des_etq;
	 ELSE
	IF (ws_key_cam='fal_fecini' ) THEN
	ws_eti_q02:=ws_des_etq;
	 ELSE
	IF (ws_key_cam='fal_fecexp' ) THEN
	ws_eti_q03:=ws_des_etq;
	 ELSE
	IF (ws_key_cam='fal_diainc' ) THEN
	ws_eti_q04:=ws_des_etq;
	 ELSE
	IF (ws_key_cam='fal_coninc' ) THEN
	ws_eti_q05:=ws_des_etq;
	 ELSE
	IF (ws_key_cam='fal_numinc' ) THEN
	ws_eti_q06:=ws_des_etq;
	 ELSE
	IF (ws_key_cam='fal_tipims' ) THEN
	ws_eti_q07:=ws_des_etq;
	 ELSE
	IF (ws_key_cam='fal_tipemp' ) THEN
	ws_eti_q08:=ws_des_etq;
	 ELSE
	IF (ws_key_cam='fal_dianoa' ) THEN
	ws_eti_q09:=ws_des_etq;
	 ELSE
	IF (ws_key_cam='fal_emiinc' ) THEN
	ws_eti_q010:=ws_des_etq;
	 ELSE
	IF (ws_key_cam='fal_keyims' ) THEN
	ws_eti_q011:=ws_des_etq;
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
	sp_glNewDsp('nmcofalt', 'fal_keyemp', ws_key_men,wn_dsp_001);
	sp_glNewDsp('nmcofalt', 'fal_fecini', ws_key_men,wn_dsp_002);
	sp_glNewDsp('nmcofalt', 'fal_fecexp', ws_key_men,wn_dsp_003);
	sp_glNewDsp('nmcofalt', 'fal_diainc', ws_key_men,wn_dsp_004);
	sp_glNewDsp('nmcofalt', 'fal_coninc', ws_key_men,wn_dsp_005);
	sp_glNewDsp('nmcofalt', 'fal_numinc', ws_key_men,wn_dsp_006);
	sp_glNewDsp('nmcofalt', 'fal_tipims', ws_key_men,wn_dsp_007);
	sp_glNewDsp('nmcofalt', 'fal_tipemp', ws_key_men,wn_dsp_008);
	sp_glNewDsp('nmcofalt', 'fal_dianoa', ws_key_men,wn_dsp_009);
	sp_glNewDsp('nmcofalt', 'fal_emiinc', ws_key_men,wn_dsp_010);
	sp_glNewDsp('nmcofalt', 'fal_keyims', ws_key_men,wn_dsp_011);
	sp_glNewDsp('nmcofalt', 'fal_recinc', ws_key_men,wn_dsp_012);
	sp_glNewDsp('nmcofalt', 'fal_cirinc', ws_key_men,wn_dsp_013);
	sp_glNewDsp('nmcofalt', 'fal_prorie', ws_key_men,wn_dsp_014);
	sp_glNewDsp('nmcofalt', 'fal_tiprie', ws_key_men,wn_dsp_015);
	sp_glNewDsp('nmcofalt', 'fal_tipdic', ws_key_men,wn_dsp_016);
	sp_glNewDsp('nmcofalt', 'fal_porval', ws_key_men,wn_dsp_017);
	sp_glNewDsp('nmcofalt', 'fal_falst1', ws_key_men,wn_dsp_018);
	sp_glNewDsp('nmcofalt', 'fal_folst2', ws_key_men,wn_dsp_019);
	sp_glNewDsp('nmcofalt', 'fal_folst3', ws_key_men,wn_dsp_020);
	sp_glNewDsp('nmcofalt', 'fal_folst4', ws_key_men,wn_dsp_021);
	ws_tab_ant:=1;
	wn_num_reg:=0;
	wn_pct_act:=1;
	wn_pct_reg:=(wn_tot_reg/10.0);
	wn_ant_emp:=-9999;
	ws_ant_ims:='-999';
	FOR c_nmfallinc IN ( SELECT fal_keyemp, fal_fecini, fal_fecexp, fal_diainc, fal_coninc, fal_numinc, fal_tipims, fal_tipemp, fal_dianoa, fal_emiinc, fal_keyims, fal_recinc, fal_cirinc, fal_prorie, fal_tiprie, fal_tipdic, fal_porval, fal_folst1, fal_folst2, fal_folst3, fal_folst4 FROM nmcofalt
	WHERE fal_keyims IN (
	SELECT ran_keyper FROM glwkrang
	WHERE ran_nomrep = ws_nom_rep
	AND ran_idepcc = ws_ide_pcc
	AND ran_keyusu = wn_key_usu
	AND ran_keyper IS NOT NULL )
	AND fal_keyemp IN (
	SELECT ran_keyemp FROM glwkrang
	WHERE ran_nomrep = ws_nom_rep
	AND ran_idepcc = ws_ide_pcc
	AND ran_keyusu = wn_key_usu
	AND ran_keyemp IS NOT NULL )
	AND fal_tipims IN (
	SELECT ran_keycon FROM glwkrang
	WHERE ran_nomrep = ws_nom_rep
	AND ran_idepcc = ws_ide_pcc
	AND ran_keyusu = wn_key_usu
	AND ran_keycon IS NOT NULL )
	AND fal_fecini BETWEEN ws_fec_te1 AND ws_fec_te2 ) LOOP
		wn_key_emp :=c_nmfallinc.fal_keyemp;
			ws_fec_ini :=c_nmfallinc.fal_fecini;
			ws_fec_exp :=c_nmfallinc.fal_fecexp;
			wn_dia_inc :=c_nmfallinc.fal_diainc;
			ws_con_inc :=c_nmfallinc.fal_coninc;
			ws_num_inc :=c_nmfallinc.fal_numinc;
			ws_tip_ims :=c_nmfallinc.fal_tipims;
			ws_tip_emp :=c_nmfallinc.fal_tipemp;
			wn_dia_noa :=c_nmfallinc.fal_dianoa;
			ws_emi_inc :=c_nmfallinc.fal_emiinc;
			ws_key_ims :=c_nmfallinc.fal_keyims;
			ws_rec_aid :=c_nmfallinc.fal_recinc;
			ws_cir_inc :=c_nmfallinc.fal_cirinc;
			ws_pro_rie :=c_nmfallinc.fal_prorie;
			ws_tip_rie :=c_nmfallinc.fal_tiprie;
			ws_tip_dic :=c_nmfallinc.fal_tipdic;
			wn_por_val :=c_nmfallinc.fal_porval;
			wn_fol_st1 :=c_nmfallinc.fal_folst1;
			wn_fol_st2 :=c_nmfallinc.fal_folst2;
			wn_fol_st3 :=c_nmfallinc.fal_folst3;
			wn_fol_st4 :=c_nmfallinc.fal_folst4;
	IF (wn_ant_emp != wn_key_emp  ) THEN
	ws_des_emp:='No Existe Nombre  ...';
	BEGIN SELECT emp_nomemp
	INTO ws_des_emp FROM nmcoempl
	WHERE emp_keyemp = wn_key_emp;
EXCEPTION
 WHEN NO_DATA_FOUND THEN
  NULL;
  END;
  wn_ant_emp:=wn_key_emp;
	END IF;
	IF (ws_ant_ims != ws_key_ims ) THEN
	ws_des_ims:='No Existe Descripcion  ...';
	BEGIN SELECT ims_razsoc
	INTO ws_des_ims FROM nmloimss
	WHERE ims_keyims = ws_key_ims;
EXCEPTION
 WHEN NO_DATA_FOUND THEN
  NULL;
  END;
  ws_ant_ims:=ws_key_ims;
	END IF;
		wn_num_reg:=(wn_num_reg+1);
	wn_num_tem:=(wn_pct_reg*wn_pct_act);
	IF (wn_num_reg>=wn_num_tem ) THEN
	UPDATE glcoresu SET res_numreg=wn_num_reg
	WHERE res_idepro = ws_nom_rep
	AND res_idepcc = ws_ide_pcc
	AND res_keyusu = wn_key_usu; COMMIT;
		wn_pct_act:=(wn_pct_act+1);
	END IF;
	IF (wn_dsp_001=1 ) THEN
	wn_key_emp:=0;
	END IF;
	IF (wn_dsp_002=1 ) THEN
	ws_fec_ini:=NULL;
	END IF;
	IF (wn_dsp_003=1 ) THEN
	ws_fec_exp:=NULL;
	END IF;
	IF (wn_dsp_004=1 ) THEN
	wn_dia_inc:=NULL;
	END IF;
	IF (wn_dsp_005=1 ) THEN
	ws_con_inc:=NULL;
	END IF;
	IF (wn_dsp_006=1 ) THEN
	ws_num_inc:=NULL;
	END IF;
	IF (wn_dsp_007=1 ) THEN
	ws_tip_ims:=NULL;
	END IF;
	IF (wn_dsp_008=1 ) THEN
	ws_tip_emp:=NULL;
	END IF;
	IF (wn_dsp_009=1 ) THEN
	wn_dia_noa:=NULL;
	END IF;
	IF (wn_dsp_010=1 ) THEN
	ws_emi_inc:=NULL;
	END IF;
	IF (wn_dsp_011=1 ) THEN
	ws_key_ims:=NULL;
	END IF;
	IF (wn_dsp_012=1 ) THEN
	ws_key_ims:=NULL;
	END IF;
	IF (wn_dsp_013=1 ) THEN
	ws_rec_aid:=NULL;
	END IF;
	IF (wn_dsp_014=1 ) THEN
	ws_cir_inc:=NULL;
	END IF;
	IF (wn_dsp_015=1 ) THEN
	ws_pro_rie:=NULL;
	END IF;
	IF (wn_dsp_016=1 ) THEN
	ws_tip_rie:=NULL;
	END IF;
	IF (wn_dsp_017=1 ) THEN
	ws_tip_dic:=NULL;
	END IF;
	IF (wn_dsp_018=1 ) THEN
	wn_por_val:=NULL;
	END IF;
	IF (wn_dsp_019=1 ) THEN
	wn_fol_st1:=NULL;
	END IF;
	IF (wn_dsp_020=1 ) THEN
	wn_fol_st2:=NULL;
	END IF;
	IF (wn_dsp_021=1 ) THEN
	wn_fol_st3:=NULL;
	END IF;
		INSERT INTO glwkcrys( cry_nomrep,cry_idepcc,cry_keyusu,cry_chr001,cry_dec006,cry_dat001,cry_dat002,cry_dec007,cry_chr017,cry_chr012,cry_chr018,cry_chr019,cry_dec008,cry_chr008,cry_chr020,cry_chr004,cry_chr033,cry_chr034,cry_chr035,cry_chr036,cry_chr037,cry_dec011,cry_dec012,cry_dec013,cry_dec014,cry_dec015,cry_dat003,cry_dec009,cry_chr002,cry_chr003,cry_chr021,cry_chr022,cry_chr023,cry_chr024,cry_chr025,cry_chr026,cry_chr027,cry_chr028,cry_chr029,cry_chr030,cry_chr031,cry_chr032)
		VALUES(ws_nom_rep,ws_ide_pcc,wn_key_usu,ws_des_cor,wn_key_emp,ws_fec_ini,ws_fec_exp,wn_dia_inc,ws_con_inc,ws_num_inc,ws_tip_ims,ws_tip_emp,wn_dia_noa,ws_emi_inc,ws_key_ims,ws_des_ims,ws_rec_aid,ws_cir_inc,ws_pro_rie,ws_tip_rie,ws_tip_dic,wn_por_val,wn_fol_st1,wn_fol_st2,wn_fol_st3,wn_fol_st4,ws_dia_act,wn_tot_reg,ws_des_emp,ws_des_lis,ws_eti_q01,ws_eti_q02,ws_eti_q03,ws_eti_q04,ws_eti_q05,ws_eti_q06,ws_eti_q07,ws_eti_q08,ws_eti_q09,ws_eti_q010,ws_eti_q011,ws_hor_act); COMMIT;
	END LOOP;
	sp_glfechor(ws_dia_act, ws_hor_act);
	UPDATE glcoresu SET res_numreg=wn_num_reg,res_fecfin=ws_dia_act,res_horfin=ws_hor_act,res_status='T'
	WHERE res_idepro = ws_nom_rep
	AND res_idepcc = ws_ide_pcc
	AND res_keyusu = wn_key_usu; COMMIT;
		END;
/
