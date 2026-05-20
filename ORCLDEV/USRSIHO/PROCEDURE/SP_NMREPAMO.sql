CREATE OR REPLACE EDITIONABLE PROCEDURE "USRSIHO"."SP_NMREPAMO" (ws_nom_rep VARCHAR2, ws_ide_pcc VARCHAR2,
  wn_key_usu NUMBER, ws_key_men VARCHAR2, ws_hor_reg VARCHAR2,
  wn_key_pro NUMBER) IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
  -- SIPROS, S.A. DE C.V.
  --
  -- Sistema  : RH-2000 C/S
  -- Modulo   : Administracion de remuneraciones (nm)
  --
  -- Programa : sp_nmreppre
  --            Reporte de Prestamos
  --
  -- Autor    : Gabriela Paredes Romano.
  -- Fecha    : 29 de Septiembre  de 1997.
  --
  -- Variables para obtener los datos de la tabla de prestamos
  wn_key_emp NUMBER(10);
  ws_nom_emp VARCHAR2(50);
  ws_key_con VARCHAR2(3);
  ws_des_con VARCHAR2(50);
  ws_ref_ere VARCHAR2(20);
  wn_uni_pre NUMBER(12,2);
  wn_imp_pre NUMBER(12,2);
  ws_fec_ini DATE;
  wn_uni_sal NUMBER(12,2);
  wn_imp_sal NUMBER(12,2);
  ws_fec_pag DATE;
  wn_uni_pag NUMBER(12,2);
  wn_imp_pag NUMBER(12,2);
  wn_int_pag NUMBER(12,2);
  wn_por_int NUMBER(6,4);
  ws_key_per VARCHAR2(7);
  wn_imp_des NUMBER(12,2);
  wn_uni_des NUMBER(12,2);
  wn_num_pag NUMBER(10);
  wn_pla_zop NUMBER(10);
  ws_sta_tus VARCHAR2(8);
  wn_uni_amo NUMBER(12,2);
  wn_imp_amo NUMBER(12,2);
  wn_uni_ini NUMBER(12,2);
  wn_imp_ini NUMBER(12,2);
  wn_uni_tem NUMBER(12,2);
  wn_imp_tem NUMBER(12,2);
  ws_des_cor VARCHAR2(60);
  ws_des_lis VARCHAR2(50);
  ws_key_cia VARCHAR2(2);
  -- Variables para la carga de las descripciones de las Etiquetas--
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
  -- Variables para las restricciones de despliegue               --
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
  -- Variables para el reporte de avance                          --
  wn_tot_reg NUMBER(10);
  wn_num_reg NUMBER(10);
  wn_pct_reg NUMBER(6,2);
  wn_pct_act NUMBER(5);
  ws_hor_act VARCHAR2(8);
  wd_fec_act DATE;
  wn_pro_ant NUMBER(10);
  wn_nom_ant NUMBER(10);
CURSOR c_lista  IS
    SELECT lis_deslis FROM USRSIHO.glcolist
      WHERE lis_keylis = ws_nom_rep;
CURSOR c_etiqueta IS
    SELECT cam_keycam, cam_descor
        FROM USRSIHO.glcocamp
      WHERE cam_keytab = 'nmlopres' OR cam_keytab = 'nmloamor';
CURSOR c_etiquetas IS
    SELECT cam_keycam, cam_descor
      FROM USRSIHO.glcocamp
      WHERE cam_keytab = 'nmloconc'
      OR cam_keytab='nmcoempl';
CURSOR c_descon IS
      SELECT con_descon FROM USRSIHO.nmloconc
        WHERE con_keycon = ws_key_con;
CURSOR c_nomemp IS
	SELECT emp_nomemp FROM USRSIHO.nmcoempl
	  WHERE emp_keyemp = wn_key_emp;
CURSOR C_nmlstpre  IS
    SELECT pre_keyemp, pre_keycon, pre_refere, pre_unipre, pre_imppre,
           pre_fecini, pre_unisal, pre_impsal, amo_fecpag, amo_unipag,
           amo_imppag, amo_intpag, amo_porint, amo_keyper, amo_numpag,
           pre_plazop, pre_status, pre_unides, pre_impdes, pre_uniamo,
           pre_impamo, pre_keypro
        FROM USRSIHO.nmlopres, USRSIHO.nmloamor
      WHERE pre_keycon IN
        ( SELECT ran_keycon FROM USRSIHO.glwkrang
           WHERE ran_nomrep = ws_nom_rep
              AND ran_idepcc = ws_ide_pcc
              AND ran_keyusu = wn_key_usu
              AND ran_keycon IS NOT NULL )
        AND pre_keyemp IN
        ( SELECT ran_keyemp FROM USRSIHO.glwkrang
            WHERE ran_nomrep = ws_nom_rep
              AND ran_idepcc = ws_ide_pcc
              AND ran_keyusu = wn_key_usu
              AND ran_keyemp IS NOT NULL )
        AND pre_keyemp = amo_keyemp
        AND pre_keycon = amo_keycon
        --AND pre_refere = amo_refere
        AND pre_keypro = wn_key_pro
      ORDER BY pre_keyemp,amo_numpag;
BEGIN
  -- Realiza el conteo de registros a procesar                    --
	DBMS_OUTPUT.put_line('inicio..');
	BEGIN
		SELECT COUNT(*)
		INTO wn_tot_reg
		FROM USRSIHO.nmlopres,USRSIHO.nmloamor
		WHERE pre_keycon IN
					  ( SELECT ran_keycon FROM USRSIHO.glwkrang
						  WHERE ran_nomrep = ws_nom_rep
							AND ran_idepcc = ws_ide_pcc
							AND ran_keyusu = wn_key_usu
							AND ran_keycon IS NOT NULL )
		  AND pre_keyemp IN
					  ( SELECT ran_keyemp FROM USRSIHO.glwkrang
						  WHERE ran_nomrep = ws_nom_rep
							AND ran_idepcc = ws_ide_pcc
							AND ran_keyusu = wn_key_usu
							AND ran_keyemp IS NOT NULL )
		   AND pre_keyemp = amo_keyemp
		   AND pre_keycon = amo_keycon
		   AND pre_refere = amo_refere
		   AND pre_keypro = wn_key_pro;
		EXCEPTION WHEN no_data_found THEN wn_tot_reg := 0;
	END;
  -- Inserta registro para monitoreo de resultados                --
  wd_fec_act := TRUNC(SYSDATE);
  ws_hor_act := to_CHAR(SYSDATE, 'hh24:mi:ss');
  INSERT INTO USRSIHO.glcoresu (
      res_idepro, res_idepcc, res_keyusu, res_fecini, res_horini,
      res_horreg, res_totreg, res_status )
    VALUES (
      ws_nom_rep, ws_ide_pcc, wn_key_usu, TRUNC(SYSDATE), ws_hor_act,
      ws_hor_reg, wn_tot_reg, 'P' );
  -- Borra la tabla de trabajo del Crystal Report                 --
  DELETE FROM USRSIHO.glwkcrys
    WHERE cry_nomrep = ws_nom_rep
      AND cry_idepcc = ws_ide_pcc
      AND cry_keyusu = wn_key_usu;
  -- Extrae el nombre del Reporte
  ws_des_lis := 'No existe Nombre del Reporte ...';
  FOR rec IN c_lista LOOP
  ws_des_lis := rec.lis_deslis;
  END LOOP;
  -- Asigna valores por omision a las etiquetas del Diccionario de Datos --
  ws_etq_001 := '........';
  ws_etq_002 := '........';
  ws_etq_003 := '........';
  ws_etq_004 := '........';
  ws_etq_005 := '........';
  ws_etq_006 := '........';
  ws_etq_007 := '........';
  ws_etq_008 := '........';
  ws_etq_009 := '........';
  ws_etq_010 := '........';
  ws_etq_011 := '........';
  ws_etq_012 := '........';
  ws_etq_013 := '........';
  ws_etq_014 := '........';
  ws_etq_015 := '........';
  ws_etq_016 := '........';
  ws_etq_017 := '........';
  ws_etq_018 := '........';
  ws_etq_019 := '........';
  ws_etq_020 := '........';
  ws_etq_021 := '........';
  ws_etq_022 := '........';
  ws_etq_023 := '........';
  -- Extrae las etiquetas del Diccionario de Datos                --
  FOR rec2 IN c_etiqueta LOOP
    ws_key_cam := rec2.cam_keycam;
    ws_des_etq := rec2.cam_descor;
    IF ws_key_cam = 'pre_keyemp' THEN
      ws_etq_001 := ws_des_etq;
    END IF;
    IF ws_key_cam = 'pre_keycon' THEN
      ws_etq_003 := ws_des_etq;
    END IF;
    IF ws_key_cam = 'pre_refere' THEN
      ws_etq_005 := ws_des_etq;
    END IF;
    IF ws_key_cam = 'pre_unipre' THEN
      ws_etq_006 := ws_des_etq;
    END IF;
    IF ws_key_cam = 'pre_imppre' THEN
      ws_etq_007 := ws_des_etq;
    END IF;
    IF ws_key_cam = 'pre_fecini' THEN
      ws_etq_008 := ws_des_etq;
    END IF;
    IF ws_key_cam = 'pre_unisal' THEN
      ws_etq_009 := ws_des_etq;
    END IF;
    IF ws_key_cam = 'pre_impsal' THEN
      ws_etq_010 := ws_des_etq;
    END IF;
    IF ws_key_cam = 'amo_fecpag' THEN
      ws_etq_011 := ws_des_etq;
    END IF;
    IF ws_key_cam = 'amo_unipag' THEN
      ws_etq_012 := ws_des_etq;
    END IF;
    IF ws_key_cam = 'amo_imppag' THEN
      ws_etq_013 := ws_des_etq;
    END IF;
    IF ws_key_cam = 'amo_intpag' THEN
      ws_etq_014 := ws_des_etq;
    END IF;
    IF ws_key_cam = 'amo_porint' THEN
      ws_etq_015 := ws_des_etq;
    END IF;
    IF ws_key_cam = 'amo_keyper' THEN
      ws_etq_016 := ws_des_etq;
    END IF;
    IF ws_key_cam = 'amo_numpag' THEN
      ws_etq_017 := ws_des_etq;
    END IF;
    IF ws_key_cam = 'pre_plazop' THEN
      ws_etq_018 := ws_des_etq;
    END IF;
    IF ws_key_cam = 'pre_status' THEN
      ws_etq_019 := ws_des_etq;
    END IF;
    IF ws_key_cam = 'pre_unides' THEN
      ws_etq_020 := ws_des_etq;
    END IF;
    IF ws_key_cam = 'pre_impdes' THEN
      ws_etq_021 := ws_des_etq;
    END IF;
    IF ws_key_cam = 'pre_uniamo' THEN
      ws_etq_022 := ws_des_etq;
    END IF;
    IF ws_key_cam = 'pre_impamo' THEN
      ws_etq_023 := ws_des_etq;
    END IF;
  END LOOP;
  -- Extrae las etiquetas del Diccionario de datos
  FOR rec3 IN c_etiquetas LOOP
    ws_key_cam := rec3.cam_keycam;
    ws_des_etq := rec3.cam_descor;
    IF ws_key_cam = 'con_descon' THEN
      ws_etq_004 := ws_des_etq;
    END IF;
    IF ws_key_cam = 'emp_nomemp' THEN
      ws_etq_002 := ws_des_etq;
    END IF;
  END LOOP;
  -- Asigna restriccionee dee ddpliegue                           --
--sp_glGetDsp ('nmlopres', 'pre_keycon', ws_key_men, wn_dsp_001);
  DBMS_OUTPUT.put_line('ejecuta otro stored..');
    sp_glGetDsp( 'nmlopres', 'pre_keyemp', ws_key_men,wn_dsp_001 );
    sp_glGetDsp( 'nmlopres', 'pre_keycon', ws_key_men ,wn_dsp_003);
    sp_glGetDsp( 'nmlopres', 'pre_refere', ws_key_men, wn_dsp_005);
    sp_glGetDsp( 'nmlopres', 'pre_unipre', ws_key_men , wn_dsp_006);
    sp_glGetDsp( 'nmlopres', 'pre_imppre', ws_key_men , wn_dsp_007);
    sp_glGetDsp( 'nmlopres', 'pre_fecini', ws_key_men, wn_dsp_008);
    sp_glGetDsp( 'nmlopres', 'pre_unisal', ws_key_men, wn_dsp_009);
    sp_glGetDsp( 'nmlopres', 'pre_impsal', ws_key_men, wn_dsp_010);
    sp_glGetDsp( 'nmloamor', 'amo_fecpag', ws_key_men, wn_dsp_011);
    sp_glGetDsp( 'nmloamor', 'amo_unipag', ws_key_men, wn_dsp_012);
    sp_glGetDsp( 'nmloamor', 'amo_imppag', ws_key_men, wn_dsp_013);
    sp_glGetDsp( 'nmloamor', 'amo_intpag', ws_key_men, wn_dsp_014);
    sp_glGetDsp( 'nmloamor', 'amo_porint', ws_key_men, wn_dsp_015);
    sp_glGetDsp( 'nmloamor', 'amo_keyper', ws_key_men, wn_dsp_016);
    sp_glGetDsp( 'nmloamor', 'amo_numpag', ws_key_men, wn_dsp_017);
    sp_glGetDsp( 'nmlopres', 'pre_plazop', ws_key_men, wn_dsp_018);
    sp_glGetDsp( 'nmlopres', 'pre_status', ws_key_men, wn_dsp_019);
    sp_glGetDsp( 'nmlopres', 'pre_unides', ws_key_men, wn_dsp_020);
    sp_glGetDsp( 'nmlopres', 'pre_impdes', ws_key_men, wn_dsp_021);
    sp_glGetDsp( 'nmlopres', 'pre_uniamo', ws_key_men, wn_dsp_022);
    sp_glGetDsp( 'nmlopres', 'pre_impamo', ws_key_men, wn_dsp_023);
  -- Inicializa variables de trabajo para reallzar Cortes y Monit ---
  wn_pro_ant := -32760;
  wn_nom_ant := -32760;
  wn_num_reg := 0;
  wn_pct_act := 1;
  wn_pct_reg := wn_tot_reg / 10.0;
  wn_uni_ini := 0;
  wn_imp_ini := 0;
  -- Define cursor principal
  FOR rec4 IN c_nmlstpre LOOP
   -- Extraer el nombre de la empresa
      DBMS_OUTPUT.put_line('dentro ciclo..');
    wn_key_emp := rec4.pre_keyemp;
    ws_key_con := rec4.pre_keycon;
    ws_ref_ere := rec4.pre_refere;
    wn_uni_pre := rec4.pre_unipre;
    wn_imp_pre := rec4.pre_imppre;
    ws_fec_ini := rec4.pre_fecini;
    wn_uni_sal := rec4.pre_unisal;
    wn_imp_sal := rec4.pre_impsal;
    ws_fec_pag := rec4.amo_fecpag;
    wn_uni_pag := rec4.amo_unipag;
    wn_imp_pag := rec4.amo_imppag;
    wn_int_pag := rec4.amo_intpag;
    wn_por_int := rec4.amo_porint;
    ws_key_per := rec4.amo_keyper;
    wn_num_pag := rec4.amo_numpag;
    wn_pla_zop := rec4.pre_plazop;
    ws_sta_tus := rec4.pre_status;
    wn_uni_des := rec4.pre_unides;
    wn_imp_des := rec4.pre_impdes;
    wn_uni_amo := rec4.pre_uniamo;
    wn_imp_amo := rec4.pre_impamo;
    --wn_key_pro := rec4.pre_keypro;
    ws_key_cia := '';
	BEGIN
		SELECT pro_keycia
		INTO ws_key_cia
		FROM nmloproc
		WHERE pro_keypro = wn_key_pro;
		EXCEPTION WHEN no_data_found THEN ws_key_cia := '';
	END;
    ws_des_cor := 'EMPRESA NO EXISTE ...';
	BEGIN
		SELECT cia_descia
		INTO ws_des_cor
		FROM nmlocias
		WHERE cia_keycia = ws_key_cia;
		EXCEPTION WHEN no_data_found THEN ws_des_cor := '';
	END;
    -- Actualiza registro de monitoreo                              --
    wn_num_reg := wn_num_reg + 1;
    IF wn_num_reg >= ( wn_pct_reg * wn_pct_act ) THEN
      UPDATE glcoresu SET res_numreg = wn_num_reg
        WHERE res_idepro = ws_nom_rep
          AND res_idepcc = ws_ide_pcc
          AND res_keyusu = wn_key_usu
         AND res_fecini = TRUNC(SYSDATE)
          AND res_horreg = ws_hor_reg;
      wn_pct_act := wn_pct_act + 1;
    END IF;
    -- Extrae descripcionnde concepto, y nombre del empleado  --
    ws_des_con := 'CONCEPTO NO EXISTE ...';
    FOR rec5 IN c_descon LOOP
    ws_des_con := rec5.con_descon;
    END LOOP;
    ws_nom_emp := 'EMPLEADO NO EXISTE ...' ;
    FOR rec6 IN c_nomemp LOOP
    ws_nom_emp := rec6.emp_nomemp;
    END LOOP;
    -- Aplica restricciones de despliegue de Campos                 --
     IF wn_dsp_001 = 1 THEN
      wn_key_emp := NULL;
      ws_nom_emp := NULL;
    END IF;
    IF wn_dsp_003 = 1 THEN
      ws_key_con := NULL;
      ws_des_con := NULL;
    END IF;
    IF ws_sta_tus = '1' THEN
      ws_sta_tus := 'Proc. Ad.';
    END IF;
    IF ws_sta_tus = '2' THEN
      ws_sta_tus := 'Vigente';
    END IF;
    IF ws_sta_tus = '3' THEN
      ws_sta_tus := 'Redimido';
    END IF;
    IF ws_sta_tus = '4' THEN
      ws_sta_tus := 'Suspend';
    END IF;
    IF wn_dsp_005 = 1 THEN ws_ref_ere := NULL; END IF;
    IF wn_dsp_006 = 1 THEN wn_uni_pre := NULL; END IF;
    IF wn_dsp_007 = 1 THEN wn_imp_pre := NULL; END IF;
    IF wn_dsp_008 = 1 THEN ws_fec_ini := NULL; END IF;
    IF wn_dsp_009 = 1 THEN wn_uni_sal := NULL; END IF;
    IF wn_dsp_010 = 1 THEN wn_imp_sal := NULL; END IF;
    IF wn_dsp_011 = 1 THEN ws_fec_pag := NULL; END IF;
    IF wn_dsp_012 = 1 THEN wn_uni_pag := NULL; END IF;
    IF wn_dsp_013 = 1 THEN wn_imp_pag := NULL; END IF;
    IF wn_dsp_014 = 1 THEN wn_int_pag := NULL; END IF;
    IF wn_dsp_015 = 1 THEN wn_por_int := NULL; END IF;
    IF wn_dsp_016 = 1 THEN ws_key_per := NULL; END IF;
    IF wn_dsp_017 = 1 THEN wn_num_pag := NULL; END IF;
    IF wn_dsp_018 = 1 THEN wn_pla_zop := NULL; END IF;
    IF wn_dsp_019 = 1 THEN ws_sta_tus := NULL; END IF;
    IF wn_dsp_020 = 1 THEN wn_uni_des := NULL; END IF;
    IF wn_dsp_021 = 1 THEN wn_imp_des := NULL; END IF;
    IF wn_dsp_022 = 1 THEN wn_uni_amo := NULL; END IF;
    IF wn_dsp_023 = 1 THEN wn_imp_amo := NULL; END IF;
    -- Inserta en la tabla de trabajo del Crystal Report            --
    IF wn_num_pag = 1 then
      wn_uni_ini := wn_uni_pre;
      wn_imp_ini := wn_imp_pre;
    ELSE
      wn_uni_ini := wn_uni_ini - wn_uni_tem;
      wn_imp_ini := wn_imp_ini - wn_imp_tem;
    END IF;
    INSERT INTO glwkcrys (
        cry_nomrep, cry_idepcc, cry_keyusu, cry_chr001, cry_dec006,
        cry_chr003, cry_chr017, cry_chr004, cry_chr008, cry_dec011,
        cry_dec012, cry_dat001, cry_dec013, cry_dec014, cry_dat002,
        cry_dec015, cry_dec016, cry_dec017, cry_dec018, cry_chr018,
        cry_dec007, cry_dec008, cry_chr037, cry_dec019, cry_dec020,
        cry_dec021, cry_dec022, cry_dec023, cry_dec024,
        cry_chr020, cry_chr021, cry_chr022, cry_chr023, cry_chr024,
        cry_chr025, cry_chr026, cry_chr027, cry_chr028, cry_chr029,
        cry_chr030, cry_chr031, cry_chr032, cry_chr033, cry_chr034,
        cry_chr035, cry_chr038, cry_chr039, cry_chr040, cry_chr041,
        cry_chr042, cry_chr043, cry_chr044,
        cry_dat003, cry_chr036, cry_chr002 )
      VALUES (
        ws_nom_rep, ws_ide_pcc, wn_key_usu, ws_des_cor, wn_key_emp,
        ws_nom_emp, ws_key_con, ws_des_con, ws_ref_ere, wn_uni_pre,
        wn_imp_pre, ws_fec_ini, wn_uni_sal, wn_imp_sal, ws_fec_pag,
        wn_uni_pag, wn_imp_pag, wn_int_pag, wn_por_int, ws_key_per,
        wn_num_pag, wn_pla_zop, ws_sta_tus, wn_uni_des, wn_imp_des,
        wn_uni_amo, wn_imp_amo, wn_uni_ini, wn_imp_ini,
	ws_etq_001, ws_etq_002, ws_etq_003, ws_etq_004, ws_etq_005,
	ws_etq_006, ws_etq_007, ws_etq_008, ws_etq_009, ws_etq_010,
 	ws_etq_011, ws_etq_012, ws_etq_013, ws_etq_014, ws_etq_015,
        ws_etq_016, ws_etq_017, ws_etq_018, ws_etq_019, ws_etq_020,
        ws_etq_021, ws_etq_022, ws_etq_023,
        wd_fec_act, ws_hor_act, ws_des_lis
        );
     wn_uni_tem := wn_uni_pag;
     wn_imp_tem := wn_imp_pag;
     END LOOP;
  -- Actualiza la tabbaa deemnitoreo indicandoola finalizacion    --
  -- del proceso.                                                 --
   ws_hor_act := to_CHAR(SYSDATE, 'hh24:mi:ss');
  UPDATE glcoresu SET res_numreg = wn_num_reg,
                      res_fecfin = TRUNC(SYSDATE),
                      res_horfin = ws_hor_act,
                      res_status = 'T'
    WHERE res_idepro = ws_nom_rep
      AND res_idepcc =  ws_ide_pcc
      AND res_keyusu = wn_key_usu
      AND res_fecini = TRUNC(SYSDATE)
      AND res_horreg = ws_hor_reg;
END;
/
