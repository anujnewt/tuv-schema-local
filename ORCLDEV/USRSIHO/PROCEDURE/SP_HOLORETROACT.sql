CREATE OR REPLACE EDITIONABLE PROCEDURE "USRSIHO"."SP_HOLORETROACT" (ps_idepcc VARCHAR2,pi_keyusu NUMBER, pd_fechapag DATE, pd_fechagen DATE,
                pd_comidaGM NUMBER, pd_cenaGM NUMBER, pd_desayunoGM NUMBER,
                pd_pasajesGM NUMBER, pd_viaticoslocGM NUMBER,pn_numgen out number)
IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
-- -----------------------------------------------------------------
-- CREO:                                COMENTARIO:                                                             FECHA:
-- Juan Carlos Reyes Olivera            Este stored procedure se utiliza para realizar una copia de la          29 de Junio de 2011
--                                      hoja de trabajo original calculando el porcentaje del
--                                      retroactivo en la hoja destino.
--
-- MODIFICO:                            COMENTARIO:                                                             FECHA:
-- Juan Carlos Reyes Olivera            Se agrego condicion en los campos de sindicato y tipo de sindicato      16 de Marzo del 2012
--                                      para corregir error de origen a la hora de copiar los registros.
--
-- Juan Carlos Reyes Olivera            Se cambio la condicion de solo copiar unos datos del campo det_auxca2   16 de Marzo del 2012
--                                      para copiar identicamente el registro. (Solicito Jose Maria Dolores Cuellar)
-- -----------------------------------------------------------------
 li_ht NUMBER(10);
 li_secht NUMBER(10);
 ld_ptje_retro NUMBER(5,2);
 ls_cadena VARCHAR2(50);
 ps_caracter VARCHAR2(2);
 pi_inicial NUMBER(10);
 pi_final NUMBER(10);
 pi_nomina NUMBER(10);
 pi_auxiliar NUMBER(10);
 pi_lencad NUMBER(10);
BEGIN
li_ht := 0;
li_secht := 0;
ld_ptje_retro := 0;
pi_inicial := 1;
pi_final := 1;
pi_nomina := 1;
pi_auxiliar := 1;
pi_lencad := 0;
pn_numgen := 0;
DELETE
  FROM USRSIHO.glwkcrys
 WHERE cry_nomrep = 'retronomin'
   AND cry_idepcc = ps_idepcc
   AND cry_keyusu = pi_keyusu;
BEGIN
    SELECT pam_folini
      INTO ls_cadena
      FROM USRSIHO.GLCOPAMS
     WHERE pam_keypar in (SELECT pam_folini
                            FROM USRSIHO.glcopams
                           WHERE pam_keypar='00'
                             AND pam_cvesec='loretr')
       AND pam_nompar = 'NOMINAS';
    EXCEPTION WHEN no_data_found THEN ls_cadena := '';
END;
pi_lencad := LENGTH(TRIM(ls_cadena));
WHILE pi_final <= pi_lencad LOOP
        ps_caracter := SUBSTR(ls_cadena , pi_final , 1);
        IF ps_caracter = ',' OR pi_final = pi_lencad THEN
                IF pi_lencad = pi_final THEN pi_auxiliar := pi_final + 1; ELSE pi_auxiliar := pi_final; END IF;
                IF pi_inicial = 1 THEN
                        pi_nomina := to_number(SUBSTR(ls_cadena , pi_inicial , pi_auxiliar - pi_inicial));
                ELSE
                        pi_nomina := to_number(SUBSTR(ls_cadena , pi_inicial , pi_auxiliar - pi_inicial));
                END IF;
                INSERT INTO USRSIHO.glwkcrys (cry_nomrep,cry_idepcc,cry_keyusu,cry_numsec)
                VALUES ('retronomin',ps_idepcc,pi_keyusu,pi_nomina);
                pi_inicial := pi_final + 1;
        END IF;
        pi_final := pi_final + 1;
END LOOP;
BEGIN
    SELECT NVL(pam_folini,0)
      INTO ld_ptje_retro
      FROM USRSIHO.GLCOPAMS
     WHERE pam_keypar in (SELECT pam_folini
                            FROM USRSIHO.glcopams
                           WHERE pam_keypar='00'
                             AND pam_cvesec='loretr')
       AND pam_cvesec = 'OPCI01';
    EXCEPTION WHEN no_data_found THEN ld_ptje_retro := 0;
END;
FOR rec IN (SELECT cry_numsec
          FROM USRSIHO.GLWKCRYS
         WHERE cry_nomrep = 'GENRETRO' AND
               cry_idepcc = ps_idepcc AND
               cry_keyusu = pi_keyusu
         ORDER BY cry_numsec) LOOP
      li_ht := rec.cry_numsec;
      INSERT INTO USRSIHO.TMP_HOLOENCTRA (
              enc_keydep, enc_fecgra, enc_fecpag, enc_keytpr, enc_nomprd, enc_feccap, enc_horcom,
              enc_keypro, enc_usuori, enc_stsrep, enc_feclib, enc_horlib, enc_gcxxii, enc_entcom,
              enc_salcom, enc_auxnu1, enc_auxca1, enc_desscc, enc_numlla, enc_conlla, enc_descap
              )
       SELECT enc_keydep, enc_fecgra, pd_fechapag, enc_keytpr, enc_nomprd, enc_feccap, enc_horcom,
              enc_keypro, pi_keyusu , 2          , enc_feclib, enc_horlib, enc_gcxxii, enc_entcom,
              enc_salcom, enc_auxnu1, enc_auxca1, enc_desscc, enc_numlla, enc_conlla, 'RETROACTIVO DE LA HOJA ' || li_ht
         FROM HOLOENCTRA
        WHERE enc_num_id = li_ht;
      INSERT INTO HOLOENCTRA (
              enc_keydep, enc_fecgra, enc_fecpag, enc_keytpr, enc_nomprd, enc_feccap, enc_horcom,
              enc_keypro, enc_usuori, enc_stsrep, enc_feclib, enc_horlib, enc_gcxxii, enc_entcom,
              enc_salcom, enc_auxnu1, enc_auxca1, enc_desscc, enc_numlla, enc_conlla, enc_descap
              )
       SELECT enc_keydep, enc_fecgra, enc_fecpag, enc_keytpr, enc_nomprd, enc_feccap, enc_horcom,
              enc_keypro, enc_usuori, enc_stsrep, enc_feclib, enc_horlib, enc_gcxxii, enc_entcom,
              enc_salcom, enc_auxnu1, enc_auxca1, enc_desscc, enc_numlla, enc_conlla, enc_descap
         FROM TMP_HOLOENCTRA;
      -- --------------------------------------------
      -- Lectura del secuencial de la Hoja de Trabajo
      -- --------------------------------------------
      SELECT USRSIHO.HOLOENCTRA_seq.currval INTO li_secht FROM dual;
      DELETE FROM USRSIHO.TMP_HOLOENCTRA;
      INSERT INTO USRSIHO.TMP_HOLODETTRA (
             det_num_id, det_keydep, det_fecgra, det_keytco, det_sindkto, det_keyfol, det_keyemp,
             det_nomcor, det_person, det_keypue, det_keycon, det_noforo, det_hralla, det_hraent,
             det_hrasal, det_hrstra, det_capgra, det_stsreg, det_stspag, det_keyaut, det_inanda,
             det_ultact, det_fecpag, det_keyrph, det_keynom, det_cdilla, det_capini, det_capfin,
             det_auxnu1, det_auxnu2, det_auxca1, det_auxca2, det_usuori, det_fecori, det_usufin,
             det_fecfin, det_tipinc, det_cosuni, det_numlla
             )
-- JCRO 16/03/2012    SELECT li_secht  , det_keydep, det_fecgra, det_keytco, det_sindkto, det_keyfol, det_keyemp,
      SELECT li_secht  , det_keydep, det_fecgra, CASE WHEN (det_keytco IS NULL OR det_keytco = 0) AND TRIM(det_sindkto) = 'ANDA' OR TRIM(DET_SINDKTO) = 'ANDA PENSIONADA' THEN 2
                                                      WHEN (det_keytco IS NULL OR det_keytco = 0) AND TRIM(DET_SINDKTO) = 'SITATYR' THEN 3
                                                      WHEN (det_keytco IS NULL OR det_keytco = 0) AND TRIM(DET_SINDKTO) = 'CONDUCTOR ART' OR TRIM(DET_SINDKTO) = 'CONDUCTORES' THEN 519
                                                      ELSE det_keytco
                                                 END, CASE WHEN (det_sindkto IS NULL OR TRIM(det_sindkto) = '') AND DET_KEYTCO = 2 THEN 'ANDA'
                                                           WHEN (det_sindkto IS NULL OR TRIM(det_sindkto) = '') AND DET_KEYTCO = 3 THEN 'SITATYR'
                                                           WHEN (det_sindkto IS NULL OR TRIM(det_sindkto) = '') AND DET_KEYTCO = 519 THEN 'CONDUCTOR ART'
                                                           ELSE det_sindkto
                                                      END, det_keyfol, det_keyemp,
             det_nomcor, det_person, det_keypue, det_keycon, det_noforo , det_hralla, det_hraent,
             det_hrasal, det_hrstra, det_capgra, 'V'       , 'P'        , det_serial, det_inanda,
             pd_fechagen,det_fecpag, 0         , det_keynom, 0          , det_capini, det_capfin,
-- JCRO 16/03/2012           det_auxnu1, det_auxnu2, det_auxca1, det_auxca2[1,2] || "000" || det_auxca2[6,8] || "00" , pi_keyusu, pd_fechagen, pi_keyusu,
             det_auxnu1, det_auxnu2, det_auxca1, det_auxca2, pi_keyusu, pd_fechagen, pi_keyusu,
             pd_fechagen,det_tipinc, ROUND(
                                           CASE WHEN holodettra.det_tipinc='N' OR holodettra.det_tipinc='LI' THEN
                                                  CASE WHEN con_cosuni > 0 OR  con_cosuni IS NOT NULL THEN
                                                   con_cosuni
                                                  ELSE
                                                    (SELECT tab_import
                                                       FROM USRSIHO.HOLOTABS
                                                      WHERE tab_keypro = emp_keypro
                                                        AND tab_keypue = con_keypue
                                                        AND tab_pertra = con_pertra
                                                        AND tab_idioma = con_idioma
                                                        AND tab_keynac = con_keynac
                                                        AND tab_keytab = (CASE WHEN con_keytco = 519 THEN 3 ELSE con_keytco END -1)
                                                        AND tab_fecini <= det_fecgra
                                                        AND tab_fecfin >= det_fecgra
                                                        AND con_keyfol = det_keyfol
                                                    ) END * ld_ptje_retro / 100
                                                WHEN holodettra.det_tipinc='CM' THEN pd_comidaGM
                                                WHEN holodettra.det_tipinc='CN' THEN pd_cenaGM
                                                WHEN holodettra.det_tipinc='DE' THEN pd_desayunoGM
                                                WHEN holodettra.det_tipinc='PA' THEN pd_pasajesGM
                                                WHEN holodettra.det_tipinc='VL' THEN pd_viaticoslocGM
                                           ELSE
                                              det_cosuni * ld_ptje_retro / 100
                                           END
                                          ), det_numlla
        FROM USRSIHO.HOLOENCTRA, USRSIHO.HOLODETTRA, USRSIHO.HOLOFRPH, USRSIHO.NMCOEMPL, USRSIHO.HOLOCONT
       WHERE enc_num_id = det_num_id AND
             det_keyrph = frp_keyrph AND
             det_keyemp = emp_keyemp AND
             det_keyemp = con_keyemp AND
             det_keyfol = con_keyfol AND
             frp_keypro = 138 AND
             det_stsreg <> 'E' AND
             frp_keynom IN (SELECT cry_numsec FROM USRSIHO.glwkcrys WHERE cry_nomrep = 'retronomin' AND cry_idepcc = ps_idepcc AND cry_keyusu = pi_keyusu) AND
             enc_num_id = li_ht;
      INSERT INTO USRSIHO.TMP_HOLODETTRA (
             det_num_id, det_keydep, det_fecgra, det_keytco, det_sindkto, det_keyfol, det_keyemp,
             det_nomcor, det_person, det_keypue, det_keycon, det_noforo, det_hralla, det_hraent,
             det_hrasal, det_hrstra, det_capgra, det_stsreg, det_stspag, det_keyaut, det_inanda,
             det_ultact, det_fecpag, det_keyrph, det_keynom, det_cdilla, det_capini, det_capfin,
             det_auxnu1, det_auxnu2, det_auxca1, det_auxca2, det_usuori, det_fecori, det_usufin,
             det_fecfin, det_tipinc, det_cosuni, det_numlla
             )
-- JCRO 16/03/2012     SELECT li_secht  , det_keydep, det_fecgra, det_keytco, det_sindkto, det_keyfol, det_keyemp,
      SELECT li_secht  , det_keydep, det_fecgra, CASE WHEN (det_keytco IS NULL OR det_keytco = 0) AND TRIM(det_sindkto) = 'ANDA' OR TRIM(DET_SINDKTO) = 'ANDA PENSIONADA' THEN 2
                                                      WHEN (det_keytco IS NULL OR det_keytco = 0) AND TRIM(DET_SINDKTO) = 'SITATYR' THEN 3
                                                      WHEN (det_keytco IS NULL OR det_keytco = 0) AND TRIM(DET_SINDKTO) = 'CONDUCTOR ART' OR TRIM(DET_SINDKTO) = 'CONDUCTORES' THEN 519
                                                      ELSE det_keytco
                                                 END, CASE WHEN (det_sindkto IS NULL OR TRIM(det_sindkto) = '') AND DET_KEYTCO = 2 THEN 'ANDA'
                                                           WHEN (det_sindkto IS NULL OR TRIM(det_sindkto) = '') AND DET_KEYTCO = 3 THEN 'SITATYR'
                                                           WHEN (det_sindkto IS NULL OR TRIM(det_sindkto) = '') AND DET_KEYTCO = 519 THEN 'CONDUCTOR ART'
                                                           ELSE det_sindkto
                                                      END, det_keyfol, det_keyemp,
             det_nomcor, det_person, det_keypue, det_keycon, det_noforo, det_hralla, det_hraent,
             det_hrasal, det_hrstra, det_capgra, 'V'       , 'P'       , det_serial, det_inanda,
             pd_fechagen,det_fecpag, 0         , det_keynom, 0         , det_capini, det_capfin,
-- JCRO 16/03/2012            det_auxnu1, det_auxnu2, det_auxca1, det_auxca2[1,2] || "000" || det_auxca2[6,8] || "00" , pi_keyusu, pd_fechagen, pi_keyusu,
             det_auxnu1, det_auxnu2, det_auxca1, det_auxca2, pi_keyusu, pd_fechagen, pi_keyusu,
             pd_fechagen,det_tipinc, ROUND(det_cosuni * ld_ptje_retro / 100), det_numlla
        FROM USRSIHO.HOLOENCTRA, USRSIHO.HOLODETTRA, USRSIHO.HOLOFRPH, USRSIHO.NMCOEMPL
       WHERE enc_num_id = det_num_id AND
             det_keyrph = frp_keyrph AND
             det_keyemp = emp_keyemp AND
             frp_keypro = 138 AND
             det_stsreg <> 'E' AND
             frp_keynom IN (SELECT cry_numsec FROM USRSIHO.glwkcrys WHERE cry_nomrep = 'retronomin' AND cry_idepcc = ps_idepcc AND cry_keyusu = pi_keyusu) AND
             (det_keyfol IS NULL OR det_keyfol = 0) AND
             enc_num_id = li_ht;
      INSERT INTO USRSIHO.HOLODETTRA (
             det_num_id, det_keydep, det_fecgra, det_keytco, det_sindkto, det_keyfol, det_keyemp,
             det_nomcor, det_person, det_keypue, det_keycon, det_noforo, det_hralla, det_hraent,
             det_hrasal, det_hrstra, det_capgra, det_stsreg, det_stspag, det_keyaut, det_inanda,
             det_ultact, det_fecpag, det_keyrph, det_keynom, det_cdilla, det_capini, det_capfin,
             det_auxnu1, det_auxnu2, det_auxca1, det_auxca2, det_usuori, det_fecori, det_usufin,
             det_fecfin, det_tipinc, det_cosuni, det_numlla
             )
-- JCRO 16/03/2012     SELECT det_num_id, det_keydep, det_fecgra, det_keytco, det_sindkto, det_keyfol, det_keyemp,
      SELECT det_num_id, det_keydep, det_fecgra, CASE WHEN (det_keytco IS NULL OR det_keytco = 0) AND TRIM(det_sindkto) = 'ANDA' OR TRIM(DET_SINDKTO) = 'ANDA PENSIONADA' THEN 2
                                                      WHEN (det_keytco IS NULL OR det_keytco = 0) AND TRIM(DET_SINDKTO) = 'SITATYR' THEN 3
                                                      WHEN (det_keytco IS NULL OR det_keytco = 0) AND TRIM(DET_SINDKTO) = 'CONDUCTOR ART' OR TRIM(DET_SINDKTO) = 'CONDUCTORES' THEN 519
                                                      ELSE det_keytco
                                                 END, CASE WHEN (det_sindkto IS NULL OR TRIM(det_sindkto) = '') AND DET_KEYTCO = 2 THEN 'ANDA'
                                                           WHEN (det_sindkto IS NULL OR TRIM(det_sindkto) = '') AND DET_KEYTCO = 3 THEN 'SITATYR'
                                                           WHEN (det_sindkto IS NULL OR TRIM(det_sindkto) = '') AND DET_KEYTCO = 519 THEN 'CONDUCTOR ART'
                                                           ELSE det_sindkto
                                                      END, det_keyfol, det_keyemp,
             det_nomcor, det_person, det_keypue, det_keycon, det_noforo, det_hralla, det_hraent,
             det_hrasal, det_hrstra, det_capgra, det_stsreg, det_stspag, det_keyaut, det_inanda,
             det_ultact, det_fecpag, det_keyrph, det_keynom, det_cdilla, det_capini, det_capfin,
             det_auxnu1, det_auxnu2, det_auxca1, det_auxca2, det_usuori, det_fecori, det_usufin,
             det_fecfin, det_tipinc, det_cosuni,det_numlla
        FROM USRSIHO.TMP_HOLODETTRA;
      DELETE FROM USRSIHO.TMP_HOLODETTRA;
      UPDATE USRSIHO.holodettra
         SET det_keyrph = NULL,
             det_cdilla = NULL
       WHERE det_num_id = li_secht;
      pn_numgen := pn_numgen + 1;
END LOOP;
END;
/
