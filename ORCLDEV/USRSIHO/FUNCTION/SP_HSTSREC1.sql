CREATE OR REPLACE EDITIONABLE FUNCTION "USRSIHO"."SP_HSTSREC1" (vn_key_pro IN NUMBER,
                             vs_key_apr IN VARCHAR2,
                             vn_key_nom IN NUMBER,
                             vs_num_emi IN VARCHAR2,
                             vn_key_emp IN NUMBER)
   RETURN NUMBER IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
   vs_mar_con   usrsiho.hologdpr.gdp_marcon %TYPE;
   vn_key_fol   usrsiho.hologdpr.gdp_keyfol %TYPE;
   vn_key_tco   usrsiho.hologdpr.gdp_keytco %TYPE;
   vs_sts_fir   usrsiho.holocont.con_stsfir %TYPE;
   vn_sta_pro   NUMBER(5);
BEGIN
   vn_sta_pro := 1;
   FOR rec
      IN (SELECT hgd_marcon,hgd_keytco,
             hgd_keyfol,con_stsfir
        FROM usrsiho.nmloperi
        JOIN usrsiho.holofrph on nmloperi.per_keypro = holofrph.frp_keypro AND nmloperi.per_keyper = holofrph.frp_keyper
        JOIN usrsiho.holohgdp on frp_keyrph = hgd_keyrph AND hgd_keyemp = vn_key_emp AND hgd_marcon != 'X'
        JOIN usrsiho.nmloalde on frp_keydep = ald_keydep AND ald_marcco != 'E'
        LEFT JOIN usrsiho.holocont on  hgd_keytco = con_keytco AND hgd_keyfol = con_keyfol
       WHERE per_keypro = vn_key_pro
         AND per_nu3aux = vs_key_apr
         AND per_keynom = vn_key_nom
         AND per_nu4aux = vs_num_emi
         ) LOOP
            vs_mar_con := rec.hgd_marcon;
            vn_key_tco := rec.hgd_keytco;
            vn_key_fol := rec.hgd_keyfol;
            vs_sts_fir := rec.con_stsfir;
            IF vs_mar_con = 'N' THEN
               vn_sta_pro := 3;
               EXIT;
            END IF;
            IF vs_mar_con = 'S' THEN
               IF vs_sts_fir = 'N' THEN
                  vn_sta_pro := 2;
               END IF;
            END IF;
   END LOOP;
   RETURN vn_sta_pro;
END SP_HSTSREC1;
/
--Source_DDLS

  CREATE OR REPLACE EDITIONABLE FUNCTION "USRSIHO"."SP_HSTSREC1" (vn_key_pro IN NUMBER,
                             vs_key_apr IN VARCHAR2,
                             vn_key_nom IN NUMBER,
                             vs_num_emi IN VARCHAR2,
                             vn_key_emp IN NUMBER)
   RETURN NUMBER IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
   vs_mar_con   usrsiho.hologdpr.gdp_marcon %TYPE;
   vn_key_fol   usrsiho.hologdpr.gdp_keyfol %TYPE;
   vn_key_tco   usrsiho.hologdpr.gdp_keytco %TYPE;
   vs_sts_fir   usrsiho.holocont.con_stsfir %TYPE;
   vn_sta_pro   NUMBER(5);
BEGIN
   vn_sta_pro := 1;
   FOR rec
      IN (SELECT hgd_marcon,hgd_keytco,
             hgd_keyfol,con_stsfir
        FROM usrsiho.nmloperi
        JOIN usrsiho.holofrph on nmloperi.per_keypro = holofrph.frp_keypro AND nmloperi.per_keyper = holofrph.frp_keyper
        JOIN usrsiho.holohgdp on frp_keyrph = hgd_keyrph AND hgd_keyemp = vn_key_emp AND hgd_marcon != 'X'
        JOIN usrsiho.nmloalde on frp_keydep = ald_keydep AND ald_marcco != 'E'
        LEFT JOIN usrsiho.holocont on  hgd_keytco = con_keytco AND hgd_keyfol = con_keyfol
       WHERE per_keypro = vn_key_pro
         AND per_nu3aux = vs_key_apr
         AND per_keynom = vn_key_nom
         AND per_nu4aux = vs_num_emi
         ) LOOP
            vs_mar_con := rec.hgd_marcon;
            vn_key_tco := rec.hgd_keytco;
            vn_key_fol := rec.hgd_keyfol;
            vs_sts_fir := rec.con_stsfir;
            IF vs_mar_con = 'N' THEN
               vn_sta_pro := 3;
               EXIT;
            END IF;
            IF vs_mar_con = 'S' THEN
               IF vs_sts_fir = 'N' THEN
                  vn_sta_pro := 2;
               END IF;
            END IF;
   END LOOP;
   RETURN vn_sta_pro;
END SP_HSTSREC1;
/
