CREATE OR REPLACE EDITIONABLE PROCEDURE "USRSIHO"."SP_TRANSF_LLA_HJA" (pi_lla_num_id NUMBER,
                                              pd_fecha      DATE,
                                              ps_usuario    VARCHAR2,
                                              wi_val_ret01  OUT NUMBER,
                                              ws_val_ret02  OUT VARCHAR2)
	-- RETURN "informix".sp_transf_lla_hja_tab PIPELINED
IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
	--IG-CONS-0823 Comentado
	--DEFINE ps_det_sindkto CHAR(15);
	--Termina Comentado
	--IG-CONS-0823 Substituye
	pi_det_sindkto NUMBER(10);
	--Termina Substituye
	pi_tipo_folio NUMBER(10);
	pi_ord_sindkto NUMBER(10);
	pi_interno_hon NUMBER(10); --IG-CONS-0823
	pi_enc_num_id INTEGER;
	ps_cadena_reg VARCHAR2(50);
	pi_enc_num_id_aux NUMBER(10);
	ps_num_id VARCHAR2(10);
	ps_desori VARCHAR2(100);
BEGIN
	--LET ps_det_sindkto = ''; IG-CONS-0823 Comentado
	pi_det_sindkto 	:= 0;
	pi_tipo_folio   := 0;
	pi_ord_sindkto  := 0;
	pi_enc_num_id   := 0;
	ps_cadena_reg   := '';
	pi_enc_num_id_aux := 0;
	ps_num_id := '';
	ps_desori := '';
	--Busca la descripcion cuando es un llamado sin centro de costos
	begin
        SELECT esa_desori
        INTO ps_desori
        FROM USRSIHO.encsolact
        WHERE esa_numsol = (SELECT enc_solscc FROM USRSIHO.holoenclla WHERE enc_num_id = pi_lla_num_id);
     EXCEPTION
     WHEN NO_DATA_FOUND THEN
      ps_desori := '';
    END;
	--Comenta IG-CONS-0823
	-- FOREACH
	-- 	SELECT distinct det_sindkto,case when det_keyfol is null then 1 else 0 end,
	-- 		 case when det_sindkto = 'ANDA' then 1 when det_sindkto = 'SITATYR' then 2 else 3 end
	-- 	INTO ps_det_sindkto,pi_tipo_folio,pi_ord_sindkto
	-- 	FROM holodetlla
	-- 	WHERE det_num_id = pi_lla_num_id and
	-- 		trim(det_sindkto) <> 'OTRO' and
	-- 		det_stslla = 'V'
	-- 	ORDER BY 2,3
	--Termina comenta IG-CONS-0823
 DBMS_OUTPUT.put_line('inicio');
	--Inserta IG-CONS-0823
	--Para separacion de HONORISTAS INTERNOS, para SITATYR y CONDUCTORES ARTISTICOS
	FOR rec
		IN (SELECT  DISTINCT	det_keytco,
					CASE WHEN det_keyfol IS NULL THEN 1 ELSE 0 END AS val_case01,
					CASE WHEN det_keytco = 2 THEN 1 WHEN det_keytco = 3 THEN 2 ELSE 3 END AS val_case02,
					CASE WHEN det_keytco = 2 THEN 1
						 WHEN det_keytco = 3 THEN   (CASE WHEN emp_tipemp = 'I' AND ale_keyem2 IS NOT NULL THEN 1 ELSE 0 END)
						 WHEN det_keytco = 519 THEN (CASE WHEN emp_tipemp = 'I' AND ale_keyem2 IS NOT NULL THEN 1 ELSE 0 END)
						 ELSE
							1
					END  AS val_case03
      FROM 	USRSIHO.holodetlla, USRSIHO.nmcoempl, USRSIHO.holoalem
      WHERE det_num_id = pi_lla_num_id AND
            emp_keyemp = det_keyemp AND
            ale_keyemp = emp_keyemp AND
            TRIM(det_sindkto) <> 'OTRO' AND
            det_stslla = 'V'
      ORDER BY 2,3,4) LOOP
 DBMS_OUTPUT.put_line('ciclo');
		--Termina Inserta IG-CONS-0823
		--Inserta encabezado de la hoja de trabajo
		pi_det_sindkto := rec.det_keytco;
		pi_tipo_folio := rec.val_case01;
		pi_ord_sindkto := rec.val_case02;
		pi_interno_hon := rec.val_case03;
		INSERT INTO USRSIHO.holoenctra
		(enc_keydep, enc_fecgra, enc_keytpr, enc_nomprd, enc_feccap, enc_keypro,
		 enc_usuori, enc_stsrep, enc_gcxxii, enc_numlla, enc_conlla, enc_desscc)
		--Values encabezado
		SELECT
		enc_keydep, enc_feclla, enc_keytpr, enc_nomprd, enc_feccap, enc_keypro,
		enc_usuori, 0, 'N', enc_num_id, 'S', case when enc_keydep is null or enc_keydep = '' then ps_desori else null end
		FROM USRSIHO.holoenclla
		WHERE	enc_num_id = pi_lla_num_id;
		-- --------------------------------------------
    -- Lectura del secuencial de la hoja de trabajo
		-- --------------------------------------------
      select HOLOENCTRA_SEQ.currval into pi_enc_num_id from dual;
		--Values detalle
		IF pi_tipo_folio = 0 THEN
			--Inserta detalle de hoja de trabajo
			--IG-CONS-0823 Comentado
			--INSERT INTO holodettra
			--(det_num_id, det_keydep, det_fecgra, det_keytco, det_sindkto, det_keyfol, det_keyemp,
			-- det_nomcor, det_person, det_keypue, det_keycon, det_noforo, det_hralla, det_stsreg, det_stspag,
			-- det_inanda, det_ultact, det_cdilla, det_usuori, det_fecori, det_usufin, det_fecfin,
			-- det_tipinc, det_cosuni, det_numlla)
			-- SELECT	pi_enc_num_id, det_keydep, det_feclla, det_keytco, det_sindkto, det_keyfol, det_keyemp,
			-- 			det_nomcor, det_person, det_keypue, nvl(pue_ca5aux,'?'), det_noforo, det_hralla, 'V', 'P',
			-- 			'N', pd_fecha, det_cdilla, det_usuori, pd_fecha, ps_usuario, pd_fecha,
			-- 			det_tipinc, det_cosuni, det_num_id
			-- FROM 	holodetlla,nmcopues
			-- WHERE 	det_keypue = pue_keypue and
			--          det_num_id = pi_lla_num_id and
			-- 			det_sindkto = ps_det_sindkto and
			-- 			det_keyfol is not null and
			-- 			det_stslla = 'V';
			--Termina Comentado
			--IG-CONS-0823 Substituye
			INSERT INTO USRSIHO.holodettra
			(det_num_id, det_keydep, det_fecgra, det_keytco, det_sindkto, det_keyfol, det_keyemp,
			det_nomcor, det_person, det_keypue, det_keycon, det_noforo, det_hralla, det_stsreg, det_stspag,
			det_inanda, det_ultact, det_cdilla, det_usuori, det_fecori, det_usufin, det_fecfin,
			det_tipinc, det_cosuni, det_numlla, det_honint)
			SELECT	pi_enc_num_id, det_keydep, det_feclla, det_keytco, det_sindkto, det_keyfol, det_keyemp,
					det_nomcor, det_person, det_keypue, nvl(pue_ca5aux,'?'), det_noforo, det_hralla, 'V', 'P',
					'N', pd_fecha, det_cdilla, det_usuori, pd_fecha, ps_usuario, pd_fecha,
					det_tipinc, det_cosuni, det_num_id, pi_interno_hon
			FROM 	USRSIHO.holodetlla,USRSIHO.nmcopues, USRSIHO.nmcoempl, USRSIHO.holoalem
			WHERE 	det_keypue = pue_keypue and
					det_num_id = pi_lla_num_id and
					det_keytco = pi_det_sindkto and
					det_keyfol is not null and
					det_stslla = 'V' and
					emp_keyemp = det_keyemp and
					ale_keyemp = emp_keyemp and
					CASE 	WHEN det_keytco = 2 THEN 1
							WHEN det_keytco = 3 THEN
										CASE WHEN emp_tipemp = 'I' AND ale_keyem2 IS NOT NULL THEN 1 ELSE 0 END
							WHEN det_keytco = 519 THEN
										CASE WHEN emp_tipemp = 'I' AND ale_keyem2 IS NOT NULL THEN 1 ELSE 0 END
							ELSE
								1
					END = pi_interno_hon;
			-- Termina Substituye
		ELSE
			--Inserta detalle de hoja de trabajo
			-- IG-CONS-0823 Comentado
			-- INSERT INTO holodettra
			-- (det_num_id, det_keydep, det_fecgra, det_keytco, det_sindkto, det_keyfol, det_keyemp,
			-- det_nomcor, det_person, det_keypue, det_keycon, det_noforo, det_hralla, det_stsreg, det_stspag,
			-- det_inanda, det_ultact, det_cdilla, det_usuori, det_fecori, det_usufin, det_fecfin,
			-- det_tipinc, det_cosuni, det_numlla)
			-- SELECT	pi_enc_num_id, det_keydep, det_feclla, det_keytco, det_sindkto, det_keyfol, det_keyemp,
			-- 			det_nomcor, det_person, det_keypue, nvl(pue_ca5aux,'?'), det_noforo, det_hralla, 'V', 'P',
			-- 			'N', pd_fecha, det_cdilla, det_usuori, pd_fecha, ps_usuario, pd_fecha,
			-- 			det_tipinc, det_cosuni, det_num_id
			-- FROM 	holodetlla,nmcopues
			-- WHERE 	det_keypue = pue_keypue and
			--         	det_num_id = pi_lla_num_id and
			-- 			det_sindkto = ps_det_sindkto and
			-- 			det_keyfol is null and
			-- 			det_stslla = 'V';
			-- Termina Comentado
			-- IG-CONS-0823 Substituye
			INSERT INTO USRSIHO.holodettra
			(det_num_id, det_keydep, det_fecgra, det_keytco, det_sindkto, det_keyfol, det_keyemp,
			det_nomcor, det_person, det_keypue, det_keycon, det_noforo, det_hralla, det_stsreg, det_stspag,
			det_inanda, det_ultact, det_cdilla, det_usuori, det_fecori, det_usufin, det_fecfin,
			det_tipinc, det_cosuni, det_numlla, det_honint)
			SELECT	pi_enc_num_id, det_keydep, det_feclla, det_keytco, det_sindkto, det_keyfol, det_keyemp,
					det_nomcor, det_person, det_keypue, nvl(pue_ca5aux,'?'), det_noforo, det_hralla, 'V', 'P',
					'N', pd_fecha, det_cdilla, det_usuori, pd_fecha, ps_usuario, pd_fecha,
					det_tipinc, det_cosuni, det_num_id, pi_interno_hon
			FROM 	USRSIHO.holodetlla,USRSIHO.nmcopues, USRSIHO.nmcoempl, USRSIHO.holoalem
			WHERE 	det_keypue = pue_keypue and
					det_num_id = pi_lla_num_id and
					det_keytco = pi_det_sindkto and
					det_keyfol is null and
					det_stslla = 'V' and
					emp_keyemp = det_keyemp and
					ale_keyemp = emp_keyemp and
					CASE 	WHEN det_keytco = 2 THEN 1
							WHEN det_keytco = 3 THEN
								CASE 	WHEN emp_tipemp = 'I' AND ale_keyem2 IS NOT NULL THEN 1 ELSE 0 END
							WHEN det_keytco = 519 THEN
								CASE 	WHEN emp_tipemp = 'I' AND ale_keyem2 IS NOT NULL THEN 1 ELSE 0 END
							ELSE
								1
					END = pi_interno_hon;
			-- Termina Substituye
		END IF;
		IF pi_enc_num_id_aux = 0 THEN
			pi_enc_num_id_aux := pi_enc_num_id;
		END IF;
 DBMS_OUTPUT.put_line('valor '||to_char(pi_enc_num_id_aux) );
		ps_num_id := TO_CHAR(pi_enc_num_id);
		ps_cadena_reg := trim(ps_cadena_reg) || trim(ps_num_id) || ',';
	END LOOP;
	UPDATE USRSIHO.holoenclla
	SET    enc_hjatra = pi_enc_num_id_aux,
		   enc_stslla = 2
	WHERE  enc_num_id = pi_lla_num_id;
	wi_val_ret01 := pi_enc_num_id_aux;
	ws_val_ret02 := ps_cadena_reg;
	-- RETURN pi_enc_num_id_aux, ps_cadena_reg WITH RESUME;
	-- PIPE ROW ("informix".sp_transf_lla_hja_row(pi_enc_num_id_aux,ps_cadena_reg));
END;
/
