create or replace procedure usrsiho."sp_hcbgenpo2"  (wn_keypol integer, ws_nomrep varchar, ws_idepcc varchar, wn_keyusu integer) as $body$
declare
-- pgv moved types start
-- pgv moved types end
ws_keyapr varchar(8);
ws_keyper varchar(8);
ws_cvepol varchar(30);
ws_nompar varchar(40);
ws_destip varchar(40);
ws_nomusu varchar(40);
ws_cuenta varchar(40);
ws_corte  varchar(10);
ws_corte2 varchar(03);
ws_letra  varchar(10);
ws_semana smallint;
ws_tippol varchar(1);
wn_numemi smallint;
wn_keynom smallint;
wn_usugen integer;
wd_fecpol timestamp(0);
wn_cargos  decimal(18,6);
wn_abonos decimal(18,6);
ws_periodos varchar(80);
cur_01 record;
cur_02 record;
begin
--lectura del detalle de la poliza
for cur_01 in (select distinct pol_keyapr, pam_nompar, pol_numemi, pol_keynom, nom_destip, pol_usugen,
usu_nomusu, pol_cvepol, pol_fecpol, det_cuenta, det_cargos, det_abonos,
oracle.substr(det_cuenta, 1, 10) corte, oracle.substr(det_cuenta, 8, 3) corte2, per_nu5aux,
oracle.substr(det_cuenta, 1,1) corte3, pol_semana
from holopoli, nmlonomi, glcousua, glcopams, holodetp, nmloperi
where pol_keynom = nom_keynom and
pol_usugen = usu_keyusu and
pam_keypar = 'H2'       and
pam_cvesec = pol_keyapr and
pol_keypol = det_keypol and
pol_ctvpol = 1          and
pol_keypro = per_keypro and
pol_keyapr = per_nu3aux and
pol_numemi = per_nu4aux and
pol_keynom = per_keynom and
pol_keypol = wn_keypol)
loop
ws_keyapr := cur_01.pol_keyapr;
ws_nompar := cur_01.pam_nompar;
wn_numemi := cur_01.pol_numemi;
wn_keynom := cur_01.pol_keynom;
ws_destip := cur_01.nom_destip;
wn_usugen := cur_01.pol_usugen;
ws_nomusu := cur_01.usu_nomusu;
ws_cvepol := cur_01.pol_cvepol;
wd_fecpol := cur_01.pol_fecpol;
ws_cuenta := cur_01.det_cuenta;
wn_cargos := cur_01.det_cargos;
wn_abonos := cur_01.det_abonos;
ws_corte  := cur_01.corte;
ws_corte2 := cur_01.corte2;
ws_tippol := cur_01.per_nu5aux;
ws_letra  := cur_01.corte3;
ws_semana := cur_01.pol_semana;
--inserccion de los registros en la tabla de paso
if (wn_keynom = 101 or wn_keynom = 110) and wn_cargos > 0 and wn_abonos > 0 then
ws_corte := '9999999999';
else
ws_corte := ws_corte;
end if;
if ws_tippol = 'N' and ws_letra= 'S' then
ws_corte := ws_corte2;
end if;
if ws_tippol = 'P' and ws_letra = 'S' then
ws_corte :=ws_corte2;
end if;
insert into   glwkcrys(cry_nomrep, cry_idepcc, cry_keyusu,
cry_chr017, cry_chr003, cry_dec006, cry_dec007, cry_chr004, cry_dec008,
cry_chr005, cry_chr007, cry_dat001, cry_chr006, cry_dec001, cry_dec002, cry_chr016, cry_chr009)
values (ws_nomrep, ws_idepcc, wn_keyusu,
ws_keyapr, ws_nompar, wn_numemi, wn_keynom, ws_destip, wn_usugen,
ws_nomusu, ws_cvepol, wd_fecpol, ws_cuenta, wn_cargos, wn_abonos, ws_corte, ws_semana);
end loop;
--obtencion de la lista de periodo
ws_periodos := ' ';
for cur_02 in (select distinct per_keyper
-- into ws_keyper
from  holopoli, nmlonomi, glcousua, glcopams, usrsiho.holodetp, usrsiho.nmloperi
where pol_keynom=nom_keynom and
pol_usugen=usu_keyusu and
pam_keypar='H2'       and
pam_cvesec=pol_keyapr and
pol_keypol=det_keypol and
pol_ctvpol=1          and
pol_keypro=per_keypro and
pol_keyapr=per_nu3aux and
pol_numemi=per_nu4aux and
pol_keynom=per_keynom and
pol_keypol=wn_keypol)
loop
-- ws_keyapr := cur_02.per_keyper;
-- ws_periodos := trim(ws_periodos) || trim(ws_keyper) || "; ";
-- ws_periodos := trim(ws_periodos) || trim(ws_keyper) || '; ';
-- ws_periodos := '4947007';
ws_periodos := cur_02.per_keyper;
end loop;
--actualizacion del periodo
update glwkcrys
set    cry_chr001 = ws_periodos
where  cry_nomrep = ws_nomrep and
cry_idepcc = ws_idepcc and
cry_keyusu = wn_keyusu;end;
$body$
language plpgsql
;
