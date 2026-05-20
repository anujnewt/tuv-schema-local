CREATE OR REPLACE NONEDITIONABLE PROCEDURE "LABCONF"."SP_NMLSTVEC" ( ws_nom_rep IN VARCHAR2,	ws_ide_pcc IN VARCHAR2,
  					            wn_key_usu IN NUMBER,	ws_key_men IN VARCHAR2,
					            ws_hor_reg IN VARCHAR2)
    IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
  -- Variables para la Carga de la Tabla de Versiones Contables
    wn_key_ver NUMBER(5);
    ws_cta_car VARCHAR2(20);
    ws_ref_cta VARCHAR2(30);
    ws_tip_exc VARCHAR2(1);
    ws_key_con VARCHAR2(3);
    ws_cta_abo VARCHAR2(20);
  -- Variables para el reporte de avance
    wn_tot_reg NUMBER(10):=0;
    wn_num_reg NUMBER(10):=0;
    wn_pct_act NUMBER(5):=0;
    wn_pct_reg NUMBER(6,2);
    ws_hor_act glwkcrys.cry_chr045%TYPE;
    ws_des_cor glwkcrys.cry_chr001%TYPE;
    ws_des_lis glwkcrys.cry_chr007%TYPE;
    ws_dia_act glwkcrys.cry_dat004%TYPE;
	  -- Variables para la carga de las descripciones de las Etiquetas
    ws_key_cam VARCHAR2(20);
    ws_dsp_cam VARCHAR2(1);
  -- Variables de Despliegue
    wn_dsp_001 NUMBER(5) := 0;
    wn_dsp_002 NUMBER(5) := 0;
    wn_dsp_003 NUMBER(5) := 0;
    wn_dsp_004 NUMBER(5) := 0;
    wn_dsp_005 NUMBER(5) := 0;
    wn_dsp_006 NUMBER(5) := 0;
  --Variables para las Etiquetas del Diccionario de Datos
    ws_ver_sio glwkcrys.cry_chr011%TYPE;
    ws_car_gos glwkcrys.cry_chr018%TYPE;
    ws_ref_ere glwkcrys.cry_chr019%TYPE;
    ws_exc_epc glwkcrys.cry_chr020%TYPE;
    ws_con_cep glwkcrys.cry_chr022%TYPE;
    ws_abo_nos glwkcrys.cry_chr023%TYPE;
  BEGIN
		sp_glfechor(ws_dia_act,ws_hor_act);
    -- Realiza el conteo de registros a procesar
    SELECT COUNT(*) INTO wn_tot_reg FROM nmloverc
      WHERE ver_keyver IN ( SELECT ran_keypro FROM glwkrang
			      WHERE ran_nomrep = ws_nom_rep AND
				ran_idepcc = ws_ide_pcc AND
				ran_keyusu = wn_key_usu AND
				ran_keypro IS NOT NULL )
	    AND ver_tipexc IN ( SELECT ran_keycon FROM glwkrang
				  WHERE ran_nomrep = ws_nom_rep AND
					ran_idepcc = ws_ide_pcc AND
					ran_keyusu = wn_key_usu );
    -- Inserta registro para monitoreo de resultados                --
    INSERT INTO glcoresu (
	res_idepro, res_idepcc, res_keyusu, res_fecini, res_horini,
	res_horreg, res_totreg, res_status )
    VALUES (
	ws_nom_rep, ws_ide_pcc, wn_key_usu, ws_dia_act, ws_hor_act,
	ws_hor_reg, wn_tot_reg, 'P');
    -- Borra la tabla de trabajo del Crystal Report                 --
    DELETE FROM glwkcrys
      WHERE cry_nomrep = ws_nom_rep AND
	    cry_idepcc = ws_ide_pcc AND
	    cry_keyusu = wn_key_usu;
    -- Extrae el nombre de la Compa�Coorporativa
		ws_des_cor := 'CORPORATIVO NO REGISTRADO ...';
		SELECT cor_razsoc INTO ws_des_cor	FROM glcocorp;
    -- Extrae el nombre del reporte
    ws_des_lis := sp_glgetrep(ws_nom_rep,'No existe nombre del Reporte ...',50);
    --Extrae las Etiquetas del Diccionario de Datos
    ws_ver_sio := sp_glgetdsc('nmloverc','ver_keyver','........',NULL);
    ws_car_gos := sp_glgetdsc('nmloverc','ver_ctacar','........',NULL);
    ws_ref_ere := sp_glgetdsc('nmloverc','ver_refcta','........',NULL);
    ws_exc_epc := sp_glgetdsc('nmloverc','ver_tipexc','........',NULL);
    ws_con_cep := sp_glgetdsc('nmloverc','ver_keycon','........',NULL);
    ws_abo_nos := sp_glgetdsc('nmloverc','ver_ctaabo','........',NULL);
    -- extrae las restricciones de Despliegue                       --
    FOR c_desplieg IN ( SELECT rec_keycam, rec_despli FROM glcoreca
			  WHERE rec_keytab = 'nmloverc' AND
				rec_keymen = ws_key_men ) LOOP
	ws_key_cam := c_desplieg.rec_keycam;
	ws_dsp_cam := c_desplieg.rec_despli;
	IF ( ws_key_cam = 'ver_keyver') AND ( ws_dsp_cam = 'N') THEN
	    wn_dsp_001 := 1;
	END IF;
	IF ( ws_key_cam = 'ver_ctacar') AND ( ws_dsp_cam = 'N') THEN
	    wn_dsp_002 := 1;
	END IF;
	IF ( ws_key_cam = 'ver_refcta') AND ( ws_dsp_cam = 'N') THEN
	    wn_dsp_003 := 1;
	END IF;
	IF ( ws_key_cam = 'ver_tipexc') AND ( ws_dsp_cam = 'N') THEN
	    wn_dsp_004 := 1;
	END IF;
	IF ( ws_key_cam = 'ver_keycon') AND ( ws_dsp_cam = 'N') THEN
	    wn_dsp_005 := 1;
	END IF;
	IF ( ws_key_cam = 'ver_ctaabo') AND ( ws_dsp_cam = 'N') THEN
	    wn_dsp_006 := 1;
	END IF;
    END LOOP;
    -- Inicializa variables de trabajo para realizar cortes y Monitoreo
    wn_num_reg:=0;
    wn_pct_act:=1;
    wn_pct_reg:=wn_tot_reg / 10.0;
    -- Define cursor Principal-----------------------------------------
    COMMIT;
    FOR c_nmlstvec IN ( SELECT ver_keyver, ver_ctacar, ver_refcta,
                               ver_tipexc, ver_keycon, ver_ctaabo
							   FROM nmloverc
		  	      WHERE ver_keyver IN ( SELECT ran_keypro FROM glwkrang
						  WHERE ran_nomrep = ws_nom_rep AND
				      		  ran_idepcc = ws_ide_pcc AND
				      		  ran_keyusu = wn_key_usu AND
							  ran_keypro IS NOT NULL )
	      		              AND ver_tipexc IN ( SELECT ran_keycon FROM glwkrang
				    		        WHERE ran_nomrep = ws_nom_rep AND
							     ran_idepcc = ws_ide_pcc AND
							     ran_keyusu = wn_key_usu AND
							     ran_keycon IS NOT NULL )
		  	                    ORDER BY ver_keyver,ver_tipexc) LOOP
      wn_key_ver := c_nmlstvec.ver_keyver;
	ws_cta_car := c_nmlstvec.ver_ctacar;
	ws_ref_cta := c_nmlstvec.ver_refcta;
	ws_tip_exc := c_nmlstvec.ver_tipexc;
      ws_key_con := c_nmlstvec.ver_keycon;
	ws_cta_abo := c_nmlstvec.ver_ctaabo;
	-- Actualiza registro de monitoreo
	wn_num_reg := wn_num_reg + 1;
	IF wn_num_reg >= ( wn_pct_reg * wn_pct_act ) THEN
	    UPDATE glcoresu SET res_numreg = wn_num_reg
		WHERE res_idepro = ws_nom_rep AND
		      res_idepcc = ws_ide_pcc AND
		      res_keyusu = wn_key_usu AND
		      res_fecini = ws_dia_act AND
		      res_horreg = ws_hor_reg;
	    wn_pct_act := wn_pct_act + 1;
	END IF;
    -- Aplica restricciones de despliegue de Campos                 --
    IF wn_dsp_001 = 1 THEN
	   wn_key_ver := NULL;
    END IF;
    IF wn_dsp_002 = 1 THEN
	   ws_cta_car := NULL;
    END IF;
    IF wn_dsp_003 = 1 THEN
	   ws_ref_cta := NULL;
    END IF;
    IF wn_dsp_004 = 1 THEN
	   ws_tip_exc := NULL;
    END IF;
    IF wn_dsp_005 = 1 THEN
	   ws_key_con := NULL;
    END IF;
    IF wn_dsp_006 = 1 THEN
	   ws_cta_abo := NULL;
    END IF;
    -- Inserta en la tabla de trabajo del Crystal Report
    INSERT INTO glwkcrys (
	cry_nomrep, cry_idepcc, cry_keyusu, cry_chr001, cry_dec006,
	cry_chr008, cry_chr004, cry_chr017, cry_chr018, cry_chr009,
      cry_dat001, cry_dec007, cry_chr002, cry_chr011, cry_chr020,
      cry_chr021, cry_chr022, cry_chr023, cry_chr024, cry_chr025)
    VALUES (
	ws_nom_rep, ws_ide_pcc, wn_key_usu, ws_des_cor, wn_key_ver,
	ws_cta_car, ws_ref_cta, ws_tip_exc, ws_key_con, ws_cta_abo,
	ws_dia_act, wn_tot_reg, ws_des_lis, ws_ver_sio, ws_car_gos,
      ws_ref_ere, ws_exc_epc, ws_con_cep, ws_abo_nos, ws_hor_act);
    END LOOP;
    -- Actualiza la tabla de monitoreo indicando la finalizacion    --
    -- del proceso.
		sp_glfechor(ws_dia_act,ws_hor_act);
    UPDATE glcoresu SET res_numreg = wn_num_reg,
			res_fecfin = ws_dia_act,
			res_horfin = ws_hor_act,
			res_status = 'T'
    WHERE res_idepro = ws_nom_rep AND
	  res_idepcc = ws_ide_pcc AND
	  res_keyusu = wn_key_usu AND
	  res_fecini = ws_dia_act AND
	  res_horreg = ws_hor_reg;
    COMMIT;
END;
/
