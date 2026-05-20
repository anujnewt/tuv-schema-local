CREATE OR REPLACE NONEDITIONABLE PROCEDURE "LABCONF"."SP_TVINTERP" (wn_keypro IN NUMBER,
                                        ws_keyper IN VARCHAR2,
                                        wn_keynom IN NUMBER,
                                        wn_keycia IN NUMBER,
                                        ws_tippol IN VARCHAR2,
                                        ws_tiprep IN VARCHAR2,
                                        ws_nomrep IN VARCHAR2,
                                        ws_poliza IN VARCHAR2,
                                        ws_idepcc IN VARCHAR2,
                                        wn_keyusu IN NUMBER) IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
   ws_despro VARCHAR2(40);
   ws_descia VARCHAR2(40);
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
   ws_rfcban VARCHAR2(20);
   ws_sucban VARCHAR2(20);
   ws_desprov VARCHAR2(60);
   ws_keyfac VARCHAR2(30);
   ws_nomben VARCHAR2(50);
BEGIN
   --Obtiene la Descripcion del Proceso
   SELECT pro_despro
     INTO ws_despro
     FROM nmloproc
    WHERE pro_keypro = wn_keypro;
   --Obtiene la Descripcion de la Compania
   SELECT SUBSTR(cia_descia,1,40),cia_rfccia
     INTO ws_descia,ws_rfcban
     FROM nmlocias
    WHERE cia_keycia = wn_keycia;
    ws_desprov := ws_rfcban || ' ' || ws_descia;
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
   --Determina No. de Finiquitos
     SELECT COUNT(DISTINCT ape_keyemp)
       INTO wn_totemp
       FROM sipros_erp_enc
      WHERE SUBSTR(ape_keypol,1,10) = ws_poliza;
   --lectura de las Facturas
  IF ws_tiprep <> 'T' THEN
    FOR c_interp1 in (
      SELECT apd_keypol,
                  apd_cveban,
                  apd_cuenta || apd_subcta || apd_ssbcta CUENTA,    --ws_cuenta
                  apd_cvecta,        --ws_cvecta
                  apd_tipmov,        --ws_tipmov
                  SUM(apd_import) cargos,   --cry_dec001 Dec(18,6) wn_cargos
                  SUM(apd_import) abonos    --cry_dec002 Dec(18,6) wn_abonos
             FROM sipros_erp_det
            WHERE apd_keypol IN(SELECT ape_keypol
                                  FROM sipros_erp_enc
                                 WHERE SUBSTR(ape_keypol,1,10) = ws_poliza
                                   AND ape_status = ws_tiprep
                                   AND SUBSTR(ape_auxca1,1,6) = 'NOMINA')
         GROUP BY apd_keypol, apd_cveban, apd_cuenta || apd_subcta || apd_ssbcta, apd_cvecta, apd_tipmov
         ORDER BY 1,2) LOOP
      ws_keyfac := c_interp1.apd_keypol;
      ws_sucban := c_interp1.apd_cveban;
      ws_cuenta := c_interp1.CUENTA;
      ws_cvecta := c_interp1.apd_cvecta;
      ws_tipmov := c_interp1.apd_tipmov;
      wn_cargos := c_interp1.cargos;
      wn_abonos := c_interp1.abonos;
     -- Determina importe
      IF ws_tipmov = 'C' THEN
        wn_cargos := 0;
      ELSE
        wn_abonos := 0;
      END IF;
     --Corta la cuenta para las cuentas tipo "S"
      IF ws_cvecta = 'S' THEN
        ws_cuenta := SUBSTR(ws_cuenta,7,3);
        SELECT COUNT(DISTINCT apd_keyemp)
             INTO wn_canemp
             FROM sipros_erp_det
            WHERE apd_keypol IN(SELECT ape_keypol
                                  FROM sipros_erp_enc
                                 WHERE SUBSTR(ape_keypol,1,10) = ws_poliza
                                   AND ape_status = ws_tiprep
                                   AND SUBSTR(ape_auxca1,1,6) = 'NOMINA')
              AND apd_tipmov = ws_tipmov
              AND apd_ssbcta = ws_cuenta;
      ELSE
        SELECT COUNT(DISTINCT apd_keyemp)
             INTO wn_canemp
             FROM sipros_erp_det
            WHERE apd_keypol IN(SELECT ape_keypol
                                  FROM sipros_erp_enc
                                 WHERE SUBSTR(ape_keypol,1,10) = ws_poliza
                                   AND ape_status = ws_tiprep
                                   AND SUBSTR(ape_auxca1,1,6) = 'NOMINA')
              AND apd_tipmov = ws_tipmov
              AND apd_cuenta || apd_subcta || apd_ssbcta = ws_cuenta;
        END IF;
     --Busca Descripcion de la cuenta
       FOR c_ctas IN (
         SELECT pam_nompar
           FROM glcopams
          WHERE pam_keypar = 'CCTA'
            AND pam_folini = ws_cuenta) LOOP
         ws_descta := c_ctas.pam_nompar;
       END LOOP;
     -- Inserta Valores en tabla temporal
     INSERT INTO TMP_INTERP
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
                          ws_sucban,
                          ws_cuenta,
                          wn_cargos,
                          wn_abonos,
                          wn_canemp,
                          ws_cvecta,
                          ws_tipmov,
                          ws_descta,
                          ws_tiprep,
                          ws_keyfac);
    END LOOP;
  ELSE  --Si es T
    FOR c_interp2 IN (SELECT apd_keypol,
                  apd_cveban,
                  apd_cuenta || apd_subcta || apd_ssbcta cuenta,    --ws_cuenta
                  apd_cvecta,        --ws_cvecta
                  apd_tipmov,        --ws_tipmov
                  SUM(apd_import) cargos,   --cry_dec001 Dec(18,6) wn_cargos
                  SUM(apd_import) abonos    --cry_dec002 Dec(18,6) wn_abonos
             INTO ws_keyfac,
                  ws_sucban,
                  ws_cuenta,
                  ws_cvecta,
                  ws_tipmov,
                  wn_cargos,
                  wn_abonos
              FROM sipros_erp_det
            WHERE apd_keypol IN(SELECT ape_keypol
                                  FROM sipros_erp_enc
                                 WHERE SUBSTR(ape_keypol,1,10) = ws_poliza
                                   AND ape_status = ws_tiprep
                                   AND SUBSTR(ape_auxca1,1,6) = 'NOMINA')
         GROUP BY apd_keypol, apd_cveban, apd_cuenta || apd_subcta || apd_ssbcta, apd_cvecta, apd_tipmov
         ORDER BY 1,2) LOOP
     -- Determina importe
      IF ws_tipmov = 'C' THEN
        wn_cargos := 0;
      ELSE
        wn_abonos := 0;
      END IF;
     --Corta la cuenta para las cuentas tipo "S"
      IF ws_cvecta = 'S' THEN
        ws_cuenta := SUBSTR(ws_cuenta,7,3);
        SELECT COUNT(DISTINCT apd_keyemp)
             INTO wn_canemp
             FROM sipros_erp_det
            WHERE apd_keypol IN(SELECT ape_keypol
                                  FROM sipros_erp_enc
                                 WHERE SUBSTR(ape_keypol,1,10) = ws_poliza
                                   AND ape_status = ws_tiprep
                                   AND SUBSTR(ape_auxca1,1,6) = 'NOMINA')
              AND apd_tipmov = ws_tipmov
              AND apd_ssbcta = ws_cuenta;
      ELSE
        SELECT COUNT(DISTINCT apd_keyemp)
             INTO wn_canemp
             FROM sipros_erp_det
            WHERE apd_keypol IN(SELECT ape_keypol
                                  FROM sipros_erp_enc
                                 WHERE SUBSTR(ape_keypol,1,10) = ws_poliza
                                   AND ape_status = ws_tiprep
                                   AND SUBSTR(ape_auxca1,1,6) = 'NOMINA')
              AND apd_tipmov = ws_tipmov
              AND apd_cuenta || apd_subcta || apd_ssbcta = ws_cuenta;
      END IF;
     --Busca Descripcion de la cuenta
      SELECT pam_nompar
         INTO ws_descta
         FROM glcopams
        WHERE pam_keypar = 'CCS'
          AND pam_folini = ws_cuenta;
     -- Inserta Valores en tabla temporal
      INSERT INTO TMP_INTERP
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
                          ws_sucban,
                          ws_cuenta,
                          wn_cargos,
                          wn_abonos,
                          wn_canemp,
                          ws_cvecta,
                          ws_tipmov,
                          ws_descta,
                          ws_tiprep,
                          ws_keyfac);
    END LOOP;
  END IF;
  FOR c_interp3 IN (SELECT  tmp_keyfac,
                   tmp_sucban,
                   tmp_canemp,
                   tmp_cuenta,
                   tmp_descta,
                   tmp_cvecta,
                   tmp_tipmov,
                   SUM(tmp_cargos) cargos,
                   SUM(tmp_abonos) abonos
             FROM  TMP_INTERP
            GROUP BY tmp_keyfac,tmp_sucban,tmp_canemp,tmp_cuenta,tmp_descta,tmp_cvecta,tmp_tipmov
            ORDER BY 1,2,4) LOOP
    ws_keyfac := c_interp3.tmp_keyfac;
    ws_sucban := c_interp3.tmp_sucban;
    wn_canemp := c_interp3.tmp_canemp;
    ws_cuenta := c_interp3.tmp_cuenta;
    ws_descta := c_interp3.tmp_descta;
    ws_cvecta := c_interp3.tmp_cvecta;
    ws_tipmov := c_interp3.tmp_tipmov;
    wn_cargos := c_interp3.cargos;
    wn_abonos := c_interp3.abonos;
--Busca Beneficiario
    SELECT ape_auxca1
      INTO ws_nomben
      FROM sipros_erp_enc
      WHERE ape_keypol = ws_keyfac ;
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
                          cry_dec007,
                          cry_chr021,
                          cry_chr022,
                          cry_dec009,
                          cry_chr007,
                          cry_chr023,
                          cry_chr012,
                          cry_chr010,
                          cry_chr002,
                          cry_chr009,
                          cry_chr001)
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
                          ws_poliza,
                          ws_sucban,
                          ws_desprov,
                          ws_keyfac,
                          ws_nomben);
  END LOOP;
--EXCEPTION
--    WHEN OTHERS THEN
--        sp_glGenErr ('sp_tvinterp', ws_idepcc, wn_keyusu, sp_glgethor,
--		     SQLCODE, 0, SUBSTR (SQLERRM, 1, 60));
END SP_TVINTERP;
/
