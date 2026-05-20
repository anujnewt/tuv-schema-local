create or replace procedure usrsiho."sp_hpgrepre"  (vs_nom_rep varchar, vs_ide_pcc varchar, vn_key_usu smallint) as $body$
declare
-- pgv moved types start
-- pgv moved types end
-- -----------------------------------------------------------------
-- sistema  : rh-2000  c/s
-- modulo   : administracion de remuneraciones (nm)
-- programa : sp_hpgrepre
--            reporte de control de cajas
-- fecha    : 18 de agosto de 1999
begin
insert into glwkcrys(cry_nomrep, cry_idepcc, cry_keyusu, cry_dec012,
cry_chr017, cry_chr004, cry_chr018, cry_chr005,
cry_dec011, cry_dec008, cry_dec009, cry_dat001,
cry_dec006, cry_dec007, cry_dec010, cry_dec001,
cry_dec013, cry_chr001, cry_chr002, cry_chr003,
cry_chr019, cry_chr020, cry_dec014, cry_dec015,
cry_dec016, cry_dec017, cry_dec018, cry_dec019,
cry_dec020)
select /*+ use_hash(holoreci /build) */  glwkrang.ran_nomrep, glwkrang.ran_idepcc, glwkrang.ran_keyusu,
glwkrang.ran_keypro, holoreci.rec_keyapr, glcopams.pam_nompar,
nmloproc.pro_keycia, oracle.substr(nmlocias.cia_descia,1,40), holoreci.rec_numrem,
holoreci.rec_keynom, holoreci.rec_numemi, holoreci.rec_fecpag,
holoreci.rec_ejerci, holoreci.rec_keyemp, holoreci.rec_stsrec,
holoreci.rec_import, holoreci.rec_keyrec, nmcoempl.emp_nomemp,
nmlonomi.nom_destip, nmloproc.pro_despro, nmloperi.per_keyper,
nmloperi.per_keyper,
sum(case when agc_keyagr=1 then his_import  else 0 end ),
sum(case when agc_keyagr=2 then his_import  else 0 end ),
sum(case when agc_keyagr=3 then his_import  else 0 end ),
sum(case when agc_keyagr=5 then his_import  else 0 end ),
sum(case when agc_keyagr=15 then his_import  else 0 end ),
sum(case when agc_keyagr=21 then his_import  else 0 end ),
sum(case when agc_keyagr=22 then his_import  else 0 end )
from
glwkrang glwkrang,
holoreci holoreci
left outer join nmcoempl nmcoempl on holoreci.rec_keyemp = nmcoempl.emp_keyemp,
nmlonomi nmlonomi,
nmloproc nmloproc,
nmloperi nmloperi,
glcopams glcopams,
nmlocias nmlocias,
nmlohism nmlohism,
holoagcp holoagcp
where holoreci.rec_keynom = nmlonomi.nom_keynom and
holoreci.rec_keypro = nmloproc.pro_keypro and
holoreci.rec_keypro = nmloperi.per_keypro and
holoreci.rec_keynom = nmloperi.per_keynom and
holoreci.rec_keyapr = nmloperi.per_nu3aux and
holoreci.rec_numemi = nmloperi.per_nu4aux and
nmlohism.his_keypro = nmloperi.per_keypro and
nmlohism.his_keyper = nmloperi.per_keyper and
nmlohism.his_keyemp = holoreci.rec_keyemp and
nmlohism.his_keycon = holoagcp.agc_keycon and
holoagcp.agc_keyagr in (1,2,3,5,15,21,22) and
to_char(holoreci.rec_stsrec) = to_char(glcopams.pam_cvesec) and
nmloproc.pro_keycia = nmlocias.cia_keycia and
holoreci.rec_keyrec = glwkrang.ran_keyemp and
holoreci.rec_ejerci = glwkrang.ran_keyper and
glcopams.pam_keypar = 'H27' and
glwkrang.ran_nomrep = vs_nom_rep and
glwkrang.ran_idepcc = vs_ide_pcc and
glwkrang.ran_keyusu = vn_key_usu
group by
glwkrang.ran_nomrep, glwkrang.ran_idepcc, glwkrang.ran_keyusu,
glwkrang.ran_keypro, holoreci.rec_keyapr, glcopams.pam_nompar,
nmloproc.pro_keycia, nmlocias.cia_descia, holoreci.rec_numrem,
holoreci.rec_keynom, holoreci.rec_numemi, holoreci.rec_fecpag,
holoreci.rec_ejerci, holoreci.rec_keyemp, holoreci.rec_stsrec,
holoreci.rec_import, holoreci.rec_keyrec, nmcoempl.emp_nomemp,
nmlonomi.nom_destip, nmloproc.pro_despro, nmloperi.per_keyper;end;
$body$
language plpgsql
;
