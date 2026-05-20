CREATE OR REPLACE EDITIONABLE PROCEDURE "USRSIHO"."SP_HOLOVALCAP" (ps_nom_rep VARCHAR2,
                                          ps_ide_pcc VARCHAR2,
                                          pi_Key_Usu INTEGER,
                                          pd_fecpag  DATE,
                                          pi_Consult SMALLINT)
IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
	pi_num_id INTEGER;
	pi_keyfol INTEGER;
	pi_keyemp INTEGER;
	pi_sumcap INTEGER;
	err_num INTEGER;
	ps_keydep VARCHAR2(10);
	--IG-CONS-0823 Tipo de validacion del contrato
	pi_tpo_val INTEGER;
BEGIN
	pi_num_id := 0;
	pi_keyfol := 0;
	pi_keyemp := 0;
	pi_sumcap := 0;
	err_num := 0;
	-- Crea una tabla temporal -------------------------------------------
	-- BEGIN
	-- 	ON EXCEPTION IN (-310) SET err_num  -- Error Tabla Existente.
    --
	-- 	IF err_num = -310 THEN
	-- 		DROP TABLE TMP_CAP_VAL;
	-- 		CREATE TEMP TABLE TMP_CAP_VAL (NoCapitulos INTEGER);
	-- 	END IF
    --
	-- 	END EXCEPTION WITH RESUME
    --
	-- 	CREATE TEMP TABLE TMP_CAP_VAL (NoCapitulos INTEGER);
	-- END
	-- -------------------------------------------------------------------
	--Borra toda la informacion vieja antes de grabar la nueva validacion
	--DELETE FROM glwkcrys
	-- WHERE cry_nomrep = ps_nom_rep
	--   AND cry_idepcc = ps_ide_pcc
	--   AND cry_keyusu = pi_Key_Usu;
	-- FOREACH
	FOR cur_01 IN (
	  SELECT 	det_num_id, det_keyfol, det_keyemp, enc_keydep, con_keytva
		-- INTO 	pi_num_id, pi_keyfol, pi_keyemp, ps_keydep, pi_tpo_val
		FROM 	HOLOENCTRA, HOLODETTRA, HOLOCONT
		WHERE 	enc_num_id = det_num_id
				AND enc_stsrep = '2'
				AND det_stspag = 'P'
				AND det_stsreg = 'V'
				AND det_sindkto IN ('ANDA','SITATYR','CONDUCTOR ART')
				AND (  (det_tipinc in ('N','LI'))  )
				AND  enc_fecpag = pd_fecpag
				AND con_keyemp = det_keyemp
				AND con_keyfol = det_keyfol)
	LOOP
    pi_num_id  := cur_01.det_num_id;
    pi_keyfol  := cur_01.det_keyfol;
    pi_keyemp  := cur_01.det_keyemp;
    ps_keydep  := cur_01.enc_keydep;
    pi_tpo_val := cur_01.con_keytva;
		--IG-CONS-0823
		--Se agrega validacion para tipo de validacion de contrato por llamados
		IF ( pi_tpo_val != 4) THEN
			--Checa Capitulos Pagados en RPHs
			--JCRO CONS-0530 (se agrego la tabla holococa)
			INSERT INTO 	TMP_CAP_VAL (NoCapitulos)
			SELECT 			COUNT(distinct coc_keycap) Capitulos
			FROM 			holocont, holohgdp, holococa
			WHERE			con_keyfol = hgd_keyfol
							AND con_keyemp = hgd_keyemp
							AND con_keyplz = coc_keyplz
							AND hgd_keyrph = coc_keyrph
							AND coc_stspag IN ('V','E')
							AND hgd_keyemp = pi_keyemp
							AND hgd_keyfol = pi_keyfol
							AND con_keytco IN (2,3,519);
			--   SELECT nvl(SUM(hgd_numcap),0)
			--     FROM holohgdp, holofrph, holocont
			--    WHERE hgd_keyrph = frp_keyrph AND
			--          hgd_keyemp = con_keyemp AND
			--	    hgd_keyfol = con_keyfol AND
			--          frp_keydep = con_keydep AND
			--	    hgd_keyemp = pi_keyemp AND
			--          hgd_keyfol = pi_keyfol AND
			--          frp_keydep = ps_keydep;
			--JCRO Modificacion para agregar la liga con el centro de costos
			--SELECT nvl(SUM(hgd_numcap),0)
			--  FROM holohgdp
			-- WHERE hgd_keyemp = pi_keyemp
			--   AND hgd_keyfol = pi_keyfol;
			--Checa Capitulos x Pagar en RPHs
			--IG-CONS-0823 modificado para tomar en cuenta los retroactivos 06/06/2014
			--INSERT INTO TMP_CAP_VAL (NoCapitulos)
			--SELECT 		nvl(SUM(gdp_numcap),0)
			--FROM 		hologdpr
			--WHERE 		gdp_keyemp = pi_keyemp
			--			AND gdp_keyfol = pi_keyfol;
			--IG-CONS-0823 Reemplaza la modificaciones anteriores
			INSERT INTO TMP_CAP_VAL (NoCapitulos)
			SELECT 	NVL(SUM(gdp_numcap),0)
			FROM  	hologdpr, holodettra
			WHERE  	gdp_keyemp = pi_keyemp
					AND gdp_keyfol = pi_keyfol
					AND gdp_keyemp = det_keyemp
					AND gdp_keyfol = det_keyfol
					AND gdp_keyrph = det_keyrph
					AND det_keyaut IS NULL;
			--Checa Capitulos Reservados en H.T.
			INSERT INTO TMP_CAP_VAL (NoCapitulos)
			SELECT 		nvl(SUM((det_capfin - det_capini)+1),0)
			FROM 		holodettra, nmcodeps
			WHERE 		det_keydep = dep_keydep
						AND det_keyemp = pi_keyemp
						AND det_keyfol = pi_keyfol
						AND det_stsreg = 'V'
						AND det_stspag = 'P'
						AND det_sindkto IN ('ANDA','SITATYR','CONDUCTOR ART')
						AND det_tipinc IN ('N','LI')
						AND det_keyaut IS NULL; --IG-CONS-0823 modificado para tomar en cuenta los retroactivos 06/06/2014
			--Checa Capitulos Totales del Contrato
			INSERT INTO TMP_CAP_VAL (NoCapitulos)
			SELECT 		-nvl(con_numcap,0)
			FROM 		holocont
			WHERE 		con_keyemp = pi_keyemp
						AND con_keyfol = pi_keyfol;
		--IG-CONS-0823
		--Agregado para tipo de validacion por llamado
		ELSE
			--Checa Capitulos pagados en RPHs
			INSERT INTO TMP_CAP_VAL (NoCapitulos)
			SELECT 		COUNT(*) Llamados
			FROM 		holocont, holohgdp, holococa
			WHERE 		hgd_keyemp = pi_keyemp
						AND	hgd_keyfol = pi_keyfol
						AND con_keyemp = hgd_keyemp
						AND con_keyfol = hgd_keyfol
						AND con_keyplz = coc_keyplz
						AND hgd_keyrph = coc_keyrph
						AND coc_stspag in ('V','E')
						AND con_keytco in (2,3,519);
			--Checa Capitulos x Pagar en RPHs
			INSERT INTO TMP_CAP_VAL (NoCapitulos)
			SELECT 		COUNT(*) Llamados
			FROM 		hologdpr, holodettra
			WHERE 		gdp_keyemp = pi_keyemp
						AND gdp_keyfol = pi_keyfol
						AND gdp_keyemp = det_keyemp
						AND gdp_keyfol = det_keyfol
						AND gdp_keyrph = det_keyrph
						AND det_keyaut IS NULL;
			--Checa Capitulos Reservados en H.T.
			INSERT INTO TMP_CAP_VAL (NoCapitulos)
			SELECT 		COUNT(*) Llamados
			FROM 		holodettra, nmcodeps
			WHERE 		det_keydep = dep_keydep
						AND det_keyemp = pi_keyemp
						AND det_keyfol = pi_keyfol
						AND det_stsreg = 'V'
						AND det_stspag = 'P'
						AND det_keyaut IS NULL;
			--Checa Capitulos Totales del Contrato
			INSERT INTO TMP_CAP_VAL (NoCapitulos)
			SELECT 		-COUNT(*) Llamados
			FROM    	holocont, holococa
			WHERE 		con_keyemp = pi_keyemp
						AND con_keyfol = pi_keyfol
						AND coc_keycap = con_numcap
						AND coc_keyplz = con_keyplz;
		END IF;
		--Suma los capitulos o llamados en su caso
        BEGIN
            SELECT NVL(SUM(NoCapitulos),0)
              INTO pi_sumcap
              FROM TMP_CAP_VAL;
              EXCEPTION WHEN no_data_found THEN pi_sumcap := 0;
        END;
		--Si el valor es negativo tiene capitulos disponibles
		IF pi_sumcap > 0 THEN
			IF pi_Consult = 1 THEN	-- Solo es consulta
				INSERT INTO glwkcrys (
						cry_nomrep,
						cry_idepcc,
						cry_keyusu,
						cry_chr004)
					VALUES (
						ps_nom_rep,
						ps_ide_pcc,
						pi_Key_Usu,
						'CAPITULOS EXEDIDOS');
				-- EXIT FOREACH;
				EXIT;
			ELSE				-- Se graba el detalle del error
				INSERT INTO glwkcrys (
					cry_nomrep,
					cry_idepcc,
					cry_keyusu,
					cry_chr004,
					cry_chr002,
					cry_numsec,
					cry_chr001,
					cry_chr014,
					cry_dec006,
					cry_chr003,
					cry_dec007)
				SELECT DISTINCT 	ps_nom_rep,
									ps_ide_pcc,
									pi_Key_Usu,
									'Contrato :' ||det_keyfol Dato_Erroneo,
									-- 'El Contrato ya exede por ' || sp_tochar(pi_sumcap) || ' al total de capitulos contratados'  Error,
                  -- 'El Contrato ya exede por ' || TO_CHAR(pi_sumcap) || ' al total de capitulos contratados'  Error,
                  'El Contrato exede por ' || TO_CHAR(pi_sumcap) || ' al total de capitulos contratados'  Error,
									det_keyemp Cve_Empleado, nvl(emp_nomemp,'EmpleadoInexistente') Nombre,
									to_char(det_fecpag,'%d/%b/%Y')  Fecha_Pago,
									CASE WHEN det_sindkto = 'CONDUCTOR ART' THEN 104
									WHEN det_sindkto = 'SITATYR' THEN 106
									WHEN det_sindkto = 'ANDA' THEN 110
									END det_nomina,det_sindkto DescripNom,
									enc_num_id HojaTrabajo
				FROM 				HOLOENCTRA, HOLODETTRA, HOLOCONT, nmcoempl
				WHERE 				enc_num_id = det_num_id
									AND det_keyfol = con_keyfol
									AND det_keyemp = emp_keyemp
									AND det_keyemp = pi_keyemp
									AND det_keyfol = pi_keyfol
									AND det_num_id = pi_num_id;
			END IF;
		END IF;
		--DELETE FROM TMP_CAP_VAL;
	-- END FOREACH;
	END LOOP;
	-- DROP TABLE TMP_CAP_VAL;
	DELETE FROM TMP_CAP_VAL WHERE 1 = 1;
END;
/
