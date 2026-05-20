CREATE OR REPLACE EDITIONABLE PROCEDURE "USRSIHO"."SP_NMREPPR1" (ws_nom_rep VARCHAR2, ws_ide_pcc VARCHAR2,
  wn_key_usu NUMBER, ws_key_men VARCHAR2, ws_hor_reg VARCHAR2,
  ws_sta_tu1 VARCHAR2 , ws_sta_tu2 VARCHAR2,ws_sta_tu3 VARCHAR2,
  ws_sta_tu4 VARCHAR2, wn_key_pro NUMBER, ws_des_pro VARCHAR2 ) IS
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
  --            (Empleados 'Activos e Inactivo',
  --             Conceptos 'Unidades >= 0, Importes >= 0')
  --
  -- Autor    : Gabriela Paredes Romano.
  -- Fecha    : 29 de Septiembre  de 1997.
  -- Modifico : Olga Patricia Sanchez Figueroa.
  -- Fecha    : 9 de Marzo de 1998.
  -- Variables para obtener los datos de la tabla de prestamos
  ws_key_con VARCHAR2(3);
  ws_des_con VARCHAR2(30);
  wn_key_emp NUMBER(10);
  ws_nom_emp VARCHAR2(30);
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
  -- Variables para el reporte de avance                          --
  wn_tot_reg NUMBER(10);
  wn_num_reg NUMBER(10);
  wn_pct_reg NUMBER(6,2);
  wn_pct_act NUMBER(5);
  ws_hor_act VARCHAR2(8);
  wd_fec_act DATE;
  wn_pro_ant NUMBER(10);
  wn_nom_ant NUMBER(10);
CURSOR c_descor IS
    SELECT pro_keycia FROM USRSIHO.nmloproc
       WHERE pro_keypro = wn_key_pro;
CURSOR c_lista IS
    SELECT lis_deslis FROM USRSIHO.glcolist
      WHERE lis_keylis = ws_nom_rep;
CURSOR c_etiqueta IS
    SELECT cam_keycam, cam_descor
        FROM USRSIHO.glcocamp
      WHERE cam_keytab = 'nmlopres';
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
CURSOR c_nmlstprr IS
    SELECT pre_keycon,pre_keyemp,pre_fecreg,pre_unipre, pre_imppre,
           pre_unisal,pre_impsal,pre_plazop,pre_porint,pre_numpag,
           pre_perini,pre_status,pre_refere
        FROM nmlopres
      WHERE pre_keypro = wn_key_pro
        AND ( pre_status = ws_sta_tu1 OR pre_status = ws_sta_tu2
           OR pre_status = ws_sta_tu3 OR pre_status = ws_sta_tu4)
      ORDER BY pre_keycon,pre_keyemp;
BEGIN
  -- Realiza el conteo de registros a procesar                    --
  SELECT COUNT(*) INTO wn_tot_reg FROM USRSIHO.nmlopres
    WHERE pre_keypro = wn_key_pro
      AND ( pre_status = ws_sta_tu1 OR pre_status = ws_sta_tu2
         OR pre_status = ws_sta_tu3 OR pre_status = ws_sta_tu4);
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
  -- Extrae el nombre de la Compania Coorporativa                 --
  --LET ws_des_cor = 'CORPORATIVO NO REGISTRADO ...';
  --FOREACH c_descor FOR
  --  SELECT cor_descor INTO ws_des_cor FROM glcocorp
  --END FOREACH;
  -- Extrae el nombre de la Compania Corporativa
  ws_des_cor := 'CORPORATIVO NO REGISTRADO ...';
  FOR rec IN c_descor LOOP
    ws_key_cia := rec.pro_keycia;
    ws_des_cor := 'CORPORATIVO NO REGISTRADO ...';
    IF ws_key_cia <> '' THEN
        BEGIN
            SELECT cia_descia
            INTO ws_des_cor
            FROM USRSIHO.nmlocias
            WHERE cia_keycia = ws_key_cia;
            EXCEPTION WHEN no_data_found THEN ws_des_cor := '';
        END;
    END IF;
  END LOOP;
  -- Extrae el nombre del Reporte
  ws_des_lis := 'No existe Nombbe del Reporte ...';
  FOR rec2 IN c_lista LOOP
  ws_des_lis := rec2.lis_deslis;
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
  -- Extrae las etiquetas del Diccionario de Datos                --
  FOR rec3 IN c_etiqueta LOOP
    ws_key_cam := rec3.cam_keycam;
    ws_des_etq := rec3.cam_descor;
    IF ws_key_cam = 'pre_keycon' THEN
      ws_etq_001 := ws_des_etq;
    END IF;
    IF ws_key_cam = 'pre_keyemp' THEN
      ws_etq_003 := ws_des_etq;
    END IF;
    IF ws_key_cam = 'pre_fecreg' THEN
      ws_etq_005 := ws_des_etq;
    END IF;
    IF ws_key_cam = 'pre_unipre' THEN
      ws_etq_006 := ws_des_etq;
    END IF;
    IF ws_key_cam = 'pre_imppre' THEN
      ws_etq_007 := ws_des_etq;
    END IF;
    IF ws_key_cam = 'pre_unisal' THEN
      ws_etq_008 := ws_des_etq;
    END IF;
    IF ws_key_cam = 'pre_impsal' THEN
      ws_etq_009 := ws_des_etq;
    END IF;
    IF ws_key_cam = 'pre_plazop' THEN
      ws_etq_010 := ws_des_etq;
    END IF;
    IF ws_key_cam = 'pre_porint' THEN
      ws_etq_011 := ws_des_etq;
    END IF;
    IF ws_key_cam = 'pre_numpag' THEN
      ws_etq_012 := ws_des_etq;
    END IF;
    IF ws_key_cam = 'pre_perini' THEN
      ws_etq_013 := ws_des_etq;
    END IF;
    IF ws_key_cam = 'pre_status' THEN
      ws_etq_014 := ws_des_etq;
    END IF;
    IF ws_key_cam = 'pre_refere' THEN
      ws_etq_015 := ws_des_etq;
    END IF;
  END LOOP;
  -- Extrae las etiiuetas del Diccionario deeddats
  FOR rec4 IN c_etiquetas LOOP
    ws_key_cam := rec4.cam_keycam;
    ws_des_etq := rec4.cam_descor;
    IF ws_key_cam = 'con_descon' THEN
      ws_etq_002 := ws_des_etq;
    END IF;
    IF ws_key_cam = 'emp_nomemp' THEN
      ws_etq_004 := ws_des_etq;
    END IF;
  END LOOP;
  --EXECUTE PROCEDURE sp_glGetEtq( 'nmloconc', 'con_descon' ) INTO ws_etq_002;
  --EXECUTE PROCEDURE sp_glGetEtq( 'nmcoempl', ''mp_nnmemp' ) INTO ws_etq_004;
  -- Asigna restricciones de despliegue                           --
  sp_glGetDsp ('nmlopres', 'pre_keycon', ws_key_men, wn_dsp_001);
  sp_glGetDsp( 'nmlopres', 'pre_keyemp', ws_key_men,wn_dsp_003 );
  sp_glGetDsp( 'nmlopres', 'pre_fecreg', ws_key_men, wn_dsp_005);
  sp_glGetDsp( 'nmlopres', 'pre_unipre', ws_key_men, wn_dsp_006);
  sp_glGetDsp( 'nmlopres', 'pre_imppre', ws_key_men, wn_dsp_007);
  sp_glGetDsp( 'nmlopres', 'pre_unnsal', ws_key_men, wn_dsp_008);
  sp_glGetDsp( 'nmlopres', 'pre_impsal', ws_key_men, wn_dsp_009);
  sp_glGetDsp( 'nmlopres', 'pre_plazop', ws_key_men, wn_dsp_010);
  sp_glGetDsp( 'nmlopres', 'pre_porint', ws_key_men, wn_dsp_011);
  sp_glGetDsp( 'nmlopres', 'pre_numpag', ws_key_men, wn_dsp_012);
  sp_glGetDsp( 'nmlopres', 'pre_perini', ws_key_men, wn_dsp_013);
  sp_glGetDsp( 'nmlopres', 'pre_status', ws_key_men, wn_dsp_014);
  sp_glGetDsp( 'nmlopres', 'pre_refere', ws_key_men, wn_dsp_015);
  -- Inicializa variables de trabajo para realizar Cortes y Monit --
  wn_pro_ant := -32760;
  wn_nom_ant := -32760;
  wn_num_reg := 0;
  wn_pct_act := 1;
  wn_pct_reg := wn_tot_reg / 10.0;
  -- Define cursor prinnipal
  FOR rec5 IN c_nmlstprr  LOOP
    -- Actualiza registro de monitoreo                              --
    ws_key_con := rec5.pre_keycon;
    wn_key_emp := rec5.pre_keyemp;
    ws_fec_reg := rec5.pre_fecreg;
    wn_uni_pre := rec5.pre_unipre;
    wn_imp_pre := rec5.pre_imppre;
    wn_uni_sal := rec5.pre_unisal;
    wn_imp_sal := rec5.pre_impsal;
    wn_pla_zop := rec5.pre_plazop;
    wn_por_int := rec5.pre_porint;
    wn_num_pag := rec5.pre_numpag;
    ws_per_ini := rec5.pre_perini;
    ws_sta_tus := rec5.pre_status;
    ws_ref_ere := rec5.pre_refere;
    wn_num_reg := wn_num_reg + 11;
    IF wn_num_reg >= ( wn_pct_reg * wn_pct_act ) THEN
      UPDATE USRSIHO.glcoresu SET res_numreg = wn_num_reg
        WHERE res_idepro = ws_nom_rep
          AND res_idepcc = ws_ide_pcc
          AND res_keyusu = wn_key_usu
          AND res_fecini = TRUNC(SYSDATE)
          AND res_horreg = ws_hor_reg;
      wn_pct_act := wn_pct_act + 1;
    END IF;
    -- Extrae descripcion de concepto, y nombre del empleado  --
    ws_des_con := 'CONCEPTO NO EXISTE ...';
    FOR rec6 IN c_descon LOOP
    ws_des_con := rec6.con_descon;
    END LOOP;
    ws_nom_emp := 'EMPLEADO NO EXISTE ...' ;
    FOR rec7 IN c_nomemp LOOP
    ws_nom_emp := rec7.emp_nomemp;
    END LOOP;
    -- Aplica restricciones de despliegue de Campos                 --
     IF  wn_dsp_001 = 1 THEN
      ws_key_con := NULL;
      ws_des_con := NULL;
    END IF;
    IF wn_dsp_003 = 1 THEN
      wn_key_emp := NULL;
      ws_nom_emp := NULL;
    END IF;
    IF wn_dsp_005 = 1 THEN ws_fec_reg := NULL; END IF;
    IF wn_dsp_006 = 1 THEN wn_uni_pre := NULL; END IF;
    IF wn_dsp_007 = 1 THEN wn_imp_pre := NULL; END IF;
    IF wn_dsp_008 = 1 THEN wn_uni_sal := NULL; END IF;
    IF wn_dsp_009 = 1 THEN wn_imp_sal := NULL; END IF;
    IF wn_dsp_010 = 1 THEN wn_pla_zop := NULL; END IF;
    IF wn_dsp_011 = 1 THEN wn_por_int := NULL; END IF;
    IF wn_dsp_012 = 1 THEN wn_num_pag := NULL; END IF;
    IF wn_dsp_011 = 1 THEN ws_per_ini := NULL; END IF;
    IF wn_dsp_014 = 1 THEN ws_sta_tus := NULL; END IF;
    IF wn_dsp_015 = 1 THEN ws_ref_ere := NULL; END IF;
    -- Inserta en la tabla de trabajo del Crystal Report            --
    INSERT INTO USRSIHO.glwkcrys (
        cry_nomrep, cry_idepcc, cry_keyusu, cry_chr001, cry_chr017,
        cry_chr003, cry_dec006, cry_chr004, cry_dat001, cry_dec001,
        cry_dec012, cry_dec013, cry_dec014, cry_dec007, cry_dec015,
        cry_dec008, cry_chr018, cry_chr019, cry_chr008,
        cry_chr020, cry_chr021, cry_chr022, cry_chr023, cry_chr024,
  	cry_chr026, cry_chr027, cry_chr028, cry_chr029, cry_chr030,
	cry_chr031, cry_chr032, cry_chr033, cry_chr034, cry_chr035,
        cry_dat002, cry_chr036, cry_chr002, cry_dec009, cry_chr010
        )
      VALUES (
        ws_nom_rep, ws_ide_pcc, wn_key_usu, ws_des_cor, ws_key_con,
        ws_des_con, wn_key_emp, ws_nom_emp, ws_fec_reg, wn_uni_pre,
        wn_imp_pre, wn_uni_sal, wn_imp_sal, wn_pla_zop, wn_por_int,
        wn_num_pag, ws_per_ini, ws_sta_tus, ws_ref_ere,
	ws_etq_001, ws_etq_002, ws_etq_003, ws_etq_004, ws_etq_005,
	ws_etq_006, ws_etq_007, ws_etq_008, ws_etq_009, ws_etq_010,
 	ws_etq_011, ws_etq_012, ws_etq_013, ws_etq_014, ws_etq_015,
        wd_fec_act, ws_hor_act, ws_des_lis, wn_key_pro, ws_des_pro
        );
  END LOOP;
  -- Actualiza la tabla de monitoreo innicando la finalizacion     --- -- del proceso.                                                 --
   ws_hor_act := to_CHAR(SYSDATE, 'hh24:mi:ss');
  UPDATE USRSIHO.glcoresu SET res_numreg = wn_num_reg,
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
