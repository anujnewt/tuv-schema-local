CREATE OR REPLACE EDITIONABLE PROCEDURE "USRSIHO"."SP_HOLOTRARPH_DF" (pi_rph NUMBER,         --Numero de RPH
                                             pd_fechaact DATE,       --Fecha de actualizaci?n
                                             pd_fechapag DATE,       --Fecha de pago
                                             pi_keyemp NUMBER,      --Numero del empleado
                                             pi_num_id NUMBER,      --Numero de la hoja de trabajo
                                             pi_serial NUMBER,      --Numero del detalle de la hoja de trabajo
                                             --pi_capini NUMBER,      --Capitulo inicial
                                             --pi_capfin NUMBER,      --Capitulo final
                                             pi_keyusu NUMBER,      --Clave del usuario
                                             ps_fechapagdf VARCHAR2, --Fecha de pago en texto con formato 'DD/MM/YYYY'
                                             pi_keypro NUMBER) IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start

-- PGV moved types end
       --Numero de proceso
--Variables para proceso normal
 ps_regrfc VARCHAR2(13);
 ps_recurp VARCHAR2(18);
 pi_valdf NUMBER(10);
 ps_keyconvia VARCHAR2(10);
 pi_keygdp NUMBER(10);
 ps_mensaje VARCHAR2(30);
 ps_keydep VARCHAR2(16);
 pi_keytco NUMBER(10);
 pi_keyfol NUMBER(10);
 pd_cosuni NUMBER(15,2);
 ps_keypue VARCHAR2(16);
--DEFINE pi_capitulo INTEGER;
 ps_tipinc VARCHAR2(2);

--Variables para proceso del detalle de los capitulos
 ps_capgra VARCHAR2(100);
 ps_caracter VARCHAR2(1);
 pi_numcap NUMBER(10);
 pi_inicial NUMBER(10);
 pi_final NUMBER(10);
 pi_capfin INTEGER;
 pi_capini INTEGER;
 pi_auxiliar NUMBER(10);
 pi_continuos NUMBER(10);
 pi_lencad NUMBER(10);

--VARIABLES PARA EL CALCULO DE MENORES DE EDAD
 Ld_MenorEdad NUMBER(10);
 Ls_Nacionalidad VARCHAR2(2);
 Li_CodigoAnda NUMBER(10);
 Ld_Anios NUMBER(10);
 Pd_FecGra DATE;
BEGIN


--Inicializacion de variables del proceso normal
ps_regrfc := '';
ps_recurp := '';
pi_valdf := 0;
ps_keyconvia := '';
pi_keygdp := 0;
ps_mensaje := '';
ps_keydep := '';
pi_keytco := 0;
pi_keyfol := 0;
pd_cosuni := 0;
ps_keypue := '';
ps_tipinc := '';

--Inicializacion de variables para proceso del detalle de los capitulos
ps_caracter := '';
pi_numcap := 0;
pi_inicial := 0;
pi_final := 0;
pi_auxiliar := 0;
pi_continuos := 0;
pi_lencad := 0;

--INICIALIZACION DE VARIABLES DEL CALCULO DE MENORES DE EDAD
Ld_MenorEdad := 0;
Ls_Nacionalidad := '';
Li_CodigoAnda := 0;
Ld_Anios := 0;
Pd_FecGra := TO_dATE('01/01/1900','DD/MM/YYYY');

---------------------------------------------------
-- INICIAN MODIFICACION JCRO PARA MENORES DE EDAD--
---------------------------------------------------

   -- -----------------------------------------------------
   -- Obtenemos los a?os considerados para el menor de edad
   -- -----------------------------------------------------
   BEGIN
       SELECT NVL(pam_folini,0)
         into Ld_MenorEdad
         FROM USRSIHO.GLCOPAMS
        WHERE pam_keypar = 'TEME';
        EXCEPTION WHEN no_data_found THEN Ld_MenorEdad := 0;
   END;

   -- -----------------------------------------------------
   -- Obtenemos la nacionalidad del empleado
   -- -----------------------------------------------------
   BEGIN
        SELECT emp_ca3aux
          INTO Ls_Nacionalidad
          FROM USRSIHO.NMCOEMPL
         WHERE emp_keyemp = pi_KeyEmp;
         EXCEPTION WHEN no_data_found THEN Ls_Nacionalidad := '';
    END;
   -- -----------------------------------------------------
   -- Obtenemos el codigo de la ANDA
   -- -----------------------------------------------------
   BEGIN
        SELECT to_number(pam_folini)
          INTO Li_CodigoAnda
          FROM USRSIHO.glcopams
         WHERE pam_keypar = 'ACP'
           AND pam_folfin = 'CODIGO ANDA';
        EXCEPTION WHEN no_data_found THEN Li_CodigoAnda := 0;
    END;

   -- -----------------------------------------------------
   -- Obtenemos la fecha de grabacion de la HT
   -- -----------------------------------------------------
   BEGIN
        SELECT enc_fecgra
          INTO Pd_FecGra
          FROM USRSIHO.holoenctra
        WHERE enc_num_id = pi_num_id;
        EXCEPTION WHEN no_data_found THEN Pd_FecGra := '';
    END;
   -- --------------------------------------------------------------------
   -- Calculamos la edad del empleado para determinar si es menor de edad
   -- --------------------------------------------------------------------
   IF ls_Nacionalidad = '02' THEN
        BEGIN
           SELECT to_number((Pd_FecGra - ale_fecnac)/365.25)
             INTO Ld_Anios
             FROM USRSIHO.HOLOALEM
            WHERE ale_keyemp = pi_KeyEmp;
            EXCEPTION WHEN no_data_found THEN Ld_Anios := 0;
        END;
   ELSE
       IF Li_CodigoAnda <> pi_KeyEmp THEN
               SELECT CASE WHEN to_number(substr(emp_regrfc,7,2)) > 0 AND to_number(substr(emp_regrfc,9,2)) > 0 AND to_number(substr(emp_regrfc,5,2)) >= 0 THEN
                        trunc( nvl(to_number((Pd_FecGra - TO_DATE(substr(emp_regrfc,7,2) || '/' || substr(emp_regrfc,9,2) || '/' || case when to_number(substr(emp_regrfc,5,2)) >= (extract(year from Pd_FecGra)-2000) then '19' else '20' end || substr(emp_regrfc,5,2)))/365.25),0) )
                   ELSE
                         99
                   END
              INTO Ld_Anios
              FROM USRSIHO.nmcoempl
             WHERE emp_keyemp = pi_KeyEmp;
       ELSE
            Ld_Anios := 99;
       END IF;
   END IF;

---------------------------------------------------
-- TERMINA MODIFICACION JCRO PARA MENORES DE EDAD--
---------------------------------------------------

BEGIN
	SELECT det_tipinc
	INTO ps_tipinc
	FROM USRSIHO.HOLODETTRA
	WHERE det_num_id = pi_num_id AND
		  det_serial = pi_serial;
	EXCEPTION WHEN no_data_found THEN ps_tipinc := '';
END;

--INSERT INTO BORRA VALUES(1,'ps_tipinc',0,ps_tipinc);
BEGIN
	SELECT count(*)
	INTO pi_valdf
	FROM USRSIHO.glcopams
	WHERE pam_keypar = 'CDF' AND
		  pam_cvesec <> 1 AND
		  TO_DATE(pam_folfin, 'DD/MM/YYYY') =
		  (SELECT enc_fecgra
			FROM USRSIHO.HOLOENCTRA
		  WHERE  enc_num_id = pi_num_id);
	EXCEPTION WHEN no_data_found THEN pi_valdf := 0;
END;


--INSERT INTO TMP_errores VALUES(0,pi_valdf,0,0,'pi_valdf','','');

--INSERT INTO BORRA VALUES(2,'pi_valdf',pi_valdf,'');

IF pi_valdf > 0 THEN
	BEGIN
		SELECT emp_regrfc,emp_recurp
		INTO ps_regrfc, ps_recurp
		FROM USRSIHO.NMCOEMPL
		WHERE emp_keyemp = pi_keyemp;
		EXCEPTION WHEN no_data_found THEN ps_regrfc := ''; ps_recurp := '';
	END;

		IF ps_tipinc = 'N' THEN--IG-CONS-0823
			BEGIN
			   SELECT pue_ca5aux
				 INTO ps_keyconvia
				 FROM USRSIHO.nmcopues
				WHERE pue_keypue =
								 (SELECT pam_cvesec
									FROM USRSIHO.glcopams
								   WHERE pam_keypar = 'AJEV' AND
										 pam_folini ='DF' AND
										 pam_folfin =
													(SELECT det_keypue
													   FROM USRSIHO.HOLODETTRA
													  WHERE det_num_id = pi_num_id AND
															det_serial = pi_serial
													)
								 );
				EXCEPTION WHEN no_data_found THEN ps_keyconvia := '';
			END;

			BEGIN
			   SELECT pam_cvesec
				 INTO ps_keypue
				 FROM USRSIHO.glcopams
				WHERE pam_keypar = 'AJEV' AND
					  pam_folini ='DF' AND
					  pam_folfin =
								(SELECT det_keypue
								   FROM USRSIHO.HOLODETTRA
								  WHERE det_num_id = pi_num_id AND
										det_serial = pi_serial
								);
				EXCEPTION WHEN no_data_found THEN ps_keypue := '';
			END;
		ELSE

			BEGIN
				SELECT pue_ca5aux
					 INTO ps_keyconvia
					 FROM USRSIHO.nmcopues
					WHERE pue_keypue =
									 (SELECT pam_cvesec
										FROM USRSIHO.glcopams
									   WHERE pam_keypar = 'AJEV' AND
											 pam_folini = ps_tipinc AND
											 pam_cvesec =
														(SELECT det_keypue
														   FROM USRSIHO.HOLODETTRA
														  WHERE det_num_id = pi_num_id AND
																det_serial = pi_serial
														)
									 );
				EXCEPTION WHEN no_data_found THEN ps_keyconvia := '';
			END;
				BEGIN
					SELECT pam_cvesec
					INTO ps_keypue
					FROM USRSIHO.glcopams
					WHERE pam_keypar = 'AJEV' AND
							pam_folini = ps_tipinc AND
							pam_cvesec =
								(SELECT det_keypue
								   FROM USRSIHO.HOLODETTRA
								  WHERE det_num_id = pi_num_id AND
										det_serial = pi_serial
								);
					EXCEPTION WHEN no_data_found THEN ps_keypue := '';
				END;
		END IF;--IG-CONS-0823 FIN


   SELECT det_keydep,det_keytco,det_keyfol,det_capfin,det_capgra
     INTO   ps_keydep,pi_keytco,pi_keyfol,pi_numcap,ps_capgra
     FROM USRSIHO.HOLODETTRA
    WHERE det_num_id = pi_num_id AND
          det_serial = pi_serial;

   IF ps_tipinc = 'N' THEN
      IF NVL(pi_keytco,0) > 0 THEN
         SELECT NVL(TAB.TAB_IMPORT,0)
           INTO pd_cosuni
           FROM USRSIHO.HOLOCONT CONT, USRSIHO.NMCOEMPL EMPL, USRSIHO.NMCOPUES PUES, USRSIHO.NMLOCONC CON,
                USRSIHO.HOLOTABS TAB, USRSIHO.HOLOFRPH, USRSIHO.NMLOALDE AL
          WHERE CONT.CON_KEYEMP = EMPL.EMP_KEYEMP
            AND CONT.CON_KEYPUE = PUES.PUE_KEYPUE
            AND CONT.CON_KEYDEP = AL.ALD_KEYDEP
            AND pue_nu1aux <> '2'
            AND AL.ALD_STATUS = 'A'
            AND CON.CON_KEYCON = PUES.PUE_CA5AUX
            AND TRIM(CONT.CON_KEYDEP) = ps_keydep
            AND CONT.CON_KEYTCO = pi_keytco
            AND CONT.CON_KEYFOL = pi_keyfol
            AND CONT.CON_KEYEMP = pi_keyemp
            AND TAB.TAB_KEYPRO =  pi_keypro
            AND TAB.TAB_KEYPUE = CONT.CON_KEYPUE
            AND TAB.TAB_PERTRA = CONT.CON_PERTRA
            AND TAB.TAB_IDIOMA = CONT.CON_IDIOMA
            AND TAB.TAB_KEYNAC = CONT.CON_KEYNAC
            AND TAB.TAB_KEYTAB = (CASE WHEN CONT.CON_KEYTCO = 519 THEN 3 ELSE CONT.CON_KEYTCO END - 1)
            AND FRP_KEYRPH = pi_rph
            AND TAB.TAB_FECINI <= FRP_FECTRAB
            AND NVL(TAB.TAB_FECFIN,FRP_FECTRAB) >= FRP_FECTRAB;
      ELSE
         pi_keytco := 0;
      END IF;
   ELSE
		BEGIN
			SELECT NVL(det_cosuni,0)
			INTO pd_cosuni
			FROM USRSIHO.HOLODETTRA
			WHERE det_num_id = pi_num_id AND
				  det_serial = pi_serial;
			EXCEPTION WHEN no_data_found THEN pd_cosuni := 0;
		END;
   END IF;

--   INSERT INTO TMP_errores VALUES(0,pd_cosuni,pi_capitulo,0,'pd_cosuni','pi_capitulo','');

   IF ps_tipinc = 'N' THEN
      IF pi_numcap > 1 THEN
        pi_inicial := 1;
        pi_final := 1;
        pi_capini := 1;
        pi_auxiliar := 1;
        pi_continuos := 1;
        pi_numcap := 1;
        pi_lencad := LENGTH(TRIM(ps_capgra));

IF PI_KEYEMP = 490212363 THEN
  pi_valdf := 1;
END IF;

        WHILE pi_final <= pi_lencad LOOP
              ps_caracter := SUBSTR(ps_capgra,pi_final,1);
            IF ps_caracter = ',' OR pi_final = pi_lencad THEN
               IF pi_lencad = pi_final THEN pi_auxiliar := pi_final + 1; ELSE pi_auxiliar := pi_final; END IF;
               IF pi_inicial = 1 THEN
                  pi_capini := to_number(SUBSTR(ps_capgra , pi_inicial , pi_auxiliar - pi_inicial));
                  pi_capfin := 0;
               ELSE
                  pi_capfin := pi_capini;
                  pi_capini := to_number(SUBSTR(ps_capgra , pi_inicial , pi_auxiliar - pi_inicial));
               END IF;
               INSERT INTO USRSIHO.TEMP_CAPITULOS VALUES(pi_capini); --Capitulo
               pi_inicial := pi_final + 1;
               pi_numcap := pi_numcap +1;
               IF pi_capfin > 0 THEN
                  IF pi_capfin + 1 <> pi_capini AND pi_continuos = 1 THEN
                     pi_continuos := 0;
                  END IF;
               END IF;
            END IF;
            pi_final := pi_final + 1;
         END LOOP;
      ELSE
           pi_capini := to_number(trim(ps_capgra));
         INSERT INTO USRSIHO.TEMP_CAPITULOS VALUES(pi_capini);
         pi_continuos := 1;
         pi_numcap := 2;
      END IF;

      pi_numcap := pi_numcap -1;

      IF pi_continuos = 1 THEN
         --Graba un solo registro por el n?mero de capitulos
         pi_capini := 0;
         pi_capfin := 0;

         FOR rec IN (SELECT capitulo
            FROM USRSIHO.TEMP_CAPITULOS
           ORDER BY 1) LOOP


            pi_auxiliar := rec.capitulo;
            IF pi_capini = 0 THEN
               pi_capini := pi_auxiliar;
               pi_capfin := pi_auxiliar;
            ELSE
               pi_capfin := pi_auxiliar;
            END IF;

         END LOOP;

--INSERT INTO BORRA VALUES(7,'pi_capini',pi_capini,'');
--INSERT INTO BORRA VALUES(8,'pi_capfin',pi_capfin,'');


         INSERT INTO USRSIHO.HOLOGDPR
         (gdp_keydep,gdp_keyrph,gdp_fechag,gdp_keyemp,gdp_regrfc,gdp_recurp,gdp_keypue,gdp_capini,gdp_capfin,
         gdp_numcap,gdp_keycon,gdp_marcon,gdp_marcos,gdp_cosuni,gdp_keysue,gdp_keytco,gdp_keyfol,gdp_keyusu,
         gdp_minleg,gdp_minsal,gdp_minext,gdp_mincom)

         SELECT det_keydep,pi_rph,pd_fechaact,NVL(det_keyemp,0),ps_regrfc,ps_recurp,ps_keypue,NVL(pi_capini,0),NVL(pi_capfin,0),
                pi_numcap,CASE WHEN Ld_Anios < Ld_MenorEdad THEN 'HTI' ELSE ps_keyconvia END,'X','X',CASE WHEN NVL(pd_cosuni,0) = 0 THEN det_cosuni ELSE NVL(pd_cosuni,0) END ,0,0,0,pi_keyusu,
                0,0,0,0
           FROM USRSIHO.HOLODETTRA, USRSIHO.HOLOENCTRA
          WHERE det_num_id = enc_num_id AND
                det_num_id = pi_num_id AND
                det_serial = pi_serial;

         INSERT INTO USRSIHO.HOLOGDPR
         (gdp_keydep,gdp_keyrph,gdp_fechag,gdp_keyemp,gdp_regrfc,gdp_recurp,gdp_keypue,gdp_capini,gdp_capfin,
         gdp_numcap,gdp_keycon,gdp_marcon,gdp_marcos,gdp_cosuni,gdp_keysue,gdp_keytco,gdp_keyfol,gdp_keyusu,
         gdp_minleg,gdp_minsal,gdp_minext,gdp_mincom)

--- aedo 05/04/2011 se agrego la liga de numero de empleado
         SELECT det_keydep,pi_rph,pd_fechaact,NVL(det_keyemp,0),ps_regrfc,ps_recurp,ps_keypue,NVL(pi_capini,0),NVL(pi_capfin,0),
                pi_numcap,CASE WHEN Ld_Anios < Ld_MenorEdad THEN 'HTI' ELSE ps_keyconvia END,'X','X',CASE WHEN NVL(pd_cosuni,0) = 0 THEN det_cosuni ELSE NVL(pd_cosuni,0) END ,0,0,0,pi_keyusu,
                0,0,0,0
           FROM USRSIHO.HOLODETTRA, USRSIHO.HOLOCONT
          WHERE det_keyfol = con_keyfol AND
                det_keyemp = con_keyemp  AND
                det_num_id = pi_num_id AND
                det_serial = pi_serial;
      ELSE
         --Graba un registro por cada capitulo en la tabla temporal
         FOR rec2 IN (SELECT capitulo
            FROM USRSIHO.TEMP_CAPITULOS
           ORDER BY 1) LOOP


            pi_auxiliar := rec2.capitulo;
            pi_capini := pi_auxiliar;
            pi_capfin := pi_auxiliar;

            INSERT INTO USRSIHO.HOLOGDPR
            (gdp_keydep,gdp_keyrph,gdp_fechag,gdp_keyemp,gdp_regrfc,gdp_recurp,gdp_keypue,gdp_capini,gdp_capfin,
            gdp_numcap,gdp_keycon,gdp_marcon,gdp_marcos,gdp_cosuni,gdp_keysue,gdp_keytco,gdp_keyfol,gdp_keyusu,
            gdp_minleg,gdp_minsal,gdp_minext,gdp_mincom)

            SELECT det_keydep,pi_rph,pd_fechaact,NVL(det_keyemp,0),ps_regrfc,ps_recurp,ps_keypue,NVL(pi_capini,0),NVL(pi_capfin,0),
                   1,CASE WHEN Ld_Anios < Ld_MenorEdad THEN 'HTI' ELSE ps_keyconvia END,'X','X',CASE WHEN NVL(pd_cosuni,0) = 0 THEN det_cosuni ELSE NVL(pd_cosuni,0) END ,0,0,0,pi_keyusu,
                   0,0,0,0
              FROM USRSIHO.HOLODETTRA, USRSIHO.HOLOENCTRA
             WHERE det_num_id = enc_num_id AND
                   det_num_id = pi_num_id AND
                   det_serial = pi_serial;

            INSERT INTO HOLOGDPR
            (gdp_keydep,gdp_keyrph,gdp_fechag,gdp_keyemp,gdp_regrfc,gdp_recurp,gdp_keypue,gdp_capini,gdp_capfin,
            gdp_numcap,gdp_keycon,gdp_marcon,gdp_marcos,gdp_cosuni,gdp_keysue,gdp_keytco,gdp_keyfol,gdp_keyusu,
            gdp_minleg,gdp_minsal,gdp_minext,gdp_mincom)

--- aedo 05/04/2011 se agrego la liga de numero de empleado
            SELECT det_keydep,pi_rph,pd_fechaact,NVL(det_keyemp,0),ps_regrfc,ps_recurp,ps_keypue,NVL(pi_capini,0),NVL(pi_capfin,0),
                   1,CASE WHEN Ld_Anios < Ld_MenorEdad THEN 'HTI' ELSE ps_keyconvia END,'X','X',CASE WHEN NVL(pd_cosuni,0) = 0 THEN det_cosuni ELSE NVL(pd_cosuni,0) END ,0,0,0,pi_keyusu,
                   0,0,0,0
              FROM USRSIHO.HOLODETTRA, USRSIHO.HOLOCONT
             WHERE det_keyfol = con_keyfol AND
                   det_keyemp = con_keyemp AND
                   det_num_id = pi_num_id AND
                   det_serial = pi_serial;

         END LOOP;
      END IF;
   END IF;
END IF;
--DROP TABLE TEMP_CAPITULOS;

END;
/
