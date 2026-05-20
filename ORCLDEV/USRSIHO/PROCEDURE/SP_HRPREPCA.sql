create or replace procedure usrsiho."sp_hrprepca"  (vs_nom_rep varchar, vs_ide_pcc varchar, vn_key_usu numeric, vs_key_apr varchar) as $body$
declare
-- pgv moved types start
-- pgv moved types end
begin
--sipros, s. a. de c. v.
--sistema  : rh-2000  c/s --modulo   : nomina de honorarios --programa :
--_hrprepca --           reporte de rph procesados --autor    : veronica vazquez
--driguez --fecha    : 01 de agosto de 1999
--set debug file to "/rapps/usuarios/sistemas/cig/temp.txt";
--trace on;
--trace off;
insert into usrsiho.glwkcrys(cry_nomrep, cry_idepcc, cry_keyusu, cry_numsec, cry_dec006,
cry_chr017, cry_dec007, cry_dec009, cry_chr044, cry_chr011, cry_dec008,
cry_chr018, cry_dec012, cry_dec013, cry_dec014, cry_chr019, cry_chr022,
cry_chr023, cry_dec001, cry_chr003, cry_dat001, cry_chr021, cry_dat002,
cry_dat003, cry_dec011, cry_chr004, cry_chr001, cry_chr024, cry_chr007,
cry_chr006, cry_chr005, cry_chr002, cry_chr020, cry_chr045, cry_dec015,
cry_dec016, cry_chr008, cry_chr009, cry_dec005)
select glwkrang.ran_nomrep,
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
from usrsiho.glwkrang
join usrsiho.holofrph on glwkrang.ran_keyemp = holofrph.frp_keyrph
join usrsiho.nmloalde on holofrph.frp_keydep = nmloalde.ald_keydep
join usrsiho.hologdpr on holofrph.frp_keyrph = hologdpr.gdp_keyrph
join usrsiho.nmcodeps on holofrph.frp_keydep = nmcodeps.dep_keydep
join usrsiho.nmlonomi on holofrph.frp_keynom = nmlonomi.nom_keynom
join usrsiho.nmloproc on nmloalde.ald_keypro = nmloproc.pro_keypro
left join usrsiho.holocont on hologdpr.gdp_keyfol = holocont.con_keyfol
and hologdpr.gdp_keytco = holocont.con_keytco
join usrsiho.nmcoempl on  hologdpr.gdp_keyemp = nmcoempl.emp_keyemp
left join usrsiho.nmcoempl nmcoempl1 on nmloalde.ald_keyemp = nmcoempl1.emp_keyemp
join usrsiho.nmloconc on hologdpr.gdp_keycon = nmloconc.con_keycon
join usrsiho.nmcopues on hologdpr.gdp_keypue = nmcopues.pue_keypue
join usrsiho.glcopams on holofrph.frp_tiptra = glcopams.pam_cvesec and glcopams.pam_keypar = 'H7'
join usrsiho.glcopams glcopams1 on glcopams1.pam_keypar = 'H2' and glcopams1.pam_cvesec = vs_key_apr
join usrsiho.holodear on holodear.dea_keydep = nmloalde.ald_keydep and vs_key_apr = holodear.dea_keyapr
join usrsiho.glcoacno on glwkrang.ran_keyusu = glcoacno.acn_keyusu and holofrph.frp_keynom = glcoacno.acn_keynom
left join usrsiho.holoapco on holofrph.frp_keynom = holoapco.apc_keynom and holofrph.frp_tipfol = holoapco.apc_keytfo
and nmloalde.ald_keypro = holoapco.apc_keypro and hologdpr.gdp_keycon = holoapco.apc_keycon
and holoapco.apc_keyapr=vs_key_apr
where glwkrang.ran_nomrep = vs_nom_rep
and glwkrang.ran_idepcc = vs_ide_pcc
and glwkrang.ran_keyusu = vn_key_usu;end;
$body$
language plpgsql
;
