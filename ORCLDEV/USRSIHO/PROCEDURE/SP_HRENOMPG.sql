CREATE OR REPLACE EDITIONABLE PROCEDURE "USRSIHO"."SP_HRENOMPG" (vs_nom_rep VARCHAR2,
										vs_ide_pcc VARCHAR2,
										vn_key_usu SMALLINT,
										vn_opc_ion SMALLINT,
										vn_mes_ini SMALLINT,
										vn_mes_fin SMALLINT,
										vs_key_apr VARCHAR2,
										vn_key_pro SMALLINT)
IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
--Sistema  : RH-2000  C/S
--Modulo   :
--Programa : sp_hrenompg
--           Listado de nominas pagadas
BEGIN
DELETE FROM glwkcrys
WHERE cry_nomrep = vs_nom_rep
  AND cry_keyusu = vn_key_usu
  AND cry_idepcc = vs_ide_pcc;
IF vn_opc_ion = 1 THEN           -- TODOS LOS PAGOS
   INSERT INTO glwkcrys (cry_nomrep,cry_keyusu,cry_idepcc,cry_numsec,
               cry_chr017,cry_chr018,cry_dec006,cry_dec011,cry_dec012,
               cry_dec013,cry_dec014,cry_dec015,cry_dec016,cry_dec017,
               cry_dec018,cry_dec019,cry_dec020,cry_dec021,cry_dec022,
               cry_dec023,cry_dec024,cry_dec025,cry_dec001,cry_dec002,
                          cry_dec003,cry_dec004)
    SELECT vs_nom_rep,vn_key_usu,vs_ide_pcc, per_keynom,per_nu4aux,
           per_nu3aux area, per_nummes,
           SUM(DECODE(agc_keyagr,23,his_import,0)) bases,
           SUM(DECODE(agc_keyagr,24,his_import,0)) otr_ing,
           SUM(DECODE(agc_keyagr,25,his_import,0)) tie_ext,
           SUM(DECODE(agc_keyagr,26,his_import,0)) sindic,
           SUM(DECODE(agc_keyagr, 2,his_import,0)) iva_acr,
           SUM(DECODE(agc_keyagr, 3,his_import,0)) iva_pen,
           SUM(DECODE(agc_keyagr,15,his_import,0)) ispttt,
           SUM(DECODE(agc_keyagr,21,his_import,0)) isr_nac,
           SUM(DECODE(agc_keyagr,22,his_import,0)) isr_ext,
           SUM(DECODE(agc_keyagr, 8,his_import,0)) pensio,
           SUM(DECODE(agc_keyagr, 7,his_import,0)) otr_des,
           SUM(DECODE(agc_keyagr, 5,his_import,0)) iva_ret,
           SUM(DECODE(his_keycon, 'H20',his_import,0)) prev_soc,
           SUM(DECODE(his_keycon, 'H64',his_import,0)),
           SUM(DECODE(his_keycon, 'H29',his_import,0)),
           SUM(DECODE(his_keycon, 'H63',his_import,0)),
           SUM(DECODE(his_keycon, 'H97',his_import,0)),
           SUM(DECODE(his_keycon, 'H98',his_import,0)),
           SUM(DECODE(his_keycon, 'H30',his_import,0))
      FROM nmlohism, nmloperi, nmloalde, nmcoempl, holoagcp, glwkrang
     WHERE his_keypro = per_keypro
       AND his_keyper = per_keyper
       AND his_keydep = ald_keydep
       AND his_keyemp = emp_keyemp
       AND his_keycon = agc_keycon
       AND per_nummes between vn_mes_ini and vn_mes_fin
       AND per_keyper > 1000000
       AND agc_keyagr in (23,24,25,26,2,3,15,21,22,8,7,5,9,6)
       AND ran_nomrep = 'hrenompg'
       AND ran_idepcc = vs_ide_pcc
       AND ran_keyusu = vn_key_usu
       AND ran_keypro = per_keypro
       AND ran_keyper = per_keyper
     GROUP BY  per_keynom, per_nu4aux, per_nu3aux, per_nummes;
ELSIF vn_opc_ion = 2 THEN          -- SIN CANCELACIONES
   INSERT INTO glwkcrys (cry_nomrep,cry_keyusu,cry_idepcc,cry_numsec,
               cry_chr017,cry_chr018,cry_dec006,cry_dec011,cry_dec012,
               cry_dec013,cry_dec014,cry_dec015,cry_dec016,cry_dec017,
               cry_dec018,cry_dec019,cry_dec020,cry_dec021,cry_dec022,
               cry_dec023,cry_dec024,cry_dec025,cry_dec001,cry_dec002,
                          cry_dec003,cry_dec004)
    SELECT vs_nom_rep,vn_key_usu,vs_ide_pcc, per_keynom,per_nu4aux,
           per_nu3aux area, per_nummes,
           SUM(DECODE(agc_keyagr,23,his_import,0)) bases,
           SUM(DECODE(agc_keyagr,24,his_import,0)) otr_ing,
           SUM(DECODE(agc_keyagr,25,his_import,0)) tie_ext,
           SUM(DECODE(agc_keyagr,26,his_import,0)) sindic,
           SUM(DECODE(agc_keyagr, 2,his_import,0)) iva_acr,
           SUM(DECODE(agc_keyagr, 3,his_import,0)) iva_pen,
           SUM(DECODE(agc_keyagr,15,his_import,0)) ispttt,
           SUM(DECODE(agc_keyagr,21,his_import,0)) isr_nac,
           SUM(DECODE(agc_keyagr,22,his_import,0)) isr_ext,
           SUM(DECODE(agc_keyagr, 8,his_import,0)) pensio,
           SUM(DECODE(agc_keyagr, 7,his_import,0)) otr_des,
           SUM(DECODE(agc_keyagr, 5,his_import,0)) iva_ret,
           SUM(DECODE(his_keycon, 'H20',his_import,0)) prev_soc,
           SUM(DECODE(his_keycon, 'H64',his_import,0)),
           SUM(DECODE(his_keycon, 'H29',his_import,0)),
           SUM(DECODE(his_keycon, 'H63',his_import,0)),
           SUM(DECODE(his_keycon, 'H97',his_import,0)),
           SUM(DECODE(his_keycon, 'H98',his_import,0)),
           SUM(DECODE(his_keycon, 'H30',his_import,0))
      FROM nmlohism,nmloperi,nmloalde,nmcoempl,holoagcp,glwkrang
     WHERE his_keypro = per_keypro
       AND his_keyper = per_keyper
       AND his_keydep = ald_keydep
       AND his_keyemp = emp_keyemp
       AND his_keycon = agc_keycon
       -- AND his_ca1aux[4] = '0'
       AND SUBSTR(his_ca1aux, 4, 1) = '0'
       AND per_nummes between vn_mes_ini and vn_mes_fin
       AND per_keyper > 1000000
       AND agc_keyagr in (23,24,25,26,2,3,15,21,22,8,7,5,9,6)
       AND ran_nomrep = 'hrenompg'
       AND ran_idepcc = vs_ide_pcc
       AND ran_keyusu = vn_key_usu
       AND ran_keypro = per_keypro
       AND ran_keyper = per_keyper
     GROUP BY  per_keynom,per_nu4aux,per_nu3aux,per_nummes;
ELSIF vn_opc_ion = 3 THEN         -- SOLO CANCELADOS
   INSERT INTO glwkcrys (cry_nomrep,cry_keyusu,cry_idepcc,cry_numsec,
               cry_chr017,cry_chr018,cry_dec006,cry_dec011,cry_dec012,
               cry_dec013,cry_dec014,cry_dec015,cry_dec016,cry_dec017,
               cry_dec018,cry_dec019,cry_dec020,cry_dec021,cry_dec022,
               cry_dec023,cry_dec024,cry_dec025,cry_dec001,cry_dec002,
                          cry_dec003,cry_dec004)
    SELECT vs_nom_rep,vn_key_usu,vs_ide_pcc, per_keynom,per_nu4aux,
           per_nu3aux area, per_nummes,
           SUM(DECODE(agc_keyagr,23,his_import,0)) bases,
           SUM(DECODE(agc_keyagr,24,his_import,0)) otr_ing,
           SUM(DECODE(agc_keyagr,25,his_import,0)) tie_ext,
           SUM(DECODE(agc_keyagr,26,his_import,0)) sindic,
           SUM(DECODE(agc_keyagr, 2,his_import,0)) iva_acr,
           SUM(DECODE(agc_keyagr, 3,his_import,0)) iva_pen,
           SUM(DECODE(agc_keyagr,15,his_import,0)) ispttt,
           SUM(DECODE(agc_keyagr,21,his_import,0)) isr_nac,
           SUM(DECODE(agc_keyagr,22,his_import,0)) isr_ext,
           SUM(DECODE(agc_keyagr, 8,his_import,0)) pensio,
           SUM(DECODE(agc_keyagr, 7,his_import,0)) otr_des,
           SUM(DECODE(agc_keyagr, 5,his_import,0)) iva_ret,
           SUM(DECODE(his_keycon, 'H20',his_import,0)) prev_soc,
           SUM(DECODE(his_keycon, 'H64',his_import,0)),
           SUM(DECODE(his_keycon, 'H29',his_import,0)),
           SUM(DECODE(his_keycon, 'H63',his_import,0)),
           SUM(DECODE(his_keycon, 'H97',his_import,0)),
           SUM(DECODE(his_keycon, 'H98',his_import,0)),
           SUM(DECODE(his_keycon, 'H30',his_import,0))
      FROM nmlohism,nmloperi,nmloalde,nmcoempl,holoagcp,glwkrang
     WHERE his_keypro = per_keypro
       AND his_keyper = per_keyper
       AND his_keydep = ald_keydep
       AND his_keyemp = emp_keyemp
       AND his_keycon = agc_keycon
       -- AND his_ca1aux[4] = '2'
       AND SUBSTR(his_ca1aux, 4, 1) = '2'
       AND per_nummes between vn_mes_ini and vn_mes_fin
       AND per_keyper > 1000000
       AND agc_keyagr in (23,24,25,26,2,3,15,21,22,8,7,5,9,6)
       AND ran_nomrep = 'hrenompg'
       AND ran_idepcc = vs_ide_pcc
       AND ran_keyusu = vn_key_usu
       AND ran_keypro = per_keypro
       AND ran_keyper = per_keyper
     GROUP BY  per_keynom,per_nu4aux,per_nu3aux,per_nummes;
ELSIF vn_opc_ion = 4 THEN         -- REALMENTE PAGADOS
   INSERT INTO glwkcrys (cry_nomrep,cry_keyusu,cry_idepcc,cry_numsec,
               cry_chr017,cry_chr018,cry_dec006,cry_dec011,cry_dec012,
               cry_dec013,cry_dec014,cry_dec015,cry_dec016,cry_dec017,
               cry_dec018,cry_dec019,cry_dec020,cry_dec021,cry_dec022,
               cry_dec023,cry_dec024,cry_dec025,cry_dec001,cry_dec002,
                          cry_dec003,cry_dec004)
    SELECT vs_nom_rep,vn_key_usu,vs_ide_pcc, per_keynom,per_nu4aux,
           per_nu3aux area, per_nummes,
           SUM(DECODE(agc_keyagr,23,his_import,0)) bases,
           SUM(DECODE(agc_keyagr,24,his_import,0)) otr_ing,
           SUM(DECODE(agc_keyagr,25,his_import,0)) tie_ext,
           SUM(DECODE(agc_keyagr,26,his_import,0)) sindic,
           SUM(DECODE(agc_keyagr, 2,his_import,0)) iva_acr,
           SUM(DECODE(agc_keyagr, 3,his_import,0)) iva_pen,
           SUM(DECODE(agc_keyagr,15,his_import,0)) ispttt,
           SUM(DECODE(agc_keyagr,21,his_import,0)) isr_nac,
           SUM(DECODE(agc_keyagr,22,his_import,0)) isr_ext,
           SUM(DECODE(agc_keyagr, 8,his_import,0)) pensio,
           SUM(DECODE(agc_keyagr, 7,his_import,0)) otr_des,
           SUM(DECODE(agc_keyagr, 5,his_import,0)) iva_ret,
           SUM(DECODE(his_keycon, 'H20',his_import,0)) prev_soc,
           SUM(DECODE(his_keycon, 'H64',his_import,0)),
           SUM(DECODE(his_keycon, 'H29',his_import,0)),
           SUM(DECODE(his_keycon, 'H63',his_import,0)),
           SUM(DECODE(his_keycon, 'H97',his_import,0)),
           SUM(DECODE(his_keycon, 'H98',his_import,0)),
           SUM(DECODE(his_keycon, 'H30',his_import,0))
      FROM nmlohism,nmloperi,nmloalde,nmcoempl,holoagcp,glwkrang
     WHERE his_keypro = per_keypro
       AND his_keyper = per_keyper
       AND his_keydep = ald_keydep
       AND his_keyemp = emp_keyemp
       AND his_keycon = agc_keycon
       -- AND his_ca1aux[4] in ('1','3')
       AND SUBSTR(his_ca1aux, 4, 1) IN ('1','3')
       AND per_nummes between vn_mes_ini and vn_mes_fin
       AND per_keyper > 1000000
       AND agc_keyagr IN (23,24,25,26,2,3,15,21,22,8,7,5,9,6)
       AND ran_nomrep = 'hrenompg'
       AND ran_idepcc = vs_ide_pcc
       AND ran_keyusu = vn_key_usu
       AND ran_keypro = per_keypro
       AND ran_keyper = per_keyper
     GROUP BY  per_keynom,per_nu4aux,per_nu3aux,per_nummes;
END IF;
END;
/
