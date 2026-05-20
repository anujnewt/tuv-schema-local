CREATE OR REPLACE EDITIONABLE PROCEDURE "USRSIHO"."SP_TOTHOJTRA" ( intNumHoja NUMBER, strUsuario VARCHAR2 ) IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
ws_ind_con VARCHAR2(2);
BEGIN
	DELETE FROM USRSIHO.glwkcrys WHERE cry_idepcc = 'totlla' AND  cry_keyusu = strUsuario AND  cry_nomrep = 'tothollama';
	INSERT INTO USRSIHO.glwkcrys ( cry_nomrep, cry_idepcc, cry_keyusu, cry_numsec, cry_chr001, cry_chr002, cry_dec001)
	--Cuota de transito
	SELECT  'tothollama', 'totlla', strUsuario, 0, 'Total Gral Cuota Transito:' , nvl(det_noforo, '-'),
		NVL(
			SUM(
				CASE WHEN NVL(substr(enc_descap,1,11),'') = 'RETROACTIVO' THEN
					CASE
						WHEN (det_tipinc='N' OR det_tipinc='LI') THEN
							(
								( SELECT  tab_import
									FROM    USRSIHO.holotabs
									WHERE   tab_keytab = 3
									AND 	tab_keypro =  138
									AND 	tab_keypue = det_keypue
									AND 	tab_pertra = con_pertra
									AND 	tab_idioma = con_idioma
									AND 	tab_keynac = con_keynac
									-- AND det_fecgra between tab_fecini AND tab_fecfin
									AND 	EXTRACT(YEAR FROM tab_fecfin) = extract(year from det_fecgra)
									+ 1
								)
								-
								( SELECT  	tab_import
									FROM    USRSIHO.holotabs
									WHERE   tab_keytab = 3
													AND tab_keypro =  138
													AND tab_keypue = det_keypue
													AND tab_pertra = con_pertra
													AND tab_idioma = con_idioma
													AND tab_keynac = con_keynac
													--AND det_fecgra between tab_fecini AND tab_fecfin
													AND EXTRACT(YEAR FROM tab_fecfin) = extract(year from det_fecgra)
								)
							)
					ELSE
						0 	-- Solo aplica para extranjeros (Si existe el tabulador)
					END
				ELSE
					CASE
						WHEN (det_tipinc='N' OR det_tipinc='LI' OR det_tipinc='JV'  OR det_tipinc='JE') AND det_keyaut IS NULL  THEN
							( 	SELECT  tab_import
								FROM    USRSIHO.holotabs
								WHERE   tab_keytab = 3
								AND 	tab_keypro =  138
								AND 	tab_keypue = det_keypue
								AND 	tab_pertra = con_pertra
								AND 	tab_idioma = con_idioma
								AND 	tab_keynac = con_keynac
								AND 	det_fecgra between tab_fecini AND tab_fecfin
							)
						ELSE
							0 	-- Solo aplica para extranjeros (Si existe el tabulador)
					END
				END
				*
				CASE WHEN NVL(to_number(SUBSTR(det_auxca2, 8, 1)), 0) = 1 THEN
					( 	SELECT 	CASE WHEN count(*) > 0 THEN 3 ELSE 1 END
						FROM 	USRSIHO.glcopams
						WHERE 	pam_keypar = 'CDF'
						AND 	pam_folfin = TO_CHAR(det_fecgra, 'DD/MM/YYYY')
					)
				+
					CASE WHEN NVL(to_number(SUBSTR(det_auxca2, 6, 1)), 0) = 1 THEN 1 ELSE 0 END
				ELSE
					1
				END
				*
				((det_capfin - det_capini) + 1) ), 0)
	FROM 	USRSIHO.holodettra
			JOIN USRSIHO.holoenctra ON enc_num_id = det_num_id
			LEFT JOIN USRSIHO.holocont ON det_keyemp = con_keyemp AND det_keyfol = con_keyfol
	WHERE   det_num_id  = intNumHoja
	AND 	det_keyemp NOT IN ( SELECT  pam_folini
								FROM 	USRSIHO.GLCOPAMS
								WHERE   pam_keypar = 'ACP'
								AND 	pam_folfin = 'CODIGO ANDA')
	--AND det_tipinc IN ("N", "LI")
	AND 	det_sindkto IN ('ANDA', 'ANDA PENSIONADA')
	AND 	det_stsreg = 'V'
	GROUP BY det_noforo; --6,5;
	-- Prevision social
	-- ----------------
	INSERT INTO USRSIHO.glwkcrys ( cry_nomrep, cry_idepcc, cry_keyusu, cry_numsec, cry_chr001, cry_chr002, cry_dec001)
	SELECT  'tothollama', 'totlla', strUsuario, 0, 'Total Gral Prevision Social:', NVL(det_noforo, '-'),
	ROUND (
		SUM(
			CASE WHEN det_keytco = 2 THEN
							(
                                CASE WHEN (det_tipinc='N' OR det_tipinc='LI') AND det_keyaut IS NULL  THEN
                                    ( 	SELECT 	tab_import
                                        From 	USRSIHO.holotabs
                                        Where 	tab_keypro = 138
                                        AND 	tab_keypue = con_keypue
                                        AND 	tab_pertra = con_pertra
                                        AND 	tab_idioma = con_idioma
                                        AND 	tab_keynac = con_keynac
                                        AND 	tab_keytab = (case when con_keytco = 519 then 3 else con_keytco end -1)
                                        AND 	det_fecgra between tab_fecini AND tab_fecfin
                                    )
                                    WHEN (det_tipinc in ('DE', 'CM', 'CN','PA')) THEN
                                        0
                                    ELSE
                                        det_cosuni
                                END
                                *
                                CASE WHEN NVL(to_number(SUBSTR(det_auxca2, 8, 1)), 0) = 1 THEN
                                    ( 	SELECT 	CASE WHEN count(*) > 0 THEN 3 ELSE 1 END
                                        FROM 	USRSIHO.glcopams
                                        WHERE 	pam_keypar = 'CDF'
                                        AND 	pam_folfin = TO_CHAR(det_fecgra, 'DD/MM/YYYY')
                                    )
                                    ELSE
                                        1
                                END
                                *
                                ((NVL(det_capfin,1) - NVL(det_capini,1)) + 1)
                                *
                                CASE WHEN NVL(to_number(SUBSTR(det_auxca2, 6, 1)), 0) = 1 THEN
                                    2
                                ELSE
                                    1
                                END
						 	) * 0.18
						 	+
						 	(
								CASE
							 	WHEN det_keyemp IS NULL OR det_keyfol IS NULL THEN
										0
								ELSE
									USRSIHO.sp_calimptiext( (nvl(substr(det_hraent,1,2),0)*60 + nvl(substr(det_hraent,4,2),0)),
									(nvl(substr(det_hrasal,1,2),0)*60 + nvl(substr(det_hrasal,4,2),0)),
									CASE
										WHEN to_number(substr(det_auxca2,9,1)) = 1 AND to_number(substr(det_auxca2,10,1)) = 1 THEN to_number(to_number(NVL(substr(holoenctra.enc_salcom,1,2),0)) * 60 + to_number(NVL(substr(holoenctra.enc_salcom,4,2),0))) - to_number(to_number(NVL(substr(holoenctra.enc_entcom,1,2),0)) * 60 + to_number(NVL(substr(holoenctra.enc_entcom,4,2),0)))
										WHEN to_number(substr(det_auxca2,9,1)) = 1 AND to_number(substr(det_auxca2,10,1)) = 0 THEN to_number(to_number(NVL(substr(holoenctra.enc_salcom,1,2),0)) * 60 + to_number(NVL(substr(holoenctra.enc_salcom,4,2),0))) - to_number(to_number(NVL(substr(holoenctra.enc_entcom,1,2),0)) * 60 + to_number(NVL(substr(holoenctra.enc_entcom,4,2),0)))
										WHEN to_number(substr(det_auxca2,9,1)) = 0 AND to_number(substr(det_auxca2,10,1)) = 1 THEN 30
										WHEN to_number(substr(det_auxca2,9,1)) = 0 AND to_number(substr(det_auxca2,10,1)) = 0 THEN 0
										ELSE 0
									END,
									nvl(det_capini,0),
									nvl(det_capfin,0),
									det_keydep,
									det_keyfol,
									nvl(con_keypue,'X'),
									nvl(CASE
										WHEN (det_tipinc='N' OR det_tipinc='LI') AND det_keyaut IS NULL  THEN
											( 	SELECT 	tab_import
												From 	USRSIHO.holotabs
												Where 	tab_keypro = 138
												AND 	tab_keypue = con_keypue
												AND 	tab_pertra = con_pertra
												AND 	tab_idioma = con_idioma
												AND 	tab_keynac = con_keynac
												AND 	tab_keytab = (case when con_keytco = 519 then 3 else con_keytco end -1)
												AND 	det_fecgra between tab_fecini AND tab_fecfin
											)
										ELSE
											det_cosuni
										END, con_cosuni
										),
									det_keytco,
									nvl(det_keyemp,0),
									det_fecgra,
									det_serial,
									intNumHoja) * 0.18
								END
							)
				ELSE
					0
			END
		), 2)
	FROM  	USRSIHO.holodettra
			JOIN USRSIHO.holoenctra ON enc_num_id = det_num_id
			LEFT JOIN USRSIHO.holocont ON det_keyemp = con_keyemp AND con_keyfol = det_keyfol	AND con_cosuni>= 0.01
			LEFT JOIN USRSIHO.nmcopues ON pue_keypue = NVL(con_keypue, det_keypue)
	WHERE   det_num_id  = intNumHoja
	AND 	det_keyemp NOT IN ( SELECT	pam_folini
								FROM  	USRSIHO.GLCOPAMS
								WHERE 	pam_keypar = 'ACP'
								AND 	pam_folfin = 'CODIGO ANDA'
							  )
	AND det_stsreg = 'V'
	AND substr(pue_ca4aux,2, 1) = 1
	GROUP BY det_noforo;
	-- Fomento a la cultura
	-- --------------------
	-- ELJM 07.10.2021 APLICA CONDICION DE BUSQUEDA
	ws_ind_con := 'NO';
	SELECT pam_folini INTO ws_ind_con FROM usrsiho.glcopams WHERE pam_keypar = 'ACP' AND pam_cvesec = '99999';
	INSERT INTO USRSIHO.glwkcrys ( cry_nomrep, cry_idepcc, cry_keyusu, cry_numsec, cry_chr001, cry_chr002, cry_dec001)
	SELECT  'tothollama', 'totlla', strUsuario, 0, 'Total Gral Fomento C:', nvl(det_noforo, '-'),
			ROUND(
                CASE WHEN NVL(substr(enc_descap,1,11),'') = 'RETROACTIVO' THEN
					SUM(
						CASE
							WHEN det_keytco = 2 THEN
								(
									( 	CASE
											WHEN (det_tipinc='N' OR det_tipinc='LI') THEN
												( 	SELECT 	tab_import
													FROM   	USRSIHO.holotabs
													WHERE  	tab_keypro = 138
													AND 	tab_keypue = con_keypue
													AND 	tab_pertra = con_pertra
													AND 	tab_idioma = con_idioma
													AND 	tab_keynac = con_keynac
													AND 	tab_keytab = (case when con_keytco = 519 then 3 else con_keytco end -1)
													AND 	det_fecgra between tab_fecini AND tab_fecfin
												)
											WHEN (det_tipinc in ('DE', 'CM', 'CN','PA')) THEN
												0
											ELSE
												det_cosuni
										END  * 0.0300)
								-
									( CASE
										-- ELJM 07.10.2021 APLICA CONDICION DE BUSQUEDA
										-- WHEN (det_tipinc='N' OR det_tipinc='LI') THEN
										WHEN (det_tipinc='N' OR det_tipinc='LI') AND ws_ind_con = 'SI' THEN
												( SELECT  tab_import
													FROM    USRSIHO.holotabs
													WHERE   tab_keypro = 138
															AND tab_keypue = con_keypue
															AND tab_pertra = con_pertra
															AND tab_idioma = con_idioma
															AND tab_keynac = con_keynac
															AND tab_keytab = (case when con_keytco = 519 then 3 else con_keytco end -1)
															AND det_fecgra > tab_fecfin
															AND (EXTRACT(YEAR FROM det_fecgra)=EXTRACT(YEAR FROM tab_fecfin))
															AND (EXTRACT(YEAR FROM to_date(det_fecgra,'MM/DD/YYYY'))=EXTRACT(YEAR FROM tab_fecini))
												)
										WHEN (det_tipinc='N' OR det_tipinc='LI') THEN
												( SELECT  tab_import
													FROM    USRSIHO.holotabs
													WHERE   tab_keypro = 138
															AND tab_keypue = con_keypue
															AND tab_pertra = con_pertra
															AND tab_idioma = con_idioma
															AND tab_keynac = con_keynac
															AND tab_keytab = (case when con_keytco = 519 then 3 else con_keytco end -1)
															AND det_fecgra > tab_fecfin
															AND (EXTRACT(YEAR FROM det_fecgra)=EXTRACT(YEAR FROM tab_fecfin))
												)
										ELSE
											0
									END  * 0.0300 )
								) * ((det_capfin - det_capini ) + 1)
							ELSE
								0
						END
					)
				ELSE
					SUM(
						CASE
							WHEN det_keytco = 2 THEN
                                ROUND(
									CASE
										WHEN (det_tipinc='N' OR det_tipinc='LI') AND det_keyaut IS NULL THEN
											( 	SELECT  tab_import
												FROM    USRSIHO.holotabs
												WHERE   tab_keypro = 138
												AND 	tab_keypue = con_keypue
												AND 	tab_pertra = con_pertra
												AND 	tab_idioma = con_idioma
												AND 	tab_keynac = con_keynac
												AND 	tab_keytab = (case when con_keytco = 519 then 3 else con_keytco end -1)
												AND 	det_fecgra between tab_fecini AND tab_fecfin
											)
										-- ELJM 23.12.2021 TE AJUSTE DE TIEMPO EXTRA NO LLEVA FOMENTOS
										-- WHEN (det_tipinc in ('DE', 'CM', 'CN','PA')) THEN
										WHEN (det_tipinc IN ('TE', 'DE', 'CM', 'CN','PA')) THEN
											0
										ELSE
											det_cosuni
									END
									* 0.0300
									*
									CASE WHEN NVL(to_number(SUBSTR(det_auxca2, 8, 1)), 0) = 1 THEN
										( 	SELECT 	CASE WHEN count(*) > 0 THEN 3 ELSE 1 END
											FROM 	USRSIHO.glcopams
											WHERE 	pam_keypar = 'CDF'
											AND 	pam_folfin = TO_CHAR(det_fecgra, 'DD/MM/YYYY')
										)
										ELSE
											1
									END
									*  ((det_capfin - det_capini ) + 1)
                                    *
                                    CASE WHEN NVL(to_number(SUBSTR(det_auxca2, 6, 1)), 0) = 1 THEN
                                        2
                                    ELSE
                                        1
                                    END
                                )
							ELSE
								0
						END
					)
				END
                )
	FROM 	USRSIHO.holodettra
			JOIN USRSIHO.holoenctra ON enc_num_id = det_num_id
			LEFT JOIN USRSIHO.holocont ON det_keyemp = con_keyemp AND det_keyfol = con_keyfol
	WHERE 	det_num_id  = intNumHoja
	AND 	det_keyemp NOT IN ( SELECT pam_folini
								FROM   USRSIHO.GLCOPAMS
								WHERE  pam_keypar = 'ACP'
								AND    pam_folfin = 'CODIGO ANDA')
	AND det_stsreg = 'V'
	GROUP BY det_noforo, enc_descap; --6,5, enc_descap;
	-- Total Gral Fomento Eficiencia
	-- -----------------------------
	INSERT INTO USRSIHO.glwkcrys ( cry_nomrep, cry_idepcc, cry_keyusu, cry_numsec, cry_chr001, cry_chr002, cry_dec001)
	SELECT  'tothollama', 'totlla', strUsuario, 0, 'Total Gral Fomento E:', nvl(det_noforo, '-'),
		ROUND(
        CASE WHEN NVL(substr(enc_descap,1,11),'') = 'RETROACTIVO' THEN
			SUM(
				CASE
					WHEN det_keytco = 2 THEN
						(
							( CASE
								WHEN (det_tipinc='N' OR det_tipinc='LI')  THEN
									( 	SELECT	tab_import
										FROM    USRSIHO.holotabs
										WHERE   tab_keypro = 138
										AND 	tab_keypue = con_keypue
										AND 	tab_pertra = con_pertra
										AND 	tab_idioma = con_idioma
										AND 	tab_keynac = con_keynac
										AND 	tab_keytab = (case when con_keytco = 519 then 3 else con_keytco end -1)
										AND 	det_fecgra between tab_fecini AND tab_fecfin )
								WHEN (det_tipinc in ('DE', 'CM', 'CN','PA')) THEN
									0
								ELSE
									det_cosuni
							END  * 0.0300)
						-
							( CASE
								-- ELJM 07.10.2021 APLICA CONDICION DE BUSQUEDA
								-- WHEN (det_tipinc='N' OR det_tipinc='LI') THEN
								WHEN (det_tipinc='N' OR det_tipinc='LI') AND ws_ind_con = 'SI' THEN
									( 	SELECT	tab_import
										FROM    USRSIHO.holotabs
										WHERE   tab_keypro = 138
										AND 	tab_keypue = con_keypue
										AND 	tab_pertra = con_pertra
										AND 	tab_idioma = con_idioma
										AND 	tab_keynac = con_keynac
										AND 	tab_keytab = (case when con_keytco = 519 then 3 else con_keytco end -1)
										AND 	det_fecgra > tab_fecfin
										AND 	(EXTRACT(YEAR FROM det_fecgra)=EXTRACT(YEAR FROM tab_fecfin))
										AND 	(EXTRACT(YEAR FROM to_date(det_fecgra,'MM/DD/YYYY'))=EXTRACT(YEAR FROM tab_fecini))
									)
								WHEN (det_tipinc='N' OR det_tipinc='LI') THEN
									( 	SELECT  tab_import
										FROM    USRSIHO.holotabs
										WHERE   tab_keypro = 138
										AND 	tab_keypue = con_keypue
										AND 	tab_pertra = con_pertra
										AND 	tab_idioma = con_idioma
										AND 	tab_keynac = con_keynac
										AND 	tab_keytab = (case when con_keytco = 519 then 3 else con_keytco end -1)
										AND 	det_fecgra > tab_fecfin
										AND 	(EXTRACT(YEAR FROM det_fecgra)=EXTRACT(YEAR FROM tab_fecfin))
									)
								ELSE
									0
							END  * 0.0300 )
						)
                        *
                        ((det_capfin - det_capini ) + 1)
					ELSE
						0
				END
			)
		ELSE
			SUM(
				CASE
					WHEN det_keytco = 2 THEN
                        ROUND(
							CASE
								WHEN (det_tipinc='N' OR det_tipinc='LI') AND det_keyaut IS NULL THEN
									( 	SELECT  tab_import
										FROM    USRSIHO.holotabs
										WHERE   tab_keypro = 138
										AND 	tab_keypue = con_keypue
										AND 	tab_pertra = con_pertra
										AND 	tab_idioma = con_idioma
										AND 	tab_keynac = con_keynac
										AND 	tab_keytab = (case when con_keytco = 519 then 3 else con_keytco end -1)
										AND 	det_fecgra between tab_fecini AND tab_fecfin
												)
								-- ELJM 23.12.2021 AJUSTE DE TIEMPO EXTRA NO LLEVA FOMENTOS
								-- WHEN (det_tipinc in ('DE', 'CM', 'CN','PA')) THEN
								WHEN (det_tipinc IN ('TE', 'DE', 'CM', 'CN','PA')) THEN
									0
								ELSE  det_cosuni
							END
							* 0.0300
							*
							CASE WHEN NVL(to_number(SUBSTR(det_auxca2, 8, 1)), 0) = 1 THEN
								( 	SELECT 	CASE WHEN count(*) > 0 THEN 3 ELSE 1 END
									FROM 	USRSIHO.glcopams
									WHERE 	pam_keypar = 'CDF'
									AND 	pam_folfin = TO_CHAR(det_fecgra, 'DD/MM/YYYY')
								)
								ELSE
									1
							END
							*  ((det_capfin - det_capini ) + 1)
                            *
                            CASE WHEN NVL(to_number(SUBSTR(det_auxca2, 6, 1)), 0) = 1 THEN
                                2
                            ELSE
                                1
                            END
                        )
					ELSE
						0
				END
			)
		END
        )
	FROM 	USRSIHO.holodettra
			JOIN USRSIHO.holoenctra ON enc_num_id = det_num_id
			LEFT JOIN USRSIHO.holocont ON det_keyemp = con_keyemp AND det_keyfol = con_keyfol
	WHERE   det_num_id  = intNumHoja
	AND 	det_keyemp NOT IN ( SELECT  pam_folini
								FROM    USRSIHO.GLCOPAMS
								WHERE   pam_keypar = 'ACP'
								AND pam_folfin = 'CODIGO ANDA')
	AND det_stsreg = 'V'
	GROUP BY det_noforo,enc_descap; --6,5, enc_descap;
	-- Calculo de hora extras
	-- ----------------------
	INSERT INTO USRSIHO.glwkcrys ( cry_nomrep, cry_idepcc, cry_keyusu, cry_numsec, cry_chr001, cry_chr002, cry_dec001)
	SELECT  'tothollama', 'totlla', strUsuario, 0, 'Total Gral Tiempo Extra:', nvl(det_noforo, '-'),
			SUM( ROUND(
			CASE WHEN det_keyemp IS NULL OR det_keyfol IS NULL THEN
                    0
                WHEN det_keyemp IS NOT NULL THEN
										sp_calimptiext( (nvl(substr(det_hraent,1,2),0)*60 + nvl(substr(det_hraent,4,2),0)), --hora entrada
										(nvl(substr(det_hrasal,1,2),0)*60 + nvl(substr(det_hrasal,4,2),0)), -- hora salida minutos
										CASE
											WHEN to_number(substr(det_auxca2,9,1)) = 1 AND to_number(substr(det_auxca2,10,1)) = 1 THEN to_number(to_number(NVL(substr(holoenctra.enc_salcom,1,2),0)) * 60 + to_number(NVL(substr(holoenctra.enc_salcom,4,2),0))) - to_number(to_number(NVL(substr(holoenctra.enc_entcom,1,2),0)) * 60 + to_number(NVL(substr(holoenctra.enc_entcom,4,2),0)))
											WHEN to_number(substr(det_auxca2,9,1)) = 1 AND to_number(substr(det_auxca2,10,1)) = 0 THEN to_number(to_number(NVL(substr(holoenctra.enc_salcom,1,2),0)) * 60 + to_number(NVL(substr(holoenctra.enc_salcom,4,2),0))) - to_number(to_number(NVL(substr(holoenctra.enc_entcom,1,2),0)) * 60 + to_number(NVL(substr(holoenctra.enc_entcom,4,2),0)))
											WHEN to_number(substr(det_auxca2,9,1)) = 0 AND to_number(substr(det_auxca2,10,1)) = 1 THEN 30
											WHEN to_number(substr(det_auxca2,9,1)) = 0 AND to_number(substr(det_auxca2,10,1)) = 0 THEN 0
											ELSE 0
										END,
										nvl(det_capini,0),
										nvl(det_capfin,0),
										det_keydep,
										det_keyfol,
										nvl(con_keypue,'X'),
										nvl(CASE
											WHEN (det_tipinc='N' OR det_tipinc='LI') AND det_keyaut IS NULL  THEN
												( 	SELECT 	tab_import
													FROM	USRSIHO.holotabs
													WHERE	tab_keypro = 138
													AND 	tab_keypue = con_keypue
													AND 	tab_pertra = con_pertra
													AND 	tab_idioma = con_idioma
													AND 	tab_keynac = con_keynac
													AND 	tab_keytab = (case when con_keytco = 519 then 3 else con_keytco end -1)
													AND 	det_fecgra between tab_fecini AND tab_fecfin
												)
										Else
											det_cosuni
										END, con_cosuni) ,
										det_keytco,
										nvl(det_keyemp,0),
										det_fecgra,
										det_serial,
										intNumHoja)
				END
			, 2))
	FROM 	USRSIHO.holodettra
			JOIN USRSIHO.holoenctra ON enc_num_id = det_num_id
			LEFT JOIN USRSIHO.holocont ON det_keyemp = con_keyemp AND det_keyfol = con_keyfol
	WHERE   det_num_id  = intNumHoja
	AND 	det_stsreg = 'V'
	GROUP BY det_noforo;
	-- Calculo de viaticos
	-- -------------------
	DELETE FROM USRSIHO.TMP_VIAT;
	INSERT INTO USRSIHO.TMP_VIAT
	SELECT  *
	FROM    USRSIHO.glcopams
	WHERE   pam_keypar = 'ACP'
	AND pam_nompar IN('PASAJES','VIATICOS LOCACION','DESAYUNO','COMIDA','CENA');
	INSERT INTO USRSIHO.glwkcrys ( cry_nomrep, cry_idepcc, cry_keyusu, cry_numsec, cry_chr001, cry_chr002, cry_dec001)
	SELECT  'tothollama', 'totlla', strUsuario, 0, 'Total Gral Vaticos:', nvl(det_noforo, '-'),
					CASE
						WHEN NVL(substr(enc_descap,1,11), ' ') <> 'RETROACTIVO' THEN
							SUM
							(
								((CASE WHEN NVL(det_acomen,0) = 1 THEN 2 ELSE 1 END) * NVL(P.pam_folini,0))
							+   ((CASE WHEN NVL(det_acomen,0) = 1 THEN 2 ELSE 1 END) * NVL(V.pam_folini,0))
							+   ((CASE WHEN NVL(det_acomen,0) = 1 THEN 2 ELSE 1 END) * NVL(D.pam_folini,0))
							+   ((CASE WHEN NVL(det_acomen,0) = 1 THEN 2 ELSE 1 END) * NVL(C.pam_folini,0))
							+   ((CASE WHEN NVL(det_acomen,0) = 1 THEN 2 ELSE 1 END) * NVL(N.pam_folini,0))
							+   ((CASE WHEN NVL(det_acomen,0) = 1 THEN 2 ELSE 1 END) * NVL(IP.pam_folini,0))
							+   ((CASE WHEN NVL(det_acomen,0) = 1 THEN 2 ELSE 1 END) * NVL(ID.pam_folini,0))
							+   ((CASE WHEN NVL(det_acomen,0) = 1 THEN 2 ELSE 1 END) * NVL(IC.pam_folini,0))
							+   ((CASE WHEN NVL(det_acomen,0) = 1 THEN 2 ELSE 1 END) * NVL(NI.pam_folini,0))
							)
						ELSE
							0
					END
	FROM   	USRSIHO.holodettra
			JOIN USRSIHO.holoenctra ON enc_num_id = det_num_id
			LEFT JOIN USRSIHO.TMP_VIAT P ON P.pam_nompar = CASE WHEN substr(det_auxca2,1,1) = '1' AND det_tipinc NOT IN ('DE', 'CM', 'CN','PA') THEN 'PASAJES' ELSE '' END
			LEFT JOIN USRSIHO.TMP_VIAT V ON V.pam_nompar = CASE WHEN substr(det_auxca2,2,1) = '1' THEN 'VIATICOS LOCACION' ELSE '' END
			LEFT JOIN USRSIHO.TMP_VIAT D ON D.pam_nompar = CASE WHEN substr(det_auxca2,3,1) = '1' AND det_tipinc NOT IN ('DE', 'CM', 'CN','PA') THEN 'DESAYUNO' ELSE '' END
			LEFT JOIN USRSIHO.TMP_VIAT C ON C.pam_nompar = CASE WHEN substr(det_auxca2,4,1) = '1' AND det_tipinc NOT IN ('DE', 'CM', 'CN','PA') THEN 'COMIDA' ELSE '' END
			LEFT JOIN USRSIHO.TMP_VIAT N ON N.pam_nompar = CASE WHEN substr(det_auxca2,5,1) = '1' AND det_tipinc NOT IN ('DE', 'CM', 'CN','PA') THEN 'CENA' ELSE '' END
			LEFT JOIN USRSIHO.TMP_VIAT IP ON IP.pam_nompar = CASE WHEN det_tipinc = 'PA' THEN 'PASAJES' ELSE '' END
			LEFT JOIN USRSIHO.TMP_VIAT ID ON ID.pam_nompar = CASE WHEN det_tipinc = 'DE' THEN 'DESAYUNO' ELSE '' END
			LEFT JOIN USRSIHO.TMP_VIAT IC ON IC.pam_nompar = CASE WHEN det_tipinc = 'CM' THEN 'COMIDA' ELSE '' END
			LEFT JOIN USRSIHO.TMP_VIAT NI ON NI.pam_nompar = CASE WHEN det_tipinc = 'CN' THEN 'CENA' ELSE '' END
	WHERE   det_num_id  = intNumHoja
	AND 	det_stsreg = 'V'
	GROUP BY det_noforo,enc_descap; --6, 5, enc_descap;
	--EXECUTE IMMEDIATE 'TRUNCATE TABLE TMP_VIAT';
	-- Total Gral Costo Unitario
	-- -------------------------
	INSERT INTO USRSIHO.glwkcrys ( cry_nomrep, cry_idepcc, cry_keyusu, cry_numsec, cry_chr001, cry_chr002, cry_dec001)
	--Total de la hoja
	SELECT  'tothollama', 'totlla', strUsuario, 0, 'Total Gral Costo Unitario:', nvl(det_noforo, '-'),
			sum (
				CASE WHEN (det_tipinc='N' OR det_tipinc='LI') AND det_keyaut IS NULL  THEN
					( 	SELECT 	tab_import
						From 	USRSIHO.holotabs
						Where 	tab_keypro = 138
						AND 	tab_keypue = con_keypue
						AND 	tab_pertra = con_pertra
						AND 	tab_idioma = con_idioma
						AND 	tab_keynac = con_keynac
						AND 	tab_keytab = (case when con_keytco = 519 then 3 else con_keytco end -1)
						AND 	det_fecgra between tab_fecini AND tab_fecfin
					)
					WHEN (det_tipinc in ('DE', 'CM', 'CN','PA')) THEN
						0
					ELSE
						det_cosuni
				END
				*
				CASE WHEN NVL(to_number(SUBSTR(det_auxca2, 8, 1)), 0) = 1 THEN
					( 	SELECT 	CASE WHEN count(*) > 0 THEN 3 ELSE 1 END
						FROM 	USRSIHO.glcopams
						WHERE 	pam_keypar = 'CDF'
						AND 	pam_folfin = TO_CHAR(det_fecgra, 'DD/MM/YYYY')
					)
					ELSE
						1
				END
				*
				((NVL(det_capfin,1) - NVL(det_capini,1)) + 1)
				*
				CASE WHEN NVL(to_number(SUBSTR(det_auxca2, 6, 1)), 0) = 1 THEN
					2
				ELSE
					1
				END
				)
	FROM    USRSIHO.holodettra
			LEFT JOIN USRSIHO.holocont ON det_keyemp = con_keyemp AND det_keyfol = con_keyfol
			LEFT JOIN USRSIHO.nmcopues ON pue_keypue = con_keypue
	WHERE   det_num_id  = intNumHoja
	AND 	det_stsreg = 'V'
	-- AND con_cosuni >= 0.01
	GROUP BY det_noforo; --6,5;
	DELETE FROM USRSIHO.glwkcrys
	WHERE   cry_nomrep = 'tothollama'
	AND 	cry_idepcc = 'totlla'
	AND 	cry_keyusu = strUsuario
	AND 	NVL(cry_dec001, 0) = 0;
	COMMIT;
END;
/
