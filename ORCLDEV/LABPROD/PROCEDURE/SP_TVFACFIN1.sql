CREATE OR REPLACE NONEDITIONABLE PROCEDURE "LABPROD"."SP_TVFACFIN1" (wn_keypro IN NUMBER ,
                                        ws_keyper IN VARCHAR2,
                                        wn_keynom IN NUMBER,
                                        wn_keycia IN NUMBER,
                                        ws_tippol IN VARCHAR2,
                                        ws_tiprep IN VARCHAR2,
                                        ws_opcrep IN VARCHAR2,
                                        ws_lote  IN VARCHAR2,
                                        wd_fecpol IN date,
                                        ws_nomrep IN VARCHAR2,
                                        ws_idepcc IN VARCHAR2,
                                        wn_keyusu IN NUMBER)
IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
   ws_despro VARCHAR2(40);
   ws_descia VARCHAR2(60);
   ws_destip VARCHAR2(40);
   ws_nomusu VARCHAR2(40);
   ws_cuenta VARCHAR2(40);
   wn_cargos DECIMAL(18,6);
   wn_abonos DECIMAL(18,6);
   ws_cta VARCHAR2(03);
   ws_scta VARCHAR2(03);
   ws_sscta VARCHAR2(03);
   ws_tipmov VARCHAR2(1);
   wn_canemp INTEGER;
   wn_totemp INTEGER;
   ws_cvecta VARCHAR2(1);
   ws_descta VARCHAR2(40);
   wd_fecmod DATE;
BEGIN
insert into glwkcrys (CRY_NOMREP,CRY_CHR001,cry_dec001,cry_dec002) values ('PRUEBA',ws_despro,wn_cargos,1);
   --Obtiene la Descripcion del Proceso
   SELECT pro_despro
     INTO ws_despro
     FROM nmloproc
    WHERE pro_keypro = wn_keypro;
insert into glwkcrys (CRY_NOMREP,CRY_CHR001,cry_dec001,cry_dec002) values ('PRUEBA',ws_despro,wn_cargos,2);
   --Obtiene la Descripcion de la Compania
   SELECT substr(cia_descia,1,60)
     INTO ws_descia
     FROM nmlocias
    WHERE cia_keycia = wn_keycia;
insert into glwkcrys (CRY_NOMREP,CRY_CHR001,cry_dec001,cry_dec002) values ('PRUEBA',ws_despro,wn_cargos,3);
   --Obtiene la descripcion de la Nomina
   SELECT nom_destip
     INTO ws_destip
     FROM nmlonomi
    WHERE nom_keynom = wn_keynom;
insert into glwkcrys (CRY_NOMREP,CRY_CHR001,cry_dec001,cry_dec002) values ('PRUEBA',ws_despro,wn_cargos,4);
   --Obtiene el nombre del Usuario
   SELECT usu_nomusu
     INTO ws_nomusu
     FROM glcousua
    WHERE usu_keyusu = wn_keyusu;
insert into glwkcrys (CRY_NOMREP,CRY_CHR001,cry_dec001,cry_dec002) values ('PRUEBA',ws_despro,wn_cargos,5);
   --Obtiene Fecha de Aplicacion y Fecha de Generacion
     SELECT DISTINCT ape_fecmod
       INTO wd_fecmod
       FROM sipros_erp_enc
      WHERE ape_keylot = ws_lote
      AND ape_fecpol = wd_fecpol;
insert into glwkcrys (CRY_NOMREP,CRY_CHR001,cry_dec001,cry_dec002) values ('PRUEBA',ws_despro,wn_cargos,6);
   --Determina No. de Finiquitos
     SELECT COUNT(DISTINCT ape_keyemp)
       INTO wn_totemp
       FROM sipros_erp_enc
      WHERE ape_keylot = ws_lote
        AND ape_fecpol = wd_fecpol;
insert into glwkcrys (CRY_NOMREP,CRY_CHR001,cry_dec001,cry_dec002) values ('PRUEBA',ws_despro,wn_cargos,7);
  IF ws_tiprep <> 'T' THEN
    IF ws_opcrep = 'NO' THEN
      FOR c_sipros_erp IN  (SELECT apd_cuenta || apd_subcta || apd_ssbcta ws_cuenta,    --ws_cuenta
                     apd_cvecta,        --ws_cvecta
                     apd_tipmov,        --ws_tipmov
                     SUM(apd_import) cargos,   --cry_dec001 Dec(18,6) wn_cargos
                     SUM(apd_import) abonos    --cry_dec002 Dec(18,6) wn_abonos
                FROM sipros_erp_enc,
                     sipros_erp_det
                 WHERE ape_keypol = apd_keypol
                 AND ape_keylot = ws_lote
                 AND ape_fecpol = wd_fecpol
                 AND ape_status = ws_tiprep
                 AND substr(ape_keypol,12,1) = ws_tippol
                 AND ape_keypol NOT LIKE '%PA'
           GROUP BY apd_cuenta || apd_subcta || apd_ssbcta, apd_cvecta, apd_tipmov
            ORDER BY 1) LOOP
        ws_cuenta := c_sipros_erp.ws_cuenta;
        ws_cvecta := c_sipros_erp.apd_cvecta;
        ws_tipmov := c_sipros_erp.apd_tipmov;
        wn_cargos := c_sipros_erp.cargos;
        wn_abonos := c_sipros_erp.abonos;
        IF ws_tipmov = 'C' THEN
           wn_cargos := 0;
        ELSE
           wn_abonos := 0;
        END IF;
     --Corta la cuenta para las cuentas tipo "S"
        IF ws_cvecta = 'S' THEN
           ws_cuenta := SUBSTR(ws_cuenta,7,3);
           SELECT COUNT(DISTINCT ape_keyemp)
             INTO wn_canemp
             FROM sipros_erp_enc,
                  sipros_erp_det
            WHERE ape_keypol = apd_keypol
              AND ape_keylot = ws_lote
              AND ape_fecpol = wd_fecpol
              AND ape_status = ws_tiprep
              AND SUBSTR(ape_keypol,12,1) = ws_tippol
              AND apd_tipmov = ws_tipmov
              AND apd_ssbcta = ws_cuenta;
        ELSE
           SELECT COUNT(DISTINCT ape_keyemp)
             INTO wn_canemp
             FROM sipros_erp_enc,
                  sipros_erp_det
            WHERE ape_keypol = apd_keypol
              AND ape_keylot = ws_lote
              AND ape_fecpol = wd_fecpol
              AND ape_status = ws_tiprep
              AND SUBSTR(ape_keypol,12,1) = ws_tippol
              AND apd_tipmov = ws_tipmov
              AND apd_cuenta || apd_subcta || apd_ssbcta = ws_cuenta;
        END IF;
        ws_descta := 'NO EXISTE CUENTA';
        FOR c_cuenta1 IN (SELECT pam_nompar
          FROM glcopams
          WHERE pam_keypar = 'CCTA'
            AND pam_folini = ws_cuenta) LOOP
          ws_descta := c_cuenta1.pam_nompar;
        END LOOP;
        INSERT INTO tmp_facfin
                   VALUES(ws_nomrep,
                          ws_idepcc,
                          wn_keyusu,
                          wn_keypro,
                          ws_despro,
                          wn_keycia,
                          ws_descia,
                          wn_keynom,
                          ws_destip,
                          ws_keyper,
                          ws_nomusu,
                          ws_tippol,
                          ws_cuenta,
                          wn_cargos,
                          wn_abonos,
                          wn_canemp,
                          ws_cvecta,
                          ws_tipmov,
                          ws_descta,
                          ws_tiprep);
       END LOOP;
    ELSE   --Else para Pensionadas
      FOR c_sipros_erp2 IN
        (SELECT apd_cuenta || apd_subcta || apd_ssbcta ws_cuenta,    --ws_cuenta
                     apd_cvecta,        --ws_cvecta
                     apd_tipmov,        --ws_tipmov
                     SUM(apd_import) cargos,   --cry_dec001 Dec(18,6) wn_cargos
                     SUM(apd_import) abonos     --cry_dec002 Dec(18,6) wn_abonos
                FROM sipros_erp_enc,
                     sipros_erp_det
               WHERE ape_keypol = apd_keypol
                 AND ape_keylot = ws_lote
                 AND ape_fecpol = wd_fecpol
                 AND ape_status = ws_tiprep
                 AND SUBSTR(ape_keypol,12,1) = ws_tippol
                 AND ape_keypol LIKE '%PA'
            GROUP BY apd_cuenta || apd_subcta || apd_ssbcta, apd_cvecta, apd_tipmov
            ORDER BY 1) LOOP
        ws_cuenta := c_sipros_erp2.ws_cuenta;
        ws_cvecta := c_sipros_erp2.apd_cvecta;
        ws_tipmov := c_sipros_erp2.apd_tipmov;
        wn_cargos := c_sipros_erp2.cargos;
        wn_abonos := c_sipros_erp2.abonos;
     -- Determina importe
        IF ws_tipmov = 'C' THEN
           wn_cargos := 0;
        ELSE
           wn_abonos := 0;
        END IF;
     --Corta la cuenta para las cuentas tipo "S"
        IF ws_cvecta = 'S' THEN
           ws_cuenta := SUBSTR(ws_cuenta,7,3);
           SELECT COUNT(DISTINCT ape_keyemp)
             INTO wn_canemp
             FROM sipros_erp_enc,
                  sipros_erp_det
            WHERE ape_keypol = apd_keypol
              AND ape_keylot = ws_lote
              AND ape_fecpol = wd_fecpol
              AND ape_status = ws_tiprep
              AND SUBSTR(ape_keypol,12,1) = ws_tippol
              AND apd_tipmov = ws_tipmov
              AND apd_ssbcta = ws_cuenta;
        ELSE
           SELECT COUNT(DISTINCT ape_keyemp)
             INTO wn_canemp
             FROM sipros_erp_enc,
                  sipros_erp_det
            WHERE ape_keypol = apd_keypol
              AND ape_keylot = ws_lote
              AND ape_fecpol = wd_fecpol
              AND ape_status = ws_tiprep
              AND SUBSTR(ape_keypol,12,12) = ws_tippol
              AND apd_tipmov = ws_tipmov
              AND apd_cuenta || apd_subcta || apd_ssbcta = ws_cuenta;
        END IF;
     --Busca Descripcion de la cuenta
        ws_descta := 'NO EXISTE CUENTA';
        FOR c_cuenta2 IN (SELECT pam_nompar
          FROM glcopams
          WHERE pam_keypar = 'CCTA'
            AND pam_folini = ws_cuenta) LOOP
          ws_descta := c_cuenta2.pam_nompar;
        END LOOP;
     -- Inserta Valores en tabla temporal
        INSERT INTO tmp_facfin
                   VALUES(ws_nomrep,
                          ws_idepcc,
                          wn_keyusu,
                          wn_keypro,
                          ws_despro,
                          wn_keycia,
                          ws_descia,
                          wn_keynom,
                          ws_destip,
                          ws_keyper,
                          ws_nomusu,
                          ws_tippol,
                          ws_cuenta,
                          wn_cargos,
                          wn_abonos,
                          wn_canemp,
                          ws_cvecta,
                          ws_tipmov,
                          ws_descta,
                          ws_tiprep);
       END LOOP;
    END IF;
  ELSE  --Si es T
    IF ws_opcrep = 'NO' THEN
      FOR c_sipros_erp3 IN (SELECT apd_cuenta || apd_subcta || apd_ssbcta ws_cuenta,    --ws_cuenta
                    apd_cvecta,        --ws_cvecta
                    apd_tipmov,        --ws_tipmov
                    SUM(apd_import) cargos,   --cry_dec001 Dec(18,6) wn_cargos
                    SUM(apd_import) abonos    --cry_dec002 Dec(18,6) wn_abonos
               FROM sipros_erp_enc,
                    sipros_erp_det
              WHERE ape_keypol = apd_keypol
                AND SUBSTR(ape_keylot,1,10) = SUBSTR(ws_lote,1,10)
                AND SUBSTR(ape_keypol,12,1) = ws_tippol
                AND ape_keypol NOT LIKE '%PA'
           GROUP BY apd_cuenta || apd_subcta || apd_ssbcta,apd_cvecta,apd_tipmov
           ORDER BY 1) LOOP
        ws_cuenta := c_sipros_erp3.ws_cuenta;
        ws_cvecta := c_sipros_erp3.apd_cvecta;
        ws_tipmov := c_sipros_erp3.apd_tipmov;
        wn_cargos := c_sipros_erp3.cargos;
        wn_abonos := c_sipros_erp3.abonos;
     -- Determina importe
        IF ws_tipmov = 'C' THEN
          wn_cargos := 0;
        ELSE
          wn_abonos := 0;
        END IF;
     --Corta la cuenta para las cuentas tipo "S"
        IF ws_cvecta = 'S' THEN
           ws_cuenta := SUBSTR(ws_cuenta,7,3);
           SELECT COUNT(DISTINCT ape_keyemp)
             INTO wn_canemp
             FROM sipros_erp_enc,
                  sipros_erp_det
            WHERE ape_keypol = apd_keypol
              AND SUBSTR(ape_keylot,1,10) = SUBSTR(ws_lote,1,10)
              AND ape_status = ws_tiprep
              AND SUBSTR(ape_keypol,12,1) = ws_tippol
              AND apd_tipmov = ws_tipmov
              AND apd_ssbcta = ws_cuenta;
        ELSE
           SELECT COUNT(DISTINCT ape_keyemp)
             INTO wn_canemp
             FROM sipros_erp_enc,
                  sipros_erp_det
            WHERE ape_keypol = apd_keypol
              AND SUBSTR(ape_keylot,1,10) = SUBSTR(ws_lote,1,10)
              AND ape_status = ws_tiprep
              AND SUBSTR(ape_keypol,12,1) = ws_tippol
              AND apd_tipmov = ws_tipmov
              AND apd_cuenta || apd_subcta || apd_ssbcta = ws_cuenta;
        END IF;
     --Busca Descripcion de la cuenta
        ws_descta := 'NO EXISTE CUENTA';
        FOR c_cuenta3 IN (SELECT pam_nompar
          FROM glcopams
          WHERE pam_keypar = 'CCTA'
            AND pam_folini = ws_cuenta) LOOP
          ws_descta := c_cuenta3.pam_nompar;
        END LOOP;
     -- Inserta Valores en tabla temporal
        INSERT INTO tmp_facfin
                   VALUES(ws_nomrep,
                          ws_idepcc,
                          wn_keyusu,
                          wn_keypro,
                          ws_despro,
                          wn_keycia,
                          ws_descia,
                          wn_keynom,
                          ws_destip,
                          ws_keyper,
                          ws_nomusu,
                          ws_tippol,
                          ws_cuenta,
                          wn_cargos,
                          wn_abonos,
                          wn_canemp,
                          ws_cvecta,
                          ws_tipmov,
                          ws_descta,
                          ws_tiprep);
      END LOOP;
    ELSE  -- Else para Pensionadas
      FOR c_sipros_erp4 IN (SELECT apd_cuenta || apd_subcta || apd_ssbcta ws_cuenta,    --ws_cuenta
                    apd_cvecta,        --ws_cvecta
                    apd_tipmov,        --ws_tipmov
                    SUM(apd_import) cargos,   --cry_dec001 Dec(18,6) wn_cargos
                    SUM(apd_import) abonos    --cry_dec002 Dec(18,6) wn_abonos
               INTO ws_cuenta,
                    ws_cvecta,
                    ws_tipmov,
                    wn_cargos,
                    wn_abonos
               FROM sipros_erp_enc,
                    sipros_erp_det
              WHERE ape_keypol = apd_keypol
                AND SUBSTR(ape_keylot,1,10) = SUBSTR(ws_lote,1,10)
                AND SUBSTR(ape_keypol,12,1) = ws_tippol
                AND ape_keypol LIKE '%PA'
           GROUP BY apd_cuenta || apd_subcta || apd_ssbcta,apd_cvecta,apd_tipmov
           ORDER BY 1) LOOP
        ws_cuenta := c_sipros_erp4.ws_cuenta;
        ws_cvecta := c_sipros_erp4.apd_cvecta;
        ws_tipmov := c_sipros_erp4.apd_tipmov;
        wn_cargos := c_sipros_erp4.cargos;
        wn_abonos := c_sipros_erp4.abonos;
     -- Determina importe
        IF ws_tipmov = 'C' THEN
           wn_cargos := 0;
        ELSE
           wn_abonos := 0;
        END IF;
     --Corta la cuenta para las cuentas tipo "S"
        IF ws_cvecta = 'S' THEN
           ws_cuenta := SUBSTR(ws_cuenta,7,3);
           SELECT COUNT(DISTINCT ape_keyemp)
             INTO wn_canemp
             FROM sipros_erp_enc,
                  sipros_erp_det
            WHERE ape_keypol = apd_keypol
              AND SUBSTR(ape_keylot,1,10) = SUBSTR(ws_lote,1,10)
              AND ape_status = ws_tiprep
              AND SUBSTR(ape_keypol,12,1) = ws_tippol
              AND apd_tipmov = ws_tipmov
              AND apd_ssbcta = ws_cuenta;
        ELSE
           SELECT COUNT(DISTINCT ape_keyemp)
             INTO wn_canemp
             FROM sipros_erp_enc,
                  sipros_erp_det
            WHERE ape_keypol = apd_keypol
              AND SUBSTR(ape_keylot,1,10) = SUBSTR(ws_lote,1,10)
              AND ape_status = ws_tiprep
              AND SUBSTR(ape_keypol,12,1) = ws_tippol
              AND apd_tipmov = ws_tipmov
              AND apd_cuenta || apd_subcta || apd_ssbcta = ws_cuenta;
        END IF;
     --Busca Descripcion de la cuenta
        ws_descta := 'NO EXISTE CUENTA';
        FOR c_cuenta4 IN (SELECT pam_nompar
          FROM glcopams
          WHERE pam_keypar = 'CCTA'
            AND pam_folini = ws_cuenta) LOOP
          ws_descta := c_cuenta4.pam_nompar;
        END LOOP;
     -- Inserta Valores en tabla temporal
        INSERT INTO tmp_facfin
                   VALUES(ws_nomrep,
                          ws_idepcc,
                          wn_keyusu,
                          wn_keypro,
                          ws_despro,
                          wn_keycia,
                          ws_descia,
                          wn_keynom,
                          ws_destip,
                          ws_keyper,
                          ws_nomusu,
                          ws_tippol,
                          ws_cuenta,
                          wn_cargos,
                          wn_abonos,
                          wn_canemp,
                          ws_cvecta,
                          ws_tipmov,
                          ws_descta,
                          ws_tiprep);
      END LOOP;
    END IF;
  END IF;
     --Saca Encabezados del Reporte
  SELECT  DISTINCT
             tmp_despro,
             tmp_descia,
             tmp_destip,
             tmp_nomusu
       INTO
             ws_despro,
             ws_descia,
             ws_destip,
             ws_nomusu
       FROM  tmp_facfin;
   SELECT COUNT(*) into wn_cargos
   FROM tmp_facfin;
insert into glwkcrys (CRY_NOMREP,CRY_CHR001,cry_dec001,cry_dec002) values ('PRUEBA',ws_despro,wn_cargos,8);
  FOR c_sipros_erp5 IN (SELECT  tmp_canemp,
                   tmp_cuenta,
                   tmp_descta,
                   tmp_cvecta,
                   tmp_tipmov,
                   SUM(tmp_cargos) cargos,
                   SUM(tmp_abonos) abonos
             FROM  tmp_facfin
       GROUP BY tmp_canemp,tmp_cuenta,tmp_descta,tmp_cvecta,tmp_tipmov
       ORDER BY 2) LOOP
    wn_canemp := c_sipros_erp5.tmp_canemp;
    ws_cuenta := c_sipros_erp5.tmp_cuenta;
    ws_descta := c_sipros_erp5.tmp_descta;
    ws_cvecta := c_sipros_erp5.tmp_cvecta;
    ws_tipmov := c_sipros_erp5.tmp_tipmov;
    wn_cargos := c_sipros_erp5.cargos;
    wn_abonos := c_sipros_erp5.abonos;
    INSERT INTO glwkcrys(cry_nomrep, cry_idepcc, cry_keyusu, cry_dec006, cry_chr003,
                          cry_chr017,
                          cry_chr004,
                          cry_chr018,
                          cry_chr005,
                          cry_chr019,
                          cry_dec008,
                          cry_chr006,
                          cry_chr020,
                          cry_chr008,
                          cry_dec001,
                          cry_dec002,
                          cry_dec007,
                          cry_chr021,
                          cry_chr022,
                          cry_dec009,
                          cry_chr007,
                          cry_chr023,
                          cry_chr012,
                          cry_dat001,
                          cry_dat002)
                   VALUES(ws_nomrep,
                          ws_idepcc,
                          wn_keyusu,
                          wn_keypro,
                          ws_despro,
                          wn_keycia,
                          ws_descia,
                          wn_keynom,
                          ws_destip,
                          ws_keyper,
                          wn_keyusu,
                          ws_nomusu,
                          ws_tippol,
                          ws_cuenta,
                          wn_cargos,
                          wn_abonos,
                          wn_canemp,
                          ws_cvecta,
                          ws_tipmov,
                          wn_totemp,
                          ws_descta,
                          ws_tiprep,
                          ws_lote,
                          wd_fecpol,
                          wd_fecmod);
  END LOOP;
   SELECT COUNT(*) into wn_cargos
   FROM tmp_facfin;
--EXCEPTION
--    WHEN OTHERS THEN
--        sp_glGenErr ('tvfacfin', ws_idepcc, wn_keyusu, sp_glgethor,
--		     SQLCODE, 0, SUBSTR (SQLERRM, 1, 60));
END;
/
