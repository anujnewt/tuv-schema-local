CREATE OR REPLACE EDITIONABLE PROCEDURE "USRSIHO"."SP_HOLOTRARPH" (pd_fechapag DATE, pd_fechaact DATE, pi_keyusu NUMBER,
  ps_fechapagdf VARCHAR2,
  ps_ide_pcc VARCHAR2, ps_num_enc NUMBER,
  ps_typefolio VARCHAR2, ps_keyare NUMBER,
  li_secrph OUT NUMBER, ps_mensaje OUT VARCHAR2, ps_sindkto OUT VARCHAR2)
 IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
--DEFINE ps_noforo VARCHAR2(20);            --Foro/Locacion
 ps_gcxxii VARCHAR2(1);               --Clausula XXII
 ps_keydep VARCHAR2(16);              --Centro de costos
 --ps_sindkto VARCHAR2(15);             --Sindicato (ANDA, SITATYR, CONDUCTOR ART, ANDA PENSIONADA)
 ps_regrfc VARCHAR2(13);              --RFC del empleado
 ps_recurp VARCHAR2(18);              --CURP del empleado
 ps_tipinc VARCHAR2(2);               --Tipo de incidencia (N-Normal, JV-Jornada de viaje, etc)
 ps_viaticos VARCHAR2(20);            --Campo con el detalle de los viaticos (Desayuno, Comida, Cena, etc)
 pi_num_id NUMBER(10);pi_serial NUMBER(10);pi_keyemp NUMBER(10);pi_nomina NUMBER(10);
 pd_totcos NUMBER(16,4); --Total del costo del RPH
 pi_totemp NUMBER(18,2); --Total de empleado
 pd_fecgra DATE;                  --Fecha de grabacion
 pi_pasaje NUMBER(5); pi_vialoc NUMBER(5); pi_desayu NUMBER(5); pi_comida NUMBER(5); pi_cena NUMBER(5); pi_auxdcc NUMBER(5);
 pi_corcom NUMBER(5); pi_corcen NUMBER(5); ps_descvia VARCHAR2(20);                --Descripcion de viatico
 ps_keyconvia VARCHAR2(20);           --Clave del concepto segun el viatico
 i NUMBER(5);                      --Contador
 pd_costvia NUMBER(16,4);        --Costo del viatico
 pi_valconcep NUMBER(10);            --Validacion del concepto
--DEFINE pi_keycap INTEGER;             --Capitulo para el RPH de la clausala XXII
 pi_hraent NUMBER(10);               --Hora de entrada
 pi_hrasal NUMBER(10);               --Hora de salida
 pi_mincom NUMBER(10);               --Minutos de comida
 pi_keypro NUMBER(5);              --Clave del proceso
--DEFINE pi_numcap INTEGER;             --Numero de capitulos de la incidencia
 ps_capgra VARCHAR2(60);              --Detalle de los capitilos grabados
 pi_keygdp NUMBER(10);               --Llave del detalle del RPH (Tabla: HOLOGDPR)
 pi_keyfol NUMBER(10);               --Numero de contrato
--Variables para crear los capitulos cuando no son consecutivos
 pi_lencad NUMBER(10);               --Longitud de la cadena
 ps_caracter VARCHAR2(1);             --Caracter evaluado dentro de la cadena
 pi_inicial NUMBER(10);              --Posicion Inicial de la cadena
 pi_final NUMBER(10);                --Posicion final de la cadena
 pi_auxiliar NUMBER(10);             --Variable auxialiar para los calculos de la longitud de la cadena a cortar
 pi_capini NUMBER(10);               --Capitulo inicial a comparar
 pi_capfin NUMBER(10);               --Capitulo segundo a comparar
 pi_continuos NUMBER(5);           --Variable que determina si los capitulos son continuos o no
 pi_numcap NUMBER(5);              --Numero consecutivo de capitulo para agregarlo a la tabla temporal
 pi_valdiafest NUMBER(5);      --Valida si se calculara la incidencia por concepto de dia festivo
--IG-CONS-0823
 pi_keytco NUMBER(10);
 TYPE NumList IS TABLE OF NUMBER;
BEGIN --Substituye a tipo ps_sindkto
--LET ps_noforo = '';
ps_gcxxii := NULL;
ps_keydep := NULL;
ps_sindkto := NULL;
ps_regrfc := NULL;
ps_recurp := NULL;
ps_tipinc := NULL;
ps_viaticos := NULL;
pi_num_id := 0;
pi_totemp := 0;
li_secrph := 0;
pi_serial := 0;
pi_keyemp := 0;
pi_nomina := 0;
pd_totcos := 0;
pd_fecgra := pd_fechaact;
pi_pasaje := 0;
pi_vialoc := 0;
pi_desayu := 0;
pi_comida := 0;
pi_cena := 0;
pi_corcom := 0;
pi_corcen := 0;
pi_auxdcc := 0;
ps_descvia := NULL;
ps_keyconvia := NULL;
i := 0;
pd_costvia := 0;
pi_valconcep := 0;
pi_hraent := 0;
pi_hrasal := 0;
pi_mincom := 0;
pi_keypro := 0;
ps_capgra := NULL;
pi_keygdp := 0;
pi_keyfol := 0;
pi_valdiafest := 0;
--Variables para crear los capitulos cuando no son consecutivos
pi_lencad := 0;
ps_caracter := NULL;
pi_inicial := 0;
pi_final := 0;
pi_auxiliar := 0;
pi_capini := 0;
pi_capfin := 0;
pi_continuos := 0;
pi_numcap := 0;
ps_mensaje := NULL;
 --DBMS_OUTPUT.put_line('inicio store');
-- Se agrega condicion del num folio para realizar proceso por registro CAR 02-Dic-09
FOR rec IN (SELECT DISTINCT enc_num_id,enc_keydep,det_sindkto,enc_gcxxii, det_keytco
        FROM USRSIHO.HOLOENCTRA,USRSIHO.HOLODETTRA
        WHERE enc_num_id = det_num_id AND
              enc_stsrep = '2' AND
              det_stsreg = 'V' AND
              det_stspag = 'P' AND
              det_keytco IN (2,3,519) AND
              enc_fecpag = pd_fechapag AND
              enc_num_id NOT IN
                                (SELECT enc_num_id
                                 FROM USRSIHO.HOLOENCTRA,USRSIHO.HOLODETTRA,USRSIHO.HOLOCONT
                                 WHERE enc_num_id = det_num_id AND
                                       det_keyfol = con_keyfol AND
                                       det_keyemp = con_keyemp AND
                                       det_stspag = 'P' AND
                                       det_stsreg = 'V' AND
                                       enc_stsrep = '2' AND
                                       det_keytco IN (2,3,519) AND
--                                       det_sindkto IN ('ANDA','SITATYR','CONDUCTOR ART','ANDA PENSIONADA') AND --JCRO 10/Agosto/2011 CONS-0530 Se cambio por el campo det_keytco
                                       enc_fecpag = pd_fechapag AND
                                       --((det_tipinc = 'N') AND
                                       (det_tipinc = 'N' AND
                                       --(con_stspag <> 'V' OR
                                          (TRIM(det_hraent) = '' OR
                                          TRIM(det_hrasal) = '' OR
                                          det_capfin IS NULL OR
                                          TRIM(det_capgra) = ''))
                                )
              AND enc_num_id = ps_num_enc
        ORDER BY enc_num_id,enc_keydep,det_sindkto,enc_gcxxii) LOOP
        pi_num_id := rec.enc_num_id;
        ps_keydep := rec.enc_keydep;
        ps_sindkto := rec.det_sindkto;
        ps_gcxxii := rec.enc_gcxxii;
        pi_keytco := rec.det_keytco;
        pd_totcos := 0;
        pi_totemp := 0;
        INSERT INTO USRSIHO.TMP_HJATRAB VALUES(pi_num_id);
        BEGIN
            SELECT enc_fecgra,enc_keypro
            INTO pd_fecgra, pi_keypro
            FROM USRSIHO.HOLOENCTRA
            WHERE enc_num_id = pi_num_id;
            EXCEPTION WHEN no_data_found THEN pd_fecgra := ''; pi_keypro := 0;
        END;
        --  ----------------------------------------------------------------------------------------
        --  Dependiendo del sindicato es como graba el RPH
        --  ----------------------------------------------------------------------------------------
        --IG-CONS-0823
        --Comentado para validacion por llave
        --IF ps_sindkto = 'ANDA' OR ps_sindkto ='ANDA PENSIONADA' THEN
        --IG-CONS-0823
        --Substituye para validacion por llave
        IF pi_keytco = 2 THEN
           IF ps_sindkto = 'ANDA' THEN
              pi_nomina := 110;
           ELSE
              pi_nomina := 210;
           END IF;
           --  ----------------------------------------------------------------------------------------------
           --  Consulta para generar los diferentes tipos de RPH con el tipo de sindicato ANDA
           --  ----------------------------------------------------------------------------------------------
                   --  -------------------------------
                   --  Inserta el encabezado del RPH
                   --  -------------------------------}
                   -- Se asigna variable ps_typefolio en uno de los campos a insertar CAR 02-Dic-09
                   INSERT INTO USRSIHO.HOLOFRPH
                   (frp_keydep,frp_keyper,frp_fecact,frp_stsfol,frp_totcos,frp_keyusu,frp_keynom,
                   frp_repeti,frp_tiptra,frp_fecsol,frp_fecitr,frp_fectrab,frp_forpag,frp_tipcam,
                   frp_pertra,frp_tipfol,frp_totemp,frp_keypro,frp_unifor,frp_transp,frp_ident,frp_keyare)
                   SELECT enc_keydep,'0',pd_fechaact,'0',pd_totcos,pi_keyusu,pi_nomina,
                   'N','G',pd_fechapag,enc_fecgra,enc_fecgra,1,1.0000,
                   1,ps_typefolio,pi_totemp,enc_keypro,0,0,CASE WHEN enc_gcxxii = 'N' THEN 'P' ELSE 'S' END,ps_keyare
                   FROM USRSIHO.HOLOENCTRA
                   WHERE enc_num_id = pi_num_id;
                   -- ---------------------------------
                   -- Lectura del secuencial del RPH
                   -- ---------------------------------
                   SELECT HOLOFRPH_seq.currval INTO li_secrph FROM dual;
                   INSERT INTO USRSIHO.glwkcrys(cry_nomrep,cry_idepcc,cry_keyusu,cry_numsec,cry_chr001) VALUES('holotrarp2',ps_ide_pcc,pi_keyusu,li_secrph,'RPH ACTUAL');
                   --  ----------------------------------------------------------------------------------------------
                   --  Consulta para insertar cada una de las insidencias de la hoja de trabajo (FOREACH DEL DETALLE)
                   --  ----------------------------------------------------------------------------------------------
                   FOR rec2 IN (SELECT det_serial,det_keyemp,det_num_id,det_auxca2,det_tipinc
                           FROM USRSIHO.HOLOENCTRA,USRSIHO.HOLODETTRA,USRSIHO.HOLOCONT
                           WHERE enc_num_id = det_num_id AND
                                 det_keyfol = con_keyfol AND
                                 det_keyemp = con_keyemp AND
                                 det_stspag = 'P' AND
                                 det_stsreg = 'V' AND
                                 enc_stsrep = '2' AND
                                 enc_fecpag = pd_fechapag AND
                                 enc_keydep = ps_keydep AND
                                 det_sindkto = ps_sindkto AND
                                 det_keyemp > 0 AND
                                 det_keyfol > 0 AND
                                 enc_num_id = pi_num_id
                           UNION
                           SELECT det_serial,det_keyemp,det_num_id,det_auxca2,det_tipinc
                           FROM USRSIHO.HOLOENCTRA,USRSIHO.HOLODETTRA
                           WHERE enc_num_id = det_num_id AND
                                 det_stspag = 'P' AND
                                 det_stsreg = 'V' AND
                                 enc_stsrep = '2' AND
                                 enc_fecpag = pd_fechapag AND
                                 enc_keydep = ps_keydep AND
                                 det_sindkto = ps_sindkto AND
                                 det_keyemp > 0 AND
                                 enc_num_id = pi_num_id
                           ORDER BY 1) LOOP
                           pi_serial := rec2.det_serial;
                           pi_keyemp := rec2.det_keyemp;
                           pi_num_id := rec2.det_num_id;
                           ps_viaticos := rec2.det_auxca2;
                           ps_tipinc := rec2.det_tipinc;
                           pi_valconcep := 0;
                           -- -------------------------------------------------
                           -- Consulta para obtener el RFC y CURP del empleado
                           -- -------------------------------------------------
                           BEGIN
                           SELECT emp_regrfc,emp_recurp
                             INTO ps_regrfc, ps_recurp
                             FROM USRSIHO.NMCOEMPL
                            WHERE emp_keyemp = pi_keyemp;
                            EXCEPTION WHEN no_data_found THEN ps_regrfc := ''; ps_recurp := '';
                           END;
                           BEGIN
                               SELECT to_number(substr(det_auxca2,1,1)),to_number(substr(det_auxca2,2,1)),to_number(substr(det_auxca2,3,1)),to_number(substr(det_auxca2,4,1)),to_number(substr(det_auxca2,5,1)),to_number(substr(det_auxca2,9,1)),to_number(substr(det_auxca2,10,1)),to_number(substr(det_auxca2,8,1))
                               INTO pi_pasaje, pi_vialoc, pi_desayu, pi_comida, pi_cena ,pi_corcom, pi_corcen, pi_valdiafest
                               FROM USRSIHO.HOLODETTRA
                               WHERE det_num_id = pi_num_id AND
                                     det_serial = pi_serial;
                               EXCEPTION WHEN no_data_found THEN pi_pasaje := 0; pi_vialoc := 0; pi_desayu := 0; pi_comida := 0; pi_cena := 0; pi_corcom := 0; pi_corcen := 0; pi_valdiafest := 0;
                           END;
                           -- --------------------------------------------------------------------------------------------------------
                           --Si es una incidencia normal y tiene marcados viaticos (Pasaje, Viaticos Locacion, Desayuno, Comida, Cena)
                           -- --------------------------------------------------------------------------------------------------------
                           IF ( ps_tipinc = 'N' or ps_tipinc = 'JV' or ps_tipinc = 'JE'  ) AND (pi_pasaje+pi_vialoc+pi_desayu+pi_comida+pi_cena) > 0 THEN --IG-CONS-0823 Substituye
                              i := 1;
                              WHILE i <= 5 LOOP
                                 ps_descvia := CASE WHEN i = 1 THEN 'PASAJES'
                                                       WHEN i = 2 THEN 'VIATICOS LOCACION'
                                                       WHEN i = 3 THEN 'DESAYUNO'
                                                       WHEN i = 4 THEN 'COMIDA'
                                                       WHEN i = 5 THEN 'CENA'
                                                       ELSE ''
                                                  END;
                                 pi_auxdcc := CASE WHEN i = 1 THEN pi_pasaje
                                                      WHEN i = 2 THEN pi_vialoc
                                                      WHEN i = 3 THEN pi_desayu
                                                      WHEN i = 4 THEN pi_comida
                                                      WHEN i = 5 THEN pi_cena
                                                      ELSE 0
                                                 END;
                                 IF pi_auxdcc > 0 THEN
                                    -- -------------------------------------------------------
                                    --Ingresa un registro por cada concepto de viatico marcado
                                    -- -------------------------------------------------------
                                    -- ------------------------------
                                    --Obtenemos la clave del concepto
                                    -- ------------------------------
                                    BEGIN
                                        SELECT pue_ca5aux
                                        INTO ps_keyconvia
                                        FROM USRSIHO.nmcopues
                                        WHERE pue_keypue =
                                                         (SELECT pam_cvesec
                                                          FROM USRSIHO.glcopams
                                                          WHERE pam_keypar = 'AJEV' AND
                                                                pam_folini ='GM' AND
                                                                pam_nompar = ps_descvia
                                                         );
                                        EXCEPTION WHEN no_data_found THEN ps_keyconvia := '';
                                    END;
                                    ps_keyconvia := TRIM(ps_keyconvia) || TRIM(ps_descvia);
                                    -- -----------------------------
                                    --Obtenemos el costo del viatico
                                    -- -----------------------------
                                    BEGIN
                                        SELECT to_number(pam_folini)
                                        INTO pd_costvia
                                        FROM USRSIHO.glcopams
                                        WHERE pam_keypar = 'ACP' AND
                                              pam_nompar = ps_descvia;
                                        EXCEPTION WHEN no_data_found THEN pd_costvia := 0;
                                    END;
                                    -- ------------------------------------
                                    -- Inserta el detalle del RPH (Viatico)
                                    -- ------------------------------------
                                    USRSIHO.sp_holoaltinc(pi_keyemp,1,li_secrph,pd_fechaact,ps_keyconvia,pd_costvia,pi_keyusu,pi_num_id,pi_serial,pi_keypro,1,1,0,0,0,0,0);
                                 END IF;
                                 i := i + 1;
                                 pi_auxdcc := 0;
                              END LOOP;
                           END IF;
                           pi_pasaje := 0;
                           pi_vialoc := 0;
                           pi_desayu := 0;
                           pi_comida := 0;
                           pi_cena := 0;
                           pi_auxdcc := 0;
                           -- ------------------------------------------------
                           -- Inserta el detalle del RPH (Viatico Dia Festivo)
                           -- ------------------------------------------------
                            IF pi_valdiafest > 0 THEN
                                USRSIHO.sp_holotrarph_df(li_secrph,pd_fechaact,pd_fechapag,pi_keyemp,pi_num_id,pi_serial,pi_keyusu,ps_fechapagdf,pi_keypro);
                                pi_valdiafest := 0;
                            END IF;
                           -- -----------------------------------------------
                           -- Obtiene el numero de capitulos de la incidencia
                           -- -----------------------------------------------
                           BEGIN
                               SELECT NVL(det_capfin,0), det_capgra, det_keyfol
                                 INTO pi_numcap, ps_capgra, pi_keyfol
                                 FROM USRSIHO.HOLODETTRA
                                WHERE det_num_id = pi_num_id AND
                                     det_serial = pi_serial;
                               EXCEPTION WHEN no_data_found THEN pi_numcap := 0; ps_capgra := ''; pi_keyfol := '';
                           END;
                           IF ((ps_tipinc = 'N'  AND pi_valdiafest = 0) OR ps_tipinc = 'LI') THEN --Comentada 'IG-CONS-0823'
                              IF pi_numcap > 1 THEN
                                 pi_inicial := 1;
                                 pi_final := 1;
                                 pi_capini := 1;
                                 pi_auxiliar := 1;
                                 pi_continuos := 1;
                                 pi_numcap := 1;
                                 pi_lencad := LENGTH(TRIM(ps_capgra));
                                 WHILE pi_final <= pi_lencad LOOP
                                    ps_caracter := SUBSTR(ps_capgra , pi_final , 1);
                                    IF ps_caracter = ',' OR pi_final = pi_lencad THEN
                                       IF pi_lencad = pi_final THEN pi_auxiliar := pi_final + 1; ELSE pi_auxiliar := pi_final; END IF;
                                       IF pi_inicial = 1 THEN
                                          pi_capini := to_number(SUBSTR(ps_capgra , pi_inicial , pi_auxiliar - pi_inicial));
                                          pi_capfin := 0;
                                       ELSE
                                          pi_capfin := pi_capini;
                                          pi_capini := to_number(SUBSTR(ps_capgra , pi_inicial , pi_auxiliar - pi_inicial));
                                       END IF;
                                       INSERT INTO USRSIHO.TMP_HOLOGDPR VALUES(pi_numcap,pi_capini);
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
                                 IF pi_continuos = 1 THEN
                                    -- ------------------------------------------------------------------------
                                    -- Inserta el detalle del RPH con el rango de todos los capitulos continuos
                                    -- ------------------------------------------------------------------------
                                    BEGIN
                                        SELECT MIN(capitulo), MAX(capitulo)
                                        INTO pi_capini, pi_capfin
                                        FROM USRSIHO.TMP_HOLOGDPR;
                                        EXCEPTION WHEN no_data_found THEN pi_capini := 0; pi_capfin := 0;
                                    END;
                                    IF ps_tipinc <> 'N' THEN
                                       pi_hraent := 0;
                                       pi_hrasal := 0;
                                       pi_mincom := 0;
                                    ELSE
                                        BEGIN
                                           SELECT to_number(SUBSTR(det_hraent , 1 , 2)) * 60 + to_number(SUBSTR(det_hraent , 4 , 2)),to_number(SUBSTR(det_hrasal , 1 , 2)) * 60 + to_number(SUBSTR(det_hrasal , 4 , 2)),
                                                  CASE WHEN to_number(substr(det_auxca2,9,1)) = 1 AND to_number(substr(det_auxca2,10,1)) = 1 THEN to_number(to_number(NVL(substr(holoenctra.enc_salcom,1,2),0)) * 60 + to_number(NVL(substr(holoenctra.enc_salcom,4,2),0))) - to_number(to_number(NVL(substr(holoenctra.enc_entcom,1,2),0)) * 60 + to_number(NVL(substr(holoenctra.enc_entcom,4,2),0)))
                                                       WHEN to_number(substr(det_auxca2,9,1)) = 1 AND to_number(substr(det_auxca2,10,1)) = 0 THEN to_number(to_number(NVL(substr(holoenctra.enc_salcom,1,2),0)) * 60 + to_number(NVL(substr(holoenctra.enc_salcom,4,2),0))) - to_number(to_number(NVL(substr(holoenctra.enc_entcom,1,2),0)) * 60 + to_number(NVL(substr(holoenctra.enc_entcom,4,2),0)))
                                                       WHEN to_number(substr(det_auxca2,9,1)) = 0 AND to_number(substr(det_auxca2,10,1)) = 1 THEN 30
                                                       WHEN to_number(substr(det_auxca2,9,1)) = 0 AND to_number(substr(det_auxca2,10,1)) = 0 THEN 0
                                                       ELSE 0
                                                  END
                                           INTO pi_hraent, pi_hrasal, pi_mincom
                                           FROM USRSIHO.HOLOENCTRA, USRSIHO.HOLODETTRA
                                           WHERE enc_num_id = det_num_id AND
                                                 det_num_id = pi_num_id AND
                                                 det_serial = pi_serial;
                                            EXCEPTION WHEN no_data_found THEN pi_hraent := 0; pi_hrasal := 0; pi_mincom := 0;
                                        END;
                                    END IF;
                                    -- ---------------------
                                    -- Graba las incidencias
                                    -- ---------------------
                                     USRSIHO.sp_holoaltinc(pi_keyemp,2,li_secrph,pd_fechaact,ps_keyconvia,pd_costvia,pi_keyusu,pi_num_id,pi_serial,pi_keypro,pi_capini,pi_capfin,pi_hraent,pi_hrasal,pi_mincom,0,0);
                                 ELSE
                                    BEGIN
                                        SELECT MIN(keycapitulo),MAX(keycapitulo)
                                        INTO pi_inicial,pi_final
                                        FROM USRSIHO.TMP_HOLOGDPR;
                                        EXCEPTION WHEN no_data_found THEN pi_inicial := 0; pi_final :=0;
                                    END;
                                    WHILE pi_inicial <= pi_final LOOP
                                        BEGIN
                                           SELECT capitulo
                                           INTO pi_capini
                                           FROM USRSIHO.TMP_HOLOGDPR
                                           WHERE keycapitulo = pi_inicial;
                                           EXCEPTION WHEN no_data_found THEN pi_capini := 0;
                                         END;
                                       IF ps_tipinc <> 'N' THEN
                                          pi_hraent := 0;
                                          pi_hrasal := 0;
                                          pi_mincom := 0;
                                       ELSE
                                            BEGIN
                                                  SELECT to_number(SUBSTR(det_hraent , 1 , 2)) * 60 + to_number(SUBSTR(det_hraent , 4 , 2)),to_number(SUBSTR(det_hrasal , 1 , 2)) * 60 + to_number(SUBSTR(det_hrasal , 4 , 2)),
                                                         CASE WHEN to_number(substr(det_auxca2,9,1)) = 1 AND to_number(substr(det_auxca2,10,1)) = 1 THEN to_number(to_number(NVL(substr(holoenctra.enc_salcom,1,2),0)) * 60 + to_number(NVL(substr(holoenctra.enc_salcom,4,2),0))) - to_number(to_number(NVL(substr(holoenctra.enc_entcom,1,2),0)) * 60 + to_number(NVL(substr(holoenctra.enc_entcom,4,2),0)))
                                                              WHEN to_number(substr(det_auxca2,9,1)) = 1 AND to_number(substr(det_auxca2,10,1)) = 0 THEN to_number(to_number(NVL(substr(holoenctra.enc_salcom,1,2),0)) * 60 + to_number(NVL(substr(holoenctra.enc_salcom,4,2),0))) - to_number(to_number(NVL(substr(holoenctra.enc_entcom,1,2),0)) * 60 + to_number(NVL(substr(holoenctra.enc_entcom,4,2),0)))
                                                              WHEN to_number(substr(det_auxca2,9,1)) = 0 AND to_number(substr(det_auxca2,10,1)) = 1 THEN 30
                                                              WHEN to_number(substr(det_auxca2,9,1)) = 0 AND to_number(substr(det_auxca2,10,1)) = 0 THEN 0
                                                              ELSE 0
                                                         END
                                                  INTO pi_hraent,pi_hrasal,pi_mincom
                                                  FROM USRSIHO.HOLOENCTRA, USRSIHO.HOLODETTRA
                                                  WHERE enc_num_id = det_num_id AND
                                                        det_num_id = pi_num_id AND
                                                        det_serial = pi_serial;
                                                  EXCEPTION WHEN no_data_found THEN pi_hraent := 0; pi_hrasal := 0; pi_mincom := 0;
                                             END;
                                       END IF;
                                       -- ---------------------
                                       -- Graba las incidencias
                                       -- ---------------------
                                        USRSIHO.sp_holoaltinc(pi_keyemp,2,li_secrph,pd_fechaact,ps_keyconvia,pd_costvia,pi_keyusu,pi_num_id,pi_serial,pi_keypro,pi_capini,pi_capini,pi_hraent,pi_hrasal,pi_mincom,pi_inicial,0);
                                       pi_inicial := pi_inicial + 1;
                                    END LOOP;
                                    DELETE FROM USRSIHO.TMP_HOLOGDPR;
                                 END IF;
                              ELSE
                                 -- -----------------------------------------------------
                                 -- Inserta el detalle del RPH cuando solo es un capitulo
                                 -- -----------------------------------------------------
                                 IF ps_tipinc <> 'N' THEN
                                    pi_hraent := 0;
                                    pi_hrasal := 0;
                                    pi_mincom := 0;
                                    BEGIN
                                        SELECT to_number(det_capgra)
                                        INTO pi_capini
                                        FROM USRSIHO.HOLODETTRA
                                        WHERE det_num_id = pi_num_id AND
                                              det_serial = pi_serial;
                                        EXCEPTION WHEN no_data_found THEN pi_capini := 0;
                                    END;
                                 ELSE
                                    BEGIN
                                        SELECT to_number(SUBSTR(det_hraent , 1 , 2)) * 60 + to_number(SUBSTR(det_hraent , 4 , 2)),to_number(SUBSTR(det_hrasal , 1 , 2)) * 60 + to_number(SUBSTR(det_hrasal , 4 , 2)),
                                               CASE WHEN to_number(substr(det_auxca2,9,1)) = 1 AND to_number(substr(det_auxca2,10,1)) = 1 THEN to_number(to_number(NVL(substr(holoenctra.enc_salcom,1,2),0)) * 60 + to_number(NVL(substr(holoenctra.enc_salcom,4,2),0))) - to_number(to_number(NVL(substr(holoenctra.enc_entcom,1,2),0)) * 60 + to_number(NVL(substr(holoenctra.enc_entcom,4,2),0)))
                                                    WHEN to_number(substr(det_auxca2,9,1)) = 1 AND to_number(substr(det_auxca2,10,1)) = 0 THEN to_number(to_number(NVL(substr(holoenctra.enc_salcom,1,2),0)) * 60 + to_number(NVL(substr(holoenctra.enc_salcom,4,2),0))) - to_number(to_number(NVL(substr(holoenctra.enc_entcom,1,2),0)) * 60 + to_number(NVL(substr(holoenctra.enc_entcom,4,2),0)))
                                                    WHEN to_number(substr(det_auxca2,9,1)) = 0 AND to_number(substr(det_auxca2,10,1)) = 1 THEN 30
                                                    WHEN to_number(substr(det_auxca2,9,1)) = 0 AND to_number(substr(det_auxca2,10,1)) = 0 THEN 0
                                                    ELSE 0
                                               END,to_number(det_capgra)
                                        INTO pi_hraent, pi_hrasal, pi_mincom, pi_capini
                                        FROM USRSIHO.HOLOENCTRA, USRSIHO.HOLODETTRA
                                        WHERE enc_num_id = det_num_id AND
                                              det_num_id = pi_num_id AND
                                              det_serial = pi_serial;
                                        EXCEPTION WHEN no_data_found THEN pi_hraent := 0; pi_hrasal := 0; pi_mincom := 0; pi_capini :=0;
                                    END;
                                 END IF;
                                 -- ---------------------
                                 -- Graba las incidencias
                                 -- ---------------------
                                  USRSIHO.sp_holoaltinc(pi_keyemp,2,li_secrph,pd_fechaact,ps_keyconvia,pd_costvia,pi_keyusu,pi_num_id,pi_serial,pi_keypro,pi_capini,pi_capini,pi_hraent,pi_hrasal,pi_mincom,ps_capgra,1);
                              END IF;
                           ELSE
                              -- ------------------------------------------------------------------
                              -- Inserta el detalle del RPH cuando la inidencia es diferente de 'N'
                              -- ------------------------------------------------------------------
                               USRSIHO.sp_holoaltinc(pi_keyemp,3,li_secrph,pd_fechaact,ps_keyconvia,pd_costvia,pi_keyusu,pi_num_id,pi_serial,pi_keypro,pi_capini,pi_capini,pi_hraent,pi_hrasal,pi_mincom,ps_capgra,0);
                           END IF;
                           UPDATE USRSIHO.HOLODETTRA
                           SET det_stspag = 'T',
                               det_keyrph = li_secrph
                           WHERE det_num_id = pi_num_id AND
                                 det_serial = pi_serial;
                           COMMIT;
                   END LOOP;
                   --  ----------------------------------------------------------------------------------
                   --  Calcula el total del costo de la hoja de trabajo y la suma del numero de empleado
                   --  ----------------------------------------------------------------------------------
                   BEGIN
                       SELECT SUM(gdp_numcap * gdp_cosuni), SUM(gdp_keyemp)
                         INTO pd_totcos, pi_totemp
                         FROM USRSIHO.HOLOGDPR
                        WHERE gdp_keyrph = li_secrph;
                        EXCEPTION WHEN no_data_found THEN pd_totcos := 0; pi_totemp := 0;
                    END;
                   UPDATE USRSIHO.HOLOFRPH
                   SET frp_totcos = pd_totcos,
                   frp_totemp = pi_totemp
                   WHERE frp_keyrph = li_secrph;
           --END FOREACH
        ELSE
           --IG-CONS-0823
           --Comentado para validacion por llave
           --IF ps_sindkto = 'SITATYR' THEN
           --IG-CONS-0823
           --Substituye para validacion por llave
           IF pi_keytco = 3 THEN
                    --LET pi_nomina = 106;
                    BEGIN
                        SELECT  CASE WHEN emp_tipemp = 'I' AND ale_keyem2 IS NOT NULL THEN 102 ELSE 106 END
                        INTO    pi_nomina
                        FROM    USRSIHO.holodettra, USRSIHO.nmcoempl, USRSIHO.holoalem
                        WHERE   det_num_id = pi_num_id
                                      AND emp_keyemp = det_keyemp
                                      AND ale_keyemp = emp_keyemp
                        AND det_serial = (SELECT MIN(det_serial) FROM holodettra WHERE det_num_id = pi_num_id );
                        EXCEPTION WHEN no_data_found THEN pi_nomina := 0;
                    END;
           ELSE
                    --LET pi_nomina = 104;
                    BEGIN
                        SELECT  CASE WHEN emp_tipemp = 'I' AND ale_keyem2 IS NOT NULL THEN 102 ELSE 104 END
                        INTO    pi_nomina
                        FROM    USRSIHO.holodettra, USRSIHO.nmcoempl, USRSIHO.holoalem
                        WHERE   det_num_id = pi_num_id
                                      AND emp_keyemp = det_keyemp
                                      AND ale_keyemp = emp_keyemp
                        AND det_serial = (SELECT MIN(det_serial) FROM USRSIHO.holodettra WHERE det_num_id = pi_num_id );
                        EXCEPTION WHEN no_data_found THEN pi_nomina := 0;
                    END;
           END IF;
--INSERT INTO TMP_errores VALUES(0,0,0,0,'OTRO SINDICATO','',ps_sindkto);
           --  -------------------------------
           --  Inserta el encabezado del RPH
           --  -------------------------------
--INSERT INTO TMP_errores VALUES(0,0,0,0,'INSERTA ENCABEZADO','','');
                                         -- Se asigna variable ps_typefolio en uno de los campos a insertar CAR 02-Dic-09
   -- DBMS_OUTPUT.put_line(pi_num_id);
           INSERT INTO USRSIHO.HOLOFRPH
           (frp_keydep,frp_keyper,frp_fecact,frp_stsfol,frp_totcos,frp_keyusu,frp_keynom,
           frp_repeti,frp_tiptra,frp_fecsol,frp_fecitr,frp_fectrab,frp_forpag,frp_tipcam,
           frp_pertra,frp_tipfol,frp_totemp,frp_keypro,frp_unifor,frp_transp,frp_ident,frp_keyare)
           SELECT enc_keydep,'0',pd_fechaact,'0',pd_totcos,pi_keyusu,pi_nomina,
           'N','G',pd_fechapag,enc_fecgra,enc_fecgra,1,1.0000,
           1,ps_typefolio,pi_totemp,enc_keypro,0,0,'P',ps_keyare
           FROM USRSIHO.HOLOENCTRA
           WHERE enc_num_id = pi_num_id;
           -- ---------------------------------
           -- Lectura del secuencial del RPH
           -- ---------------------------------
           SELECT HOLOFRPH_seq.currval INTO li_secrph FROM dual;
           INSERT INTO USRSIHO.glwkcrys(cry_nomrep,cry_idepcc,cry_keyusu,cry_numsec,cry_chr001) VALUES('holotrarp2',ps_ide_pcc,pi_keyusu,li_secrph,'RPH ACTUAL');
           --  ----------------------------------------------------------------------------------------------
           --  Consulta para insertar cada una de las insidencias de la hoja de trabajo (FOREACH DEL DETALLE)
           --  ----------------------------------------------------------------------------------------------
           FOR rec3 IN (SELECT det_serial,det_keyemp,det_auxca2,det_tipinc
                   FROM USRSIHO.HOLOENCTRA,USRSIHO.HOLODETTRA,USRSIHO.HOLOCONT
                   WHERE enc_num_id = det_num_id AND
                         det_keyfol = con_keyfol AND
                         det_keyemp = con_keyemp AND
                         det_stspag = 'P' AND
                         det_stsreg = 'V' AND
                         enc_stsrep = '2' AND
                         enc_fecpag = pd_fechapag AND
                         enc_keydep = ps_keydep AND
                         det_sindkto = ps_sindkto AND
                         det_keyemp > 0 AND
                         det_keyfol > 0 AND
                         enc_num_id = pi_num_id
                   UNION ALL
                   SELECT det_serial,det_keyemp,det_auxca2,det_tipinc
                   FROM USRSIHO.HOLOENCTRA,USRSIHO.HOLODETTRA
                   WHERE enc_num_id = det_num_id AND
                         det_stspag = 'P' AND
                         det_stsreg = 'V' AND
                         enc_stsrep = '2' AND
                         enc_fecpag = pd_fechapag AND
                         enc_keydep = ps_keydep AND
                         det_sindkto = ps_sindkto AND
                         det_keyemp > 0 AND
                         enc_num_id = pi_num_id AND
                         det_keyfol IS NULL AND
                         det_tipinc <> 'N'
                   ORDER BY 1) LOOP
                   -- -------------------------------------------------
                   -- Consulta para obtener el RFC y CURP del empleado
                   -- -------------------------------------------------
                   pi_serial := rec3.det_serial;
                   pi_keyemp := rec3.det_keyemp;
                   ps_viaticos := rec3.det_auxca2;
                   ps_tipinc := rec3.det_tipinc;
                   SELECT emp_regrfc,emp_recurp
                   INTO   ps_regrfc,ps_recurp
                   FROM USRSIHO.NMCOEMPL
                   WHERE emp_keyemp = pi_keyemp;
                   BEGIN
                       SELECT to_number(substr(det_auxca2,1,1)),to_number(substr(det_auxca2,2,1)),to_number(substr(det_auxca2,3,1)),to_number(substr(det_auxca2,4,1)),to_number(substr(det_auxca2,5,1)),to_number(substr(det_auxca2,9,1)),to_number(substr(det_auxca2,10,1)),to_number(substr(det_auxca2,8,1))
                       INTO pi_pasaje, pi_vialoc, pi_desayu, pi_comida, pi_cena, pi_corcom, pi_corcen, pi_valdiafest
                       FROM USRSIHO.HOLODETTRA
                       WHERE det_num_id = pi_num_id AND
                             det_serial = pi_serial;
                       EXCEPTION WHEN no_data_found THEN pi_pasaje := 0; pi_vialoc := 0; pi_desayu := 0;
                                                         pi_comida := 0; pi_cena := 0; pi_corcom := 0; pi_corcen := 0; pi_valdiafest :=0;
                   END;
                   -- --------------------------------------------------------------------------------------------------------
                   --Si es una incidencia normal y tiene marcados viaticos (Pasaje, Viaticos Locacion, Desayuno, Comida, Cena)
                   -- --------------------------------------------------------------------------------------------------------
                   --IF ps_tipinc = 'N' AND (pi_pasaje+pi_vialoc+pi_desayu+pi_comida+pi_cena) > 0 THEN 'IG-CONS-0823 Comentado'
                   IF (ps_tipinc = 'N' OR ps_tipinc='JV' OR ps_tipinc='JE') AND (pi_pasaje+pi_vialoc+pi_desayu+pi_comida+pi_cena) > 0 THEN --IG-CONS-0823 Substituye
                      -- -------------------------------------------------------
                      --i = 1 Pasajes, i = 2 Viaticos Locacion, i = 3  Desayuno,
                      --i = 4 Comida,  i = 5 Cena
                      -- -------------------------------------------------------
                      i := 1;
                      WHILE i <= 5 LOOP
                         ps_descvia := CASE WHEN i = 1 THEN 'PASAJES'
                                               WHEN i = 2 THEN 'VIATICOS LOCACION'
                                               WHEN i = 3 THEN 'DESAYUNO'
                                               WHEN i = 4 THEN 'COMIDA'
                                               WHEN i = 5 THEN 'CENA'
                                               ELSE ''
                                          END;
                         pi_auxdcc := CASE WHEN i = 1 THEN pi_pasaje
                                              WHEN i = 2 THEN pi_vialoc
                                              WHEN i = 3 THEN pi_desayu
                                              WHEN i = 4 THEN pi_comida
                                              WHEN i = 5 THEN pi_cena
                                              ELSE 0
                                         END;
                         IF pi_auxdcc > 0 THEN
                         -- -------------------------------------------------------
                         --Ingresa un registro por cada concepto de viatico marcado
                         -- -------------------------------------------------------
                            -- ------------------------------
                            --Obtenemos la clave del concepto
                            -- ------------------------------
                            BEGIN
                                SELECT pue_ca5aux
                                INTO ps_keyconvia
                                FROM USRSIHO.nmcopues
                                WHERE pue_keypue =
                                                 (SELECT pam_cvesec
                                                  FROM USRSIHO.glcopams
                                                  WHERE pam_keypar = 'AJEV' AND
                                                        pam_folini ='GM' AND
                                                        pam_nompar = ps_descvia
                                                                   --(SELECT det_keypue
                                                                   -- FROM HOLODETTRA
                                                                   -- WHERE det_num_id = pi_num_id AND
                                                                   --       det_serial = pi_serial
                                                                   --)
                                                 );
                                EXCEPTION WHEN no_data_found THEN ps_keyconvia := '';
                            END;
                            -- -----------------------------
                            --Obtenemos el costo del viatico
                            -- -----------------------------
                            BEGIN
                                SELECT to_number(pam_folini)
                                INTO pd_costvia
                                FROM USRSIHO.glcopams
                                WHERE pam_keypar = 'ACP' AND
                                      pam_nompar = ps_descvia;
                                ps_keyconvia := TRIM(ps_keyconvia) || TRIM(ps_descvia);
                                EXCEPTION WHEN no_data_found THEN pd_costvia := 0;
                            END;
                              -- ------------------------------------
                              -- Inserta el detalle del RPH (Viatico)
                              -- ------------------------------------
--INSERT INTO TMP_errores VALUES(0,0,0,0,'INSERTA VIATICOS <> ANDA','','');
--INSERT INTO TMP_errores VALUES(0,pi_keyemp,li_secrph,pd_costvia,'pi_keyemp','li_secrph','pd_costvia');
--INSERT INTO TMP_errores VALUES(0,pi_keyusu,pi_num_id,pi_serial,'pi_keyusu','pi_num_id','pi_serial');
--INSERT INTO TMP_errores VALUES(0,pi_keypro,0,0,'pi_keypro','ps_keyconvia','');
                               sp_holoaltinc(pi_keyemp,1,li_secrph,pd_fechaact,ps_keyconvia,pd_costvia,pi_keyusu,pi_num_id,pi_serial,pi_keypro,1,1,0,0,0,0,0);
                         END IF;
                         i := i + 1;
                         pi_auxdcc := 0;
                      END LOOP;
                   END IF;
                   pi_pasaje := 0;
                   pi_vialoc := 0;
                   pi_desayu := 0;
                   pi_comida := 0;
                   pi_cena := 0;
                   pi_auxdcc := 0;
                   -- ------------------------------------------------
                   -- Inserta el detalle del RPH (Viatico Dia Festivo)
                   -- ------------------------------------------------
                   IF pi_valdiafest > 0 THEN
IF PI_KEYEMP = 490212363 THEN
  PI_KEYEMP := 490212363;
END IF;
                       USRSIHO.sp_holotrarph_df(li_secrph,pd_fechaact,pd_fechapag,pi_keyemp,pi_num_id,pi_serial,pi_keyusu,ps_fechapagdf,pi_keypro);
                      pi_valdiafest := 0;
                   END IF;
                   -- -----------------------------------------------
                   -- Obtiene el numero de capitulos de la incidencia
                   -- -----------------------------------------------
                   BEGIN
                       SELECT NVL(det_capfin,0),det_capgra,det_keyfol
                       INTO pi_numcap, ps_capgra, pi_keyfol
                       FROM USRSIHO.HOLODETTRA
                       WHERE det_num_id = pi_num_id AND
                             det_serial = pi_serial;
                       EXCEPTION WHEN no_data_found THEN pi_numcap := 0; ps_capgra := ''; pi_keyfol := 0;
                   END;
--                   IF (ps_tipinc = 'N' OR ps_tipinc = 'LI') THEN --Condicion inhabilitada
                   --IF ((ps_tipinc = 'N' AND pi_valdiafest = 0) OR ps_tipinc = 'LI') THEN 'IG-CONS-0823 Comentada'
                   IF (((ps_tipinc = 'N' ) AND pi_valdiafest = 0) OR ps_tipinc = 'LI') THEN --IG-CONS-0823 Substituye
                      IF pi_numcap > 1 THEN
--INSERT INTO TMP_errores VALUES(0,pi_numcap,0,0,'NUM CAP > 1 NO ANDA',ps_tipinc,'');
                         pi_inicial := 1;
                         pi_final := 1;
                         pi_capini := 1;
                         pi_auxiliar := 1;
                         pi_continuos := 1;
                         pi_numcap := 1;
                         pi_lencad := LENGTH(TRIM(ps_capgra));
                         WHILE pi_final <= pi_lencad LOOP
                            ps_caracter := SUBSTR(ps_capgra , pi_final , 1);
                            IF (ps_caracter = ',') OR (pi_final = pi_lencad ) THEN
                               IF pi_lencad = pi_final THEN pi_auxiliar := pi_final + 1; ELSE pi_auxiliar := pi_final; END IF;
                               IF pi_inicial = 1 THEN
                                  pi_capini := to_number(SUBSTR(ps_capgra , pi_inicial , pi_auxiliar - pi_inicial));
                                  pi_capfin := 0;
                               ELSE
                                  pi_capfin := pi_capini;
                                  pi_capini := to_number(SUBSTR(ps_capgra , pi_inicial , pi_auxiliar - pi_inicial));
                               END IF;
                               INSERT INTO USRSIHO.TMP_HOLOGDPR VALUES(pi_numcap,pi_capini);
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
--INSERT INTO TMP_errores VALUES(0,pi_continuos,pi_numcap,pi_capini,'pi_continuos','pi_numcap','pi_capini');
                         IF pi_continuos = 1 THEN
                            -- ------------------------------------------------------------------------
                            -- Inserta el detalle del RPH con el rango de todos los capitulos continuos
                            -- ------------------------------------------------------------------------
--INSERT INTO TMP_errores VALUES(0,0,0,0,'SI ES CONTINUO','','');
                            SELECT MIN(capitulo),MAX(capitulo)
                            INTO pi_capini,pi_capfin
                            FROM USRSIHO.TMP_HOLOGDPR;
                            IF ps_tipinc <> 'N' THEN
                               pi_hraent := 0;
                               pi_hrasal := 0;
                               pi_mincom := 0;
                            ELSE
                                BEGIN
                                    SELECT to_number(SUBSTR(det_hraent , 1 , 2)) * 60 + to_number(SUBSTR(det_hraent , 4 , 2)),to_number(SUBSTR(det_hrasal , 1 , 2)) * 60 + to_number(SUBSTR(det_hrasal , 4 , 2)),
                                          CASE WHEN to_number(substr(det_auxca2,9,1)) = 1 AND to_number(substr(det_auxca2,10,1)) = 1 THEN to_number(to_number(NVL(substr(holoenctra.enc_salcom,1,2),0)) * 60 + to_number(NVL(substr(holoenctra.enc_salcom,4,2),0))) - to_number(to_number(NVL(substr(holoenctra.enc_entcom,1,2),0)) * 60 + to_number(NVL(substr(holoenctra.enc_entcom,4,2),0)))
                                               WHEN to_number(substr(det_auxca2,9,1)) = 1 AND to_number(substr(det_auxca2,10,1)) = 0 THEN to_number(to_number(NVL(substr(holoenctra.enc_salcom,1,2),0)) * 60 + to_number(NVL(substr(holoenctra.enc_salcom,4,2),0))) - to_number(to_number(NVL(substr(holoenctra.enc_entcom,1,2),0)) * 60 + to_number(NVL(substr(holoenctra.enc_entcom,4,2),0)))
                                               WHEN to_number(substr(det_auxca2,9,1)) = 0 AND to_number(substr(det_auxca2,10,1)) = 1 THEN 30
                                               WHEN to_number(substr(det_auxca2,9,1)) = 0 AND to_number(substr(det_auxca2,10,1)) = 0 THEN 0
                                               ELSE 0
                                          END
                                   INTO pi_hraent,pi_hrasal,pi_mincom
                                   FROM USRSIHO.HOLOENCTRA, USRSIHO.HOLODETTRA
                                   WHERE enc_num_id = det_num_id AND
                                         det_num_id = pi_num_id AND
                                         det_serial = pi_serial;
                                   EXCEPTION WHEN no_data_found THEN pi_hraent := 0; pi_hrasal := 0; pi_mincom := 0;
                               END;
                            END IF;
                           -- ---------------------
                           -- Graba las incidencias
                           -- ---------------------
                            sp_holoaltinc(pi_keyemp,2,li_secrph,pd_fechaact,ps_keyconvia,pd_costvia,pi_keyusu,pi_num_id,pi_serial,pi_keypro,pi_capini,pi_capfin,pi_hraent,pi_hrasal,pi_mincom,0,0);
                         ELSE
                            SELECT MIN(keycapitulo), MAX(keycapitulo)
                            INTO pi_inicial,  pi_final
                            FROM USRSIHO.TMP_HOLOGDPR;
                            WHILE pi_inicial <= pi_final LOOP
                                BEGIN
                                    SELECT capitulo
                                    INTO pi_capini
                                    FROM USRSIHO.TMP_HOLOGDPR
                                    WHERE keycapitulo = pi_inicial;
                                    EXCEPTION WHEN no_data_found THEN pi_capini := 0;
                                END;
                               IF ps_tipinc <> 'N' THEN
                                  pi_hraent := 0;
                                  pi_hrasal := 0;
                                  pi_mincom := 0;
                               ELSE
                                    BEGIN
                                          SELECT to_number(SUBSTR(det_hraent , 1 , 2)) * 60 + to_number(SUBSTR(det_hraent , 4 , 2)),to_number(SUBSTR(det_hrasal , 1 , 2)) * 60 + to_number(SUBSTR(det_hrasal , 4 , 2)),
                                                 CASE WHEN to_number(substr(det_auxca2,9,1)) = 1 AND to_number(substr(det_auxca2,10,1)) = 1 THEN to_number(to_number(NVL(substr(holoenctra.enc_salcom,1,2),0)) * 60 + to_number(NVL(substr(holoenctra.enc_salcom,4,2),0))) - to_number(to_number(NVL(substr(holoenctra.enc_entcom,1,2),0)) * 60 + to_number(NVL(substr(holoenctra.enc_entcom,4,2),0)))
                                                      WHEN to_number(substr(det_auxca2,9,1)) = 1 AND to_number(substr(det_auxca2,10,1)) = 0 THEN to_number(to_number(NVL(substr(holoenctra.enc_salcom,1,2),0)) * 60 + to_number(NVL(substr(holoenctra.enc_salcom,4,2),0))) - to_number(to_number(NVL(substr(holoenctra.enc_entcom,1,2),0)) * 60 + to_number(NVL(substr(holoenctra.enc_entcom,4,2),0)))
                                                      WHEN to_number(substr(det_auxca2,9,1)) = 0 AND to_number(substr(det_auxca2,10,1)) = 1 THEN 30
                                                      WHEN to_number(substr(det_auxca2,9,1)) = 0 AND to_number(substr(det_auxca2,10,1)) = 0 THEN 0
                                                      ELSE 0
                                                 END
                                          INTO pi_hraent, pi_hrasal, pi_mincom
                                          FROM USRSIHO.HOLOENCTRA, USRSIHO.HOLODETTRA
                                          WHERE enc_num_id = det_num_id AND
                                                det_num_id = pi_num_id AND
                                                det_serial = pi_serial;
                                          EXCEPTION WHEN no_data_found THEN pi_hraent := 0; pi_hrasal := 0; pi_mincom := 0;
                                    END;
                               END IF;
                               -- ---------------------
                               -- Graba las incidencias
                               -- ---------------------
--INSERT INTO TMP_errores VALUES(0,0,0,0,'INSERT INCID <> ANDA UNO X UNO','','');
                                USRSIHO.sp_holoaltinc(pi_keyemp,2,li_secrph,pd_fechaact,ps_keyconvia,pd_costvia,pi_keyusu,pi_num_id,pi_serial,pi_keypro,pi_capini,pi_capini,pi_hraent,pi_hrasal,pi_mincom,pi_inicial,0);
                               pi_inicial := pi_inicial + 1;
                            END LOOP;
                            DELETE FROM USRSIHO.TMP_HOLOGDPR;
                         END IF;
                      ELSE
                         -- -----------------------------------------------------
                         -- Inserta el detalle del RPH cuando solo es un capitulo
                         -- -----------------------------------------------------
                         IF ps_tipinc <> 'N' THEN
                            pi_hraent := 0;
                            pi_hrasal := 0;
                            pi_mincom := 0;
                            BEGIN
                                SELECT to_number(det_capgra)
                                INTO pi_capini
                                FROM USRSIHO.HOLODETTRA
                                WHERE det_num_id = pi_num_id AND
                                      det_serial = pi_serial;
                                EXCEPTION WHEN no_data_found THEN pi_capini := 0;
                            END;
                         ELSE
                            BEGIN
                                SELECT to_number(SUBSTR(det_hraent , 1 , 2)) * 60 + to_number(SUBSTR(det_hraent , 4 , 2)),to_number(SUBSTR(det_hrasal , 1 , 2)) * 60 + to_number(SUBSTR(det_hrasal , 4 , 2)),
                                       CASE WHEN to_number(substr(det_auxca2,9,1)) = 1 AND to_number(substr(det_auxca2,10,1)) = 1 THEN to_number(to_number(NVL(substr(holoenctra.enc_salcom,1,2),0)) * 60 + to_number(NVL(substr(holoenctra.enc_salcom,4,2),0))) - to_number(to_number(NVL(substr(holoenctra.enc_entcom,1,2),0)) * 60 + to_number(NVL(substr(holoenctra.enc_entcom,4,2),0)))
                                            WHEN to_number(substr(det_auxca2,9,1)) = 1 AND to_number(substr(det_auxca2,10,1)) = 0 THEN to_number(to_number(NVL(substr(holoenctra.enc_salcom,1,2),0)) * 60 + to_number(NVL(substr(holoenctra.enc_salcom,4,2),0))) - to_number(to_number(NVL(substr(holoenctra.enc_entcom,1,2),0)) * 60 + to_number(NVL(substr(holoenctra.enc_entcom,4,2),0)))
                                            WHEN to_number(substr(det_auxca2,9,1)) = 0 AND to_number(substr(det_auxca2,10,1)) = 1 THEN 30
                                            WHEN to_number(substr(det_auxca2,9,1)) = 0 AND to_number(substr(det_auxca2,10,1)) = 0 THEN 0
                                            ELSE 0
                                       END,to_number(det_capgra)
                                INTO pi_hraent,pi_hrasal,pi_mincom,pi_capini
                                FROM USRSIHO.HOLOENCTRA, USRSIHO.HOLODETTRA
                                WHERE enc_num_id = det_num_id AND
                                      det_num_id = pi_num_id AND
                                      det_serial = pi_serial;
                                EXCEPTION WHEN no_data_found THEN pi_hraent := 0; pi_hrasal := 0; pi_mincom := 0; pi_capini :=0;
                            END;
                         END IF;
                         -- ---------------------
                         -- Graba las incidencias
                         -- ---------------------
--INSERT INTO TMP_errores VALUES(0,0,0,0,'INSERT INCID <> ANDA 1 SOLO CAP','','');
                          USRSIHO.sp_holoaltinc(pi_keyemp,2,li_secrph,pd_fechaact,ps_keyconvia,pd_costvia,pi_keyusu,pi_num_id,pi_serial,pi_keypro,pi_capini,pi_capini,pi_hraent,pi_hrasal,pi_mincom,ps_capgra,1);
                      END IF;
                   ELSE
                      -- ------------------------------------------------------------------
                      -- Inserta el detalle del RPH cuando la inidencia es diferente de 'N'
                      -- ------------------------------------------------------------------
--INSERT INTO TMP_errores VALUES(0,0,0,0,'INSERTA INCID <> ANDA <> N','','');
                       USRSIHO.sp_holoaltinc(pi_keyemp,3,li_secrph,pd_fechaact,ps_keyconvia,pd_costvia,pi_keyusu,pi_num_id,pi_serial,pi_keypro,pi_capini,pi_capini,pi_hraent,pi_hrasal,pi_mincom,ps_capgra,0);
                   END IF;
                   UPDATE USRSIHO.HOLODETTRA
                   SET det_stspag = 'T',
                       det_keyrph = li_secrph
                   WHERE det_num_id = pi_num_id AND
                         det_serial = pi_serial;
           END LOOP;
        END IF;
        --  ----------------------------------------------------------------------------------
        --  Calcula el total del costo de la hoja de trabajo y la suma del numero de empleado
        --  ----------------------------------------------------------------------------------
        BEGIN
            SELECT SUM(gdp_numcap * gdp_cosuni), SUM(gdp_keyemp)
              INTO pd_totcos, pi_totemp
              FROM USRSIHO.HOLOGDPR
             WHERE gdp_keyrph = li_secrph;
             EXCEPTION WHEN no_data_found THEN pd_totcos := 0; pi_totemp := 0;
        END;
        UPDATE USRSIHO.HOLOFRPH
        SET frp_totcos = pd_totcos,
            frp_totemp = pi_totemp
        WHERE frp_keyrph = li_secrph;
END LOOP;
--  -------------------------------------------------------
--  Actualiza el estatus de las hojas de trabajo procesadas
--  -------------------------------------------------------
UPDATE USRSIHO.HOLOENCTRA
SET enc_stsrep = '3'
WHERE enc_num_id IN (SELECT hja_num_id FROM TMP_HJATRAB);
--  ----------------------------------------------------------------------------
--  Ingresa a la tabla temporal las hojas de trabajo que tienen inconcistencias
--  ----------------------------------------------------------------------------
DELETE FROM USRSIHO.TMP_HOLOGDPR;
INSERT INTO USRSIHO.TMP_HOLOGDPR
SELECT DISTINCT 1,enc_num_id
FROM USRSIHO.HOLOENCTRA,USRSIHO.HOLODETTRA,USRSIHO.HOLOCONT
WHERE enc_num_id = det_num_id AND
      det_keyfol = con_keyfol AND
      det_keyemp = con_keyemp AND
      det_stspag = 'P' AND
      det_stsreg = 'V' AND
      enc_stsrep = '2' AND
      det_sindkto IN ('ANDA','SITATYR','CONDUCTOR ART') AND
      enc_fecpag = pd_fechapag AND
      --((det_tipinc = 'N') AND
       (det_tipinc = 'N' AND
      --(con_stspag <> 'V' OR
       (TRIM(det_hraent) = '' OR
       TRIM(det_hrasal) = '' OR
       det_capfin IS NULL OR
       TRIM(det_capgra) = ''));
--  ----------------------------------------------------------------------------
--  Actualiza el estatus de las hojas de trabajo que tienen inconcistencias.
--  Nota: Se utilizo la tabla temporal para poder hacer la actualizacion general
--        ya que no permite actualizar por medio de un subquery
--  ----------------------------------------------------------------------------
UPDATE USRSIHO.HOLOENCTRA
SET enc_stsrep = '5'
WHERE enc_num_id IN (SELECT capitulo FROM USRSIHO.TMP_HOLOGDPR);
--DROP TABLE TMP_HOLOGDPR;
--DROP TABLE TMP_HJATRAB;
--DROP TABLE TMP_errores;
--DROP TABLE TMP_erroresdate;
END;
/
