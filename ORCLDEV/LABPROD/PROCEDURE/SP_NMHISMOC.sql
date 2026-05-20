CREATE OR REPLACE NONEDITIONABLE PROCEDURE "LABPROD"."SP_NMHISMOC" (ws_nom_rep IN VARCHAR2,ws_ide_pcc IN VARCHAR2,wn_key_usu IN  NUMBER,ws_key_men IN VARCHAR2,ws_hor_reg IN VARCHAR2,ws_etq_rep IN VARCHAR2 ) IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
    ws_key_con VARCHAR2(3);
		wn_can_mov NUMBER(16,2);
		wn_imp_mov NUMBER(16,2);
		ws_key_per VARCHAR2(7);
		wn_key_pro NUMBER(10);
		ws_des_pro VARCHAR2(20);
		wn_key_emp NUMBER(10);
		wn_emp_ant NUMBER(10);
		ws_nom_emp VARCHAR2(60);
		ws_des_lis VARCHAR2(40);
		ws_var_xxx VARCHAR2(50);
		ws_des_con VARCHAR2(40);
		ws_des_cor VARCHAR2(60);
		ws_con_ant VARCHAR2(3);
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
		ws_dsp_cam VARCHAR2(1);
		wn_dsp_001 NUMBER(5);
		wn_dsp_002 NUMBER(5);
		wn_dsp_003 NUMBER(5);
		wn_dsp_004 NUMBER(5);
		wn_dsp_005 NUMBER(5);
		ws_hor_act VARCHAR2(8);
		ws_fec_act DATE;
		ws_key_cia VARCHAR2(5);
		ws_cod_imp VARCHAR2(2);
		ws_cod_ant VARCHAR2(2);
BEGIN
	LABPROD.sp_glfechor(ws_fec_act, ws_hor_act);
	DELETE FROM LABPROD.glwkcrys
	WHERE cry_nomrep=ws_nom_rep
	AND cry_idepcc=ws_ide_pcc
	AND cry_keyusu=wn_key_usu;
--GSA
  -- Extrae el nombre de la Compania --
	ws_des_cor := 'CORPORATIVO NO REGISTRADO ...';
	FOR  c_descor IN
		(SELECT pro_keycia	FROM LABPROD.nmloproc
		WHERE pro_keypro  in (SELECT his_keypro from LABPROD.nmwkhism
            	   WHERE  his_idepcc = ws_ide_pcc)) LOOP
    ws_key_cia:=c_descor.pro_keycia;
		--IF ws_key_cia != '' THEN
			BEGIN SELECT cia_descia INTO ws_des_cor
			  FROM LABPROD.nmlocias    WHERE cia_keycia = ws_key_cia;
			  		      EXCEPTION
			  WHEN NO_DATA_FOUND THEN
			 	     ws_des_cor := 'CORPORATIVO NO REGISTRADO ...';
             --NULL;
		    END;
		--END IF;
	END LOOP;
--/GSA
	ws_etq_001:='....';
	ws_etq_002:='....';
	ws_etq_003:='....';
	ws_etq_004:='....';
	ws_etq_005:='....';
	ws_etq_007:='....';
	FOR c_etiqueta IN ( SELECT cam_keycam, cam_descor FROM LABPROD.glcocamp
	WHERE cam_keytab='nmlohism' ) LOOP
		ws_key_cam :=c_etiqueta.cam_keycam;
			ws_des_etq :=c_etiqueta.cam_descor;
			 IF ws_key_cam='his_keycon' THEN
			ws_etq_001:=ws_des_etq;
	ELSIF ws_key_cam='his_cantid' THEN
			ws_etq_002:=ws_des_etq;
	ELSIF ws_key_cam='his_import' THEN
			ws_etq_003:=ws_des_etq;
	ELSIF ws_key_cam='his_keyper' THEN
			ws_etq_004:=ws_des_etq;
	ELSIF ws_key_cam='his_keypro' THEN
			ws_etq_005:=ws_des_etq;
	ELSIF ws_key_cam='his_keyemp' THEN
			ws_etq_007:=ws_des_etq;
	  END IF;
	END LOOP;
	ws_etq_006:='DESCRIP';
	BEGIN SELECT cam_descor	INTO ws_etq_006 FROM LABPROD.glcocamp	WHERE cam_keytab='nmloconc'
	AND cam_keycam='con_descon';
			      EXCEPTION
			  WHEN NO_DATA_FOUND THEN
			  	     NULL;
    END;
	ws_etq_008:='NOMBRE';
	BEGIN SELECT cam_descor	INTO ws_etq_008 FROM LABPROD.glcocamp	WHERE cam_keytab='nmcoempl'
	AND cam_keycam='emp_nomemp';
			      EXCEPTION
			  WHEN NO_DATA_FOUND THEN
			  	     NULL;
    END;
	wn_dsp_001:=0;
	wn_dsp_002:=0;
	wn_dsp_003:=0;
	wn_dsp_004:=0;
	wn_dsp_005:=0;
	LABPROD.sp_glNewDsp('nmlohism', 'his_keyemp', ws_key_men,wn_dsp_001);
	LABPROD.sp_glNewDsp('nmlohism', 'his_keycon', ws_key_men,wn_dsp_002);
	LABPROD.sp_glNewDsp('nmlohism', 'his_cantid', ws_key_men,wn_dsp_003);
	sp_glNewDsp('nmlohism', 'his_import', ws_key_men,wn_dsp_004);
	sp_glNewDsp('nmlohism', 'his_keyper', ws_key_men,wn_dsp_005);
	ws_con_ant:='@@@';
    ws_cod_ant:='@@';
	ws_var_xxx:='HISTORICO DE MOVIMIENTOS';
--	SELECT lis_deslis	INTO ws_var_xxx FROM glcolist WHERE lis_keylis = ws_etq_rep;
	BEGIN SELECT lis_deslis	INTO ws_var_xxx FROM LABPROD.glcolist WHERE lis_keylis = ws_etq_rep;
		      EXCEPTION
			  WHEN NO_DATA_FOUND THEN
			  	     NULL;
    END;
	ws_des_lis:= SUBSTR(ws_var_xxx,1,40);
	wn_emp_ant:=-1;
FOR c_nmhismoc IN ( SELECT his_keycon, his_keyemp, his_import,his_cantid, his_keyper, his_keypro, his_codimp
  FROM LABPROD.nmwkhism
	WHERE his_idepcc=ws_ide_pcc ORDER BY 7,1,2) LOOP
      ws_key_con :=c_nmhismoc.his_keycon;
			wn_key_emp :=c_nmhismoc.his_keyemp;
			wn_imp_mov :=c_nmhismoc.his_import;
			wn_can_mov :=c_nmhismoc.his_cantid;
			ws_key_per :=c_nmhismoc.his_keyper;
			wn_key_pro :=c_nmhismoc.his_keypro;
			ws_cod_imp :=c_nmhismoc.his_codimp;
--<gsa>
	IF ws_cod_imp <> ws_cod_ant THEN
      ws_cod_ant := ws_cod_imp;
      ws_con_ant := '@@@';
	END IF;
--</gsa>
	ws_des_con:='CONCEPTO NO EXISTE ..';
	IF (ws_key_con != ws_con_ant ) THEN
		BEGIN SELECT con_descon	INTO ws_des_con FROM LABPROD.nmloconc	WHERE con_keycon=ws_key_con;
				      EXCEPTION
			  WHEN NO_DATA_FOUND THEN
			  	     NULL;
        END;
		ws_con_ant:=ws_key_con;
	END IF;
	ws_des_pro:='PROCESO NO EXISTE';
	BEGIN SELECT pro_despro	INTO ws_des_pro FROM LABPROD.nmloproc	WHERE pro_keypro=wn_key_pro;
			      EXCEPTION
			  WHEN NO_DATA_FOUND THEN
			  	     NULL;
    END;
	IF (wn_emp_ant!=wn_key_emp ) THEN
		wn_emp_ant:=wn_key_emp;
		ws_nom_emp := 'Empleado no existe';
		BEGIN SELECT emp_nomemp INTO ws_nom_emp FROM LABPROD.nmcoempl WHERE emp_keyemp = wn_key_emp;
		      EXCEPTION
			  WHEN NO_DATA_FOUND THEN
			  	     NULL;
        END;
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
		wn_can_mov:=NULL;
	END IF;
	IF (wn_dsp_004=1 ) THEN
	   wn_imp_mov:=NULL;
	END IF;
	IF (wn_dsp_005=1 ) THEN
		ws_key_per:=NULL;
	END IF;
		INSERT INTO LABPROD.glwkcrys( cry_nomrep,cry_idepcc,cry_keyusu,cry_chr001,cry_chr017,cry_dec007,cry_chr002,cry_chr018,cry_chr006,cry_dec001,cry_dec002,cry_chr019,cry_chr020,cry_chr021,cry_chr022,cry_chr023,cry_chr028,cry_dat003,cry_chr029,cry_chr024,cry_chr025,cry_chr003,cry_dec008,cry_chr008,cry_chr030)
                 	       VALUES(ws_nom_rep,ws_ide_pcc,wn_key_usu,ws_des_cor,ws_key_per,wn_key_emp,ws_nom_emp,ws_key_con,ws_des_con,wn_can_mov,wn_imp_mov,ws_etq_001,ws_etq_002,ws_etq_003,ws_etq_004,ws_etq_005,ws_hor_act,ws_fec_act,ws_etq_006,ws_etq_007,ws_etq_008,ws_des_lis,wn_key_pro,ws_des_pro,ws_cod_imp);
		commit;
END LOOP;
END;
/
