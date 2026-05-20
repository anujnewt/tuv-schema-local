CREATE OR REPLACE EDITIONABLE PROCEDURE "USRSIHO"."SP_HRPREPCH2" (vs_nom_rep varchar2,
            vs_ide_pcc varchar2,
            vn_key_usu NUMBER,
            vs_key_apr varchar2) IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
BEGIN
--SIPROS, S. A. DE C. V.
--Sistema  : RH-2000  C/S
--Modulo   : Nomina de Honorario
--Programa : sp_hrprepch2
--           Reporte de RPH procesados
--Autor    : Emilio Pulido Rangel
--Fecha    : 12 de Enero de 2004
INSERT INTO glwkcrys(cry_nomrep, cry_idepcc, cry_keyusu, cry_numsec,
                   cry_dec006, cry_chr017, cry_dec007, cry_dec009,
                   cry_chr044, cry_chr011, cry_dec008, cry_chr018,
                   cry_dec012, cry_dec013, cry_dec014, cry_chr019,
                   cry_chr022, cry_chr023, cry_dec001, cry_chr003,
                   cry_dat001, cry_chr021, cry_dat002, cry_dat003,
                   cry_dec011, cry_chr004, cry_chr001, cry_chr024,
                   cry_chr007, cry_chr006, cry_chr005, cry_chr002,
                   cry_chr020, cry_chr045, cry_dec015, cry_dec016,
                   cry_chr008, cry_chr009, cry_dec005)
SELECT glwkrang.ran_nomrep, glwkrang.ran_idepcc, glwkrang.ran_keyusu,
       glwkrang.ran_keypro, glwkrang.ran_keyemp, holofrph.frp_keydep,
       glwkrang.ran_keynom, nmloalde.ald_keyemp, vs_key_apr,
       glcopams1.pam_nompar,holohgdp.hgd_keyemp, holohgdp.hgd_keypue,
       holohgdp.hgd_capini, holohgdp.hgd_capfin, holohgdp.hgd_numcap,
       holohgdp.hgd_keycon, holohgdp.hgd_marcon, holohgdp.hgd_marcos,
       holohgdp.hgd_costog, nmcodeps.dep_desdep, holofrph.frp_fecact,
       holofrph.frp_tiptra, holofrph.frp_fecsol, holofrph.frp_fectrab,
       holofrph.frp_forpag, nmlonomi.nom_destip, nmloproc.pro_despro,
       holocont.con_stsfir, nmcoempl.emp_nomemp, nmcoempl1.emp_nomemp,
       nmloconc.con_descon, nmcopues.pue_despue, glcopams.pam_nompar, 'H',
       holofrph.frp_unifor, holofrph.frp_transp,
       holoapco.apc_keycom, nmcopues.pue_nu5aux, holohgdp.hgd_keysec
  FROM glwkrang
    join holofrph on glwkrang.ran_keyemp = holofrph.frp_keyrph
    join nmloalde on holofrph.frp_keydep = nmloalde.ald_keydep
    join holohgdp on holofrph.frp_keyrph = holohgdp.hgd_keyrph
    join nmcodeps on holofrph.frp_keydep = nmcodeps.dep_keydep
    join nmlonomi on holofrph.frp_keynom = nmlonomi.nom_keynom
    join nmloproc on nmloalde.ald_keypro = nmloproc.pro_keypro
    left join holocont on holohgdp.hgd_keyfol = holocont.con_keyfol
                    AND holohgdp.hgd_keytco = holocont.con_keytco
    join nmcoempl on holohgdp.hgd_keyemp = nmcoempl.emp_keyemp
    left join nmcoempl nmcoempl1 on nmloalde.ald_keyemp = nmcoempl1.emp_keyemp
    join nmloconc on holohgdp.hgd_keycon = nmloconc.con_keycon
    join nmcopues on  holohgdp.hgd_keypue = nmcopues.pue_keypue
    join glcopams on holofrph.frp_tiptra = glcopams.pam_cvesec
                        AND glcopams.pam_keypar = 'H7'
    join glcopams glcopams1 on glcopams1.pam_keypar = 'H2' AND glcopams1.pam_cvesec = vs_key_apr
    join holodear on holodear.dea_keydep = nmloalde.ald_keydep AND vs_key_apr          = holodear.dea_keyapr
    join glcoacno on glwkrang.ran_keyusu = glcoacno.acn_keyusu
                AND holofrph.frp_keynom = glcoacno.acn_keynom
    left join holoapco on holofrph.frp_keynom = holoapco.apc_keynom AND holofrph.frp_tipfol = holoapco.apc_keytfo
            AND nmloalde.ald_keypro = holoapco.apc_keypro    AND holohgdp.hgd_keycon = holoapco.apc_keycon
            AND holoapco.apc_keyapr = vs_key_apr
 WHERE  glwkrang.ran_nomrep = vs_nom_rep
   AND glwkrang.ran_idepcc = vs_ide_pcc
   AND glwkrang.ran_keyusu = vn_key_usu;
END;
/
