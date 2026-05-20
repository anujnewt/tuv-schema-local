CREATE OR REPLACE NONEDITIONABLE PROCEDURE "LABCONF"."SP_TVFACFIN2" (wn_keypro IN NUMBER ,
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
   wn_keyemp INTEGER;
   ws_nomemp VARCHAR2(60);
   wn_import DECIMAL(18,6);
   ws_keypol VARCHAR2(30);
   ws_descta VARCHAR2(20);
   wd_fecmod DATE;
   ws_benef VARCHAR2(60);
BEGIN
  SELECT substr(cia_descia,1,60)
     INTO ws_descia
     FROM nmlocias
    WHERE cia_keycia = wn_keycia;
   --Obtiene la descripcion de la Nomina
  SELECT nom_destip
     INTO ws_destip
     FROM nmlonomi
    WHERE nom_keynom = wn_keynom;
   --Obtiene el nombre del Usuario
  SELECT usu_nomusu
     INTO ws_nomusu
     FROM glcousua
    WHERE usu_keyusu = wn_keyusu;
   --Obtiene Fecha de Aplicacion y Fecha de Generacion
  SELECT DISTINCT ape_fecmod
       INTO wd_fecmod
       FROM sipros_erp_enc
      WHERE ape_keylot = ws_lote
       AND ape_fecpol = wd_fecpol;
  IF ws_tiprep <> 'T' THEN
    IF ws_opcrep = 'NO' THEN
      FOR c_sipros_erp IN (SELECT ape_keypol,
                     ape_despro,
                     apd_tipmov,
                     ape_keyemp,
                     emp_nomemp,
                     ape_fecpol,
                     ape_import,
                     apd_cuenta || apd_subcta || apd_ssbcta CUENTA,
                     SUM(apd_import) cargos,
                     SUM(apd_import) abonos
                FROM sipros_erp_enc,
                     sipros_erp_det,
                     nmcoempl
               WHERE ape_keypol = apd_keypol
                 AND ape_keyemp = emp_keyemp
                 AND ape_keylot = ws_lote
                 AND ape_fecpol = wd_fecpol   --Nueva
                 AND ape_status = ws_tiprep
                 AND SUBSTR(ape_keypol,12,1) = ws_tippol
                 AND ape_keypol NOT LIKE '%PA'
            GROUP BY ape_keypol,ape_despro,apd_tipmov,ape_keyemp,emp_nomemp,ape_fecpol,ape_import,apd_cuenta||apd_subcta||apd_ssbcta
            ORDER BY 1,4,8) LOOP
        ws_keypol := c_sipros_erp.ape_keypol;
        ws_despro := c_sipros_erp.ape_despro;
        ws_tipmov := c_sipros_erp.apd_tipmov;
        wn_keyemp := c_sipros_erp.ape_keyemp;
        ws_nomemp := c_sipros_erp.emp_nomemp;
        --wd_fecpol := c_sipros_erp.ape_fecpol;
        wn_import := c_sipros_erp.ape_import;
        ws_cuenta := c_sipros_erp.CUENTA;
        wn_cargos := c_sipros_erp.cargos;
        wn_abonos := c_sipros_erp.abonos;
        -- Determina importe
        IF ws_tipmov = 'C' THEN
          wn_cargos := 0;
        ELSE
          wn_abonos := 0;
        END IF;
      --Corta la cuenta para las cuentas tipo "S"
        IF SUBSTR(ws_cuenta,7,1) = '1' THEN
          ws_cuenta := SUBSTR(ws_cuenta,7,3);
        END IF;
      --Busca Descripcion de la cuenta
        ws_descta := 'NO EXISTE CUENTA';
        FOR c_cuenta1 IN (SELECT SUBSTR(pam_nompar,1,20) pam_nompar
          FROM glcopams
          WHERE pam_keypar = 'CCTA'
            AND pam_folini = ws_cuenta) LOOP
          ws_descta := c_cuenta1.pam_nompar;
        END LOOP;
      --Obtiene Nombre del Beneficiario
        SELECT DISTINCT ape_auxca1
          INTO ws_benef
          FROM sipros_erp_enc
         WHERE ape_keylot = ws_lote
           AND ape_fecpol = wd_fecpol --Nueva
           AND ape_keypol = ws_keypol;
        -- Inserta Valores
      -- INSERT INTO paso(linea) VALUES(7);
        INSERT INTO glwkcrys(cry_nomrep,
                             cry_idepcc,
                             cry_keyusu,
                             cry_dec006,
                             cry_chr003,
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
                             cry_chr007, ---Se aumentaron estos 5 renglones
                             cry_dec007,
                             cry_chr001,
                             cry_dat001,
                             cry_dec003,
                             cry_chr023,
                             cry_chr012,
                             cry_chr009,
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
                             ws_keypol,  --Se aumentaron estos 5 renglones
                             wn_keyemp,
                             ws_benef,   --ws_nomemp,
                             wd_fecpol,
                             wn_import,
                             ws_tiprep,
                             ws_lote,
                             ws_descta,
                             wd_fecmod);
      END LOOP;
    ELSE
      FOR c_sipros_erp2 IN (SELECT ape_keypol,
                     ape_despro,
                     apd_tipmov,
                     ape_keyemp,
                     emp_nomemp,
                     ape_fecpol,
                     ape_import,
                     apd_cuenta || apd_subcta || apd_ssbcta CUENTA,
                     SUM(apd_import) cargos,
                     SUM(apd_import) abonos
                FROM sipros_erp_enc,
                     sipros_erp_det,
                     nmcoempl
               WHERE ape_keypol = apd_keypol
                 AND ape_keyemp = emp_keyemp
                 AND ape_keylot = ws_lote
                 AND ape_fecpol = wd_fecpol   --Nueva
                 AND ape_status = ws_tiprep
                 AND SUBSTR(ape_keypol,12,1) = ws_tippol
                 AND ape_keypol LIKE '%PA'
            GROUP BY ape_keypol,ape_despro,apd_tipmov,ape_keyemp,emp_nomemp,ape_fecpol,ape_import,apd_cuenta||apd_subcta||apd_ssbcta
            ORDER BY 1,4,8) LOOP
        ws_keypol := c_sipros_erp2.ape_keypol;
        ws_despro := c_sipros_erp2.ape_despro;
        ws_tipmov := c_sipros_erp2.apd_tipmov;
        wn_keyemp := c_sipros_erp2.ape_keyemp;
        ws_nomemp := c_sipros_erp2.emp_nomemp;
        --wd_fecpol := c_sipros_erp2.ape_fecpol;
        wn_import := c_sipros_erp2.ape_import;
        ws_cuenta := c_sipros_erp2.CUENTA;
        wn_cargos := c_sipros_erp2.cargos;
        wn_abonos := c_sipros_erp2.abonos;
        -- Determina importe
        IF ws_tipmov = 'C' THEN
          wn_cargos := 0;
        ELSE
          wn_abonos := 0;
        END IF;
      --Corta la cuenta para las cuentas tipo "S"
        IF SUBSTR(ws_cuenta,7,1) = '1' THEN
          ws_cuenta := SUBSTR(ws_cuenta,7,3);
        END IF;
      --Busca Descripcion de la cuenta
        ws_descta := 'NO EXISTE CUENTA';
        FOR c_cuenta2 IN (SELECT SUBSTR(pam_nompar,1,20)  pam_nompar
          FROM glcopams
          WHERE pam_keypar = 'CCTA'
            AND pam_folini = ws_cuenta) LOOP
          ws_descta := c_cuenta2.pam_nompar;
        END LOOP;
      --Obtiene Nombre del Beneficiario
        SELECT DISTINCT ape_auxca1
          INTO ws_benef
          FROM sipros_erp_enc
         WHERE ape_keylot = ws_lote
           AND ape_fecpol = wd_fecpol --Nueva
           AND ape_keypol = ws_keypol;
        -- Inserta Valores
      -- INSERT INTO paso(linea) VALUES(7);
        INSERT INTO glwkcrys(cry_nomrep,
                             cry_idepcc,
                             cry_keyusu,
                             cry_dec006,
                             cry_chr003,
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
                             cry_chr007, ---Se aumentaron estos 5 renglones
                             cry_dec007,
                             cry_chr001,
                             cry_dat001,
                             cry_dec003,
                             cry_chr023,
                             cry_chr012,
                             cry_chr009,
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
                             ws_keypol,  --Se aumentaron estos 5 renglones
                             wn_keyemp,
                             ws_benef,   --ws_nomemp,
                             wd_fecpol,
                             wn_import,
                             ws_tiprep,
                             ws_lote,
                             ws_descta,
                             wd_fecmod);
      END LOOP;
    END IF;
  ELSE
    IF ws_opcrep = 'NO' THEN
      FOR c_sipros_erp3 IN (SELECT ape_keypol,
                     ape_despro,
                     apd_tipmov,
                     ape_keyemp,
                     emp_nomemp,
                     ape_fecpol,
                     ape_import,
                     apd_cuenta || apd_subcta || apd_ssbcta CUENTA,
                     SUM(apd_import) cargos,
                     SUM(apd_import) abonos
                FROM sipros_erp_enc,
                     sipros_erp_det,
                     nmcoempl
               WHERE ape_keypol = apd_keypol
                 AND ape_keyemp = emp_keyemp
                 AND ape_keylot = ws_lote
                 AND ape_fecpol = wd_fecpol   --Nueva
                 AND SUBSTR(ape_keypol,12,1) = ws_tippol
                 AND ape_keypol NOT LIKE '%PA'
            GROUP BY ape_keypol,ape_despro,apd_tipmov,ape_keyemp,emp_nomemp,ape_fecpol,ape_import,apd_cuenta||apd_subcta||apd_ssbcta
            ORDER BY 1,4,8) LOOP
        ws_keypol := c_sipros_erp3.ape_keypol;
        ws_despro := c_sipros_erp3.ape_despro;
        ws_tipmov := c_sipros_erp3.apd_tipmov;
        wn_keyemp := c_sipros_erp3.ape_keyemp;
        ws_nomemp := c_sipros_erp3.emp_nomemp;
        --wd_fecpol := c_sipros_erp3.ape_fecpol;
        wn_import := c_sipros_erp3.ape_import;
        ws_cuenta := c_sipros_erp3.CUENTA;
        wn_cargos := c_sipros_erp3.cargos;
        wn_abonos := c_sipros_erp3.abonos;
        -- Determina importe
        IF ws_tipmov = 'C' THEN
          wn_cargos := 0;
        ELSE
          wn_abonos := 0;
        END IF;
      --Corta la cuenta para las cuentas tipo "S"
        IF SUBSTR(ws_cuenta,7,1) = '1' THEN
          ws_cuenta := SUBSTR(ws_cuenta,7,3);
        END IF;
      --Busca Descripcion de la cuenta
        ws_descta := 'NO EXISTE CUENTA';
        FOR c_cuenta3 IN (SELECT SUBSTR(pam_nompar,1,20)  pam_nompar
          FROM glcopams
          WHERE pam_keypar = 'CCTA'
            AND pam_folini = ws_cuenta) LOOP
          ws_descta := c_cuenta3.pam_nompar;
        END LOOP;
      --Obtiene Nombre del Beneficiario
        SELECT DISTINCT ape_auxca1
          INTO ws_benef
          FROM sipros_erp_enc
         WHERE ape_keylot = ws_lote
           AND ape_fecpol = wd_fecpol --Nueva
           AND ape_keypol = ws_keypol;
        -- Inserta Valores
      -- INSERT INTO paso(linea) VALUES(7);
        INSERT INTO glwkcrys(cry_nomrep,
                             cry_idepcc,
                             cry_keyusu,
                             cry_dec006,
                             cry_chr003,
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
                             cry_chr007, ---Se aumentaron estos 5 renglones
                             cry_dec007,
                             cry_chr001,
                             cry_dat001,
                             cry_dec003,
                             cry_chr012,
                             cry_chr009,
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
                             ws_keypol,  --Se aumentaron estos 5 renglones
                             wn_keyemp,
                             ws_benef,   --ws_nomemp,
                             wd_fecpol,
                             wn_import,
                             ws_lote,
                             ws_descta,
                             wd_fecmod);
      END LOOP;
    ELSE
      FOR c_sipros_erp4 IN (SELECT ape_keypol,
                     ape_despro,
                     apd_tipmov,
                     ape_keyemp,
                     emp_nomemp,
                     ape_fecpol,
                     ape_import,
                     apd_cuenta || apd_subcta || apd_ssbcta CUENTA,
                     SUM(apd_import) cargos,
                     SUM(apd_import) abonos
                FROM sipros_erp_enc,
                     sipros_erp_det,
                     nmcoempl
               WHERE ape_keypol = apd_keypol
                 AND ape_keyemp = emp_keyemp
                 AND ape_keylot = ws_lote
                 AND ape_fecpol = wd_fecpol   --Nueva
                 AND SUBSTR(ape_keypol,12,1) = ws_tippol
                 AND ape_keypol LIKE '%PA'
            GROUP BY ape_keypol,ape_despro,apd_tipmov,ape_keyemp,emp_nomemp,ape_fecpol,ape_import,apd_cuenta||apd_subcta||apd_ssbcta
            ORDER BY 1,4,8) LOOP
        ws_keypol := c_sipros_erp4.ape_keypol;
        ws_despro := c_sipros_erp4.ape_despro;
        ws_tipmov := c_sipros_erp4.apd_tipmov;
        wn_keyemp := c_sipros_erp4.ape_keyemp;
        ws_nomemp := c_sipros_erp4.emp_nomemp;
        --wd_fecpol := c_sipros_erp4.ape_fecpol;
        wn_import := c_sipros_erp4.ape_import;
        ws_cuenta := c_sipros_erp4.CUENTA;
        wn_cargos := c_sipros_erp4.cargos;
        wn_abonos := c_sipros_erp4.abonos;
        -- Determina importe
        IF ws_tipmov = 'C' THEN
          wn_cargos := 0;
        ELSE
          wn_abonos := 0;
        END IF;
      --Corta la cuenta para las cuentas tipo "S"
        IF SUBSTR(ws_cuenta,7,1) = '1' THEN
          ws_cuenta := SUBSTR(ws_cuenta,7,3);
        END IF;
      --Busca Descripcion de la cuenta
        ws_descta := 'NO EXISTE CUENTA';
        FOR c_cuenta4 IN (SELECT SUBSTR(pam_nompar,1,20)  pam_nompar
          FROM glcopams
          WHERE pam_keypar = 'CCTA'
            AND pam_folini = ws_cuenta) LOOP
          ws_descta := c_cuenta4.pam_nompar;
        END LOOP;
      --Obtiene Nombre del Beneficiario
        SELECT DISTINCT ape_auxca1
          INTO ws_benef
          FROM sipros_erp_enc
         WHERE ape_keylot = ws_lote
           AND ape_fecpol = wd_fecpol --Nueva
           AND ape_keypol = ws_keypol;
        -- Inserta Valores
      -- INSERT INTO paso(linea) VALUES(7);
        INSERT INTO glwkcrys(cry_nomrep,
                             cry_idepcc,
                             cry_keyusu,
                             cry_dec006,
                             cry_chr003,
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
                             cry_chr007, ---Se aumentaron estos 5 renglones
                             cry_dec007,
                             cry_chr001,
                             cry_dat001,
                             cry_dec003,
                             cry_chr012,
                             cry_chr009,
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
                             ws_keypol,  --Se aumentaron estos 5 renglones
                             wn_keyemp,
                             ws_benef,   --ws_nomemp,
                             wd_fecpol,
                             wn_import,
                             ws_lote,
                             ws_descta,
                             wd_fecmod);
      END LOOP;
    END IF;
  END IF;
END;
/
