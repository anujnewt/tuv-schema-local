CREATE OR REPLACE EDITIONABLE PROCEDURE "USRSIHO"."SP_HPGPFAOR1" (wn_keypro NUMBER,
        ws_keyapr VARCHAR2,wn_keynom NUMBER,wn_numemi NUMBER,ws_tippol VARCHAR2,
        ws_nomrep VARCHAR2,ws_idepcc VARCHAR2,wn_keyusu NUMBER,ws_status VARCHAR2) IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
--AEDO 28/08/06  Se agrego la variable ws_status, la cual trae el status que se desea generar (A - P - C)
   ws_despro VARCHAR2(40);ws_nompar VARCHAR2(40);ws_destip VARCHAR2(40);ws_nomusu VARCHAR2(40);ws_cuenta VARCHAR2(40);
   wn_usugen NUMBER(10);
   wd_fecpol DATE;
   wn_cargos NUMBER(18,6);wn_abonos NUMBER(18,6);
   wi_pol_forpag NUMBER(5);
   wi_pol_fpafin NUMBER(5);
   wd_pol_tipcam NUMBER(16,4);
	 ws_tipofac VARCHAR2(02);
	 ws_desfpa  VARCHAR2(20);
	 ws_desfpf  VARCHAR2(20);
	 ws_tipfac  VARCHAR2(01);
BEGIN
   --lectura de las Facturas
   FOR rec IN (SELECT pol_keypro,        --cry_dec006 Integer   wn_keypro
                  pro_despro,        --cry_chr003 VARCHAR2(40)  ws_despro
                  pol_keyapr,        --cry_chr017 VARCHAR2(08)  ws_keyapr
                  pam_nompar,        --cry_chr004 VARCHAR2(40)  ws_nompar
                  pol_keynom,        --cry_chr018 VARCHAR2(08)  wn_keynom
                  nom_destip,        --cry_chr005 VARCHAR2(40)  ws_destip
                  pol_numemi,        --cry_chr019 VARCHAR2(08)  wn_numemi
                  pol_fecpol,        --cry_dat001 Date      --wd_fecpol
                  pol_usugen,        --cry_dec008 Integer   wn_usugen
                  usu_nomusu,        --cry_chr006 VARCHAR2(40)  ws_nomusu
                  pol_tippol,        --cry_chr020 VARCHAR2(08)  ws_tippol
                  substr(det_cuenta,9,14) cuenta,  --cry_chr008 VARCHAR2(20)  ws_cuenta
                  SUM(det_cargos) cargos,   --cry_dec001 Dec(18,6) wn_cargos
                  SUM(det_abonos) abonos,   --cry_dec002 Dec(18,6) wn_abonos
                  pol_forpag,
                  pol_tipcam,
                  pol_fpafin
                      FROM USRSIHO.holopoli1,
                  USRSIHO.holodetp1,
                  USRSIHO.nmlonomi,
                  USRSIHO.glcopams,
                  USRSIHO.nmloproc,
                  USRSIHO.glcousua
            WHERE pol_keypol = det_keypol
              AND pol_keynom = nom_keynom
              AND pol_keypro = pro_keypro
              AND pol_keyapr = pam_cvesec
              AND pol_usugen = usu_keyusu
              AND pam_keypar='H2'
              AND pol_keypro = wn_keypro
              AND pol_keyapr = ws_keyapr
              AND pol_keynom = wn_keynom
              AND pol_numemi = wn_numemi
              AND pol_tippol = ws_tippol
              AND pol_stspol = ws_status
         GROUP BY pol_keypro,pro_despro,pol_keyapr,pam_nompar,pol_keynom,nom_destip,pol_numemi,pol_fecpol,pol_usugen,usu_nomusu,
            pol_tippol,pol_forpag,pol_tipcam,pol_fpafin,substr(det_cuenta,9,14)
         ORDER BY substr(det_cuenta,9,14)) LOOP
--12,1,2,3,4,5,6,7,8,9,10,11,15,16,17
     -- Obtiene La descripcion de la Moneda
     --wn_keypro := rec.pol_keypro;
     ws_despro := rec.pro_despro;
     --ws_keyapr := rec.pol_keyapr;
     ws_nompar := rec.pam_nompar;
     --wn_keynom := rec.pol_keynom;
     ws_destip := rec.nom_destip;
     --wn_numemi := rec.pol_numemi;
     wd_fecpol := rec.pol_fecpol;
     wn_usugen := rec.pol_usugen;
     ws_nomusu := rec.usu_nomusu;
     --ws_tippol := rec.pol_tippol;
     ws_cuenta := rec.cuenta;
     wn_cargos := rec.cargos;
     wn_abonos := rec.abonos;
     wi_pol_forpag := rec.pol_forpag;
     wd_pol_tipcam := rec.pol_tipcam;
     wi_pol_fpafin := rec.pol_fpafin;
     BEGIN
            SELECT a.pam_folini, b.pam_folini
              INTO ws_desfpa, ws_desfpf
              FROM USRSIHO.glcopams a, USRSIHO.glcopams b
             WHERE a.pam_keypar = 'H10'
               AND a.pam_cvesec = wi_pol_forpag
               AND b.pam_keypar = 'H10'
               AND b.pam_cvesec = wi_pol_fpafin;
            EXCEPTION WHEN no_data_found THEN ws_desfpa := ''; ws_desfpf := '';
     END;
     --Obtiene el tipo de Factura o Poliza modificacion Fecha 22/MAY/2007
     BEGIN
         SELECT per_nu5aux
           INTO ws_tipfac
           FROM USRSIHO.nmloperi
          WHERE per_keypro = wn_keypro
            AND per_nu3aux = ws_keyapr
            AND per_keynom = wn_keynom
            AND per_nu4aux = wn_numemi;
        EXCEPTION WHEN no_data_found THEN ws_tipfac := '';
     END;
      ---Fecha 22/MAY/2007---
     -- Inserta Valores
     INSERT INTO USRSIHO.glwkcrys(cry_nomrep,
                          cry_idepcc,
                          cry_keyusu,
                          cry_dec006,
                          cry_chr003,
                          cry_chr017,
                          cry_chr004,
                          cry_chr018,
                          cry_chr005,
                          cry_chr019,
                          cry_dat001,
                          cry_dec008,
                          cry_chr006,
                          cry_chr020,
                          cry_chr008,
                          cry_dec001,
                          cry_dec002,
                          cry_dec010,
                          cry_dec004,
                          cry_dec005,
                          cry_chr012,
                          cry_chr013)
                   VALUES(ws_nomrep,
                          ws_idepcc,
                          wn_keyusu,
                          wn_keypro,
                          ws_despro,
                          ws_keyapr,
                          ws_nompar,
                          wn_keynom,
                          ws_destip,
                          wn_numemi,
                          wd_fecpol,   -- NULL
                          wn_usugen,
                          ws_nomusu,
                          ws_tipfac,   --ws_tippol,
                          ws_cuenta,
                          wn_cargos,
                          wn_abonos,
                          wi_pol_forpag,
                          wd_pol_tipcam,
                          wi_pol_fpafin,
                          ws_desfpa,
                          ws_desfpf);
   END LOOP;
   --TRACE OFF;
END;
/
