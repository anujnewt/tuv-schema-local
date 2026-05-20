CREATE OR REPLACE EDITIONABLE PROCEDURE "USRSIHO"."SP_HCBGENPO2" (wn_keypol INTEGER,
                                         ws_nomrep VARCHAR2,
                                         ws_idepcc VARCHAR2,
                                         wn_keyusu INTEGER)
   IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
   ws_keyapr VARCHAR2(8);
   ws_keyper VARCHAR2(8);
   ws_cvepol VARCHAR2(30);
   ws_nompar VARCHAR2(40);
   ws_destip VARCHAR2(40);
   ws_nomusu VARCHAR2(40);
   ws_cuenta VARCHAR2(40);
   ws_corte  VARCHAR2(10);
   ws_corte2 VARCHAR2(03);
   ws_letra  VARCHAR2(10);
   ws_semana smallint;
   ws_tippol VARCHAR2(1);
   wn_numemi SMALLINT;
   wn_keynom SMALLINT;
   wn_usugen INTEGER;
   wd_fecpol DATE;
   wn_cargos  DECIMAL(18,6);
   wn_abonos DECIMAL(18,6);
   ws_periodos VARCHAR2(80);
 BEGIN
   --lectura del detalle de la poliza
   FOR cur_01 IN  (SELECT DISTINCT pol_keyapr, pam_nompar, pol_numemi, pol_keynom, nom_destip, pol_usugen,
                           usu_nomusu, pol_cvepol, pol_fecpol, det_cuenta, det_cargos, det_abonos,
                           SUBSTR(det_cuenta, 1, 10) corte, SUBSTR(det_cuenta, 8, 3) corte2, per_nu5aux,
                           SUBSTR(det_cuenta, 1,1) corte3, pol_semana
           FROM holopoli, nmlonomi, glcousua, glcopams, holodetp, nmloperi
           WHERE pol_keynom = nom_keynom AND
                 pol_usugen = usu_keyusu AND
                 pam_keypar = 'H2'       AND
                 pam_cvesec = pol_keyapr AND
                 pol_keypol = det_keypol AND
                 pol_ctvpol = 1          AND
                 pol_keypro = per_keypro AND
                 pol_keyapr = per_nu3aux AND
                 pol_numemi = per_nu4aux AND
                 pol_keynom = per_keynom AND
                 pol_keypol = wn_keypol)
   LOOP
          ws_keyapr := cur_01.pol_keyapr;
          ws_nompar := cur_01.pam_nompar;
          wn_numemi := cur_01.pol_numemi;
          wn_keynom := cur_01.pol_keynom;
          ws_destip := cur_01.nom_destip;
          wn_usugen := cur_01.pol_usugen;
          ws_nomusu := cur_01.usu_nomusu;
          ws_cvepol := cur_01.pol_cvepol;
          wd_fecpol := cur_01.pol_fecpol;
          ws_cuenta := cur_01.det_cuenta;
          wn_cargos := cur_01.det_cargos;
          wn_abonos := cur_01.det_abonos;
          ws_corte  := cur_01.corte;
          ws_corte2 := cur_01.corte2;
          ws_tippol := cur_01.per_nu5aux;
          ws_letra  := cur_01.corte3;
          ws_semana := cur_01.pol_semana;
             --inserccion de los registros en la tabla de paso
             IF (wn_keynom = 101 OR wn_keynom = 110) AND wn_cargos > 0 AND wn_abonos > 0 THEN
                ws_corte := '9999999999';
             ELSE
                ws_corte := ws_corte;
             END IF;
             IF ws_tippol = 'N' AND ws_letra= 'S' THEN
                ws_corte := ws_corte2;
             END IF;
             IF ws_tippol = 'P' AND ws_letra = 'S' THEN
                ws_corte :=ws_corte2;
             END IF;
             INSERT INTO   glwkcrys(cry_nomrep, cry_idepcc, cry_keyusu,
                           cry_chr017, cry_chr003, cry_dec006, cry_dec007, cry_chr004, cry_dec008,
                           cry_chr005, cry_chr007, cry_dat001, cry_chr006, cry_dec001, cry_dec002, cry_chr016, cry_chr009)
             VALUES(ws_nomrep, ws_idepcc, wn_keyusu,
                           ws_keyapr, ws_nompar, wn_numemi, wn_keynom, ws_destip, wn_usugen,
                           ws_nomusu, ws_cvepol, wd_fecpol, ws_cuenta, wn_cargos, wn_abonos, ws_corte, ws_semana);
   END LOOP;
   --obtencion de la lista de periodo
   ws_periodos := ' ';
   FOR cur_02 IN (SELECT DISTINCT per_keyper
           -- INTO ws_keyper
           FROM  holopoli, nmlonomi, glcousua, glcopams, usrsiho.holodetp, usrsiho.nmloperi
           WHERE pol_keynom=nom_keynom AND
                 pol_usugen=usu_keyusu AND
                 pam_keypar='H2'       AND
                 pam_cvesec=pol_keyapr AND
                 pol_keypol=det_keypol AND
                 pol_ctvpol=1          AND
                 pol_keypro=per_keypro AND
                 pol_keyapr=per_nu3aux AND
                 pol_numemi=per_nu4aux AND
                 pol_keynom=per_keynom AND
                 pol_keypol=wn_keypol)
   LOOP
       -- ws_keyapr := cur_02.per_keyper;
       -- ws_periodos := TRIM(ws_periodos) || TRIM(ws_keyper) || "; ";
       -- ws_periodos := TRIM(ws_periodos) || TRIM(ws_keyper) || '; ';
       -- ws_periodos := '4947007';
       ws_periodos := cur_02.per_keyper;
   END LOOP;
   --actualizacion del periodo
   UPDATE glwkcrys
   SET    cry_chr001 = ws_periodos
   WHERE  cry_nomrep = ws_nomrep AND
          cry_idepcc = ws_idepcc AND
          cry_keyusu = wn_keyusu;
END;
/
