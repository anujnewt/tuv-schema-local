CREATE OR REPLACE EDITIONABLE PROCEDURE "USRSIHO"."SP_HRPREPCA" (vs_nom_rep varchar2, vs_ide_pcc varchar2,
vn_key_usu NUMBER, vs_key_apr varchar2) IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
BEGIN
--SIPROS, S. A. DE C. V.
--Sistema  : RH-2000  C/S --Modulo   : Nomina de Honorarios --Programa :
--_hrprepca --           Reporte de RPH procesados --Autor    : Veronica Vazquez
--driguez --Fecha    : 01 de Agosto de 1999
--SET DEBUG FILE TO "/rapps/usuarios/sistemas/cig/temp.txt";
--TRACE ON;
--TRACE OFF;
INSERT INTO USRSIHO.glwkcrys(cry_nomrep, cry_idepcc, cry_keyusu, cry_numsec, cry_dec006,
cry_chr017, cry_dec007, cry_dec009, cry_chr044, cry_chr011, cry_dec008,
cry_chr018, cry_dec012, cry_dec013, cry_dec014, cry_chr019, cry_chr022,
cry_chr023, cry_dec001, cry_chr003, cry_dat001, cry_chr021, cry_dat002,
cry_dat003, cry_dec011, cry_chr004, cry_chr001, cry_chr024, cry_chr007,
cry_chr006, cry_chr005, cry_chr002, cry_chr020, cry_chr045, cry_dec015,
cry_dec016, cry_chr008, cry_chr009, cry_dec005)
SELECT glwkrang.ran_nomrep,
glwkrang.ran_idepcc, glwkrang.ran_keyusu, glwkrang.ran_keypro,
glwkrang.ran_keyemp, holofrph.frp_keydep, glwkrang.ran_keynom,
nmloalde.ald_keyemp, vs_key_apr, glcopams1.pam_nompar, hologdpr.gdp_keyemp,
hologdpr.gdp_keypue, hologdpr.gdp_capini,  hologdpr.gdp_capfin,
hologdpr.gdp_numcap, hologdpr.gdp_keycon,  hologdpr.gdp_marcon,
hologdpr.gdp_marcos, hologdpr.gdp_cosuni,  nmcodeps.dep_desdep,
holofrph.frp_fecact, holofrph.frp_tiptra,  holofrph.frp_fecsol,
holofrph.frp_fectrab, holofrph.frp_forpag,  nmlonomi.nom_destip,
nmloproc.pro_despro, holocont.con_stsfir,  nmcoempl.emp_nomemp,
nmcoempl1.emp_nomemp, nmloconc.con_descon,  nmcopues.pue_despue,
glcopams.pam_nompar, 'A', holofrph.frp_unifor,  holofrph.frp_transp,
holoapco.apc_keycom,  nmcopues.pue_nu5aux, hologdpr.gdp_keysec
FROM USRSIHO.glwkrang
join USRSIHO.holofrph on glwkrang.ran_keyemp = holofrph.frp_keyrph
join USRSIHO.nmloalde on holofrph.frp_keydep = nmloalde.ald_keydep
join USRSIHO.hologdpr on holofrph.frp_keyrph = hologdpr.gdp_keyrph
join USRSIHO.nmcodeps on holofrph.frp_keydep = nmcodeps.dep_keydep
join USRSIHO.nmlonomi on holofrph.frp_keynom = nmlonomi.nom_keynom
join USRSIHO.nmloproc on nmloalde.ald_keypro = nmloproc.pro_keypro
left join USRSIHO.holocont on hologdpr.gdp_keyfol = holocont.con_keyfol
                    AND hologdpr.gdp_keytco = holocont.con_keytco
join USRSIHO.nmcoempl on  hologdpr.gdp_keyemp = nmcoempl.emp_keyemp
left join USRSIHO.nmcoempl nmcoempl1 on nmloalde.ald_keyemp = nmcoempl1.emp_keyemp
join USRSIHO.nmloconc on hologdpr.gdp_keycon = nmloconc.con_keycon
join USRSIHO.nmcopues on hologdpr.gdp_keypue = nmcopues.pue_keypue
join USRSIHO.glcopams on holofrph.frp_tiptra = glcopams.pam_cvesec and glcopams.pam_keypar = 'H7'
join USRSIHO.glcopams glcopams1 on glcopams1.pam_keypar = 'H2' AND glcopams1.pam_cvesec = vs_key_apr
join USRSIHO.holodear on holodear.dea_keydep = nmloalde.ald_keydep and vs_key_apr = holodear.dea_keyapr
join USRSIHO.glcoacno on glwkrang.ran_keyusu = glcoacno.acn_keyusu AND holofrph.frp_keynom = glcoacno.acn_keynom
left join USRSIHO.holoapco on holofrph.frp_keynom = holoapco.apc_keynom AND holofrph.frp_tipfol = holoapco.apc_keytfo
            AND nmloalde.ald_keypro = holoapco.apc_keypro and hologdpr.gdp_keycon = holoapco.apc_keycon
            AND holoapco.apc_keyapr=vs_key_apr
WHERE glwkrang.ran_nomrep = vs_nom_rep
AND glwkrang.ran_idepcc = vs_ide_pcc
AND glwkrang.ran_keyusu = vn_key_usu;
END ;
/
