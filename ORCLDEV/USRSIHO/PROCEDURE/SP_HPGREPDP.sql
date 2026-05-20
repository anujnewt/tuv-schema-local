create or replace procedure usrsiho."sp_hpgrepdp"  (vs_nom_rep varchar, vn_key_pro numeric, vs_key_apr varchar, vn_key_usu numeric, vs_ide_pcc varchar, vn_tip_pag numeric, vn_ban_cos numeric, vn_efe_cti numeric, vn_key_nom numeric, vn_num_emi numeric) as $body$
declare
-- pgv moved types start
-- pgv moved types end
begin
-- sistema  : rh-2000  c/s
-- modulo   : nomina de honorarios(ho)
-- programa : sp_ hpgrepdp
--            seleccion de datos de recibos pendientes de pago
-- autor    : veronica vazquez rodriguez
-- fecha    : 14 de octubre de 1999
delete from usrsiho.glwkcrys
where cry_nomrep = vs_nom_rep
and cry_idepcc = vs_ide_pcc
and cry_keyusu = vn_key_usu;
insert into usrsiho.glwkcrys(cry_nomrep, cry_idepcc, cry_keyusu,
cry_numsec, cry_chr017, cry_dec006,
cry_dec009, cry_dec008, cry_chr001,
cry_chr012, cry_dec007, cry_dec001,
cry_dec002, cry_dec003, cry_dec004,
cry_dec005)
select -- /*+ use_hash (nmlohism / build) */          vs_nom_rep,
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
sum(case when agc_keyagr=1 then his_import  else 0 end ),
sum(case when agc_keyagr=2 then his_import  else 0 end ),
sum(case when agc_keyagr=5 then his_import when agc_keyagr=14 then his_import when agc_keyagr=15 then his_import  else 0 end ),
sum(case when agc_keyagr=7 then his_import when agc_keyagr=8 then his_import  else 0 end ),
rec_import
from usrsiho.holoreci,
usrsiho.nmcoempl,
usrsiho.nmloperi,
usrsiho.nmlohism ,
usrsiho.holoagcp
where rec_keyemp = emp_keyemp
and rec_keypro = per_keypro
and rec_keyapr = per_nu3aux
and rec_keynom = per_keynom
and rec_numemi = per_nu4aux
and per_keypro = his_keypro
and per_keyper = his_keyper
and rec_keyemp = his_keyemp
and his_keycon = agc_keycon
and agc_keyagr in (1,2,5,14,15,7,8)
--     and rec_keyemp = ran_keyemp
--     and rec_keynom = ran_keynom
--     and rec_numemi = ran_keycen
and rec_keypro = vn_key_pro
and rec_keyapr = vs_key_apr
and rec_keynom = vn_key_nom
and rec_numemi = vn_num_emi
--      and ran_nomrep = vs_nom_rep
--      and ran_idepcc = vs_ide_pcc
--      and ran_keyusu = vn_key_usu
--      and ran_keypro = vn_key_pro
and((vn_tip_pag  = 1
and((vn_ban_cos = 1 and oracle.substr(emp_cveban,1,3) =  '002' and rec_stsfon = 0)
or (vn_ban_cos = 2 and oracle.substr(emp_cveban,1,3) <> '002' and rec_stsfon = 0)
or (vn_ban_cos = 3 and rec_stsfon = 0  and nullif(emp_cveban::text, '') is not null)))
or(vn_tip_pag  = 2
and((vn_efe_cti = 1 and rec_stsfon = 1)
or (vn_efe_cti = 2 and rec_stsfon in (0,2)   and nullif(emp_cveban::text, '') is null)
or (vn_efe_cti = 3 and rec_stsfon in (0,1,2) and nullif(emp_cveban::text, '') is null)))
or vn_tip_pag = 3)
and rec_stsrec = 0
group by rec_keypro,
rec_keyapr,
rec_keynom,
rec_numemi,
rec_keyemp,
emp_nomemp,
emp_keycen,
rec_keyrec,
rec_import;end;
$body$
language plpgsql
;
