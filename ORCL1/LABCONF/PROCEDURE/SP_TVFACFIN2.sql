create or replace procedure labconf."sp_tvfacfin2"  (wn_keypro numeric , ws_keyper varchar, wn_keynom numeric, wn_keycia numeric, ws_tippol varchar, ws_tiprep varchar, ws_opcrep varchar, ws_lote varchar, wd_fecpol timestamp(0), ws_nomrep varchar, ws_idepcc varchar, wn_keyusu numeric) as $body$
declare
-- pgv moved types start
-- pgv moved types end
ws_despro varchar(40);
ws_descia varchar(60);
ws_destip varchar(40);
ws_nomusu varchar(40);
ws_cuenta varchar(40);
wn_cargos decimal(18,6);
wn_abonos decimal(18,6);
ws_cta varchar(03);
ws_scta varchar(03);
ws_sscta varchar(03);
ws_tipmov varchar(1);
wn_keyemp integer;
ws_nomemp varchar(60);
wn_import decimal(18,6);
ws_keypol varchar(30);
ws_descta varchar(20);
wd_fecmod timestamp(0);
ws_benef varchar(60);
c_sipros_erp record;
c_cuenta1 record;
c_sipros_erp2 record;
c_cuenta2 record;
c_sipros_erp3 record;
c_cuenta3 record;
c_sipros_erp4 record;
c_cuenta4 record;
begin
select oracle.substr(cia_descia,1,60)
into strict ws_descia
from nmlocias
where cia_keycia = wn_keycia;
--obtiene la descripcion de la nomina
select nom_destip
into strict ws_destip
from nmlonomi
where nom_keynom = wn_keynom;
--obtiene el nombre del usuario
select usu_nomusu
into strict ws_nomusu
from glcousua
where usu_keyusu = wn_keyusu;
--obtiene fecha de aplicacion y fecha de generacion
select distinct ape_fecmod
into strict wd_fecmod
from sipros_erp_enc
where ape_keylot = ws_lote
and ape_fecpol = wd_fecpol;/* dmap converted statement start */
if ws_tiprep <> 'T' then
if ws_opcrep = 'NO' then
for c_sipros_erp in (select ape_keypol,
ape_despro,
apd_tipmov,
ape_keyemp,
emp_nomemp,
ape_fecpol,
ape_import,
concat(apd_cuenta, apd_subcta , apd_ssbcta)  cuenta,
sum(apd_import) cargos,
sum(apd_import) abonos
from sipros_erp_enc,
sipros_erp_det,
nmcoempl
where ape_keypol = apd_keypol
and ape_keyemp = emp_keyemp
and ape_keylot = ws_lote
and ape_fecpol = wd_fecpol   --nueva
and ape_status = ws_tiprep
and oracle.substr(ape_keypol,12,1) = ws_tippol
and ape_keypol not like '%PA'
group by ape_keypol,ape_despro,apd_tipmov,ape_keyemp,emp_nomemp,ape_fecpol,ape_import, concat(apd_cuenta, apd_subcta, apd_ssbcta)  order by  1,4,8) loop
ws_keypol := c_sipros_erp.ape_keypol;/* dmap converted statement end */
ws_despro := c_sipros_erp.ape_despro;
ws_tipmov := c_sipros_erp.apd_tipmov;
wn_keyemp := c_sipros_erp.ape_keyemp;
ws_nomemp := c_sipros_erp.emp_nomemp;
--wd_fecpol := c_sipros_erp.ape_fecpol;
wn_import := c_sipros_erp.ape_import;
ws_cuenta := c_sipros_erp.cuenta;
wn_cargos := c_sipros_erp.cargos;
wn_abonos := c_sipros_erp.abonos;
-- determina importe
if ws_tipmov = 'C' then
wn_cargos := 0;
else
wn_abonos := 0;
end if;
--corta la cuenta para las cuentas tipo "s"
if oracle.substr(ws_cuenta,7,1) = '1' then
ws_cuenta := oracle.substr(ws_cuenta,7,3);
end if;
--busca descripcion de la cuenta
ws_descta := 'NO EXISTE CUENTA';
for c_cuenta1 in (select oracle.substr(pam_nompar,1,20) pam_nompar
from glcopams
where pam_keypar = 'CCTA'
and pam_folini = ws_cuenta) loop
ws_descta := c_cuenta1.pam_nompar;
end loop;
--obtiene nombre del beneficiario
select distinct ape_auxca1
into strict ws_benef
from sipros_erp_enc
where ape_keylot = ws_lote
and ape_fecpol = wd_fecpol --nueva
and ape_keypol = ws_keypol;
-- inserta valores
-- insert into paso(linea) values(7);
insert into glwkcrys(cry_nomrep,
cry_idepcc,
cry_keyusu,
cry_dec006,
cry_chr003,
cry_chr017,
cry_chr004,
cry_chr018,
cry_chr005,
cry_chr019,
cry_dec008,
cry_chr006,
cry_chr020,
cry_chr008,
cry_dec001,
cry_dec002,
cry_chr007, ---se aumentaron estos 5 renglones
cry_dec007,
cry_chr001,
cry_dat001,
cry_dec003,
cry_chr023,
cry_chr012,
cry_chr009,
cry_dat002)
values (ws_nomrep,
ws_idepcc,
wn_keyusu,
wn_keypro,
ws_despro,
wn_keycia,
ws_descia,
wn_keynom,
ws_destip,
ws_keyper,
wn_keyusu,
ws_nomusu,
ws_tippol,
ws_cuenta,
wn_cargos,
wn_abonos,
ws_keypol,  --se aumentaron estos 5 renglones
wn_keyemp,
ws_benef,   --ws_nomemp,
wd_fecpol,
wn_import,
ws_tiprep,
ws_lote,
ws_descta,
wd_fecmod);
end loop;/* dmap converted statement start */
else
for c_sipros_erp2 in (select ape_keypol,
ape_despro,
apd_tipmov,
ape_keyemp,
emp_nomemp,
ape_fecpol,
ape_import,
concat(apd_cuenta, apd_subcta , apd_ssbcta)  cuenta,
sum(apd_import) cargos,
sum(apd_import) abonos
from sipros_erp_enc,
sipros_erp_det,
nmcoempl
where ape_keypol = apd_keypol
and ape_keyemp = emp_keyemp
and ape_keylot = ws_lote
and ape_fecpol = wd_fecpol   --nueva
and ape_status = ws_tiprep
and oracle.substr(ape_keypol,12,1) = ws_tippol
and ape_keypol like '%PA'
group by ape_keypol,ape_despro,apd_tipmov,ape_keyemp,emp_nomemp,ape_fecpol,ape_import, concat(apd_cuenta, apd_subcta, apd_ssbcta)  order by  1,4,8) loop
ws_keypol := c_sipros_erp2.ape_keypol;/* dmap converted statement end */
ws_despro := c_sipros_erp2.ape_despro;
ws_tipmov := c_sipros_erp2.apd_tipmov;
wn_keyemp := c_sipros_erp2.ape_keyemp;
ws_nomemp := c_sipros_erp2.emp_nomemp;
--wd_fecpol := c_sipros_erp2.ape_fecpol;
wn_import := c_sipros_erp2.ape_import;
ws_cuenta := c_sipros_erp2.cuenta;
wn_cargos := c_sipros_erp2.cargos;
wn_abonos := c_sipros_erp2.abonos;
-- determina importe
if ws_tipmov = 'C' then
wn_cargos := 0;
else
wn_abonos := 0;
end if;
--corta la cuenta para las cuentas tipo "s"
if oracle.substr(ws_cuenta,7,1) = '1' then
ws_cuenta := oracle.substr(ws_cuenta,7,3);
end if;
--busca descripcion de la cuenta
ws_descta := 'NO EXISTE CUENTA';
for c_cuenta2 in (select oracle.substr(pam_nompar,1,20)  pam_nompar
from glcopams
where pam_keypar = 'CCTA'
and pam_folini = ws_cuenta) loop
ws_descta := c_cuenta2.pam_nompar;
end loop;
--obtiene nombre del beneficiario
select distinct ape_auxca1
into strict ws_benef
from sipros_erp_enc
where ape_keylot = ws_lote
and ape_fecpol = wd_fecpol --nueva
and ape_keypol = ws_keypol;
-- inserta valores
-- insert into paso(linea) values(7);
insert into glwkcrys(cry_nomrep,
cry_idepcc,
cry_keyusu,
cry_dec006,
cry_chr003,
cry_chr017,
cry_chr004,
cry_chr018,
cry_chr005,
cry_chr019,
cry_dec008,
cry_chr006,
cry_chr020,
cry_chr008,
cry_dec001,
cry_dec002,
cry_chr007, ---se aumentaron estos 5 renglones
cry_dec007,
cry_chr001,
cry_dat001,
cry_dec003,
cry_chr023,
cry_chr012,
cry_chr009,
cry_dat002)
values (ws_nomrep,
ws_idepcc,
wn_keyusu,
wn_keypro,
ws_despro,
wn_keycia,
ws_descia,
wn_keynom,
ws_destip,
ws_keyper,
wn_keyusu,
ws_nomusu,
ws_tippol,
ws_cuenta,
wn_cargos,
wn_abonos,
ws_keypol,  --se aumentaron estos 5 renglones
wn_keyemp,
ws_benef,   --ws_nomemp,
wd_fecpol,
wn_import,
ws_tiprep,
ws_lote,
ws_descta,
wd_fecmod);
end loop;
end if;/* dmap converted statement start */
else
if ws_opcrep = 'NO' then
for c_sipros_erp3 in (select ape_keypol,
ape_despro,
apd_tipmov,
ape_keyemp,
emp_nomemp,
ape_fecpol,
ape_import,
concat(apd_cuenta, apd_subcta , apd_ssbcta)  cuenta,
sum(apd_import) cargos,
sum(apd_import) abonos
from sipros_erp_enc,
sipros_erp_det,
nmcoempl
where ape_keypol = apd_keypol
and ape_keyemp = emp_keyemp
and ape_keylot = ws_lote
and ape_fecpol = wd_fecpol   --nueva
and oracle.substr(ape_keypol,12,1) = ws_tippol
and ape_keypol not like '%PA'
group by ape_keypol,ape_despro,apd_tipmov,ape_keyemp,emp_nomemp,ape_fecpol,ape_import, concat(apd_cuenta, apd_subcta, apd_ssbcta)  order by  1,4,8) loop
ws_keypol := c_sipros_erp3.ape_keypol;/* dmap converted statement end */
ws_despro := c_sipros_erp3.ape_despro;
ws_tipmov := c_sipros_erp3.apd_tipmov;
wn_keyemp := c_sipros_erp3.ape_keyemp;
ws_nomemp := c_sipros_erp3.emp_nomemp;
--wd_fecpol := c_sipros_erp3.ape_fecpol;
wn_import := c_sipros_erp3.ape_import;
ws_cuenta := c_sipros_erp3.cuenta;
wn_cargos := c_sipros_erp3.cargos;
wn_abonos := c_sipros_erp3.abonos;
-- determina importe
if ws_tipmov = 'C' then
wn_cargos := 0;
else
wn_abonos := 0;
end if;
--corta la cuenta para las cuentas tipo "s"
if oracle.substr(ws_cuenta,7,1) = '1' then
ws_cuenta := oracle.substr(ws_cuenta,7,3);
end if;
--busca descripcion de la cuenta
ws_descta := 'NO EXISTE CUENTA';
for c_cuenta3 in (select oracle.substr(pam_nompar,1,20)  pam_nompar
from glcopams
where pam_keypar = 'CCTA'
and pam_folini = ws_cuenta) loop
ws_descta := c_cuenta3.pam_nompar;
end loop;
--obtiene nombre del beneficiario
select distinct ape_auxca1
into strict ws_benef
from sipros_erp_enc
where ape_keylot = ws_lote
and ape_fecpol = wd_fecpol --nueva
and ape_keypol = ws_keypol;
-- inserta valores
-- insert into paso(linea) values(7);
insert into glwkcrys(cry_nomrep,
cry_idepcc,
cry_keyusu,
cry_dec006,
cry_chr003,
cry_chr017,
cry_chr004,
cry_chr018,
cry_chr005,
cry_chr019,
cry_dec008,
cry_chr006,
cry_chr020,
cry_chr008,
cry_dec001,
cry_dec002,
cry_chr007, ---se aumentaron estos 5 renglones
cry_dec007,
cry_chr001,
cry_dat001,
cry_dec003,
cry_chr012,
cry_chr009,
cry_dat002)
values (ws_nomrep,
ws_idepcc,
wn_keyusu,
wn_keypro,
ws_despro,
wn_keycia,
ws_descia,
wn_keynom,
ws_destip,
ws_keyper,
wn_keyusu,
ws_nomusu,
ws_tippol,
ws_cuenta,
wn_cargos,
wn_abonos,
ws_keypol,  --se aumentaron estos 5 renglones
wn_keyemp,
ws_benef,   --ws_nomemp,
wd_fecpol,
wn_import,
ws_lote,
ws_descta,
wd_fecmod);
end loop;/* dmap converted statement start */
else
for c_sipros_erp4 in (select ape_keypol,
ape_despro,
apd_tipmov,
ape_keyemp,
emp_nomemp,
ape_fecpol,
ape_import,
concat(apd_cuenta, apd_subcta , apd_ssbcta)  cuenta,
sum(apd_import) cargos,
sum(apd_import) abonos
from sipros_erp_enc,
sipros_erp_det,
nmcoempl
where ape_keypol = apd_keypol
and ape_keyemp = emp_keyemp
and ape_keylot = ws_lote
and ape_fecpol = wd_fecpol   --nueva
and oracle.substr(ape_keypol,12,1) = ws_tippol
and ape_keypol like '%PA'
group by ape_keypol,ape_despro,apd_tipmov,ape_keyemp,emp_nomemp,ape_fecpol,ape_import, concat(apd_cuenta, apd_subcta, apd_ssbcta)  order by  1,4,8) loop
ws_keypol := c_sipros_erp4.ape_keypol;/* dmap converted statement end */
ws_despro := c_sipros_erp4.ape_despro;
ws_tipmov := c_sipros_erp4.apd_tipmov;
wn_keyemp := c_sipros_erp4.ape_keyemp;
ws_nomemp := c_sipros_erp4.emp_nomemp;
--wd_fecpol := c_sipros_erp4.ape_fecpol;
wn_import := c_sipros_erp4.ape_import;
ws_cuenta := c_sipros_erp4.cuenta;
wn_cargos := c_sipros_erp4.cargos;
wn_abonos := c_sipros_erp4.abonos;
-- determina importe
if ws_tipmov = 'C' then
wn_cargos := 0;
else
wn_abonos := 0;
end if;
--corta la cuenta para las cuentas tipo "s"
if oracle.substr(ws_cuenta,7,1) = '1' then
ws_cuenta := oracle.substr(ws_cuenta,7,3);
end if;
--busca descripcion de la cuenta
ws_descta := 'NO EXISTE CUENTA';
for c_cuenta4 in (select oracle.substr(pam_nompar,1,20)  pam_nompar
from glcopams
where pam_keypar = 'CCTA'
and pam_folini = ws_cuenta) loop
ws_descta := c_cuenta4.pam_nompar;
end loop;
--obtiene nombre del beneficiario
select distinct ape_auxca1
into strict ws_benef
from sipros_erp_enc
where ape_keylot = ws_lote
and ape_fecpol = wd_fecpol --nueva
and ape_keypol = ws_keypol;
-- inserta valores
-- insert into paso(linea) values(7);
insert into glwkcrys(cry_nomrep,
cry_idepcc,
cry_keyusu,
cry_dec006,
cry_chr003,
cry_chr017,
cry_chr004,
cry_chr018,
cry_chr005,
cry_chr019,
cry_dec008,
cry_chr006,
cry_chr020,
cry_chr008,
cry_dec001,
cry_dec002,
cry_chr007, ---se aumentaron estos 5 renglones
cry_dec007,
cry_chr001,
cry_dat001,
cry_dec003,
cry_chr012,
cry_chr009,
cry_dat002)
values (ws_nomrep,
ws_idepcc,
wn_keyusu,
wn_keypro,
ws_despro,
wn_keycia,
ws_descia,
wn_keynom,
ws_destip,
ws_keyper,
wn_keyusu,
ws_nomusu,
ws_tippol,
ws_cuenta,
wn_cargos,
wn_abonos,
ws_keypol,  --se aumentaron estos 5 renglones
wn_keyemp,
ws_benef,   --ws_nomemp,
wd_fecpol,
wn_import,
ws_lote,
ws_descta,
wd_fecmod);
end loop;
end if;
end if;end;
$body$
language plpgsql
;
