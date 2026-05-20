create or replace procedure usrsiho."sp_hpgpfaor1"  (wn_keypro numeric, ws_keyapr varchar,wn_keynom numeric,wn_numemi numeric,ws_tippol varchar, ws_nomrep varchar,ws_idepcc varchar,wn_keyusu numeric,ws_status varchar) as $body$
declare
-- pgv moved types start
-- pgv moved types end
--aedo 28/08/06  se agrego la variable ws_status, la cual trae el status que se desea generar (a - p - c)
ws_despro varchar(40);ws_nompar varchar(40);ws_destip varchar(40);ws_nomusu varchar(40);ws_cuenta varchar(40);
wn_usugen numeric(10);
wd_fecpol timestamp(0);
wn_cargos decimal(18,6);wn_abonos decimal(18,6);
wi_pol_forpag numeric(5);
wi_pol_fpafin numeric(5);
wd_pol_tipcam decimal(16,4);
ws_tipofac varchar(02);
ws_desfpa  varchar(20);
ws_desfpf  varchar(20);
ws_tipfac  varchar(01);
rec record;
begin
--lectura de las facturas
for rec in (select pol_keypro,        --cry_dec006 integer   wn_keypro
pro_despro,        --cry_chr003 varchar(40)  ws_despro
pol_keyapr,        --cry_chr017 varchar(08)  ws_keyapr
pam_nompar,        --cry_chr004 varchar(40)  ws_nompar
pol_keynom,        --cry_chr018 varchar(08)  wn_keynom
nom_destip,        --cry_chr005 varchar(40)  ws_destip
pol_numemi,        --cry_chr019 varchar(08)  wn_numemi
pol_fecpol,        --cry_dat001 date      --wd_fecpol
pol_usugen,        --cry_dec008 integer   wn_usugen
usu_nomusu,        --cry_chr006 varchar(40)  ws_nomusu
pol_tippol,        --cry_chr020 varchar(08)  ws_tippol
oracle.substr(det_cuenta,9,14) cuenta,  --cry_chr008 varchar(20)  ws_cuenta
sum(det_cargos) cargos,   --cry_dec001 dec(18,6) wn_cargos
sum(det_abonos) abonos,   --cry_dec002 dec(18,6) wn_abonos
pol_forpag,
pol_tipcam,
pol_fpafin
from usrsiho.holopoli1,
usrsiho.holodetp1,
usrsiho.nmlonomi,
usrsiho.glcopams,
usrsiho.nmloproc,
usrsiho.glcousua
where pol_keypol = det_keypol
and pol_keynom = nom_keynom
and pol_keypro = pro_keypro
and pol_keyapr = pam_cvesec
and pol_usugen = usu_keyusu
and pam_keypar='H2'
and pol_keypro = wn_keypro
and pol_keyapr = ws_keyapr
and pol_keynom = wn_keynom
and pol_numemi = wn_numemi
and pol_tippol = ws_tippol
and pol_stspol = ws_status
group by pol_keypro,pro_despro,pol_keyapr,pam_nompar,pol_keynom,nom_destip,pol_numemi,pol_fecpol,pol_usugen,usu_nomusu,
pol_tippol,pol_forpag,pol_tipcam,pol_fpafin,oracle.substr(det_cuenta,9,14)
order by  oracle.substr(det_cuenta,9,14)) loop
--12,1,2,3,4,5,6,7,8,9,10,11,15,16,17
-- obtiene la descripcion de la moneda
--wn_keypro := rec.pol_keypro;
ws_despro := rec.pro_despro;
--ws_keyapr := rec.pol_keyapr;
ws_nompar := rec.pam_nompar;
--wn_keynom := rec.pol_keynom;
ws_destip := rec.nom_destip;
--wn_numemi := rec.pol_numemi;
wd_fecpol := rec.pol_fecpol;
wn_usugen := rec.pol_usugen;
ws_nomusu := rec.usu_nomusu;
--ws_tippol := rec.pol_tippol;
ws_cuenta := rec.cuenta;
wn_cargos := rec.cargos;
wn_abonos := rec.abonos;
wi_pol_forpag := rec.pol_forpag;
wd_pol_tipcam := rec.pol_tipcam;
wi_pol_fpafin := rec.pol_fpafin;
begin
select a.pam_folini, b.pam_folini
into strict ws_desfpa, ws_desfpf
from usrsiho.glcopams a, usrsiho.glcopams b
where a.pam_keypar = 'H10'
and a.pam_cvesec = wi_pol_forpag
and b.pam_keypar = 'H10'
and b.pam_cvesec = wi_pol_fpafin;
exception when no_data_found then ws_desfpa:= null; ws_desfpf:= null;
end;
--obtiene el tipo de factura o poliza modificacion fecha 22/may/2007
begin
select per_nu5aux
into strict ws_tipfac
from usrsiho.nmloperi
where per_keypro = wn_keypro
and per_nu3aux = ws_keyapr
and per_keynom = wn_keynom
and per_nu4aux = wn_numemi;
exception when no_data_found then ws_tipfac:= null;
end;
---fecha 22/may/2007---
-- inserta valores
insert into usrsiho.glwkcrys(cry_nomrep,
cry_idepcc,
cry_keyusu,
cry_dec006,
cry_chr003,
cry_chr017,
cry_chr004,
cry_chr018,
cry_chr005,
cry_chr019,
cry_dat001,
cry_dec008,
cry_chr006,
cry_chr020,
cry_chr008,
cry_dec001,
cry_dec002,
cry_dec010,
cry_dec004,
cry_dec005,
cry_chr012,
cry_chr013)
values (ws_nomrep,
ws_idepcc,
wn_keyusu,
wn_keypro,
ws_despro,
ws_keyapr,
ws_nompar,
wn_keynom,
ws_destip,
wn_numemi,
wd_fecpol,   -- null
wn_usugen,
ws_nomusu,
ws_tipfac,   --ws_tippol,
ws_cuenta,
wn_cargos,
wn_abonos,
wi_pol_forpag,
wd_pol_tipcam,
wi_pol_fpafin,
ws_desfpa,
ws_desfpf);
end loop;
--trace off;
end;
$body$
language plpgsql
;
