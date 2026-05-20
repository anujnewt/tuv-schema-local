CREATE OR REPLACE NONEDITIONABLE PROCEDURE "LABPROD"."SP_NMHISMOV" (ws_nom_rep IN VARCHAR2,   ws_ide_pcc IN VARCHAR2,
					 	     wn_key_usu IN NUMBER, ws_key_men IN VARCHAR2,
					 	     ws_hor_reg IN VARCHAR2,   ws_etq_rep IN VARCHAR2)
IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
    -- Variables para la carga de la tabla de Historico de Movimientos.
    ws_cod_imp VARCHAR2(2);
    wn_key_pro NUMBER(10);
    ws_des_pro VARCHAR2(20);
    -- Variables para las restricciones de despliegue.
	wn_dsp_001 NUMBER(5);
    wn_dsp_002 NUMBER(5);
    wn_dsp_003 NUMBER(5);
    wn_dsp_004 NUMBER(5);
    wn_dsp_005 NUMBER(5);
    -- Variables para el reporte de avance y auxiliares.
    wn_tot_reg NUMBER(10) := -1;
    wn_num_reg NUMBER(10) := 0;
    wn_pct_reg NUMBER(6,2);
    wn_pct_act NUMBER(5)  := 1;
    ws_key_cia VARCHAR2(5)    := '..';
    wn_emp_ant NUMBER(10) := 999999999;
    wn_can_mov glwkcrys.cry_dec001%TYPE;
    wn_imp_mov glwkcrys.cry_dec002%TYPE;
    wn_key_emp glwkcrys.cry_dec007%TYPE;
    ws_des_con glwkcrys.cry_chr003%TYPE;
    ws_des_cor glwkcrys.cry_chr001%TYPE := 'CORPORATIVO NO REGISTRADO ...';
    ws_des_lis glwkcrys.cry_chr004%TYPE := sp_glgetrep (ws_nom_rep, 'No existe nombre del Reporte', 40);
    ws_etq_001 glwkcrys.cry_chr019%TYPE := sp_glgetdsc ('nmlohism', 'his_keycon', '........', NULL);
    ws_etq_002 glwkcrys.cry_chr020%TYPE := sp_glgetdsc ('nmlohism', 'his_cantid', '........', NULL);
    ws_etq_003 glwkcrys.cry_chr021%TYPE := sp_glgetdsc ('nmlohism', 'his_import', '........', NULL);
    ws_etq_004 glwkcrys.cry_chr022%TYPE := sp_glgetdsc ('nmlohism', 'his_keyper', '........', NULL);
    ws_etq_005 glwkcrys.cry_chr023%TYPE := sp_glgetdsc ('nmlohism', 'his_keypro', '........', NULL);
    ws_etq_006 glwkcrys.cry_chr026%TYPE := sp_glgetdsc ('nmloconc', 'con_descon', 'DESCRIP.', NULL);
    ws_fec_act glwkcrys.cry_dat003%TYPE;
    ws_hor_act glwkcrys.cry_chr028%TYPE;
    ws_key_con glwkcrys.cry_chr018%TYPE;
    ws_key_per glwkcrys.cry_chr017%TYPE;
    ws_nom_emp glwkcrys.cry_chr002%TYPE;
    i          NUMBER(10);
    j          NUMBER(10);
    k          NUMBER(10);
    wn_con_reg NUMBER(10) := 0;
    wn_lim_ite NUMBER(10) := 100;
BEGIN
	 -- Variables para las restricciones de despliegue.
	LABPROD.sp_glgetdsp('nmlohism', 'his_keyemp', ws_key_men,wn_dsp_001);
	LABPROD.sp_glgetdsp('nmlohism', 'his_keycon', ws_key_men,wn_dsp_002);
	LABPROD.sp_glgetdsp('nmlohism', 'his_cantid', ws_key_men,wn_dsp_003);
	LABPROD.sp_glgetdsp('nmlohism', 'his_import', ws_key_men,wn_dsp_004);
	LABPROD.sp_glgetdsp('nmlohism', 'his_keyper', ws_key_men,wn_dsp_005);
	LABPROD.sp_glfechor(ws_fec_act,ws_hor_act);
	-- Inserta registro para monitoreo de resultados.
	  DELETE FROM LABPROD.glwkcrys
	  WHERE cry_nomrep = ws_nom_rep
	  AND cry_idepcc = ws_ide_pcc
	  AND cry_keyusu = wn_key_usu;
   COMMIT;
    -- Extrae el nombre de la Compania Corporativa.
    FOR c_descor IN (SELECT pro_keycia
		       FROM LABPROD.nmloproc
			 WHERE pro_keypro IN (
				SELECT his_keypro from LABPROD.nmwkhism
              		WHERE  his_idepcc = ws_ide_pcc)) LOOP
	ws_key_cia := c_descor.pro_keycia;
    END LOOP;
    FOR c_descia IN (SELECT substr(cia_descia,1,60) cia_descia
		       FROM LABPROD.nmlocias
			 WHERE cia_keycia = ws_key_cia) LOOP
	ws_des_cor := c_descia.cia_descia;
    END LOOP;
    -- Inicializa variables de trabajo                                                         --
   wn_emp_ant := 999999999;
    -- Cursor principal.
    FOR c_nmhismov IN (
		SELECT his_keyemp, his_keycon, his_cantid,
		 his_import, his_keyper, his_codimp, his_keypro
	  	FROM LABPROD.nmwkhism
        WHERE his_idepcc =  ws_ide_pcc
		ORDER BY his_keyemp, his_codimp, his_keycon, his_keyper) LOOP
	wn_key_emp := c_nmhismov.his_keyemp;
	ws_key_con := c_nmhismov.his_keycon;
	wn_can_mov := c_nmhismov.his_cantid;
	wn_imp_mov := c_nmhismov.his_import;
	ws_key_per := c_nmhismov.his_keyper;
	ws_cod_imp := c_nmhismov.his_codimp;
	wn_key_pro := c_nmhismov.his_keypro;
	-- Extrae los Datos del Empleado.
	IF wn_key_emp IS NULL THEN
	    ws_nom_emp := 'EMPLEADO NO EXISTE ...';
	ELSE
	    IF wn_emp_ant <> wn_key_emp THEN
		i := 0;
		j := 0;
		k := 0;
		FOR c_datemp IN (SELECT emp_nomemp
				   FROM LABPROD.nmcoempl
				     WHERE emp_keyemp = wn_key_emp) LOOP
		    ws_nom_emp := c_datemp.emp_nomemp;
		END LOOP;
		wn_emp_ant := wn_key_emp;
		-- Aplica restricciones
		IF wn_dsp_001 = 1 THEN
		    wn_key_emp := NULL;
		    ws_nom_emp := NULL;
		END IF;
	    END IF;
	END IF;
	-- Extrae la descripcion del Concepto.
        ws_des_con := 'CONCEPTO NO EXISTE ...';
	FOR c_descon IN (SELECT con_descor
			   FROM LABPROD.nmloconc
			     WHERE con_keycon = ws_key_con) LOOP
	    ws_des_con := c_descon.con_descor;
	END LOOP;
    -- EXTRAE LA DESCRIPCION DE LOS PROCESOS
     ws_des_pro := 'PROCESO NO EXISTE...';
     FOR c_despro IN(
       SELECT pro_despro FROM LABPROD.nmloproc
       WHERE pro_keypro = wn_key_pro)LOOP
		ws_des_pro:=c_despro.pro_despro;
     END LOOP;
	-- Condicion para extraer las percepciones.
	IF ws_cod_imp = '01' THEN
	    -- Aplica restricciones de despliegue de Campos.
	    IF wn_dsp_002 = 1 THEN
		ws_key_con := NULL;
		ws_des_con := NULL;
	    END IF;
	    IF wn_dsp_003 = 1 THEN
		wn_can_mov := NULL;
	    END IF;
	    IF wn_dsp_004 = 1 THEN
		wn_imp_mov := NULL;
	    END IF;
	    IF wn_dsp_005 = 1 THEN
		ws_key_per := NULL;
	    END IF;
	    -- Incrementa en 1 el contador i.
	    i := i + 1;
	    -- Inserta en la tabla de trabajo de crystal report.
	    INSERT INTO LABPROD.glwkcrys
		     (cry_nomrep, cry_idepcc, cry_keyusu, cry_numsec, cry_chr001,
			cry_chr017, cry_dec007, cry_chr002, cry_chr018, cry_chr006,
			cry_dec001, cry_dec002, cry_chr019, cry_chr020, cry_chr021,
			cry_chr022, cry_chr023, cry_chr028, cry_dat003, cry_chr029,
			cry_chr007, cry_dec003, cry_dec004, cry_dec008, cry_chr008,
			cry_chr030, cry_chr003, cry_dec005, cry_dec011, cry_chr024,
			cry_chr025, cry_chr026, cry_chr004)
	     VALUES(ws_nom_rep, ws_ide_pcc, wn_key_usu, i         , ws_des_cor,
			ws_key_per, wn_key_emp, ws_nom_emp, ws_key_con, ws_des_con,
			wn_can_mov, wn_imp_mov, ws_etq_001, ws_etq_002, ws_etq_003,
			ws_etq_004, ws_etq_005, ws_hor_act, ws_fec_act, NULL      ,
			NULL      , NULL      , NULL      , wn_key_pro,	ws_des_pro,
			NULL      , NULL      , NULL      , NULL      , NULL      ,
			NULL      ,ws_etq_006 , ws_des_lis);
    			COMMIT;
	END IF;
	IF ws_cod_imp = '02' THEN
	    -- Aplica restricciones de despliegue de Campos                                     --
	    IF wn_dsp_002 = 1 THEN
		ws_key_con := NULL;
		ws_des_con := NULL;
	    END IF;
	    IF wn_dsp_003 = 1 THEN
		wn_can_mov := NULL;
	    END IF;
	    IF wn_dsp_004 = 1 THEN
		wn_imp_mov := NULL;
	    END IF;
	    IF wn_dsp_005 = 1 THEN
		ws_key_per := NULL;
	    END IF;
	    -- Realiza UPDATE o INSERT dependiendo de el control i y j.
	    j := j + 1;
	    IF j > i THEN
		INSERT INTO LABPROD.glwkcrys
			 (cry_nomrep, cry_idepcc, cry_keyusu, cry_numsec, cry_chr001, cry_chr017,
			  cry_dec007, cry_chr002, cry_chr018, cry_chr006, cry_dec001, cry_dec002,
			  cry_chr019, cry_chr020, cry_chr021, cry_chr022, cry_chr023, cry_chr028,
			  cry_dat003, cry_chr029, cry_chr007, cry_dec003, cry_dec004, cry_dec008,
			  cry_chr008, cry_chr030, cry_chr003, cry_dec005, cry_dec011, cry_chr024,
			  cry_chr025, cry_chr026, cry_chr004)
		 VALUES(ws_nom_rep, ws_ide_pcc, wn_key_usu, j         , ws_des_cor, NULL      ,
			  wn_key_emp, ws_nom_emp, NULL      , NULL      , NULL      , NULL      ,
			  ws_etq_001, ws_etq_002, ws_etq_003, ws_etq_004, ws_etq_005, ws_hor_act,
			  ws_fec_act, ws_key_con, ws_des_con, wn_can_mov, wn_imp_mov, wn_key_pro,
			  ws_des_pro, NULL      ,  NULL     , NULL      , NULL      , ws_key_per,
 			  NULL      , ws_etq_006,  ws_des_lis);
	    ELSE
		UPDATE LABPROD.glwkcrys
		  SET cry_chr029 = ws_key_con,
		      cry_chr007 = ws_des_con,
		      cry_dec003 = wn_can_mov,
		      cry_dec004 = wn_imp_mov,
		      cry_chr024 = ws_key_per
		    WHERE cry_nomrep = ws_nom_rep AND
			  cry_idepcc = ws_ide_pcc AND
			  cry_keyusu = wn_key_usu AND
			  cry_numsec = j          AND
			  cry_dec007 = wn_key_emp;
	    END IF;
	    COMMIT;
	END IF;
	IF ws_cod_imp = '03' THEN
	    -- Aplica restricciones de despliegue de Campos                                     --
	    IF wn_dsp_002 = 1 THEN
		ws_key_con := NULL;
		ws_des_con := NULL;
	    END IF;
	    IF wn_dsp_003 = 1 THEN
		wn_can_mov := NULL;
	    END IF;
	    IF wn_dsp_004 = 1 THEN
		wn_imp_mov := NULL;
	    END IF;
	    IF wn_dsp_005 = 1 THEN
		ws_key_per := NULL;
	    END IF;
	    -- Realiza UPDATE o INSERT dependiendo de el control j y k.
	    k := k + 1;
	    IF k > j THEN
		INSERT INTO LABPROD.glwkcrys
			 (cry_nomrep, cry_idepcc, cry_keyusu, cry_numsec, cry_chr001, cry_chr017,
			  cry_dec007, cry_chr002, cry_chr018, cry_chr006, cry_dec001, cry_dec002,
			  cry_chr019, cry_chr020, cry_chr021, cry_chr022, cry_chr023, cry_chr028,
			  cry_dat003, cry_chr029, cry_chr007, cry_dec003, cry_dec004, cry_dec008,
			  cry_chr008, cry_chr030, cry_chr003, cry_dec005, cry_dec011, cry_chr024,
			  cry_chr025, cry_chr026, cry_chr004)
		 VALUES(ws_nom_rep, ws_ide_pcc, wn_key_usu, k          , ws_des_cor, NULL      ,
			  wn_key_emp, ws_nom_emp, NULL      , NULL       , NULL      , NULL      ,
			  ws_etq_001, ws_etq_002, ws_etq_003, ws_etq_004 , ws_etq_005, ws_hor_act,
			  ws_fec_act, NULL      , NULL      , NULL       , NULL      , wn_key_pro,
			  ws_des_pro, ws_key_con, ws_des_con, wn_can_mov , wn_imp_mov, NULL      ,
		        ws_key_per, ws_etq_006, ws_des_lis);
	    ELSE
		UPDATE LABPROD.glwkcrys
		  SET cry_chr030 = ws_key_con,
		      cry_chr003 = ws_des_con,
		      cry_dec005 = wn_can_mov,
		      cry_dec011 = wn_imp_mov,
		      cry_chr025 = ws_key_per
		    WHERE cry_nomrep = ws_nom_rep AND
			  cry_idepcc = ws_ide_pcc AND
			  cry_keyusu = wn_key_usu AND
			  cry_numsec = k          AND
			  cry_dec007 = wn_key_emp;
	    END IF;
    	   COMMIT;
	END IF;
   END LOOP;
COMMIT;
END;
/
