CREATE OR REPLACE EDITIONABLE PROCEDURE "USRSIHO"."SP_NMLSTPER" (ws_nom_rep VARCHAR2, ws_ide_pcc VARCHAR2,
  wn_key_usu NUMBER, ws_key_men VARCHAR2, ws_hor_reg VARCHAR2 ) IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
  -- SIPROS, S.A. DE C.V.
  --
  -- Sistema  : RH-2000 C/S
  -- Modulo   : Administracion de remuneraciones (nm)
  --
  -- Programa : sp_nmlstper
  --            Reporte de Periodos
  --
  -- Autor    : Joaquin Perez M.
  -- Fecha    : 07 de Marzo de 1997.
  --
  -- Variables para la carga de la tabla de Periodos --
  wn_key_pro NUMBER(5);
  wn_key_per VARCHAR2(7);
  wd_fec_ini DATE;
  wd_fec_fin DATE;
  wn_key_nom NUMBER(5);
  wd_fec_pag DATE;
  wn_num_mes NUMBER(5);
  wn_acu_dos NUMBER(5);
  wn_acu_tre NUMBER(5);
  wn_acu_cua NUMBER(5);
  ws_nu1_aux VARCHAR2(10);
  ws_nu2_aux VARCHAR2(10);
  ws_nu3_aux VARCHAR2(10);
  ws_nu4_aux VARCHAR2(10);
  ws_nu5_aux VARCHAR2(10);
  ws_key_pol VARCHAR2(10);
  wd_fec_pol DATE;
  -- Variables para la carga de las descripciones de las Claves   --
  ws_des_pro VARCHAR2(40);
  ws_des_nom VARCHAR2(40);
  ws_des_cor VARCHAR2(60);
  wn_pro_ant NUMBER(5);
  ws_des_lis VARCHAR2(50);
  -- Variables para la carga de las descripciones de las Etiquetas --
  ws_key_cam VARCHAR2(20);
  ws_des_etq VARCHAR2(8);
  ws_des_etq1 VARCHAR2(40);
  ws_etq_001 VARCHAR2(8);
  ws_etq_002 VARCHAR2(8);
  ws_etq_003 VARCHAR2(8);
  ws_etq_004 VARCHAR2(40);
  ws_etq_005 VARCHAR2(8);
  ws_etq_006 VARCHAR2(8);
  ws_etq_007 VARCHAR2(8);
  ws_etq_008 VARCHAR2(8);
  ws_etq_009 VARCHAR2(8);
  ws_etq_010 VARCHAR2(40);
  ws_etq_011 VARCHAR2(40);
  ws_etq_012 VARCHAR2(40);
  ws_etq_013 VARCHAR2(40);
  ws_etq_014 VARCHAR2(40);
  ws_etq_015 VARCHAR2(40);
  ws_etq_016 VARCHAR2(8);
  ws_etq_017 VARCHAR2(8);
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
  -- Variables para el reporte de avance                          --
  wn_tot_reg NUMBER(10);
  wn_num_reg NUMBER(10);
  wn_pct_reg NUMBER(6,2);
  wn_pct_act NUMBER(5);
  ws_hor_act VARCHAR2(8);
  ws_fec_act DATE;
 CURSOR c_descor IS
    SELECT cor_descor FROM USRSIHO.glcocorp;
CURSOR c_lista IS
    SELECT lis_deslis FROM USRSIHO.glcolist
      WHERE lis_keylis = ws_nom_rep;
CURSOR c_etiqueta1 IS
    SELECT cam_keycam, cam_descor
        FROM USRSIHO.glcocamp
      WHERE cam_keytab = 'nmloperi';
CURSOR c_etiqueta IS
    SELECT cam_keycam, cam_descam
        FROM USRSIHO.glcocamp
      WHERE cam_keytab = 'nmloperi';
CURSOR c_desplieg IS
    SELECT rec_keycam, rec_despli FROM USRSIHO.glcoreca
      WHERE rec_keytab = 'nmloperi'
        AND rec_keymen = ws_key_men;
CURSOR c_despro IS
          SELECT pro_despro FROM USRSIHO.nmloproc
            WHERE pro_keypro = wn_key_pro;
CURSOR c_desnom IS
    SELECT nom_destip FROM USRSIHO.nmlonomi
      WHERE nom_keynom = wn_key_nom;
CURSOR c_nmlstper IS
    SELECT per_keyper, per_fecini, per_fecfin, per_keynom, per_fecpag,
           per_nummes, per_acudos, per_acutre, per_acucua, per_nu1aux,
           per_nu2aux, per_nu3aux, per_nu4aux, per_nu5aux, per_keypol,
           per_fecpol, per_keypro
        FROM USRSIHO.nmloperi
      WHERE per_keypro IN
        ( SELECT ran_keypro FROM USRSIHO.glwkrang
            WHERE ran_nomrep = ws_nom_rep
              AND ran_idepcc = ws_ide_pcc
              AND ran_keyusu = wn_key_usu
              AND ran_keypro IS NOT NULL )
        AND per_keynom IN
        ( SELECT ran_keynom FROM USRSIHO.glwkrang
            WHERE ran_nomrep = ws_nom_rep
              AND ran_idepcc = ws_ide_pcc
              AND ran_keyusu = wn_key_usu
              AND ran_keynom IS NOT NULL )
      AND per_keyper IN
      ( SELECT ran_keyper FROM USRSIHO.glwkrang
          WHERE ran_nomrep = ws_nom_rep
            AND ran_idepcc = ws_ide_pcc
            AND ran_keyusu = wn_key_usu
            AND ran_keyper IS NOT NULL )
      ORDER BY per_keypro, per_keynom, per_keyper;
BEGIN
	-- Realiza el conteo de registros a procesar                    --
	BEGIN
		SELECT COUNT(*)
		INTO wn_tot_reg
		FROM USRSIHO.nmloperi
		WHERE per_keypro IN
						( SELECT ran_keypro FROM USRSIHO.glwkrang
						  WHERE ran_nomrep = ws_nom_rep
							AND ran_idepcc = ws_ide_pcc
							AND ran_keyusu = wn_key_usu
							AND ran_keypro IS NOT NULL )
		AND per_keynom IN
						( SELECT ran_keynom FROM USRSIHO.glwkrang
						  WHERE ran_nomrep = ws_nom_rep
							AND ran_idepcc = ws_ide_pcc
							AND ran_keyusu = wn_key_usu
							AND ran_keynom IS NOT NULL )
		AND per_keyper IN
						( SELECT ran_keyper FROM USRSIHO.glwkrang
						  WHERE ran_nomrep = ws_nom_rep
							AND ran_idepcc = ws_ide_pcc
							AND ran_keyusu = wn_key_usu
							AND ran_keyper IS NOT NULL );
		EXCEPTION WHEN no_data_found THEN wn_tot_reg := 0;
	END;
  -- Inserta registro para monitoreo de resultados                --
  ws_hor_act := to_CHAR(SYSDATE, 'hh24:mi:ss');
  ws_fec_act := TRUNC(SYSDATE);
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
  -- Extrae el nombre de la Compania Corporativa                 --
  ws_des_cor := 'CORPORATIVO NO REGISTRADO ...';
  FOR rec IN c_descor LOOP
  ws_des_cor := rec.cor_descor;
  END LOOP;
  -- Extrae el nombre del Reporte
  ws_des_lis := 'No existe Nombre del Reporte ...';
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
  ws_etq_016 := '........';
  ws_etq_017 := '........';
  -- Extrae las etiquetas del Diccionario de Datos                --
  FOR rec3 IN c_etiqueta1 LOOP
    ws_key_cam := rec3.cam_keycam;
    ws_des_etq := rec3.cam_descor;
    IF ws_key_cam = 'per_keyper' THEN
      ws_etq_001 := ws_des_etq;
    END IF;
    IF ws_key_cam = 'per_fecini' THEN
      ws_etq_002 := ws_des_etq;
    END IF;
    IF ws_key_cam = 'per_fecfin' THEN
      ws_etq_003 := ws_des_etq;
    END IF;
    IF ws_key_cam = 'per_fecpag' THEN
      ws_etq_005 := ws_des_etq;
    END IF;
    IF ws_key_cam = 'per_nummes' THEN
      ws_etq_006 := ws_des_etq;
    END IF;
    IF ws_key_cam = 'per_acudos' THEN
      ws_etq_007 := ws_des_etq;
    END IF;
    IF ws_key_cam = 'per_acutre' THEN
      ws_etq_008 := ws_des_etq;
    END IF;
    IF ws_key_cam = 'per_acucua' THEN
      ws_etq_009 := ws_des_etq;
    END IF;
    IF ws_key_cam = 'per_fecpol' THEN
      ws_etq_016 := ws_des_etq;
    END IF;
    IF ws_key_cam = 'per_keypro' THEN
      ws_etq_017 := ws_des_etq;
    END IF;
  END LOOP;
  -- Extrae las etiquetas del Diccionario de Datos                --
  FOR rec4 IN c_etiqueta LOOP
    ws_key_cam := rec4.cam_keycam;
    ws_des_etq1 := rec4.cam_descam;
    IF ws_key_cam = 'per_keynom' THEN
      ws_etq_004 := ws_des_etq1;
    END IF;
    IF ws_key_cam = 'per_nu1aux' THEN
      ws_etq_010 := ws_des_etq1;
    END IF;
    IF ws_key_cam = 'per_nu2aux' THEN
      ws_etq_011 := ws_des_etq1;
    END IF;
    IF ws_key_cam = 'per_nu3aux' THEN
      ws_etq_012 := ws_des_etq1;
    END IF;
    IF ws_key_cam = 'per_nu4aux' THEN
      ws_etq_013 := ws_des_etq1;
    END IF;
    IF ws_key_cam = 'per_nu5aux' THEN
      ws_etq_014 := ws_des_etq1;
    END IF;
    IF ws_key_cam = 'per_keypol' THEN
      ws_etq_015 := ws_des_etq1;
    END IF;
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
  -- Extrae las restricciones de Despliegue                       --
  FOR rec5 IN c_desplieg LOOP
    ws_key_cam := rec5.rec_keycam;
    ws_dsp_cam := rec5.rec_despli;
    IF ( ws_key_cam = 'per_keypro' ) AND ( ws_dsp_cam = 'N' ) THEN
      wn_dsp_001 := 1;
    END IF;
    IF ( ws_key_cam = 'per_keynom' ) AND ( ws_dsp_cam = 'N' ) THEN
      wn_dsp_002 := 1;
    END IF;
    IF ( ws_key_cam = 'per_keyper' ) AND ( ws_dsp_cam = 'N' ) THEN
      wn_dsp_003 := 1;
    END IF;
    IF ( ws_key_cam = 'per_fecini' ) AND ( ws_dsp_cam = 'N' ) THEN
      wn_dsp_004 := 1;
    END IF;
    IF ( ws_key_cam = 'per_fecfin' ) AND ( ws_dsp_cam = 'N' ) THEN
      wn_dsp_005 := 1;
    END IF;
    IF ( ws_key_cam = 'per_fecpag' ) AND ( ws_dsp_cam = 'N' ) THEN
      wn_dsp_006 := 1;
    END IF;
    IF ( ws_key_cam = 'per_nummes' ) AND ( ws_dsp_cam = 'N' ) THEN
      wn_dsp_007 := 1;
    END IF;
    IF ( ws_key_cam = 'per_acudos' ) AND ( ws_dsp_cam = 'N' ) THEN
      wn_dsp_008 := 1;
    END IF;
    IF ( ws_key_cam = 'per_acutre' ) AND ( ws_dsp_cam = 'N' ) THEN
      wn_dsp_009 := 1;
    END IF;
    IF ( ws_key_cam = 'per_acucua' ) AND ( ws_dsp_cam = 'N' ) THEN
      wn_dsp_010 := 1;
    END IF;
    IF ( ws_key_cam = 'per_nu1aux' ) AND ( ws_dsp_cam = 'N' ) THEN
      wn_dsp_011 := 1;
    END IF;
    IF ( ws_key_cam = 'per_nu2aux' ) AND ( ws_dsp_cam = 'N' ) THEN
      wn_dsp_012 := 1;
    END IF;
    IF ( ws_key_cam = 'per_nu3aux' ) AND ( ws_dsp_cam = 'N' ) THEN
      wn_dsp_013 := 1;
    END IF;
    IF ( ws_key_cam = 'per_nu4aux' ) AND ( ws_dsp_cam = 'N' ) THEN
      wn_dsp_014 := 1;
    END IF;
    IF ( ws_key_cam = 'per_nu5aux' ) AND ( ws_dsp_cam = 'N' ) THEN
      wn_dsp_015 := 1;
    END IF;
    IF ( ws_key_cam = 'per_keypol' ) AND ( ws_dsp_cam = 'N' ) THEN
      wn_dsp_016 := 1;
    END IF;
    IF ( ws_key_cam = 'per_fecpol' ) AND ( ws_dsp_cam = 'N' ) THEN
      wn_dsp_017 := 1;
    END IF;
  END LOOP;
  -- Inicializa variables de trabajo para realizar Cortes y Monit --
  wn_pro_ant := -32760;
  wn_num_reg := 0;
  wn_pct_act := 1;
  wn_pct_reg := wn_tot_reg / 10.0;
  -- Define cursor principal                                      --
  FOR rec6 IN c_nmlstper LOOP
    -- Actualiza registro de monitoreo                              --
    wn_key_per := rec6.per_keyper;
    wd_fec_ini := rec6.per_fecini;
    wd_fec_fin := rec6.per_fecfin;
    wn_key_nom := rec6.per_keynom;
    wd_fec_pag := rec6.per_fecpag;
    wn_num_mes := rec6.per_nummes;
    wn_acu_dos := rec6.per_acudos;
    wn_acu_tre := rec6.per_acutre;
    wn_acu_cua := rec6.per_acucua;
    ws_nu1_aux := rec6.per_nu1aux;
    ws_nu2_aux := rec6.per_nu2aux;
    ws_nu3_aux := rec6.per_nu3aux;
    ws_nu4_aux := rec6.per_nu4aux;
    ws_nu5_aux := rec6.per_nu5aux;
    ws_key_pol := rec6.per_keypol;
    wd_fec_pol := rec6.per_fecpol;
    wn_key_pro := rec6.per_keypro;
    wn_num_reg := wn_num_reg + 1;
    IF wn_num_reg >= ( wn_pct_reg * wn_pct_act ) THEN
      UPDATE USRSIHO.glcoresu SET res_numreg = wn_num_reg
        WHERE res_idepro = ws_nom_rep
          AND res_idepcc = ws_ide_pcc
          AND res_keyusu = wn_key_usu
          AND res_fecini = TRUNC(SYSDATE)
          AND res_horreg = ws_hor_reg;
      wn_pct_act := wn_pct_act + 1;
    END IF;
    -- Extrae descripciones de proceso y tipo de Nomina   --
    IF wn_key_pro IS NULL THEN
      ws_des_pro := 'PROCESO NO EXISTE ...';
    ELSE
      IF wn_key_pro <> wn_pro_ant THEN
        ws_des_pro := 'PROCESO NO EXISTE ...';
        FOR rec7 IN c_despro LOOP
        ws_des_pro := rec7.pro_despro;
        END LOOP;
        wn_pro_ant := wn_key_pro;
      END IF;
    END IF;
  ws_des_nom := 'NOMINA NO EXISTE ...';
  FOR rec8 IN c_desnom LOOP
  ws_des_nom := rec8.nom_destip;
  END LOOP;
    -- Aplica restricciones de despliegue de Campos                 --
    IF wn_dsp_001 = 1 THEN
      wn_key_pro := NULL;
      ws_des_pro := NULL;
    END IF;
    IF wn_dsp_002 = 1 THEN
      wn_key_nom := NULL;
      ws_des_nom := NULL;
    END IF;
    IF wn_dsp_003 = 1 THEN wn_key_per := NULL; END IF;
    IF wn_dsp_004 = 1 THEN wd_fec_ini := NULL; END IF;
    IF wn_dsp_005 = 1 THEN wd_fec_fin := NULL; END IF;
    IF wn_dsp_006 = 1 THEN wd_fec_pag := NULL; END IF;
    IF wn_dsp_007 = 1 THEN wn_num_mes := NULL; END IF;
    IF wn_dsp_008 = 1 THEN wn_acu_dos := NULL; END IF;
    IF wn_dsp_009 = 1 THEN wn_acu_tre := NULL; END IF;
    IF wn_dsp_010 = 1 THEN wn_acu_cua := NULL; END IF;
    IF wn_dsp_011 = 1 THEN ws_nu1_aux := NULL; END IF;
    IF wn_dsp_012 = 1 THEN ws_nu2_aux := NULL; END IF;
    IF wn_dsp_013 = 1 THEN ws_nu3_aux := NULL; END IF;
    IF wn_dsp_014 = 1 THEN ws_nu4_aux := NULL; END IF;
    IF wn_dsp_015 = 1 THEN ws_nu5_aux := NULL; END IF;
    IF wn_dsp_016 = 1 THEN ws_key_pol := NULL; END IF;
    IF wn_dsp_017 = 1 THEN wd_fec_pol := NULL; END IF;
    -- Inserta en la tabla de trabajo del Crystal Report            --
    INSERT INTO USRSIHO.glwkcrys (
        cry_nomrep, cry_idepcc, cry_keyusu, cry_chr001, cry_chr017,
        cry_dat001, cry_dat002, cry_dec006, cry_chr003, cry_dat003,
        cry_dec007, cry_dec008, cry_dec009, cry_dec010, cry_chr008,
        cry_chr009, cry_chr010, cry_chr011, cry_chr007, cry_chr006,
        cry_dat004, cry_dec011, cry_chr004, cry_chr018, cry_dat005,
        cry_chr019, cry_chr020, cry_chr021, cry_chr005, cry_chr023,
        cry_chr024, cry_chr025, cry_chr026, cry_chr027, cry_chr012,
        cry_chr013, cry_chr014, cry_chr015, cry_chr016, cry_chr033,
        cry_chr034, cry_chr035, cry_chr002 )
      VALUES (
        ws_nom_rep, ws_ide_pcc, wn_key_usu, ws_des_cor, wn_key_per,
        wd_fec_ini, wd_fec_fin, wn_key_nom, ws_des_nom, wd_fec_pag,
        wn_num_mes, wn_acu_dos, wn_acu_tre, wn_acu_cua, ws_nu1_aux,
        ws_nu2_aux, ws_nu3_aux, ws_nu4_aux, ws_nu5_aux, ws_key_pol,
        wd_fec_pol, wn_key_pro, ws_des_pro, ws_hor_act, ws_fec_act,
        ws_etq_001, ws_etq_002, ws_etq_003, ws_etq_004, ws_etq_005,
        ws_etq_006, ws_etq_007, ws_etq_008, ws_etq_009, substr(ws_etq_010,1,16),
        substr(ws_etq_011,1,16), substr(ws_etq_012,1,16), ws_etq_013, ws_etq_014, ws_etq_015,
        ws_etq_016, ws_etq_017, ws_des_lis );
  END LOOP;
  -- Actualiza la tabla de monitoreo indicando la finalizacion    --
  -- del proceso.                                                 --
  ws_hor_act := to_CHAR(SYSDATE, 'hh24:mi:ss');
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
