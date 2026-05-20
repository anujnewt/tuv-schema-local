create or replace procedure usrsiho."sp_hrenompg"  (vs_nom_rep varchar, vs_ide_pcc varchar, vn_key_usu smallint, vn_opc_ion smallint, vn_mes_ini smallint, vn_mes_fin smallint, vs_key_apr varchar, vn_key_pro smallint) as $body$
declare
-- pgv moved types start
-- pgv moved types end
--sistema  : rh-2000  c/s
--modulo   :
--programa : sp_hrenompg
--           listado de nominas pagadas
begin
delete from glwkcrys
where cry_nomrep = vs_nom_rep
and cry_keyusu = vn_key_usu
and cry_idepcc = vs_ide_pcc;
if vn_opc_ion = 1 then           -- todos los pagos
insert into glwkcrys(cry_nomrep,cry_keyusu,cry_idepcc,cry_numsec,
cry_chr017,cry_chr018,cry_dec006,cry_dec011,cry_dec012,
cry_dec013,cry_dec014,cry_dec015,cry_dec016,cry_dec017,
cry_dec018,cry_dec019,cry_dec020,cry_dec021,cry_dec022,
cry_dec023,cry_dec024,cry_dec025,cry_dec001,cry_dec002,
cry_dec003,cry_dec004)
select vs_nom_rep,vn_key_usu,vs_ide_pcc, per_keynom,per_nu4aux,
per_nu3aux area, per_nummes,
sum(case when agc_keyagr=23 then his_import  else 0 end ) bases,
sum(case when agc_keyagr=24 then his_import  else 0 end ) otr_ing,
sum(case when agc_keyagr=25 then his_import  else 0 end ) tie_ext,
sum(case when agc_keyagr=26 then his_import  else 0 end ) sindic,
sum(case when agc_keyagr=2 then his_import  else 0 end ) iva_acr,
sum(case when agc_keyagr=3 then his_import  else 0 end ) iva_pen,
sum(case when agc_keyagr=15 then his_import  else 0 end ) ispttt,
sum(case when agc_keyagr=21 then his_import  else 0 end ) isr_nac,
sum(case when agc_keyagr=22 then his_import  else 0 end ) isr_ext,
sum(case when agc_keyagr=8 then his_import  else 0 end ) pensio,
sum(case when agc_keyagr=7 then his_import  else 0 end ) otr_des,
sum(case when agc_keyagr=5 then his_import  else 0 end ) iva_ret,
sum(case when his_keycon='H20' then his_import  else 0 end ) prev_soc,
sum(case when his_keycon='H64' then his_import  else 0 end ),
sum(case when his_keycon='H29' then his_import  else 0 end ),
sum(case when his_keycon='H63' then his_import  else 0 end ),
sum(case when his_keycon='H97' then his_import  else 0 end ),
sum(case when his_keycon='H98' then his_import  else 0 end ),
sum(case when his_keycon='H30' then his_import  else 0 end )
from nmlohism, nmloperi, nmloalde, nmcoempl, holoagcp, glwkrang
where his_keypro = per_keypro
and his_keyper = per_keyper
and his_keydep = ald_keydep
and his_keyemp = emp_keyemp
and his_keycon = agc_keycon
and per_nummes between vn_mes_ini and vn_mes_fin
and per_keyper > 1000000
and agc_keyagr in (23,24,25,26,2,3,15,21,22,8,7,5,9,6)
and ran_nomrep = 'hrenompg'
and ran_idepcc = vs_ide_pcc
and ran_keyusu = vn_key_usu
and ran_keypro = per_keypro
and ran_keyper = per_keyper
group by  per_keynom, per_nu4aux, per_nu3aux, per_nummes;
elsif vn_opc_ion = 2 then          -- sin cancelaciones
insert into glwkcrys(cry_nomrep,cry_keyusu,cry_idepcc,cry_numsec,
cry_chr017,cry_chr018,cry_dec006,cry_dec011,cry_dec012,
cry_dec013,cry_dec014,cry_dec015,cry_dec016,cry_dec017,
cry_dec018,cry_dec019,cry_dec020,cry_dec021,cry_dec022,
cry_dec023,cry_dec024,cry_dec025,cry_dec001,cry_dec002,
cry_dec003,cry_dec004)
select vs_nom_rep,vn_key_usu,vs_ide_pcc, per_keynom,per_nu4aux,
per_nu3aux area, per_nummes,
sum(case when agc_keyagr=23 then his_import  else 0 end ) bases,
sum(case when agc_keyagr=24 then his_import  else 0 end ) otr_ing,
sum(case when agc_keyagr=25 then his_import  else 0 end ) tie_ext,
sum(case when agc_keyagr=26 then his_import  else 0 end ) sindic,
sum(case when agc_keyagr=2 then his_import  else 0 end ) iva_acr,
sum(case when agc_keyagr=3 then his_import  else 0 end ) iva_pen,
sum(case when agc_keyagr=15 then his_import  else 0 end ) ispttt,
sum(case when agc_keyagr=21 then his_import  else 0 end ) isr_nac,
sum(case when agc_keyagr=22 then his_import  else 0 end ) isr_ext,
sum(case when agc_keyagr=8 then his_import  else 0 end ) pensio,
sum(case when agc_keyagr=7 then his_import  else 0 end ) otr_des,
sum(case when agc_keyagr=5 then his_import  else 0 end ) iva_ret,
sum(case when his_keycon='H20' then his_import  else 0 end ) prev_soc,
sum(case when his_keycon='H64' then his_import  else 0 end ),
sum(case when his_keycon='H29' then his_import  else 0 end ),
sum(case when his_keycon='H63' then his_import  else 0 end ),
sum(case when his_keycon='H97' then his_import  else 0 end ),
sum(case when his_keycon='H98' then his_import  else 0 end ),
sum(case when his_keycon='H30' then his_import  else 0 end )
from nmlohism,nmloperi,nmloalde,nmcoempl,holoagcp,glwkrang
where his_keypro = per_keypro
and his_keyper = per_keyper
and his_keydep = ald_keydep
and his_keyemp = emp_keyemp
and his_keycon = agc_keycon
-- and his_ca1aux[4] = '0'
and oracle.substr(his_ca1aux, 4, 1) = '0'
and per_nummes between vn_mes_ini and vn_mes_fin
and per_keyper > 1000000
and agc_keyagr in (23,24,25,26,2,3,15,21,22,8,7,5,9,6)
and ran_nomrep = 'hrenompg'
and ran_idepcc = vs_ide_pcc
and ran_keyusu = vn_key_usu
and ran_keypro = per_keypro
and ran_keyper = per_keyper
group by  per_keynom,per_nu4aux,per_nu3aux,per_nummes;
elsif vn_opc_ion = 3 then         -- solo cancelados
insert into glwkcrys(cry_nomrep,cry_keyusu,cry_idepcc,cry_numsec,
cry_chr017,cry_chr018,cry_dec006,cry_dec011,cry_dec012,
cry_dec013,cry_dec014,cry_dec015,cry_dec016,cry_dec017,
cry_dec018,cry_dec019,cry_dec020,cry_dec021,cry_dec022,
cry_dec023,cry_dec024,cry_dec025,cry_dec001,cry_dec002,
cry_dec003,cry_dec004)
select vs_nom_rep,vn_key_usu,vs_ide_pcc, per_keynom,per_nu4aux,
per_nu3aux area, per_nummes,
sum(case when agc_keyagr=23 then his_import  else 0 end ) bases,
sum(case when agc_keyagr=24 then his_import  else 0 end ) otr_ing,
sum(case when agc_keyagr=25 then his_import  else 0 end ) tie_ext,
sum(case when agc_keyagr=26 then his_import  else 0 end ) sindic,
sum(case when agc_keyagr=2 then his_import  else 0 end ) iva_acr,
sum(case when agc_keyagr=3 then his_import  else 0 end ) iva_pen,
sum(case when agc_keyagr=15 then his_import  else 0 end ) ispttt,
sum(case when agc_keyagr=21 then his_import  else 0 end ) isr_nac,
sum(case when agc_keyagr=22 then his_import  else 0 end ) isr_ext,
sum(case when agc_keyagr=8 then his_import  else 0 end ) pensio,
sum(case when agc_keyagr=7 then his_import  else 0 end ) otr_des,
sum(case when agc_keyagr=5 then his_import  else 0 end ) iva_ret,
sum(case when his_keycon='H20' then his_import  else 0 end ) prev_soc,
sum(case when his_keycon='H64' then his_import  else 0 end ),
sum(case when his_keycon='H29' then his_import  else 0 end ),
sum(case when his_keycon='H63' then his_import  else 0 end ),
sum(case when his_keycon='H97' then his_import  else 0 end ),
sum(case when his_keycon='H98' then his_import  else 0 end ),
sum(case when his_keycon='H30' then his_import  else 0 end )
from nmlohism,nmloperi,nmloalde,nmcoempl,holoagcp,glwkrang
where his_keypro = per_keypro
and his_keyper = per_keyper
and his_keydep = ald_keydep
and his_keyemp = emp_keyemp
and his_keycon = agc_keycon
-- and his_ca1aux[4] = '2'
and oracle.substr(his_ca1aux, 4, 1) = '2'
and per_nummes between vn_mes_ini and vn_mes_fin
and per_keyper > 1000000
and agc_keyagr in (23,24,25,26,2,3,15,21,22,8,7,5,9,6)
and ran_nomrep = 'hrenompg'
and ran_idepcc = vs_ide_pcc
and ran_keyusu = vn_key_usu
and ran_keypro = per_keypro
and ran_keyper = per_keyper
group by  per_keynom,per_nu4aux,per_nu3aux,per_nummes;
elsif vn_opc_ion = 4 then         -- realmente pagados
insert into glwkcrys(cry_nomrep,cry_keyusu,cry_idepcc,cry_numsec,
cry_chr017,cry_chr018,cry_dec006,cry_dec011,cry_dec012,
cry_dec013,cry_dec014,cry_dec015,cry_dec016,cry_dec017,
cry_dec018,cry_dec019,cry_dec020,cry_dec021,cry_dec022,
cry_dec023,cry_dec024,cry_dec025,cry_dec001,cry_dec002,
cry_dec003,cry_dec004)
select vs_nom_rep,vn_key_usu,vs_ide_pcc, per_keynom,per_nu4aux,
per_nu3aux area, per_nummes,
sum(case when agc_keyagr=23 then his_import  else 0 end ) bases,
sum(case when agc_keyagr=24 then his_import  else 0 end ) otr_ing,
sum(case when agc_keyagr=25 then his_import  else 0 end ) tie_ext,
sum(case when agc_keyagr=26 then his_import  else 0 end ) sindic,
sum(case when agc_keyagr=2 then his_import  else 0 end ) iva_acr,
sum(case when agc_keyagr=3 then his_import  else 0 end ) iva_pen,
sum(case when agc_keyagr=15 then his_import  else 0 end ) ispttt,
sum(case when agc_keyagr=21 then his_import  else 0 end ) isr_nac,
sum(case when agc_keyagr=22 then his_import  else 0 end ) isr_ext,
sum(case when agc_keyagr=8 then his_import  else 0 end ) pensio,
sum(case when agc_keyagr=7 then his_import  else 0 end ) otr_des,
sum(case when agc_keyagr=5 then his_import  else 0 end ) iva_ret,
sum(case when his_keycon='H20' then his_import  else 0 end ) prev_soc,
sum(case when his_keycon='H64' then his_import  else 0 end ),
sum(case when his_keycon='H29' then his_import  else 0 end ),
sum(case when his_keycon='H63' then his_import  else 0 end ),
sum(case when his_keycon='H97' then his_import  else 0 end ),
sum(case when his_keycon='H98' then his_import  else 0 end ),
sum(case when his_keycon='H30' then his_import  else 0 end )
from nmlohism,nmloperi,nmloalde,nmcoempl,holoagcp,glwkrang
where his_keypro = per_keypro
and his_keyper = per_keyper
and his_keydep = ald_keydep
and his_keyemp = emp_keyemp
and his_keycon = agc_keycon
-- and his_ca1aux[4] in ('1','3')
and oracle.substr(his_ca1aux, 4, 1) in ('1','3')
and per_nummes between vn_mes_ini and vn_mes_fin
and per_keyper > 1000000
and agc_keyagr in (23,24,25,26,2,3,15,21,22,8,7,5,9,6)
and ran_nomrep = 'hrenompg'
and ran_idepcc = vs_ide_pcc
and ran_keyusu = vn_key_usu
and ran_keypro = per_keypro
and ran_keyper = per_keyper
group by  per_keynom,per_nu4aux,per_nu3aux,per_nummes;
end if;end;
$body$
language plpgsql
;
