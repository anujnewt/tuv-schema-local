CREATE OR REPLACE EDITIONABLE PROCEDURE "USRSIHO"."SP_HPGREPRE" (vs_nom_rep VARCHAR2,
                                        vs_ide_pcc VARCHAR2,
                                        vn_key_usu SMALLINT)
IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
-- -----------------------------------------------------------------
-- Sistema  : RH-2000  C/S
-- Modulo   : Administracion de Remuneraciones (nm)
-- Programa : sp_hpgrepre
--            Reporte de Control de Cajas
-- Fecha    : 18 de Agosto de 1999
BEGIN
INSERT INTO glwkcrys(cry_nomrep, cry_idepcc, cry_keyusu, cry_dec012,
                     cry_chr017, cry_chr004, cry_chr018, cry_chr005,
                     cry_dec011, cry_dec008, cry_dec009, cry_dat001,
                     cry_dec006, cry_dec007, cry_dec010, cry_dec001,
                     cry_dec013, cry_chr001, cry_chr002, cry_chr003,
                     cry_chr019, cry_chr020, cry_dec014, cry_dec015,
                     cry_dec016, cry_dec017, cry_dec018, cry_dec019,
                     cry_dec020)
SELECT /*+ USE_HASH(HOLORECI /BUILD) */
    glwkrang.ran_nomrep, glwkrang.ran_idepcc, glwkrang.ran_keyusu,
    glwkrang.ran_keypro, holoreci.rec_keyapr, glcopams.pam_nompar,
    nmloproc.pro_keycia, SUBSTR(nmlocias.cia_descia,1,40), holoreci.rec_numrem,
    holoreci.rec_keynom, holoreci.rec_numemi, holoreci.rec_fecpag,
    holoreci.rec_ejerci, holoreci.rec_keyemp, holoreci.rec_stsrec,
    holoreci.rec_import, holoreci.rec_keyrec, nmcoempl.emp_nomemp,
    nmlonomi.nom_destip, nmloproc.pro_despro, nmloperi.per_keyper,
    nmloperi.per_keyper,
    SUM(DECODE(agc_keyagr,1,his_import,0)),
    SUM(DECODE(agc_keyagr,2,his_import,0)),
    SUM(DECODE(agc_keyagr,3,his_import,0)),
    SUM(DECODE(agc_keyagr,5,his_import,0)),
    SUM(DECODE(agc_keyagr,15,his_import,0)),
    SUM(DECODE(agc_keyagr,21,his_import,0)),
    SUM(DECODE(agc_keyagr,22,his_import,0))
FROM
    glwkrang glwkrang,
    holoreci holoreci
    -- outer nmcoempl nmcoempl,
	         LEFT OUTER JOIN nmcoempl nmcoempl ON holoreci.rec_keyemp = nmcoempl.emp_keyemp,
    nmlonomi nmlonomi,
    nmloproc nmloproc,
    nmloperi nmloperi,
    glcopams glcopams,
    nmlocias nmlocias,
    nmlohism nmlohism,
    holoagcp holoagcp
WHERE holoreci.rec_keynom = nmlonomi.nom_keynom AND
      holoreci.rec_keypro = nmloproc.pro_keypro AND
      holoreci.rec_keypro = nmloperi.per_keypro AND
      holoreci.rec_keynom = nmloperi.per_keynom AND
      holoreci.rec_keyapr = nmloperi.per_nu3aux AND
      holoreci.rec_numemi = nmloperi.per_nu4aux AND
      nmlohism.his_keypro = nmloperi.per_keypro AND
      nmlohism.his_keyper = nmloperi.per_keyper AND
      nmlohism.his_keyemp = holoreci.rec_keyemp AND
      nmlohism.his_keycon = holoagcp.agc_keycon AND
      holoagcp.agc_keyagr in (1,2,3,5,15,21,22) AND
      TO_CHAR(holoreci.rec_stsrec) = TO_CHAR(glcopams.pam_cvesec) AND
      nmloproc.pro_keycia = nmlocias.cia_keycia AND
      holoreci.rec_keyrec = glwkrang.ran_keyemp AND
      holoreci.rec_ejerci = glwkrang.ran_keyper AND
      glcopams.pam_keypar = 'H27' AND
      glwkrang.ran_nomrep = vs_nom_rep AND
      glwkrang.ran_idepcc = vs_ide_pcc AND
      glwkrang.ran_keyusu = vn_key_usu
GROUP BY
      glwkrang.ran_nomrep, glwkrang.ran_idepcc, glwkrang.ran_keyusu,
      glwkrang.ran_keypro, holoreci.rec_keyapr, glcopams.pam_nompar,
      nmloproc.pro_keycia, nmlocias.cia_descia, holoreci.rec_numrem,
      holoreci.rec_keynom, holoreci.rec_numemi, holoreci.rec_fecpag,
      holoreci.rec_ejerci, holoreci.rec_keyemp, holoreci.rec_stsrec,
      holoreci.rec_import, holoreci.rec_keyrec, nmcoempl.emp_nomemp,
      nmlonomi.nom_destip, nmloproc.pro_despro, nmloperi.per_keyper;
END;
/
