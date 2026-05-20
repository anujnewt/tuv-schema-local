create or replace procedure usrsiho."sp_hpgporap3"  (wn_keypro numeric, ws_keyapr varchar,wn_keynom numeric,wn_numemi numeric,ws_tippol varchar, ws_nomrep varchar,ws_idepcc varchar,wn_keyusu numeric,ws_status varchar) as $body$
declare
-- pgv moved types start
-- pgv moved types end
--aedo 28/08/06  se agrego la variable ws_status, la cual trae el status que se desea generar (a - p - c)
ws_despro varchar(40);ws_nompar varchar(40);ws_destip varchar(40);ws_nomusu varchar(40);ws_cuenta varchar(40);
wn_usugen numeric(10);
wd_fecpol timestamp(0);
wn_cargos decimal(18,6);wn_abonos decimal(18,6);
ws_keyemp varchar(20);
ws_nomemp varchar(60);
ws_numfac varchar(40);
wn_impfac decimal(18,6);
wn_keypol numeric(10);
wi_pol_forpag numeric(5);
wd_pol_tipcam decimal(16,4);
vs_tiporep varchar(02);
rec record;
begin
/* dmap converted statement start */
--lectura de las facturas
for rec in (select pol_keypro,        --cry_dec006 integer   wn_keypro
pro_despro,        --cry_chr003 varchar(40)  ws_despro
pol_keyapr,        --cry_chr017 varchar(08)  ws_keyapr
pam_nompar,        --cry_chr004 varchar(40)  ws_nompar
pol_keynom,        --cry_chr018 varchar(08)  wn_keynom
nom_destip,        --cry_chr005 varchar(40)  ws_destip
pol_numemi,        --cry_chr019 varchar(08)  wn_numemi
pol_fecpol,        --cry_dat001 date      wd_fecpol
pol_usugen,        --cry_dec008 integer   wn_usugen
usu_nomusu,        --cry_chr006 varchar(40)  ws_nomusu
pol_tippol,        --cry_chr020 varchar(08)  ws_tippol
concat(pol_keyemp, '-', ben_keyben)  empl,        --cry_chr009 integer   ws_keyemp
ben_nomben,        --cry_chr001 varchar(60)  ws_nomemp
pol_cvepol,        --cry_chr007 varchar(40)  ws_numfac
(pol_abopas-pol_carpas) diferencia, --cry_dec003 dec(18,6) wn_impfac
det_keypol,        --cry_dec009 integer   wn_keypol
oracle.substr(det_cuenta,2,9) cuenta,  --cry_chr008 varchar(20)  ws_cuenta
sum(det_cargos) cargos,   --cry_dec001 dec(18,6) wn_cargos
sum(det_abonos) abonos,   --cry_dec002 dec(18,6) wn_abonos
pol_forpag,
pol_tipcam
from usrsiho.holopoli1,
usrsiho.holodetp1,
usrsiho.nmlonomi,
usrsiho.glcopams,
usrsiho.nmloproc,
usrsiho.glcousua,
usrsiho.nmlobene,
usrsiho.nmlopres,
usrsiho.nmcoempl
where pol_keypol = det_keypol
and pol_keynom = nom_keynom
and pol_keypro = pro_keypro
and pol_keyapr = pam_cvesec
and pol_usugen = usu_keyusu
and pol_keyemp = emp_keyemp
and pam_keypar='H2'
and pol_keypro = wn_keypro
and pol_keyapr = ws_keyapr
and pol_keynom = wn_keynom
and pol_numemi = wn_numemi
and pol_tippol = ws_tippol
and pol_cvepol like '%-P%'
and pol_regrfc=ben_rfcben
and emp_keyemp=ben_keyemp
and pre_keyemp = emp_keyemp  --jc
and pre_keyemp = ben_keyemp  --jc
and pre_ca4aux = ben_keyben  --jc
and pre_keycon = 'HPA'       --jc
and pre_status = 2           --jc
and pol_cvepol like  concat('%P', ben_keyben
) and pol_stspol = ws_status
group by pol_keypro,pro_despro,pol_keyapr,pam_nompar,pol_keynom,nom_destip,pol_numemi,pol_fecpol,pol_usugen,
usu_nomusu,pol_tippol,pol_keyemp,ben_keyben ,ben_nomben,pol_cvepol,det_keypol,pol_forpag,pol_tipcam,
pol_abopas,pol_carpas,oracle.substr(det_cuenta,2,9)
order by  pol_keyemp,ben_keyben,det_keypol,oracle.substr(det_cuenta,2,9)) loop
--12,16,17,1,2,3,4,5,6,7,8,9,10,11,13,14,15,20,21
--wn_keypro := rec.pol_keypro;
ws_despro := rec.pro_despro;/* dmap converted statement end */
--ws_keyapr := rec.pol_keyapr;
ws_nompar := rec.pam_nompar;
--wn_keynom := rec.pol_keynom;
ws_destip := rec.nom_destip;
--wn_numemi := rec.pol_numemi;
wd_fecpol := rec.pol_fecpol;
wn_usugen := rec.pol_usugen;
ws_nomusu := rec.usu_nomusu;
--ws_tippol := rec.pol_tippol;
ws_keyemp := rec.empl;
ws_nomemp := rec.ben_nomben;
ws_numfac := rec.pol_cvepol;
wn_impfac := rec.diferencia;
wn_keypol := rec.det_keypol;
ws_cuenta := rec.cuenta;
wn_cargos := rec.cargos;
wn_abonos := rec.abonos;
wi_pol_forpag := rec.pol_forpag;
wd_pol_tipcam := rec.pol_tipcam;
if oracle.substr(length(ws_numfac)-1,1) = 'P' then
--     	vs_tiporep = 'SP'
--     else
--     	vs_tiporep = 'NP'
--     end if;
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
cry_dec007, --
cry_chr001,
cry_chr007,
cry_dec003,
cry_dec009,
cry_dec010,
cry_dec004,
cry_chr040)
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
wd_fecpol,
wn_usugen,
ws_nomusu,
ws_tippol,
ws_cuenta,
wn_cargos,
wn_abonos,
ws_keyemp,
ws_nomemp,
ws_numfac,
wn_impfac,
wn_keypol,
wi_pol_forpag,
wd_pol_tipcam,
'SP'
);
else
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
cry_chr009, --
cry_chr001,
cry_chr007,
cry_dec003,
cry_dec009,
cry_dec010,
cry_dec004,
cry_chr040)
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
wd_fecpol,
wn_usugen,
ws_nomusu,
ws_tippol,
ws_cuenta,
wn_cargos,
wn_abonos,
ws_keyemp,
ws_nomemp,
ws_numfac,
wn_impfac,
wn_keypol,
wi_pol_forpag,
wd_pol_tipcam,
'NP'
);
end if;
end loop;end;
$body$
language plpgsql
;
