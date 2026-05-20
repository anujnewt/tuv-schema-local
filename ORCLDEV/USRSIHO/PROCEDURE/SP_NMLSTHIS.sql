CREATE OR REPLACE EDITIONABLE PROCEDURE "USRSIHO"."SP_NMLSTHIS" (ws_nom_rep IN VARCHAR2, ws_ide_pcc IN VARCHAR2,
 wn_key_usu IN NUMBER, ws_key_men IN VARCHAR2, ws_hor_reg IN VARCHAR2,ws_lis_per IN VARCHAR2) IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
  -- SIPROS, S. A. DE C. V.
  --
  -- Sistema  : RH-2000  C/S
  -- Modulo   : Administracion de Remuneraciones (nm)
  --
  -- Programa : sp_nmlsthis
  --            Reporte de Programas de Cifras de Control
  --                             Historico de Movimientos
  -- Autor    : Pedro Perez Gutierrez
  -- Fecha    : 18 de Abril de 1997
  --
  -- Variables para la carga de la Tablas Movimientos
  wn_his_emp NUMBER(10);
  ws_his_con VARCHAR2(3);
  wn_his_nom NUMBER(5);
  ws_his_per VARCHAR2(7);
  wn_his_pro NUMBER(5);
  ws_cod_imp VARCHAR2(2);
  ws_his_cia VARCHAR2(4);
  -- Variable para la carga de las especificaciones de las Claves
  ws_des_pro VARCHAR2(20);
  ws_des_nom VARCHAR2(40);
  ws_des_con VARCHAR2(40);
  ws_des_cor VARCHAR2(60);
  ws_des_cia VARCHAR2(60);
  wd_fec_ini DATE;
  wd_fec_fin DATE;
  ws_lis_pro VARCHAR2(40);
  ws_lis_nom VARCHAR2(40);
  ws_des_lis VARCHAR2(50);
  ws_key_cia VARCHAR2(4);
  wn_numemi  VARCHAR2(05);
  wd_fecpag  DATE;
  -- Variable para la carga de las descripciones de las Etiquetas
  ws_key_cam VARCHAR2(10);
  ws_des_etq VARCHAR2(40);
  ws_etq_001 VARCHAR2(10);
  ws_etq_002 VARCHAR2(10);
  ws_etq_003 VARCHAR2(10);
  ws_etq_004 VARCHAR2(20);
  ws_etq_005 VARCHAR2(10);
  ws_etq_006 VARCHAR2(10);
  ws_etq_007 VARCHAR2(10);
  wn_pri_mer NUMBER(10);
  -- Variables para las restricciones de despliegue
  ws_dsp_cam VARCHAR2(20);
  wn_dsp_001 NUMBER(5);
  wn_dsp_002 NUMBER(5);
  wn_dsp_003 NUMBER(5);
  wn_dsp_004 NUMBER(5);
  wn_dsp_005 NUMBER(5);
  wn_dsp_006 NUMBER(5);
  --  Variables para los Cortes de Procesos, Periodos y Conceptos --
  wn_ant_pro NUMBER(5);
  ws_ant_per VARCHAR2(7);
  ws_ant_con VARCHAR2(3);
  wn_ant_nom NUMBER(5);
  ws_ant_cod VARCHAR2(2);
  -- Variables para el reporte de avance
  wn_tot_reg NUMBER(10);
  wn_num_reg NUMBER(10);
  ws_hor_act VARCHAR2(8);
  ws_dia_act DATE;
  wn_con_tar NUMBER(10);
  wn_tot_emp NUMBER(10);
  wn_tot_can NUMBER(18,2);
  wn_tot_imp NUMBER(18,2);
  wn_tot_tra NUMBER(10);
 CURSOR c_lista IS
    SELECT lis_deslis FROM usrsiho.glcolist
      WHERE lis_keylis = ws_nom_rep;
 CURSOR c_etiqueta IS
    SELECT cam_keycam, cam_descor
    FROM usrsiho.glcocamp
    WHERE cam_keytab = 'nmlohism';
 CURSOR c_etiqueta1 IS
    SELECT cam_keycam, cam_descam
    FROM usrsiho.glcocamp
    WHERE cam_keytab = 'nmlohism';
 CURSOR c_des_nom IS
    SELECT cam_keycam, cam_descor
    FROM usrsiho.glcocamp
    WHERE cam_keytab = 'nmlonomi';
 CURSOR  c_desplieg IS
    SELECT rec_keycam, rec_despli
    FROM usrsiho.glcoreca
    WHERE rec_keytab = 'nmlohism'
      AND rec_keymen = ws_key_men;
 CURSOR c_descor IS
        SELECT pro_keycia FROM usrsiho.nmloproc
         WHERE pro_keypro = wn_his_pro;
 CURSOR c_for_pro IS
          SELECT pro_despro, pro_keycia
            FROM usrsiho.nmloproc
            WHERE pro_keypro = wn_his_pro;
 CURSOR c_des_cia IS
          SELECT cia_descia
            FROM usrsiho.nmlocias
            WHERE cia_keycia = ws_his_cia;
 CURSOR c_lis_pro IS
          SELECT ran_keycen
            FROM usrsiho.glwkrang
            WHERE ran_keypro = wn_his_pro
              AND ran_nomrep = ws_nom_rep
              AND ran_idepcc = ws_ide_pcc
              AND ran_keyusu = wn_key_usu;
 CURSOR c_pro_tot IS
          SELECT count(unique his_keyemp) totemp
            FROM usrsiho.nmlohism
            WHERE his_keypro = wn_his_pro
              AND his_keyper = ws_his_per;
 CURSOR c_for_con IS
          SELECT con_descon
            FROM usrsiho.nmloconc
            WHERE con_keycon = ws_his_con;
 CURSOR c_for_per IS
          SELECT per_fecini, per_fecfin, per_keynom, per_nu4aux, per_fecpag  ----cig
            FROM usrsiho.nmloperi
            WHERE per_keyper = ws_his_per
              AND per_keypro = wn_his_pro;
 CURSOR c_per_tot IS
           SELECT count(unique his_keyemp) totemp
            FROM usrsiho.nmlohism
            WHERE his_keypro = wn_his_pro
              AND his_keyper = ws_his_per;
 CURSOR c_for_nom IS
          SELECT nom_destip
            FROM usrsiho.nmlonomi
            WHERE nom_keynom = wn_his_nom;
 CURSOR c_lis_nom IS
          SELECT ran_keycat
            FROM usrsiho.glwkrang
            WHERE ran_nomrep = ws_nom_rep
              AND ran_idepcc = ws_ide_pcc
              AND ran_keyusu = wn_key_usu;
 CURSOR c_nmlsthis IS
    SELECT his_keycon, sum(his_cantid) suma_can,sum(his_import) suma_imp, his_keypro, his_keyper,
          his_codimp, count(*) total
      FROM usrsiho.nmlohism
      WHERE his_keypro IN
        ( SELECT ran_keypro FROM usrsiho.glwkrang
            WHERE ran_nomrep = ws_nom_rep
              AND ran_idepcc = ws_ide_pcc
              AND ran_keyusu = wn_key_usu
              AND ran_keypro IS NOT NULL )
      AND his_keyper IN
        ( SELECT ran_keyper FROM usrsiho.glwkrang
            WHERE ran_nomrep = ws_nom_rep
            AND ran_idepcc = ws_ide_pcc
            AND ran_keyusu = wn_key_usu
            AND ran_keyper IS NOT NULL )
    GROUP BY his_keypro, his_keyper, his_codimp, his_keycon
    ORDER BY his_keypro, his_keyper, his_codimp, his_keycon;
BEGIN
  -- Realiza el conteo de registros a procesar
	BEGIN
		SELECT COUNT(*) INTO wn_tot_reg FROM usrsiho.nmloperi
		WHERE per_keypro IN
						( SELECT ran_keypro FROM usrsiho.glwkrang
							WHERE ran_nomrep = ws_nom_rep
							  AND ran_idepcc = ws_ide_pcc
							  AND ran_keyusu = wn_key_usu
							  AND ran_keypro IS NOT NULL )
		AND per_keyper IN
						( SELECT ran_keyper FROM usrsiho.glwkrang
							WHERE ran_nomrep = ws_nom_rep
							  AND ran_idepcc = ws_ide_pcc
							  AND ran_keyusu = wn_key_usu
							  AND ran_keyper IS NOT NULL );
		EXCEPTION WHEN no_data_found THEN wn_tot_reg := 0;
	END;
  -- Inserta registro de resultados
    ws_hor_act := TO_CHAR (SYSDATE, 'HH24:MI:SS');
    ws_dia_act := TRUNC(SYSDATE);
  INSERT INTO usrsiho.glcoresu (
    res_idepro, res_idepcc, res_keyusu, res_fecini, res_horini,
    res_horreg, res_totreg, res_status )
  VALUES (
    ws_nom_rep, ws_ide_pcc, wn_key_usu, TRUNC(SYSDATE), ws_hor_act,
    ws_hor_reg, wn_tot_reg, 'P' );
  -- Borra la tabla de trabajo del Crystal Report
  DELETE FROM usrsiho.glwkcrys
    WHERE cry_nomrep = ws_nom_rep
      AND cry_idepcc = ws_ide_pcc
      AND cry_keyusu = wn_key_usu;
  -- Extrae el nombre de la Compania Corporativa
  --LET ws_des_cor = 'CORPORATIVO NO REGISTRADO ...';
  --FOREACH c_descor FOR
  --  SELECT cor_descor INTO ws_des_cor FROM glcocorp
  --END FOREACH;
  -- Extrae el nombre del Reporte
    begin
      SELECT  lis_deslis into ws_des_lis FROM usrsiho.glcolist
      WHERE lis_keylis = ws_nom_rep;
       exception
          when no_data_found then
            ws_des_lis := 'No existe Nombre del Reporte ...';
     end;
  -- Asigna valores por omision a las etiquetas del Diccionario de Datos --
  ws_etq_001 := '........'; ws_etq_002 := '........';
  ws_etq_003 := '........'; ws_etq_004 := '........';
  ws_etq_005 := '........'; ws_etq_006 := '........';
  ws_etq_007 := '........';
  -- Extrae las etiquetas del Diccionario de datos
  FOR rec2 IN c_etiqueta LOOP
    ws_key_cam := rec2.cam_keycam;
    ws_des_etq := rec2.cam_descor;
    IF ws_key_cam = 'his_keypro' THEN
      ws_etq_001 := ws_des_etq;
    END IF;
    IF ws_key_cam = 'his_keyper' THEN
      ws_etq_002 := ws_des_etq;
    END IF;
    IF ws_key_cam = 'his_keycon' THEN
      ws_etq_003 := ws_des_etq;
    END IF;
  END LOOP;
  FOR rec3 IN c_etiqueta1 LOOP
    ws_key_cam := rec3.cam_keycam;
    ws_des_etq := rec3.cam_descam;
    IF ws_key_cam = 'his_cantid' THEN
      ws_etq_004 := ws_des_etq;
    END IF;
    IF ws_key_cam = 'his_import' THEN
      ws_etq_005 := ws_des_etq;
    END IF;
  END LOOP;
  FOR rec4 IN c_des_nom LOOP
    ws_key_cam := rec4.cam_keycam;
    ws_des_etq := rec4.cam_descor;
    IF ws_key_cam = 'nom_keynom' THEN
      ws_etq_006 := ws_des_etq;
    END IF;
    IF ws_key_cam = 'nom_destip' THEN
      ws_etq_007 := ws_des_etq;
    END IF;
  END LOOP;
  -- ASIGNA  por omicion que todos los campos se pueden desplegar
  wn_dsp_001 := 0; wn_dsp_002 := 0;
  wn_dsp_003 := 0; wn_dsp_004 := 0;
  wn_dsp_005 := 0; wn_dsp_006 := 0;
  -- Extrae las restricciones de Despliegue --
  FOR rec5 IN c_desplieg LOOP
    ws_key_cam := rec5.rec_keycam;
    ws_dsp_cam := rec5.rec_despli;
    IF (ws_key_cam = 'ms_his_pro') AND ( ws_dsp_cam ='N' ) THEN
      wn_dsp_001 := 1;
    END IF;
    IF (ws_key_cam = 'ws_his_per') AND ( ws_dsp_cam ='N' ) THEN
      wn_dsp_002 := 1;
    END IF;
    IF (ws_key_cam = 'ws_his_con') AND ( ws_dsp_cam ='N' ) THEN
      wn_dsp_003 := 1;
    END IF;
    IF (ws_key_cam = 'wn_tot_can') AND ( ws_dsp_cam ='N' ) THEN
      wn_dsp_004 := 1;
    END IF;
    IF (ws_key_cam = 'wn_tot_imp') AND ( ws_dsp_cam ='N' ) THEN
     wn_dsp_005 := 1;
    END IF;
  END LOOP;
  ws_ant_con := '@@@';
  wn_ant_nom := -9999;
  ws_ant_per := '@@@'; -- Variable que Contiene el Periodo Anterior
  wn_ant_pro := -9999; -- Variable que Contiene el Proceso Anterior
  ws_ant_cod := '@@';
  ws_his_cia := '..';
  wn_num_reg := 0;
  wn_con_tar := 0;
  wn_tot_can := 0;
  wn_tot_imp := 0;
  wn_pri_mer := 0;
  wn_his_emp := -999999;
  -- Para contar cuanto empleados se vana  procesar en total
	BEGIN
		SELECT count(unique his_keyemp)
		INTO wn_his_emp
		FROM usrsiho.nmlohism
		WHERE his_keypro IN
						( SELECT ran_keypro FROM usrsiho.glwkrang
							WHERE ran_nomrep = ws_nom_rep
							  AND ran_idepcc = ws_ide_pcc
							  AND ran_keyusu = wn_key_usu
							  AND ran_keypro IS NOT NULL )
		AND his_keyper IN
						( SELECT ran_keyper FROM usrsiho.glwkrang
							WHERE ran_nomrep = ws_nom_rep
							AND ran_idepcc = ws_ide_pcc
							AND ran_keyusu = wn_key_usu
							AND ran_keyper IS NOT NULL );
		EXCEPTION WHEN no_data_found THEN wn_his_emp := 0;
	END;
  -- Define Cursor PRINCIPAL -------------------------------------------------
  FOR rec6 IN c_nmlsthis LOOP
    ws_his_con := rec6.his_keycon;
    wn_tot_can := rec6.suma_can;
    wn_tot_imp := rec6.suma_imp;
    wn_his_pro := rec6.his_keypro;
    ws_his_per := rec6.his_keyper;
    ws_cod_imp := rec6.his_codimp;
    wn_con_tar := rec6.total;
    IF wn_pri_mer = 0 THEN
      -- Extrae el nombre de la Compania Corporativa
      ws_des_cor := 'CORPORATIVO NO REGISTRADO ...';
      FOR rec7 IN c_descor LOOP
        ws_key_cia := rec7.pro_keycia;
        ws_des_cor := 'CORPORATIVO NO REGISTRADO ...';
        IF length(ws_key_cia) > 0 THEN
			BEGIN
				SELECT cia_descia
				INTO ws_des_cor
				FROM nmlocias
				WHERE cia_keycia = ws_key_cia;
				EXCEPTION WHEN no_data_found THEN ws_des_cor := '';
			END;
        END IF;
      END LOOP;
      wn_pri_mer:= wn_pri_mer+1;
    END IF;
    -- Actualiza el registro de monitoreo
    IF wn_ant_pro <> wn_his_pro AND ws_ant_per <> ws_his_per THEN
      wn_num_reg := wn_num_reg + 1;
      UPDATE glcoresu SET res_numreg = wn_num_reg
        WHERE res_idepro = ws_nom_rep
          AND res_idepcc = ws_ide_pcc
          AND res_keyusu = wn_key_usu
          AND res_fecini = TRUNC(SYSDATE)
          AND res_horreg = ws_hor_reg;
    END IF;
    -- Extraemos La descripcion del Proceso
    IF wn_ant_pro is NULL THEN
      ws_des_cia := 'Compania No existe...';
      ws_his_cia := '..';
      ws_des_pro := 'No Existe Proceso...';
    ELSE
      IF wn_ant_pro <> wn_his_pro THEN
        ws_des_pro := 'No Existe Proceso...';
        ws_his_cia := '..';
        FOR rec8 IN c_for_pro LOOP
        ws_des_pro := rec8.pro_despro;
        ws_his_cia := rec8.pro_keycia;
        END LOOP;
        ws_des_cia := 'Compania No existe...';
        FOR rec9 IN c_des_cia LOOP
        ws_des_cia := rec9.cia_descia;
        END LOOP;
        FOR rec10 IN c_lis_pro LOOP
        ws_lis_pro := rec10.ran_keycen;
        END LOOP;
        FOR rec11 IN c_pro_tot LOOP
           wn_tot_emp := rec11.totemp;
        END LOOP;
        wn_ant_pro := wn_his_pro;
      END IF;
    END IF;
    -- Extraemos La descripcion del Concepto
    IF ws_ant_con is NULL THEN
      ws_des_con := 'No Existe Concepto...';
    ELSE
      IF ws_ant_con <> ws_his_con THEN
        ws_des_con := 'No Existe Concepto...';
        FOR rec12 IN c_for_con LOOP
        ws_des_con := rec12.con_descon;
        END LOOP;
        ws_ant_con := ws_his_con;
      END IF;
    END IF;
    -- Guardamos el Codigo De impresion
    IF ws_ant_cod <> ws_cod_imp THEN
      ws_ant_cod := ws_cod_imp;
    END IF;
    -- Obtenemos fecha inicio y fecha final del Periodo
    IF ws_ant_per is NULL THEN
       wd_fec_ini:= TRUNC(SYSDATE);
       wd_fec_fin:= TRUNC(SYSDATE);
    ELSE
      IF ws_ant_per <> ws_his_per THEN
         wd_fec_ini:= TRUNC(SYSDATE);
         wd_fec_fin:= TRUNC(SYSDATE);
        FOR rec13 IN c_for_per LOOP
        wd_fec_ini := rec13.per_fecini;
        wd_fec_fin := rec13.per_fecfin;
        wn_his_nom := rec13.per_keynom;
        wn_numemi := rec13.per_nu4aux;
        wd_fecpag := rec13.per_fecpag;
        END LOOP;
        FOR rec14 IN c_per_tot LOOP
            wn_tot_emp := rec14.totemp;
        END LOOP;
        ws_ant_per := ws_his_per;
      END IF;
    END IF;
    -- Extraemos La descripcion de la Nomina
    --LET ws_des_nom = 'No Existe Nomina...';
    IF wn_ant_nom is NULL THEN
      ws_des_nom := 'No Existe Nomina...';
    ELSE
      IF wn_ant_nom <> wn_his_nom THEN
        ws_des_nom := 'No Existe Nomina...';
        FOR rec15 IN c_for_nom LOOP
        ws_des_nom := rec15.nom_destip;
        END LOOP;
        FOR rec16 IN c_lis_nom LOOP
        ws_lis_nom := rec16.ran_keycat;
        END LOOP;
        wn_ant_nom := wn_his_nom;
      END IF;
    END IF;
    -- Aplica Restricciones de despliegue de Campos ---
    IF wn_dsp_001 = 1 THEN
      wn_his_pro := NULL;
    END IF;
    IF wn_dsp_002 = 1 THEN
      ws_his_per := NULL;
    END IF;
    IF wn_dsp_003 = 1 THEN
      ws_his_con := NULL;
    END IF;
    IF wn_dsp_004 = 1 THEN
      wn_tot_can := NULL;
    END IF;
    IF wn_dsp_005 = 1 THEN
      wn_tot_imp := NULL;
    END IF;
    -- Inserta en la tabla de Trabajo del Crystal Report
    INSERT INTO usrsiho.glwkcrys (
      cry_nomrep, cry_idepcc, cry_keyusu, cry_chr001, cry_chr008,
      cry_chr004, cry_chr017, cry_chr018, cry_chr019, cry_chr009,
      cry_chr010, cry_chr022, cry_chr024, cry_chr025, cry_chr005,
      cry_dec001, cry_dec002, cry_dec006, cry_chr026, cry_dec008,
      cry_dec009, cry_dat001, cry_dat002, cry_dat003, cry_chr027,
      cry_chr002, cry_chr028, cry_chr011, cry_dec010, cry_chr006,
      cry_chr007, cry_chr003, cry_chr012, cry_dec007, cry_dat004,
      cry_chr044)
    VALUES (
      ws_nom_rep, ws_ide_pcc, wn_key_usu, ws_des_cor, ws_des_pro,
      ws_des_nom, ws_etq_001, ws_etq_002, ws_etq_003, ws_etq_004,
      ws_etq_005, ws_etq_006, ws_hor_act, ws_ant_con, ws_des_con,
      wn_tot_can, wn_tot_imp, wn_his_pro, ws_his_per, wn_his_nom,
      wn_con_tar, wd_fec_ini, wd_fec_fin, ws_dia_act, ws_ant_cod,
      ws_des_cia, ws_his_cia, ws_etq_007, wn_tot_emp, ws_lis_pro,
      ws_lis_per, ws_des_lis, ws_lis_nom, wn_his_emp, wd_fecpag,
      wn_numemi);
    -- Fin del FOREACH PRINCIPAL
  END LOOP;
  -- Actualiza la tabla de monitoreo la finalizacion del Proceso
  ws_hor_act := TO_CHAR (SYSDATE, 'HH24:MI:SS');
  UPDATE usrsiho.glcoresu SET res_numreg = wn_num_reg,
    res_fecfin = TRUNC(SYSDATE),
    res_horfin = ws_hor_act,
    res_status = 'T'
    WHERE res_idepro = ws_nom_rep
      AND res_idepcc = ws_ide_pcc
      AND res_keyusu = wn_key_usu
      AND res_fecini = TRUNC(SYSDATE)
      AND res_horreg = ws_hor_reg;
  -- Fin del Store Procedure
END;
/
