CREATE OR REPLACE EDITIONABLE PROCEDURE "USRSIHO"."SP_HPGREPDP" (vs_nom_rep VARCHAR2,
                             vn_key_pro NUMBER,
                             vs_key_apr VARCHAR2,
                             vn_key_usu NUMBER,
                             vs_ide_pcc VARCHAR2,
                             vn_tip_pag NUMBER,
                             vn_ban_cos NUMBER,
                             vn_efe_cti NUMBER,
                             vn_key_nom NUMBER,
                             vn_num_emi NUMBER) IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
BEGIN
  -- Sistema  : RH-2000  C/S
  -- Modulo   : Nomina de Honorarios(ho)
  -- Programa : sp_ hpgrepdp
  --            Seleccion de datos de recibos pendientes de pago
  -- Autor    : Veronica Vazquez Rodriguez
  -- Fecha    : 14 de Octubre de 1999
   DELETE FROM USRSIHO.glwkcrys
    WHERE cry_nomrep = vs_nom_rep
      AND cry_idepcc = vs_ide_pcc
      AND cry_keyusu = vn_key_usu;
   INSERT INTO USRSIHO.glwkcrys(cry_nomrep, cry_idepcc, cry_keyusu,
                        cry_numsec, cry_chr017, cry_dec006,
                        cry_dec009, cry_dec008, cry_chr001,
                        cry_chr012, cry_dec007, cry_dec001,
                        cry_dec002, cry_dec003, cry_dec004,
                        cry_dec005)
   SELECT -- /*+ USE_HASH (nmlohism / BUILD) */
          vs_nom_rep,
          vs_ide_pcc,
          vn_key_usu,
          rec_keypro,
          rec_keyapr,
          rec_keynom,
          rec_numemi,
          rec_keyemp,
          emp_nomemp,
          emp_keycen,
          rec_keyrec,
SUM(DECODE(agc_keyagr,1,his_import,0)),
SUM(DECODE(agc_keyagr,2,his_import,0)),
SUM(DECODE(agc_keyagr,5,his_import,14,his_import,15,his_import,0)),
SUM(DECODE(agc_keyagr,7,his_import,8,his_import,0)),
          rec_import
     FROM USRSIHO.holoreci,
          USRSIHO.nmcoempl,
          USRSIHO.nmloperi,
--          glwkrang,
          USRSIHO.nmlohism ,
          USRSIHO.holoagcp
    WHERE rec_keyemp = emp_keyemp
      AND rec_keypro = per_keypro
      AND rec_keyapr = per_nu3aux
      AND rec_keynom = per_keynom
      AND rec_numemi = per_nu4aux
      AND per_keypro = his_keypro
      AND per_keyper = his_keyper
      AND rec_keyemp = his_keyemp
      AND his_keycon = agc_keycon
      AND agc_keyagr in  (1,2,5,14,15,7,8)
--     AND rec_keyemp = ran_keyemp
--     AND rec_keynom = ran_keynom
--     AND rec_numemi = ran_keycen
      AND rec_keypro = vn_key_pro
      AND rec_keyapr = vs_key_apr
      AND rec_keynom = vn_key_nom
      AND rec_numemi = vn_num_emi
--      AND ran_nomrep = vs_nom_rep
--      AND ran_idepcc = vs_ide_pcc
--      AND ran_keyusu = vn_key_usu
--      AND ran_keypro = vn_key_pro
      AND((vn_tip_pag  = 1
      AND((vn_ban_cos = 1 AND substr(emp_cveban,1,3) =  '002' AND rec_stsfon = 0)
        OR(vn_ban_cos = 2 AND substr(emp_cveban,1,3) <> '002' AND rec_stsfon = 0)
        OR(vn_ban_cos = 3 AND rec_stsfon = 0  AND emp_cveban IS NOT NULL)))
       OR(vn_tip_pag  = 2
      AND((vn_efe_cti = 1 AND rec_stsfon = 1)
        OR(vn_efe_cti = 2 AND rec_stsfon IN(0,2)   AND emp_cveban IS NULL)
        OR(vn_efe_cti = 3 AND rec_stsfon IN(0,1,2) AND emp_cveban IS NULL)))
       OR vn_tip_pag = 3)
      AND rec_stsrec = 0
    GROUP BY rec_keypro,
             rec_keyapr,
             rec_keynom,
             rec_numemi,
             rec_keyemp,
             emp_nomemp,
             emp_keycen,
             rec_keyrec,
             rec_import;
END;
/
