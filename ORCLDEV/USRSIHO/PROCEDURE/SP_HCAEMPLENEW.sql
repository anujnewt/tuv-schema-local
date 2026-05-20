CREATE OR REPLACE EDITIONABLE PROCEDURE "USRSIHO"."SP_HCAEMPLENEW" (
    ws_key_dep IN VARCHAR2,  ws_key_pue IN VARCHAR2,   ws_nom_emp IN VARCHAR2,   ws_nom_cor IN VARCHAR2,  ws_dom_emp IN VARCHAR2,
	ws_col_emp IN VARCHAR2,  ws_cid_emp IN VARCHAR2,   ws_pob_emp IN VARCHAR2,   ws_mun_emp IN VARCHAR2,  ws_ent_emp IN VARCHAR2,
    ws_cod_emp IN VARCHAR2,  ws_tel_emp IN VARCHAR2,   ws_reg_rfc IN VARCHAR2,   ws_recurp  IN VARCHAR2,  ws_cve_sex IN VARCHAR2,
	ws_cve_zon IN NUMBER,  ws_tip_emp IN VARCHAR2,   ws_status  IN NUMBER,   ws_cve_ban IN VARCHAR2,  ws_cta_ban IN VARCHAR2,
	ws_ca3_aux IN VARCHAR2,  ws_for_pag IN VARCHAR2,   ws_ca2_aux IN VARCHAR2,   ws_key_pro IN NUMBER,  ws_fec_ing IN DATE,
	ws_ref_con IN VARCHAR2,  ws_mar_per IN VARCHAR2,   ws_fec_nac IN DATE,       ws_cr_anda IN NUMBER,    ws_cal_sin IN VARCHAR2,
	ws_pais_rs IN VARCHAR2,  ws_tel_em2 IN VARCHAR2,   ws_origen IN VARCHAR2,    ws_keytco IN NUMBER,     ws_cedula IN VARCHAR2,
	ws_rel_pag IN NUMBER,  ws_key_pr2 IN NUMBER,   ws_key_em2 IN NUMBER,     ws_are_fis IN VARCHAR2,  ws_tel_em3 IN VARCHAR2,
	ws_dom_em1 IN VARCHAR2,  ws_statu1 IN NUMBER,    ws_bandera IN VARCHAR2,   wn_keyemp1 IN NUMBER,    ws_mar_rfc IN VARCHAR2,
	ws_ctasin IN NUMBER,     ws_regims IN VARCHAR2,    ws_reginf IN VARCHAR2,    ws_mot_baj IN VARCHAR2,  ws_fec_baj IN VARCHAR2,
	ws_key_con IN VARCHAR2,  ws_cta_alt IN VARCHAR2,   ws_tel_em4 IN VARCHAR2,   ws_area_ant IN VARCHAR2, ws_proc_ant IN VARCHAR2,
	ws_cdgo_ant IN VARCHAR2, ws_da_keydep IN VARCHAR2, ws_da_keypue IN VARCHAR2, ws_da_tipjefe IN NUMBER, ws_da_keyjefe IN NUMBER,
	ws_da_tipemp IN NUMBER,  ws_da_keycon IN NUMBER,   ws_da_numcon IN NUMBER,   ws_num_int IN VARCHAR2,  ws_num_ext IN VARCHAR2,
	wn_num_emp OUT NUMBER) IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
-- -------------------------------------------------------------------------------------------------------------------------------
-- AEDO 15/Junio/05   Se cambiaron las longitudes de las siguientes variables a 40 caracteres
--                    ws_cid_emp
--                    ws_pob_emp
--                    ws_num_int
--                    ws_num_ext
--
-- -------------------------------------------------------------------------------------------------------------------------------
-- ELIGIO JUAREZ M. (ELJM) 07/Jul/2012  Modificacion para la correcta generacion de codigos unicos.
--
-- -------------------------------------------------------------------------------------------------------------------------------
-- RETURNING NUMBER;
wn_key_emp NUMBER;
ws_key_emp VARCHAR2(9);
ws_pre_fij VARCHAR2(3);
wn_con_sec NUMBER;
ws_con_sec VARCHAR2(9);
ws_cve_gpo VARCHAR2(3);
wn_num_bus VARCHAR2(9);
wn_busca   SMALLINT;
wn_num_max NUMBER;
wn_num_sec NUMBER;
-- wn_num_emp NUMBER;
wn_num_ssec NUMBER;
wn_cod_emp NUMBER;
wn_buscaDA SMALLINT;
ws_fec_mod date;
BEGIN
-- SET DEBUG FILE TO "/tmp/sp_hcaemplenew.txt";
-- TRACE ON;
-- ws_fec_mod := SYSDATE;
SELECT SYSDATE
INTO ws_fec_mod
FROM DUAL;
   IF ws_bandera = 'I' THEN --Insercion
      -- Si el codigo2 es NULL calcularl el siguiente
      -- En otro caso calcularlo => tomarlo como emp_keyemp
      IF ws_key_em2 IS NULL OR ws_key_em2 = 0 THEN
         ws_pre_fij := ' ';
         wn_con_sec := 0;
         BEGIN
             SELECT xco_prefij, gru_consec, gru_cvegpo
               INTO ws_pre_fij, wn_con_sec, ws_cve_gpo
               FROM agrupxcod, consagrup
              WHERE xco_cvegpo = gru_cvegpo
                AND xco_keypro = ws_key_pro;
            EXCEPTION WHEN no_data_found THEN ws_pre_fij := ''; wn_con_sec := 0; ws_cve_gpo := '';
         END;
         -- ----------------------------- CHECO QUE EL PREFIJO O EL NUMERO CONSECUTIVO QUE NO ESTEN VACIOS
         IF LENGTH(TRIM(ws_pre_fij)) = 0 OR wn_con_sec = 0 THEN
            -- RETURN -1;
            wn_num_emp := -1;
         END IF;
         -- ----------------------------- INCREMENTO EL NUMERO CONSECUTIVO
         wn_con_sec := wn_con_sec + 1;
         --  ---------------------------- ASIGNO A UNA VARIABLE STRING EL QUE SERA EL NUEVO CODIGO DE EMPLEADO
         ws_con_sec := trim(ws_pre_fij) || LPAD(wn_con_sec,7,0);
         -- ----------------------------------------------
         wn_key_emp := ws_con_sec;
         -- ---------------- ACTUALIZO EL NUMERO CONSECUTIVO
         UPDATE consagrup set gru_consec = wn_con_sec
          WHERE gru_cvegpo = ws_cve_gpo;
         -- ----------------------------- DESBLOQUEO LA TABLA CONSAGRUP
         -- UNLOCK TABLE consagrup;
      ELSE
         -- Si encuentra el numero de empleado ya dado de alta => error
         SELECT COUNT(emp_keyemp)
           INTO wn_key_emp
           FROM nmcoempl
          WHERE emp_keyemp = ws_key_em2
            AND emp_keypro = ws_key_pro;
         IF wn_key_emp > 0 THEN
            -- RETURN -1;
            wn_num_emp := -1;
         END IF;
         wn_key_emp := ws_key_em2;
      END IF;
      INSERT INTO nmcoempl ( emp_keyemp, emp_keydep, emp_keypue, emp_nomemp,
                             emp_nomcor, emp_domemp, emp_colemp, emp_cidemp,
                             emp_pobemp, emp_munemp, emp_entemp, emp_codemp,
                             emp_telemp, emp_regrfc, emp_recurp, emp_cvesex,
                             emp_cvezon, emp_tipemp, emp_status, emp_cveban,
                             emp_ctaban, emp_ca3aux, emp_forpag, emp_ca2aux,
                             emp_keypro, emp_fecing, emp_refcon, emp_salmes,
                             emp_regims, emp_reginf, emp_cvebaj, emp_fecbaj,
                             emp_ca1aux, emp_keycen, emp_fecmod )
                     VALUES( wn_key_emp, ws_key_dep, ws_key_pue, ws_nom_emp,
                             ws_nom_cor, ws_dom_emp, ws_col_emp, ws_cid_emp,
                             ws_pob_emp, ws_mun_emp, ws_ent_emp, ws_cod_emp,
                             ws_tel_emp, ws_reg_rfc, ws_recurp,  ws_cve_sex,
                             ws_cve_zon, ws_tip_emp, ws_status,  SUBSTR(ws_cve_ban,1,7),
                             ws_cta_ban, ws_ca3_aux, ws_for_pag, ws_ca2_aux,
                             ws_key_pro, ws_fec_ing, ws_ref_con, ws_ctasin,
                             ws_regims , ws_reginf , ws_mot_baj, TO_DATE(ws_fec_baj, 'DD/MM/YYYY'),
                             ws_key_con, ws_tel_em4, ws_fec_mod );
      INSERT INTO holoalem ( ale_keyemp, ale_marper, ale_fecnac, ale_cranda,
                             ale_calsin, ale_paisrs, ale_telem2, ale_origen,
                             ale_keytco, ale_cedula, ale_relpag, ale_keypr2,
                             ale_keyem2, ale_arefis, ale_telem3, ale_domemp,
                             ale_status, ale_marrfc, ale_numint, ale_numext )
                     VALUES( wn_key_emp, ws_mar_per, ws_fec_nac, ws_cr_anda,
                             ws_cal_sin, ws_pais_rs, ws_tel_em2, ws_origen,
                             ws_keytco,  ws_cedula,  ws_rel_pag, ws_key_pr2,
                             ws_key_em2, ws_are_fis, ws_tel_em3, ws_dom_em1,
                             ws_statu1,  ws_mar_rfc, ws_num_int, ws_num_ext );
      INSERT INTO nmloctas ( cta_keypro, cta_keyemp, cta_ctaban )
                     VALUES( ws_key_pro, wn_key_emp, ws_cta_alt );
      INSERT INTO nmdtaemp ( aem_keyemp, aem_keydep,
                             aem_keypue, aem_tipem2,
                             aem_keyem2, aem_tipemp,
                             aem_keytco, aem_keyfol )
                     VALUES( wn_key_emp, ws_da_keydep,
                             ws_da_keypue, ws_da_tipjefe,
                             ws_da_keyjefe, ws_da_tipemp,
                             ws_da_keycon, ws_da_numcon );
      wn_num_emp := wn_key_emp;
--      RETURN wn_key_emp;
   ELSE   --Actualizacion
        --dbms_output.put_line('Actualiza');
        --wn_keyemp1
      UPDATE nmcoempl
             SET emp_keydep = ws_key_dep,  emp_keypue = ws_key_pue,
                 emp_nomemp = ws_nom_emp,  emp_nomcor = ws_nom_cor,
                 emp_domemp = ws_dom_emp,  emp_colemp = ws_col_emp,
                 emp_cidemp = ws_cid_emp,  emp_pobemp = ws_pob_emp,
                 emp_munemp = ws_mun_emp,  emp_entemp = ws_ent_emp,
                 emp_codemp = ws_cod_emp,  emp_telemp = ws_tel_emp,
                 emp_regrfc = ws_reg_rfc,  emp_recurp = ws_recurp,
                 emp_cvesex = ws_cve_sex,  emp_cvezon = ws_cve_zon,
                 emp_tipemp = ws_tip_emp,  emp_status = ws_status,
                 emp_cveban = SUBSTR(ws_cve_ban,1,7),  emp_ctaban = ws_cta_ban,
                 emp_ca3aux = ws_ca3_aux,  emp_forpag = ws_for_pag,
                 emp_ca2aux = ws_ca2_aux,  emp_keypro = ws_key_pro,
                 emp_fecing = ws_fec_ing,  emp_refcon = ws_ref_con,
                 emp_salmes = ws_ctasin,   emp_regims = ws_regims,
                 emp_reginf = ws_reginf,   emp_cvebaj = ws_mot_baj,
                 emp_fecbaj = TO_DATE(ws_fec_baj, 'DD/MM/YYYY'),  emp_ca1aux = ws_key_con,
                 emp_keycen = ws_tel_em4,  emp_fecmod =  ws_fec_mod
      WHERE emp_keyemp = wn_keyemp1;
      UPDATE holoalem
             SET ale_marper = ws_mar_per, ale_fecnac = ws_fec_nac,
                 ale_cranda = ws_cr_anda, ale_calsin = ws_cal_sin,
                 ale_paisrs = ws_pais_rs, ale_telem2 = ws_tel_em2,
                 ale_origen = ws_origen,  ale_keytco = ws_keytco,
                 ale_cedula = ws_cedula,  ale_relpag = ws_rel_pag,
                 ale_keypr2 = ws_key_pr2, ale_keyem2 = ws_key_em2,
                 ale_arefis = ws_are_fis, ale_telem3 = ws_tel_em3,
                 ale_domemp = ws_dom_em1, ale_status = ws_statu1,
                 ale_marrfc = ws_mar_rfc, ale_numint = ws_num_int,
                 ale_numext = ws_num_ext
      WHERE ale_keyemp = wn_keyemp1;
      UPDATE nmloctas
         SET cta_keypro = ws_key_pro,
             cta_ctaban = ws_cta_alt
       WHERE cta_keyemp = wn_keyemp1;
      SELECT COUNT(*) INTO wn_buscaDA
        FROM nmdtaemp
       WHERE aem_keyemp = wn_keyemp1;
      IF wn_buscaDA = 0 THEN
         INSERT INTO nmdtaemp ( aem_keyemp, aem_keydep,
                                aem_keypue, aem_tipem2,
                                aem_keyem2, aem_tipemp,
                                aem_keytco, aem_keyfol )
                        VALUES( wn_keyemp1, ws_da_keydep,
                                ws_da_keypue, ws_da_tipjefe,
                                ws_da_keyjefe, ws_da_tipemp,
                                ws_da_keycon, ws_da_numcon );
      ELSE
         UPDATE nmdtaemp
            SET aem_keydep = ws_da_keydep, aem_keypue = ws_da_keypue,
                aem_tipem2 = ws_da_tipjefe, aem_keyem2 = ws_da_keyjefe,
                aem_tipemp = ws_da_tipemp, aem_keytco = ws_da_keycon,
                aem_keyfol = ws_da_numcon
         WHERE aem_keyemp = wn_keyemp1;
      END IF;
      wn_num_emp := wn_keyemp1;
--      RETURN wn_keyemp1 ;
   END IF;
-- --------------------------------------------------------------------------------------
--Busca registro en tabla de trayectoria
   wn_num_bus := 0;
   wn_num_max := 0;
   IF ws_bandera = 'I' THEN
      wn_num_bus := wn_key_emp;
   ELSE
      wn_num_bus := wn_keyemp1;
   END IF;
   IF LENGTH(TRIM(wn_num_bus)) = 9 THEN
      SELECT 	count(*)
      INTO 		wn_busca
      FROM 		glcocons
      WHERE 	substr(con_keyemp,3) = substr(wn_num_bus,3);
      IF ws_cdgo_ant <> '' AND LENGTH(TRIM(ws_cdgo_ant)) < 9 THEN
					SELECT 	count(*)
         	INTO 		wn_busca
         	FROM 		glcocons
        	WHERE 	con_keyemp = ws_cdgo_ant;
      END IF;
   ELSE
      wn_num_ssec := wn_num_bus;
      SELECT 	count(*)
      INTO 		wn_busca
      FROM 		glcocons		-- wn_busca=0
      WHERE 	con_keyemp = wn_num_ssec;
   END IF;
   IF ws_bandera = 'I' THEN --Insercion
      IF ws_area_ant = '' AND ws_proc_ant = '' AND ws_cdgo_ant = '' THEN
         IF wn_busca = 0 THEN
            SELECT NVL(MAX(con_keycvc), 0) + 1 INTO wn_num_max FROM glcocons;
            -- wn_num_max := wn_num_max + 1;
            INSERT INTO glcocons (con_keycvc,con_keyemp,con_keypro,con_keyapr,con_fecalt)
                        VALUES (wn_num_max,wn_num_bus,ws_key_pro,ws_are_fis,SYSDATE);
         ELSE
            -- RETURN -1;
            wn_num_emp := -1;
         END IF;
      ELSE
         IF wn_busca = 0 THEN
         		---------------------------------------------------------------------------------------
         		--  ELJM
            BEGIN
                SELECT 	con_keycvc
                INTO 		wn_num_max
                FROM 		glcocons
                WHERE 	con_keyemp = ws_cdgo_ant;
                EXCEPTION WHEN no_data_found THEN wn_num_max := 1;
            END;
						-- EJECUTA INSERT
            INSERT INTO glcocons (con_keycvc, con_keyemp, con_keypro, con_keyapr, con_fecalt)
                    VALUES (wn_num_max, wn_num_bus, ws_key_pro, ws_are_fis, ws_fec_mod);
         		----------------------------------------------------------------------------------------
         		-- ELJM
            -- SET LOCK MODE TO WAIT;
            -- LOCK TABLE glcocons IN EXCLUSIVE MODE;
            --
            -- SELECT 	nvl(MAX(con_keycvc), 0)
            -- INTO 		wn_num_max
            -- FROM 		glcocons;			-- wn_num_max=55068
            --
            -- LET wn_num_max = wn_num_max + 1;		-- wn_num_max = 55068+1 = 55069
						--
						-- -- CASO 1 EJECUTA INSERT
            -- INSERT INTO glcocons (con_keycvc, con_keyemp, con_keypro, con_keyapr, con_fecalt)
            --         VALUES (wn_num_max, wn_num_bus, ws_key_pro, ws_are_fis, TODAY);
            --
						-- -- CASO 1 EJECUTA INSERT
            -- INSERT INTO glcocons (con_keycvc, con_keyemp, con_keypro, con_keyapr, con_fecalt)
            --         VALUES (wn_num_max, ws_cdgo_ant, ws_proc_ant, ws_area_ant, TODAY);
            --
            -- UNLOCK TABLE glcocons;
            ------------------------------------------------------------------
         ELSE
            -- SET LOCK MODE TO WAIT;
            -- LOCK TABLE glcocons IN EXCLUSIVE MODE;
            IF LENGTH(TRIM(wn_num_bus)) = 9 THEN
               BEGIN
                   SELECT UNIQUE(con_keycvc)
                     INTO wn_num_sec
                     FROM glcocons
                    WHERE SUBSTR(con_keyemp,3) = SUBSTR(wn_num_bus,3);
                   EXCEPTION WHEN no_data_found THEN wn_num_sec := 1;
               END;
               IF ws_cdgo_ant <> '' AND LENGTH(TRIM(ws_cdgo_ant)) < 9 THEN
                  BEGIN
                      SELECT UNIQUE(con_keycvc)
                        INTO wn_num_sec
                        FROM glcocons
                       WHERE con_keyemp = ws_cdgo_ant;
                       EXCEPTION WHEN no_data_found THEN wn_num_sec := 1;
                  END;
               END IF;
            ELSE
               wn_num_ssec := wn_num_bus;
               BEGIN
                   SELECT UNIQUE(con_keycvc)
                   INTO wn_num_sec
                   FROM glcocons
                   WHERE substr(con_keyemp,3) = wn_num_ssec;
                   EXCEPTION WHEN no_data_found THEN wn_num_sec := 1;
               END;
            END IF;
            INSERT INTO glcocons (con_keycvc,con_keyemp,con_keypro,con_keyapr,con_fecalt)
                         VALUES (wn_num_sec,wn_num_bus,ws_key_pro,ws_are_fis,ws_fec_mod);
            -- UNLOCK TABLE glcocons;
         END IF;
      END IF;
   ELSE
      IF ws_area_ant <> ws_are_fis OR ws_proc_ant <> ws_key_pro OR ws_cdgo_ant <> wn_num_bus THEN
         IF wn_busca = 0 THEN
            -- SET LOCK MODE TO WAIT;
            -- LOCK TABLE glcocons IN EXCLUSIVE MODE;
            SELECT NVL(MAX(con_keycvc), 0) + 1
            INTO wn_num_max
            FROM glcocons;
            -- wn_num_max := wn_num_max + 1;
            INSERT INTO glcocons (con_keycvc,con_keyemp,con_keypro,con_keyapr,con_fecalt)
                    VALUES (wn_num_max,wn_num_bus,ws_key_pro,ws_are_fis,ws_fec_mod);
            INSERT INTO glcocons (con_keycvc,con_keyemp,con_keypro,con_keyapr,con_fecalt)
                    VALUES (wn_num_max,ws_cdgo_ant,ws_proc_ant,ws_area_ant,ws_fec_mod);
            -- UNLOCK TABLE glcocons;
         ELSE
            -- actualizar e insertar si cambia el numero de empleado.
            IF ws_cdgo_ant = wn_num_bus THEN
               UPDATE glcocons SET con_keypro = ws_key_pro, con_keyapr = ws_are_fis
               WHERE  con_keypro = ws_cdgo_ant
               AND    con_keyapr = ws_area_ant
               AND    con_keyemp = ws_cdgo_ant;
            ELSE
               -- SET LOCK MODE TO WAIT;
               -- LOCK TABLE glcocons IN EXCLUSIVE MODE;
               --dbms_output.put_line(wn_num_bus);
               IF LENGTH(TRIM(wn_num_bus)) = 9 THEN
                  BEGIN
                      SELECT UNIQUE(con_keycvc)
                      INTO wn_num_sec
                      FROM glcocons
                      WHERE substr(con_keyemp,3) = substr(wn_num_bus,3);
                      EXCEPTION WHEN no_data_found THEN wn_num_sec := 1;
                  END;
               ELSE
                  wn_num_ssec := wn_num_bus;
                  BEGIN
                      SELECT UNIQUE(con_keycvc)
                      INTO wn_num_sec
                      FROM glcocons
                      WHERE substr(con_keyemp,3) = wn_num_ssec;
                      EXCEPTION WHEN no_data_found THEN wn_num_sec := 1;
                  END;
               END IF;
               INSERT INTO glcocons (con_keycvc,con_keyemp,con_keypro,con_keyapr,con_fecalt)
                      VALUES (wn_num_sec,wn_num_bus,ws_key_pro,ws_are_fis,ws_fec_mod);
               -- UNLOCK TABLE glcocons;
            END IF;
         END IF;
      ELSE
         IF wn_busca = 0 THEN
            -- SET LOCK MODE TO WAIT;
            -- LOCK TABLE glcocons IN EXCLUSIVE MODE;
            SELECT nvl(MAX(con_keycvc), 0) + 1 INTO wn_num_max FROM glcocons;
            -- wn_num_max := wn_num_max + 1;
            INSERT INTO glcocons (con_keycvc,con_keyemp,con_keypro,con_keyapr,con_fecalt)
                        VALUES (wn_num_max,wn_num_bus,ws_key_pro,ws_are_fis,ws_fec_mod);
            -- UNLOCK TABLE glcocons;
         ELSE
            SELECT count(*) INTO wn_cod_emp FROM glcocons
            WHERE con_keyemp = wn_num_bus;
            IF wn_cod_emp = 0 THEN
               -- SET LOCK MODE TO WAIT;
               -- LOCK TABLE glcocons IN EXCLUSIVE MODE;
               SELECT nvl(MAX(con_keycvc), 0) + 1 INTO wn_num_max FROM glcocons;
               -- wn_num_max := wn_num_max + 1;
               INSERT INTO glcocons (con_keycvc,con_keyemp,con_keypro,con_keyapr,con_fecalt)
                           VALUES (wn_num_max,wn_num_bus,ws_key_pro,ws_are_fis,ws_fec_mod);
               -- UNLOCK TABLE glcocons;
            END IF;
         END IF;
      END IF;
   END IF;
--   RETURN wn_num_emp;
-- TRACE OFF;
END;
/
