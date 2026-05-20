CREATE OR REPLACE EDITIONABLE PROCEDURE "USRSIHO"."SP_HPGPFAOR3" (wn_keypro NUMBER,
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
   ws_keyemp VARCHAR2(20);
   ws_nomemp VARCHAR2(60);
   ws_numfac VARCHAR2(40);
   wn_impfac NUMBER(18,6);
   wn_keypol NUMBER(10);
   wi_pol_forpag NUMBER(5);
   wd_pol_tipcam NUMBER(16,4);
   vs_tiporep VARCHAR2(02);
BEGIN
   --lectura de las Facturas
   FOR rec IN (SELECT pol_keypro,        --cry_dec006 Integer   wn_keypro
                  pro_despro,        --cry_chr003 VARCHAR2(40)  ws_despro
                  pol_keyapr,        --cry_chr017 VARCHAR2(08)  ws_keyapr
                  pam_nompar,        --cry_chr004 VARCHAR2(40)  ws_nompar
                  pol_keynom,        --cry_chr018 VARCHAR2(08)  wn_keynom
                  nom_destip,        --cry_chr005 VARCHAR2(40)  ws_destip
                  pol_numemi,        --cry_chr019 VARCHAR2(08)  wn_numemi
                  pol_fecpol,        --cry_dat001 Date      wd_fecpol
                  pol_usugen,        --cry_dec008 Integer   wn_usugen
                  usu_nomusu,        --cry_chr006 VARCHAR2(40)  ws_nomusu
                  pol_tippol,        --cry_chr020 VARCHAR2(08)  ws_tippol
                  pol_keyemp||'-'||ben_keyben empl,        --cry_chr009 Integer   ws_keyemp
                  ben_nomben,        --cry_chr001 VARCHAR2(60)  ws_nomemp
                  pol_cvepol,        --cry_chr007 VARCHAR2(40)  ws_numfac
                  (pol_abopas-pol_carpas) diferencia, --cry_dec003 Dec(18,6) wn_impfac
                  det_keypol,        --cry_dec009 Integer   wn_keypol
                  substr(det_cuenta,9,14) cuenta,  --cry_chr008 VARCHAR2(20)  ws_cuenta
                  SUM(det_cargos) cargos,   --cry_dec001 Dec(18,6) wn_cargos
                  SUM(det_abonos) abonos,   --cry_dec002 Dec(18,6) wn_abonos
                  pol_forpag,
                  pol_tipcam
                         FROM USRSIHO.holopoli1,
                  USRSIHO.holodetp1,
                  USRSIHO.nmlonomi,
                  USRSIHO.glcopams,
                  USRSIHO.nmloproc,
                  USRSIHO.glcousua,
                  USRSIHO.nmlobene,
                  USRSIHO.nmlopres,
                  USRSIHO.nmcoempl
            WHERE pol_keypol = det_keypol
              AND pol_keynom = nom_keynom
              AND pol_keypro = pro_keypro
              AND pol_keyapr = pam_cvesec
              AND pol_usugen = usu_keyusu
              AND pol_keyemp = emp_keyemp
              AND pam_keypar='H2'
              AND pol_keypro = wn_keypro
              AND pol_keyapr = ws_keyapr
              AND pol_keynom = wn_keynom
              AND pol_numemi = wn_numemi
              AND pol_tippol = ws_tippol
              AND pol_cvepol like '%-P%'
              AND pol_regrfc=ben_rfcben
              AND emp_keyemp=ben_keyemp
              AND pre_keyemp = emp_keyemp  --JC
              AND pre_keyemp = ben_keyemp  --JC
              AND pre_ca4aux = ben_keyben  --JC
              AND pre_keycon = 'HPA'       --JC
              AND pre_status = 2           --JC
              AND pol_cvepol like '%P'||ben_keyben
              AND pol_stspol = ws_status
         GROUP BY pol_keypro,pro_despro,pol_keyapr,pam_nompar,pol_keynom,nom_destip,pol_numemi,pol_fecpol,pol_usugen,
                  usu_nomusu,pol_tippol,pol_keyemp,ben_keyben ,ben_nomben,pol_cvepol,det_keypol,pol_forpag,pol_tipcam,
                  pol_abopas,pol_carpas,substr(det_cuenta,9,14)
         ORDER BY pol_keyemp,ben_keyben,det_keypol,substr(det_cuenta,9,14)) LOOP
--12,16,17,1,2,3,4,5,6,7,8,9,10,11,13,14,15,20,21
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
     ws_keyemp := rec.empl;
     ws_nomemp := rec.ben_nomben;
     ws_numfac := rec.pol_cvepol;
     wn_impfac := rec.diferencia;
     wn_keypol := rec.det_keypol;
     ws_cuenta := rec.cuenta;
     wn_cargos := rec.cargos;
     wn_abonos := rec.abonos;
     wi_pol_forpag := rec.pol_forpag;
     wd_pol_tipcam := rec.pol_tipcam;
     if substr(length(ws_numfac)-1,1) = 'P' then
--     	vs_tiporep = 'SP'
--     else
--     	vs_tiporep = 'NP'
--     end if;
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
                          cry_dec007, --
                          cry_chr001,
                          cry_chr007,
                          cry_dec003,
                          cry_dec009,
                          cry_dec010,
                          cry_dec004,
                          cry_chr040)
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
                          wd_fecpol,
                          wn_usugen,
                          ws_nomusu,
                          ws_tippol,
                          ws_cuenta,
                          wn_cargos,
                          wn_abonos,
                          ws_keyemp,
                          ws_nomemp,
                          ws_numfac,
                          wn_impfac,
                          wn_keypol,
                          wi_pol_forpag,
                          wd_pol_tipcam,
                          'SP'
                          );
		else
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
                          cry_chr009, --
                          cry_chr001,
                          cry_chr007,
                          cry_dec003,
                          cry_dec009,
                          cry_dec010,
                          cry_dec004,
                          cry_chr040)
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
                          wd_fecpol,
                          wn_usugen,
                          ws_nomusu,
                          ws_tippol,
                          ws_cuenta,
                          wn_cargos,
                          wn_abonos,
                          ws_keyemp,
                          ws_nomemp,
                          ws_numfac,
                          wn_impfac,
                          wn_keypol,
                          wi_pol_forpag,
                          wd_pol_tipcam,
                          'NP'
                          );
		end if;
   END LOOP;
END;
/
