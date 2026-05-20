CREATE OR REPLACE EDITIONABLE PROCEDURE "USRSIHO"."SP_NMLSTPEN" (ws_nom_rep VARCHAR2, ws_ide_pcc VARCHAR2,
  wn_key_usu NUMBER, ws_key_men VARCHAR2, ws_hor_reg VARCHAR2,
  ws_tab_sub VARCHAR2 ) IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
  -- SIPROS, S.A. DE C.V.
  --
  -- Sistema  : RH-2000 C/S
  -- Modulo   : Administracion de remuneraciones (nm)
  --
  -- Programa : sp_nmlstpen
  --            Reporte de Pensiones Alimenticias.
  --
  -- Autor    : Joaquin Perez M.
  -- Fecha    : 15 de Agosto de 1997.
  --
  -- Variables para la carga de la tabla de Beneficiarios y Prestamos --
  wn_key_emp NUMBER(10);
  ws_nom_emp VARCHAR2(60);
  ws_key_dep VARCHAR2(16);
  ws_des_dep VARCHAR2(40);
  wn_key_ben NUMBER(5);
  ws_tip_ben VARCHAR2(2);
  wn_com_fam NUMBER(5);
  ws_des_ben VARCHAR2(40);
  ws_nom_ben VARCHAR2(60);
  ws_rfc_ben VARCHAR2(13);
  wd_fec_nac DATE;
  wn_por_par NUMBER(6,2);
  ws_cve_sex VARCHAR2(1);
  ws_tip_par VARCHAR2(2);
  ws_key_ban VARCHAR2(7);
  ws_cta_ban VARCHAR2(18);
  ws_dep_ben VARCHAR2(16);
  ws_key_cen VARCHAR2(16);
  ws_des_cen VARCHAR2(40);
  ws_for_pag VARCHAR2(2);
  ws_ca1_aux VARCHAR2(10);
  ws_ca2_aux VARCHAR2(10);
  ws_key_con VARCHAR2(3);
  ws_reg_inf VARCHAR2(14);
  wd_fec_exp DATE;
  ws_tip_pen VARCHAR2(2);       --INTEGER;   wn_pla_zop
  wn_uni_pre NUMBER(12,2);
  wn_imp_pre NUMBER(12,2);
  wn_uni_des NUMBER(12,2);
  wn_imp_des NUMBER(12,2);
  ws_per_ini VARCHAR2(7);
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
  ws_des_cor VARCHAR2(60);
  -- Variables para las etiquetas de la tabla de prestamos       --
  ws_etq_con VARCHAR2(8);
  ws_etq_ofi VARCHAR2(8);
  ws_etq_exp VARCHAR2(8);
  ws_etq_pen VARCHAR2(8);
  ws_etq_po1 VARCHAR2(8);
  ws_etq_im1 VARCHAR2(8);
  ws_etq_po2 VARCHAR2(8);
  ws_etq_im2 VARCHAR2(8);
  ws_etq_per VARCHAR2(8);
  -- Variables para las restricciones de despliegue               --
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
  wn_dsp_027 NUMBER(5);
  -- Variables para el reporte de avance                          --
  --DEFINE wn_tot_reg INTEGER;
  wn_num_reg NUMBER(10);
  wn_pct_reg NUMBER(6,2);
  wn_pct_act NUMBER(5);
  ws_hor_act VARCHAR2(8);
  ws_fec_act DATE;
  -- variables para realizar cortes                               --
  wn_emp_ant NUMBER(10);
  ws_dep_ant VARCHAR2(16);
  ws_cen_ant VARCHAR2(16);
  ws_ben_ant VARCHAR2(2);
 CURSOR c_descor IS
    SELECT cor_descor FROM USRSIHO.glcocorp;
 CURSOR c_etiqueta IS
    SELECT cam_keycam, cam_descor
        FROM USRSIHO.glcocamp
      WHERE cam_keytab = 'nmlobene';
 CURSOR c_etiqueta2 IS
    SELECT cam_keycam, cam_descor
        FROM USRSIHO.glcocamp
      WHERE cam_keytab = 'nmlobebe';
 CURSOR c_nomemp IS
    SELECT cam_descor FROM USRSIHO.glcocamp
      WHERE cam_keytab = 'nmcoempl'
        AND cam_keycam = 'emp_nomemp';
 CURSOR c_descen IS
    SELECT cam_descor FROM USRSIHO.glcocamp
      WHERE cam_keytab = 'nmlocenc'
        AND cam_keycam = 'cen_descen';
 CURSOR c_desdep IS
    SELECT cam_descor FROM USRSIHO.glcocamp
      WHERE cam_keytab = 'nmcodeps'
        AND cam_keycam = 'dep_desdep';
 CURSOR c_desplieg IS
    SELECT rec_keycam, rec_despli FROM USRSIHO.glcoreca
      WHERE rec_keytab = 'nmlobene'
        AND rec_keymen = ws_key_men;
 CURSOR c_desplieg2 IS
    SELECT rec_keycam, rec_despli FROM USRSIHO.glcoreca
      WHERE rec_keytab = 'nmlopres'
        AND rec_keymen = ws_key_men;
 CURSOR c_nomemp2 IS
          SELECT emp_nomemp FROM USRSIHO.nmcoempl
            WHERE emp_keyemp = wn_key_emp;
 CURSOR c_desdep2 IS
          SELECT dep_desdep FROM USRSIHO.nmcodeps
            WHERE dep_keydep = ws_key_dep;
 CURSOR c_descen2 IS
          SELECT cen_descen FROM USRSIHO.nmlocenc
            WHERE cen_keycen = ws_key_cen;
 CURSOR c_desben IS
          SELECT pam_nompar FROM USRSIHO.glcopams
            WHERE pam_keypar = ws_tab_sub
            AND pam_cvesec = ws_tip_ben;
 CURSOR c_nmlstben IS
    SELECT ben_keyemp, ben_keyben, ben_comfam, ben_rfcben, ben_nomben,
           ben_fecnac, ben_cvesex, ben_tippar, beb_tipben, beb_porpar,
                       ben_keyban, ben_ctaban, ben_keydep, ben_keycen,
           beb_forpag,             ben_ca1aux, ben_ca2aux,
           pre_keycon, pre_refere, pre_tippre, pre_unipre, pre_imppre,
           pre_unides, pre_impdes, pre_perini, pre_fecreg
        FROM USRSIHO.nmlopres, USRSIHO.nmlobene, USRSIHO.nmlobebe
        WHERE pre_keyemp = ben_keyemp
          AND pre_keyemp = beb_keyemp
          AND pre_ca4aux = ben_keyben
          AND pre_ca4aux = beb_keyben
          AND ben_keyben = beb_keyben
          AND ben_comfam = beb_comfam
          AND ben_comfam = 1
        AND ben_keyemp IN
          ( SELECT ran_keyemp FROM USRSIHO.glwkrang
              WHERE ran_nomrep = ws_nom_rep
              AND ran_idepcc = ws_ide_pcc
              AND ran_keyusu = wn_key_usu
              AND ran_keyemp IS NOT NULL )
        AND ben_keyben IN
          ( SELECT ran_keynom FROM USRSIHO.glwkrang
              WHERE ran_nomrep = ws_nom_rep
              AND ran_idepcc = ws_ide_pcc
              AND ran_keyusu = wn_key_usu
              AND ran_keynom IS NOT NULL )
        ORDER BY ben_keyemp, ben_keyben, ben_keydep, ben_keycen, beb_tipben;
BEGIN
  -- Asignacion por omision de las etiquetas de la tabla de prestamos --
  ws_etq_con := 'Concepto';
  ws_etq_ofi := 'Oficio';
  ws_etq_exp := 'Fec.Exp.';
  ws_etq_pen := 'T.Pen.';
  ws_etq_po1 := '1er %';
  ws_etq_im1 := 'Importe';
  ws_etq_po2 := '2do%';
  ws_etq_im2 := '2do Imp.';
  ws_etq_per := 'Per.Ini.';
  -- Realiza el conteo de registros a procesar                    --
  --SELECT COUNT(*) INTO wn_tot_reg FROM nmlopres, nmlobenf
  --  WHERE pre_keyemp = ben_keyemp
  --  AND pre_refere = ben_keyben
  --    AND ben_keyemp IN
  --    ( SELECT ran_keyemp FROM glwkrang
  --        WHERE ran_nomrep = ws_nom_rep
  --          AND ran_idepcc = ws_ide_pcc
  --          AND ran_keyusu = wn_key_usu
  --          AND ran_keyemp IS NOT NULL )
  --    AND ben_keyben IN
  --    ( SELECT ran_keynom FROM glwkrang
  --        WHERE ran_nomrep = ws_nom_rep
  --          AND ran_idepcc = ws_ide_pcc
  --          AND ran_keyusu = wn_key_usu
  --          AND ran_keynom IS NOT NULL )
  --    AND ben_tipben IN
  --    ( SELECT ran_keycon FROM glwkrang
  --        WHERE ran_nomrep = ws_nom_rep
  --          AND ran_idepcc = ws_ide_pcc
  --          AND ran_keyusu = wn_key_usu
  --          AND ran_keycon IS NOT NULL );
  -- Inserta registro para monitoreo de resultados                --
  ws_hor_act := to_char(SYSDATE, 'hh24:mi:ss');
  ws_fec_act := TRUNC(SYSDATE);
  INSERT INTO USRSIHO.glcoresu (
      res_idepro, res_idepcc, res_keyusu, res_fecini, res_horini,
      res_horreg, res_totreg, res_status )
    VALUES (
      ws_nom_rep, ws_ide_pcc, wn_key_usu, TRUNC(SYSDATE), ws_hor_act,
      ws_hor_reg, -1, 'P' );
  -- Borra la tabla de trabajo del Crystal Report                 --
  DELETE FROM USRSIHO.glwkcrys
    WHERE cry_nomrep = ws_nom_rep
      AND cry_idepcc = ws_ide_pcc
      AND cry_keyusu = wn_key_usu;
  -- Extrae el nombre de la Compania Corporativa                 --
  ws_des_cor := 'CORPORATIVO NO REGISTRADO ...';
  FOR rec IN c_descor LOOP
  ws_des_cor := rec.cor_descor;
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
    IF ws_key_cam = 'ben_keyemp' THEN
      ws_etq_001 := ws_des_etq;
    END IF;
    IF ws_key_cam = 'ben_keyben' THEN
      ws_etq_002 := ws_des_etq;
    END IF;
    IF ws_key_cam = 'ben_comfam' THEN
      ws_etq_003 := ws_des_etq;
    END IF;
    IF ws_key_cam = 'ben_rfcben' THEN
      ws_etq_004 := ws_des_etq;
    END IF;
    IF ws_key_cam = 'ben_nomben' THEN
      ws_etq_005 := ws_des_etq;
    END IF;
    IF ws_key_cam = 'ben_fecnac' THEN
      ws_etq_006 := ws_des_etq;
    END IF;
    IF ws_key_cam = 'ben_cvesex' THEN
      ws_etq_007 := ws_des_etq;
    END IF;
    IF ws_key_cam = 'ben_tippar' THEN
      ws_etq_008 := ws_des_etq;
    END IF;
   -- IF ws_key_cam = 'ben_tipben' THEN
   --   LET ws_etq_009 = ws_des_etq;
   -- END IF;
    IF ws_key_cam = 'ben_nomben' THEN
      ws_etq_010 := ws_des_etq;
    END IF;
   -- IF ws_key_cam = 'ben_porpar' THEN
   --   LET ws_etq_011 = ws_des_etq;
   -- END IF;
   -- IF ws_key_cam = 'ben_fecven' THEN
   --   LET ws_etq_012 = ws_des_etq;
   -- END IF;
    IF ws_key_cam = 'ben_keyban' THEN
      ws_etq_013 := ws_des_etq;
    END IF;
    IF ws_key_cam = 'ben_ctaban' THEN
      ws_etq_014 := ws_des_etq;
    END IF;
    IF ws_key_cam = 'ben_keydep' THEN
      ws_etq_015 := ws_des_etq;
    END IF;
    IF ws_key_cam = 'ben_keycen' THEN
      ws_etq_016 := ws_des_etq;
    END IF;
    --IF ws_key_cam = 'ben_forpag' THEN
    --  LET ws_etq_017 = ws_des_etq;
    --END IF;
    --IF ws_key_cam = 'ben_fecact' THEN
    --  LET ws_etq_018 = ws_des_etq;
    --END IF;
    IF ws_key_cam = 'ben_ca1aux' THEN
      ws_etq_019 := ws_des_etq;
    END IF;
    IF ws_key_cam = 'ben_ca2aux' THEN
      ws_etq_020 := ws_des_etq;
    END IF;
  END LOOP;
  FOR rec3 IN c_etiqueta2 LOOP
    ws_key_cam := rec3.cam_keycam;
    ws_des_etq := rec3.cam_descor;
    IF ws_key_cam = 'beb_tipben' THEN
      ws_etq_009 := ws_des_etq;
    END IF;
    IF ws_key_cam = 'beb_porpar' THEN
      ws_etq_011 := ws_des_etq;
    END IF;
    IF ws_key_cam = 'beb_forpag' THEN
      ws_etq_017 := ws_des_etq;
    END IF;
  END LOOP;
  ws_etq_021 := 'NOMBRE';
  FOR rec4 IN c_nomemp LOOP
    ws_etq_021 := rec4.cam_descor;
  END LOOP;
  ws_etq_022 := 'DESCRIP.';
  FOR rec5 IN c_descen LOOP
  ws_etq_022 := rec5.cam_descor;
  END LOOP;
  ws_etq_023 := 'DESCRIP.';
  FOR rec6 IN c_desdep LOOP
  ws_etq_023 := rec6.cam_descor;
  END LOOP;
  -- Asigna por omision que todos los campos se pueden desplegar  --
  wn_dsp_001 := 0;
  wn_dsp_002 := 0;
  wn_dsp_003 := 0;
  wn_dsp_004 := 0;
  wn_dsp_005 := 0;
  wn_dsp_006 := 0;
  wn_dsp_007 := 0;
  wn_dsp_008 := 0;
  wn_dsp_009 := 0;
  wn_dsp_010 := 0;
  wn_dsp_011 := 0;
  wn_dsp_012 := 0;
  wn_dsp_013 := 0;
  wn_dsp_014 := 0;
  wn_dsp_015 := 0;
  wn_dsp_016 := 0;
  wn_dsp_017 := 0;
  wn_dsp_018 := 0;
  wn_dsp_019 := 0;
  wn_dsp_020 := 0;
  wn_dsp_021 := 0;
  wn_dsp_022 := 0;
  wn_dsp_023 := 0;
  wn_dsp_024 := 0;
  wn_dsp_025 := 0;
  wn_dsp_026 := 0;
  wn_dsp_027 := 0;
  -- extrae las restricciones de Despliegue de la tabla de beneficiarios --
  FOR rec7 IN c_desplieg LOOP
    ws_key_cam := rec7.rec_keycam;
    ws_dsp_cam := rec7.rec_despli;
    IF ( ws_key_cam = 'ben_keyemp' ) AND ( ws_dsp_cam = 'N' ) THEN
      wn_dsp_001 := 1;
    END IF;
    IF ( ws_key_cam = 'ben_keyben' ) AND (ws_dsp_cam = 'N' ) THEN
      wn_dsp_002 := 1;
    END IF;
    IF ( ws_key_cam = 'ben_comfam' ) AND ( ws_dsp_cam = 'N' ) THEN
      wn_dsp_003 := 1;
    END IF;
    IF ( ws_key_cam = 'ben_rfcben' ) AND ( ws_dsp_cam = 'N' ) THEN
      wn_dsp_004 := 1;
    END IF;
    IF ( ws_key_cam = 'ben_nomben' ) AND ( ws_dsp_cam = 'N' ) THEN
      wn_dsp_005 := 1;
    END IF;
    IF ( ws_key_cam = 'ben_fecnac' ) AND ( ws_dsp_cam = 'N' ) THEN
      wn_dsp_006 := 1;
    END IF;
    IF ( ws_key_cam = 'ben_cvesex' ) AND ( ws_dsp_cam = 'N' ) THEN
      wn_dsp_007 := 1;
    END IF;
    IF ( ws_key_cam = 'ben_tippar' ) AND ( ws_dsp_cam = 'N' ) THEN
      wn_dsp_008 := 1;
    END IF;
    IF ( ws_key_cam = 'ben_tipben' ) AND ( ws_dsp_cam = 'N' ) THEN
      wn_dsp_009 := 1;
    END IF;
    IF ( ws_key_cam = 'ben_porpar' ) AND ( ws_dsp_cam = 'N' ) THEN
      wn_dsp_010 := 1;
    END IF;
    IF ( ws_key_cam = 'ben_fecven' ) AND ( ws_dsp_cam = 'N' ) THEN
      wn_dsp_011 := 1;
    END IF;
    IF ( ws_key_cam = 'ben_keyban' ) AND ( ws_dsp_cam = 'N' ) THEN
      wn_dsp_012 := 1;
    END IF;
    IF ( ws_key_cam = 'ben_ctaban' ) AND ( ws_dsp_cam = 'N' ) THEN
      wn_dsp_013 := 1;
    END IF;
    IF ( ws_key_cam = 'ben_keydep' ) AND ( ws_dsp_cam = 'N' ) THEN
      wn_dsp_014 := 1;
    END IF;
    IF ( ws_key_cam = 'ben_keycen' ) AND ( ws_dsp_cam = 'N' ) THEN
      wn_dsp_015 := 1;
    END IF;
    IF ( ws_key_cam = 'ben_forpag' ) AND ( ws_dsp_cam = 'N' ) THEN
      wn_dsp_016 := 1;
    END IF;
    IF ( ws_key_cam = 'ben_fecact' ) AND ( ws_dsp_cam = 'N' ) THEN
      wn_dsp_017 := 1;
    END IF;
    IF ( ws_key_cam = 'ben_ca1aux' ) AND ( ws_dsp_cam = 'N' ) THEN
      wn_dsp_018 := 1;
    END IF;
    IF ( ws_key_cam = 'ben_ca2aux' ) AND ( ws_dsp_cam = 'N' ) THEN
      wn_dsp_019 := 1;
    END IF;
  END LOOP;
  -- extrae las restricciones de  espliegue de la tabla de prestamos --
  FOR rec8 IN c_desplieg2 LOOP
    ws_key_cam := rec8.rec_keycam;
    ws_dsp_cam := rec8.rec_despli;
    IF ( ws_key_cam = 'pre_keycon' ) AND ( ws_dsp_cam = 'N' ) THEN
      wn_dsp_020 := 1;
    END IF;
    IF ( ws_key_cam = 'pre_ca1aux' ) AND ( ws_dsp_cam = 'N' ) THEN
      wn_dsp_021 := 1;
    END IF;
    IF ( ws_key_cam = 'pre_fecini' ) AND ( ws_dsp_cam = 'N' ) THEN
      wn_dsp_022 := 1;
    END IF;
    IF ( ws_key_cam = 'pre_plazop' ) AND ( ws_dsp_cam = 'N' ) THEN
      wn_dsp_023 := 1;
    END IF;
    IF ( ws_key_cam = 'pre_porint' ) AND ( ws_dsp_cam = 'N' ) THEN
      wn_dsp_024 := 1;
    END IF;
    IF ( ws_key_cam = 'pre_impdes' ) AND ( ws_dsp_cam = 'N' ) THEN
      wn_dsp_025 := 1;
    END IF;
    IF ( ws_key_cam = 'pre_imppre' ) AND ( ws_dsp_cam = 'N' ) THEN
      wn_dsp_026 := 1;
    END IF;
    IF ( ws_key_cam = 'pre_perini' ) AND ( ws_dsp_cam = 'N' ) THEN
      wn_dsp_027 := 1;
    END IF;
  END LOOP;
  -- Inicializa variables de trabajo para realizar Cortes y Monit --
  wn_emp_ant := -999999999;
  ws_dep_ant := '################';
  ws_cen_ant := '################';
  ws_ben_ant := '##';
  wn_num_reg := 0;
  wn_pct_act := 1;
  --LET wn_pct_reg = wn_tot_reg / 10.0;
  -- Define cursor principal                                      --
  FOR rec9 IN c_nmlstben LOOP
    -- Actualiza registro de monitoreo                              --
    --LET wn_num_reg = wn_num_reg + 1;
    --IF wn_num_reg >= ( wn_pct_reg * wn_pct_act ) THEN
    --  UPDATE glcoresu SET res_numreg = wn_num_reg
    --    WHERE res_idepro = ws_nom_rep
    --      AND res_idepcc = ws_ide_pcc
    --      AND res_keyusu = wn_key_usu
    --      AND res_fecini = TODAY
    --      AND res_horreg = ws_hor_reg;
    --a  LET wn_pct_act = wn_pct_act + 1;
    --END IF;
 -- Extrae descripciones del departamento, centro de costo y  --
 -- nombre del empleado.                                      --
    wn_key_emp := rec9.ben_keyemp;
    wn_key_ben := rec9.ben_keyben;
    wn_com_fam := rec9.ben_comfam;
    ws_rfc_ben := rec9.ben_rfcben;
    ws_nom_ben := rec9.ben_nomben;
    wd_fec_nac := rec9.ben_fecnac;
    ws_cve_sex := rec9.ben_cvesex;
    ws_tip_par := rec9.ben_tippar;
    ws_tip_ben := rec9.beb_tipben;
    wn_por_par := rec9.beb_porpar;
    ws_key_ban := rec9.ben_keyban;
    ws_cta_ban := rec9.ben_ctaban;
    ws_key_dep := rec9.ben_keydep;
    ws_key_cen := rec9.ben_keycen;
    ws_for_pag := rec9.beb_forpag;
    ws_ca1_aux := rec9.ben_ca1aux;
    ws_ca2_aux := rec9.ben_ca2aux;
    ws_key_con := rec9.pre_keycon;
    ws_reg_inf := rec9.pre_refere;
    ws_tip_pen := rec9.pre_tippre;
    wn_uni_pre := rec9.pre_unipre;
    wn_imp_pre := rec9.pre_imppre;
    wn_uni_des := rec9.pre_unides;
    wn_imp_des := rec9.pre_impdes;
    ws_per_ini := rec9.pre_perini;
    wd_fec_exp := rec9.pre_fecreg;
    IF wn_key_emp IS NULL THEN
      ws_nom_emp := 'EMPLEADO NO EXISTE ...';
    ELSE
      IF wn_key_emp <> wn_emp_ant THEN
        ws_nom_emp := 'EMPLEADO NO EXISTE ...';
        FOR rec10 IN c_nomemp2 LOOP
        ws_nom_emp := rec10.emp_nomemp;
        END LOOP;
        wn_emp_ant := wn_key_emp;
      END IF;
    END IF;
    IF ws_key_dep IS NULL THEN
      ws_des_dep := 'DEPARTAMENTO NO EXISTE ...';
    ELSE
      IF ws_key_dep <> ws_dep_ant THEN
        ws_des_dep := 'DEPARTAMENTO NO EXISTE ...';
        FOR rec11 IN c_desdep2 LOOP
        ws_des_dep := rec11.dep_desdep;
        END LOOP;
        ws_dep_ant := ws_key_dep;
      END IF;
    END IF;
    IF ws_key_cen IS NULL THEN
      ws_des_cen := 'CENTRO NO EXISTE ...';
    ELSE
      IF ws_key_cen <> ws_cen_ant THEN
        ws_des_cen := 'CENTRO NO EXISTE ...';
        FOR rec12 IN c_descen2 LOOP
        ws_des_cen := rec12.cen_descen;
        END LOOP;
        ws_cen_ant := ws_key_cen;
      END IF;
    END IF;
 -- Extrae la descripcion del tipo de beneficio                  --
    IF ws_tip_ben IS NULL THEN
      ws_des_ben := 'BENEFICIO NO EXISTE ...';
    ELSE
      IF ws_tip_ben <> ws_ben_ant THEN
        ws_des_ben := 'BENEFICIO NO EXISTE ...';
        FOR rec13 IN c_desben LOOP
        ws_des_ben := rec13.pam_nompar;
        END LOOP;
        ws_ben_ant := ws_tip_ben;
      END IF;
    END IF;
 -- Aplica restricciones de despliegue de Campos                 --
    IF wn_dsp_001 = 1 THEN
      wn_key_emp := NULL;
      ws_nom_emp := NULL;
    END IF;
    IF wn_dsp_002 = 1 THEN wn_key_ben := NULL; END IF;
    IF wn_dsp_003 = 1 THEN wn_com_fam := NULL; END IF;
    IF wn_dsp_004 = 1 THEN ws_rfc_ben := NULL; END IF;
    IF wn_dsp_005 = 1 THEN ws_nom_ben := NULL; END IF;
    IF wn_dsp_006 = 1 THEN wd_fec_nac := NULL; END IF;
    IF wn_dsp_007 = 1 THEN ws_cve_sex := NULL; END IF;
    IF wn_dsp_008 = 1 THEN ws_tip_par := NULL; END IF;
    IF wn_dsp_009 = 1 THEN
      ws_tip_ben := NULL;
      ws_des_ben := NULL;
    END IF;
    IF wn_dsp_010 = 1 THEN wn_por_par := NULL; END IF;
    --IF wn_dsp_011 = 1 THEN LET wd_fec_ven = NULL; END IF;
    IF wn_dsp_012 = 1 THEN ws_key_ban := NULL; END IF;
    IF wn_dsp_013 = 1 THEN ws_cta_ban := NULL; END IF;
    IF wn_dsp_014 = 1 THEN
      ws_key_dep := NULL;
      ws_des_dep := NULL;
    END IF;
    IF wn_dsp_015 = 1 THEN
      ws_key_cen := NULL;
      ws_des_cen := NULL;
    END IF;
    IF wn_dsp_016 = 1 THEN ws_for_pag := NULL; END IF;
 --   IF wn_dsp_017 = 1 THEN LET wd_fec_act = NULL; END IF;
    IF wn_dsp_018 = 1 THEN ws_ca1_aux := NULL; END IF;
    IF wn_dsp_019 = 1 THEN ws_ca2_aux := NULL; END IF;
    IF wn_dsp_020 = 1 THEN ws_key_con := NULL; END IF;
    IF wn_dsp_021 = 1 THEN ws_reg_inf := NULL; END IF;
 --   IF wn_dsp_022 = 1 THEN LET wd_fec_exp = NULL; END IF;
 --   IF wn_dsp_023 = 1 THEN LET wn_pla_zop = NULL; END IF;
 --   IF wn_dsp_024 = 1 THEN LET wn_por_int = NULL; END IF;
 --   IF wn_dsp_025 = 1 THEN LET wn_imp_des = NULL; END IF;
 --   IF wn_dsp_026 = 1 THEN LET wn_imp_pre = NULL; END IF;
    IF wn_dsp_027 = 1 THEN ws_per_ini := NULL; END IF;
    -- Inserta en la tabla de trabajo del Crystal Report            --
    INSERT INTO USRSIHO.glwkcrys (
        cry_nomrep, cry_idepcc, cry_keyusu, cry_chr001, cry_dec006,
        cry_dec007, cry_dec008, cry_chr008, cry_chr003, cry_dat001,
        cry_chr040, cry_chr041, cry_chr042, cry_dec011,
        cry_chr043, cry_chr009, cry_chr010, cry_chr011, cry_chr044,
                    cry_chr012, cry_chr013, cry_chr002, cry_chr004,
        cry_chr005, cry_chr017, cry_chr018, cry_chr019, cry_chr020,
        cry_chr021, cry_chr022, cry_chr023, cry_chr024, cry_chr025,
        cry_chr026, cry_chr027,             cry_chr029, cry_chr030,
        cry_chr031, cry_chr032,                         cry_chr035,
        cry_chr036, cry_chr037, cry_chr038, cry_chr039, cry_chr045,
        cry_dat004, cry_chr006,
        cry_chr015, cry_chr007, cry_dat005, cry_chr033, cry_dec012,
        cry_dec013, cry_dec014, cry_chr014, cry_dec015 )
      VALUES (
        ws_nom_rep, ws_ide_pcc, wn_key_usu, ws_des_cor, wn_key_emp,
        wn_key_ben, wn_com_fam, ws_rfc_ben, substr(ws_nom_ben,1,40), wd_fec_nac,
        ws_cve_sex, ws_tip_par, ws_tip_ben, wn_por_par,
        ws_key_ban, ws_cta_ban, ws_key_dep, ws_key_cen, ws_for_pag,
                    ws_ca1_aux, ws_ca2_aux, ws_nom_emp, ws_des_dep,
        ws_des_cen, ws_etq_001, ws_etq_002, ws_etq_003, ws_etq_004,
        ws_etq_005, ws_etq_006, ws_etq_007, ws_etq_008, ws_etq_009,
        ws_etq_010, ws_etq_011,             ws_etq_013, ws_etq_014,
        ws_etq_015, ws_etq_016,                         ws_etq_019,
        ws_etq_020, ws_etq_021, ws_etq_022, ws_etq_023, ws_hor_act,
        ws_fec_act, ws_des_ben,
        ws_key_con, ws_reg_inf, wd_fec_exp, ws_tip_pen, wn_uni_pre,
        wn_imp_pre, wn_uni_des, ws_per_ini, wn_imp_des );
  END LOOP;
  -- Actualiza la tabla de monitoreo indicando la finalizacion    --
  -- del proceso.                                                 --
  ws_hor_act := to_char(SYSDATE, 'hh24:mi:ss');
  UPDATE USRSIHO.glcoresu SET res_numreg = wn_num_reg,
                      res_fecfin = TRUNC(SYSDATE),
                      res_horfin = ws_hor_act,
                      res_status = 'T'
    WHERE res_idepro = ws_nom_rep
      AND res_idepcc = ws_ide_pcc
      AND res_keyusu = wn_key_usu
      AND res_fecini = TRUNC(SYSDATE)
      AND res_horreg = ws_hor_reg;
END;
/
