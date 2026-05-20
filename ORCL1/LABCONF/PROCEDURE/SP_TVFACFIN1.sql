create or replace procedure labconf."sp_tvfacfin1"  (wn_keypro numeric , ws_keyper varchar, wn_keynom numeric, wn_keycia numeric, ws_tippol varchar, ws_tiprep varchar, ws_opcrep varchar, ws_lote varchar, wd_fecpol timestamp(0), ws_nomrep varchar, ws_idepcc varchar, wn_keyusu numeric) as $body$
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
wn_canemp integer;
wn_totemp integer;
ws_cvecta varchar(1);
ws_descta varchar(40);
wd_fecmod timestamp(0);
c_sipros_erp record;
c_cuenta1 record;
c_sipros_erp2 record;
c_cuenta2 record;
c_sipros_erp3 record;
c_cuenta3 record;
c_sipros_erp4 record;
c_cuenta4 record;
c_sipros_erp5 record;
begin
insert into glwkcrys(cry_nomrep,cry_chr001,cry_dec001,cry_dec002) values ('PRUEBA',ws_despro,wn_cargos,1);
--obtiene la descripcion del proceso
select pro_despro
into strict ws_despro
from nmloproc
where pro_keypro = wn_keypro;
insert into glwkcrys(cry_nomrep,cry_chr001,cry_dec001,cry_dec002) values ('PRUEBA',ws_despro,wn_cargos,2);
--obtiene la descripcion de la compania
select oracle.substr(cia_descia,1,60)
into strict ws_descia
from nmlocias
where cia_keycia = wn_keycia;
insert into glwkcrys(cry_nomrep,cry_chr001,cry_dec001,cry_dec002) values ('PRUEBA',ws_despro,wn_cargos,3);
--obtiene la descripcion de la nomina
select nom_destip
into strict ws_destip
from nmlonomi
where nom_keynom = wn_keynom;
insert into glwkcrys(cry_nomrep,cry_chr001,cry_dec001,cry_dec002) values ('PRUEBA',ws_despro,wn_cargos,4);
--obtiene el nombre del usuario
select usu_nomusu
into strict ws_nomusu
from glcousua
where usu_keyusu = wn_keyusu;
insert into glwkcrys(cry_nomrep,cry_chr001,cry_dec001,cry_dec002) values ('PRUEBA',ws_despro,wn_cargos,5);
--obtiene fecha de aplicacion y fecha de generacion
select distinct ape_fecmod
into strict wd_fecmod
from sipros_erp_enc
where ape_keylot = ws_lote
and ape_fecpol = wd_fecpol;
insert into glwkcrys(cry_nomrep,cry_chr001,cry_dec001,cry_dec002) values ('PRUEBA',ws_despro,wn_cargos,6);
--determina no. de finiquitos
select count(distinct ape_keyemp)
into strict wn_totemp
from sipros_erp_enc
where ape_keylot = ws_lote
and ape_fecpol = wd_fecpol;
insert into glwkcrys(cry_nomrep,cry_chr001,cry_dec001,cry_dec002) values ('PRUEBA',ws_despro,wn_cargos,7);/* dmap converted statement start */
if ws_tiprep <> 'T' then
if ws_opcrep = 'NO' then
for c_sipros_erp in (select  concat(apd_cuenta, apd_subcta , apd_ssbcta)  ws_cuenta,    --ws_cuenta
apd_cvecta,        --ws_cvecta
apd_tipmov,        --ws_tipmov
sum(apd_import) cargos,   --cry_dec001 dec(18,6) wn_cargos
sum(apd_import) abonos    --cry_dec002 dec(18,6) wn_abonos
from sipros_erp_enc,
sipros_erp_det
where ape_keypol = apd_keypol
and ape_keylot = ws_lote
and ape_fecpol = wd_fecpol
and ape_status = ws_tiprep
and oracle.substr(ape_keypol,12,1) = ws_tippol
and ape_keypol not like '%PA'
group by  concat(apd_cuenta, apd_subcta , apd_ssbcta) , apd_cvecta, apd_tipmov
order by  1) loop
ws_cuenta := c_sipros_erp.ws_cuenta;/* dmap converted statement end */
ws_cvecta := c_sipros_erp.apd_cvecta;
ws_tipmov := c_sipros_erp.apd_tipmov;
wn_cargos := c_sipros_erp.cargos;
wn_abonos := c_sipros_erp.abonos;
if ws_tipmov = 'C' then
wn_cargos := 0;
else
wn_abonos := 0;
end if;
--corta la cuenta para las cuentas tipo "s"
if ws_cvecta = 'S' then
ws_cuenta := oracle.substr(ws_cuenta,7,3);
select count(distinct ape_keyemp)
into strict wn_canemp
from sipros_erp_enc,
sipros_erp_det
where ape_keypol = apd_keypol
and ape_keylot = ws_lote
and ape_fecpol = wd_fecpol
and ape_status = ws_tiprep
and oracle.substr(ape_keypol,12,1) = ws_tippol
and apd_tipmov = ws_tipmov
and apd_ssbcta = ws_cuenta;/* dmap converted statement start */
else
select count(distinct ape_keyemp)
into strict wn_canemp
from sipros_erp_enc,
sipros_erp_det
where ape_keypol = apd_keypol
and ape_keylot = ws_lote
and ape_fecpol = wd_fecpol
and ape_status = ws_tiprep
and oracle.substr(ape_keypol,12,1) = ws_tippol
and apd_tipmov = ws_tipmov
and  concat(apd_cuenta, apd_subcta , apd_ssbcta)  = ws_cuenta;/* dmap converted statement end */
end if;
ws_descta := 'NO EXISTE CUENTA';
for c_cuenta1 in (select pam_nompar
from glcopams
where pam_keypar = 'CCTA'
and pam_folini = ws_cuenta) loop
ws_descta := c_cuenta1.pam_nompar;
end loop;
insert into tmp_facfin
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
ws_nomusu,
ws_tippol,
ws_cuenta,
wn_cargos,
wn_abonos,
wn_canemp,
ws_cvecta,
ws_tipmov,
ws_descta,
ws_tiprep);
end loop;/* dmap converted statement start */
else   --else para pensionadas
for c_sipros_erp2 in (select  concat(apd_cuenta, apd_subcta , apd_ssbcta)  ws_cuenta,    --ws_cuenta
apd_cvecta,        --ws_cvecta
apd_tipmov,        --ws_tipmov
sum(apd_import) cargos,   --cry_dec001 dec(18,6) wn_cargos
sum(apd_import) abonos     --cry_dec002 dec(18,6) wn_abonos
from sipros_erp_enc,
sipros_erp_det
where ape_keypol = apd_keypol
and ape_keylot = ws_lote
and ape_fecpol = wd_fecpol
and ape_status = ws_tiprep
and oracle.substr(ape_keypol,12,1) = ws_tippol
and ape_keypol like '%PA'
group by  concat(apd_cuenta, apd_subcta , apd_ssbcta) , apd_cvecta, apd_tipmov
order by  1) loop
ws_cuenta := c_sipros_erp2.ws_cuenta;/* dmap converted statement end */
ws_cvecta := c_sipros_erp2.apd_cvecta;
ws_tipmov := c_sipros_erp2.apd_tipmov;
wn_cargos := c_sipros_erp2.cargos;
wn_abonos := c_sipros_erp2.abonos;
-- determina importe
if ws_tipmov = 'C' then
wn_cargos := 0;
else
wn_abonos := 0;
end if;
--corta la cuenta para las cuentas tipo "s"
if ws_cvecta = 'S' then
ws_cuenta := oracle.substr(ws_cuenta,7,3);
select count(distinct ape_keyemp)
into strict wn_canemp
from sipros_erp_enc,
sipros_erp_det
where ape_keypol = apd_keypol
and ape_keylot = ws_lote
and ape_fecpol = wd_fecpol
and ape_status = ws_tiprep
and oracle.substr(ape_keypol,12,1) = ws_tippol
and apd_tipmov = ws_tipmov
and apd_ssbcta = ws_cuenta;/* dmap converted statement start */
else
select count(distinct ape_keyemp)
into strict wn_canemp
from sipros_erp_enc,
sipros_erp_det
where ape_keypol = apd_keypol
and ape_keylot = ws_lote
and ape_fecpol = wd_fecpol
and ape_status = ws_tiprep
and oracle.substr(ape_keypol,12,12) = ws_tippol
and apd_tipmov = ws_tipmov
and  concat(apd_cuenta, apd_subcta , apd_ssbcta)  = ws_cuenta;/* dmap converted statement end */
end if;
--busca descripcion de la cuenta
ws_descta := 'NO EXISTE CUENTA';
for c_cuenta2 in (select pam_nompar
from glcopams
where pam_keypar = 'CCTA'
and pam_folini = ws_cuenta) loop
ws_descta := c_cuenta2.pam_nompar;
end loop;
-- inserta valores en tabla temporal
insert into tmp_facfin
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
ws_nomusu,
ws_tippol,
ws_cuenta,
wn_cargos,
wn_abonos,
wn_canemp,
ws_cvecta,
ws_tipmov,
ws_descta,
ws_tiprep);
end loop;
end if;/* dmap converted statement start */
else  --si es t
if ws_opcrep = 'NO' then
for c_sipros_erp3 in (select  concat(apd_cuenta, apd_subcta , apd_ssbcta)  ws_cuenta,    --ws_cuenta
apd_cvecta,        --ws_cvecta
apd_tipmov,        --ws_tipmov
sum(apd_import) cargos,   --cry_dec001 dec(18,6) wn_cargos
sum(apd_import) abonos    --cry_dec002 dec(18,6) wn_abonos
from sipros_erp_enc,
sipros_erp_det
where ape_keypol = apd_keypol
and oracle.substr(ape_keylot,1,10) = oracle.substr(ws_lote,1,10)
and oracle.substr(ape_keypol,12,1) = ws_tippol
and ape_keypol not like '%PA'
group by  concat(apd_cuenta, apd_subcta , apd_ssbcta) ,apd_cvecta,apd_tipmov
order by  1) loop
ws_cuenta := c_sipros_erp3.ws_cuenta;/* dmap converted statement end */
ws_cvecta := c_sipros_erp3.apd_cvecta;
ws_tipmov := c_sipros_erp3.apd_tipmov;
wn_cargos := c_sipros_erp3.cargos;
wn_abonos := c_sipros_erp3.abonos;
-- determina importe
if ws_tipmov = 'C' then
wn_cargos := 0;
else
wn_abonos := 0;
end if;
--corta la cuenta para las cuentas tipo "s"
if ws_cvecta = 'S' then
ws_cuenta := oracle.substr(ws_cuenta,7,3);
select count(distinct ape_keyemp)
into strict wn_canemp
from sipros_erp_enc,
sipros_erp_det
where ape_keypol = apd_keypol
and oracle.substr(ape_keylot,1,10) = oracle.substr(ws_lote,1,10)
and ape_status = ws_tiprep
and oracle.substr(ape_keypol,12,1) = ws_tippol
and apd_tipmov = ws_tipmov
and apd_ssbcta = ws_cuenta;/* dmap converted statement start */
else
select count(distinct ape_keyemp)
into strict wn_canemp
from sipros_erp_enc,
sipros_erp_det
where ape_keypol = apd_keypol
and oracle.substr(ape_keylot,1,10) = oracle.substr(ws_lote,1,10)
and ape_status = ws_tiprep
and oracle.substr(ape_keypol,12,1) = ws_tippol
and apd_tipmov = ws_tipmov
and  concat(apd_cuenta, apd_subcta , apd_ssbcta)  = ws_cuenta;/* dmap converted statement end */
end if;
--busca descripcion de la cuenta
ws_descta := 'NO EXISTE CUENTA';
for c_cuenta3 in (select pam_nompar
from glcopams
where pam_keypar = 'CCTA'
and pam_folini = ws_cuenta) loop
ws_descta := c_cuenta3.pam_nompar;
end loop;
-- inserta valores en tabla temporal
insert into tmp_facfin
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
ws_nomusu,
ws_tippol,
ws_cuenta,
wn_cargos,
wn_abonos,
wn_canemp,
ws_cvecta,
ws_tipmov,
ws_descta,
ws_tiprep);
end loop;/* dmap converted statement start */
else  -- else para pensionadas
for c_sipros_erp4 in (select  concat(apd_cuenta, apd_subcta , apd_ssbcta)  ws_cuenta,    --ws_cuenta
apd_cvecta,        --ws_cvecta
apd_tipmov,        --ws_tipmov
sum(apd_import) cargos,   --cry_dec001 dec(18,6) wn_cargos
sum(apd_import) abonos    --cry_dec002 dec(18,6) wn_abonos
into strict ws_cuenta,
ws_cvecta,
ws_tipmov,
wn_cargos,
wn_abonos
from sipros_erp_enc,
sipros_erp_det
where ape_keypol = apd_keypol
and oracle.substr(ape_keylot,1,10) = oracle.substr(ws_lote,1,10)
and oracle.substr(ape_keypol,12,1) = ws_tippol
and ape_keypol like '%PA'
group by  concat(apd_cuenta, apd_subcta , apd_ssbcta) ,apd_cvecta,apd_tipmov
order by  1) loop
ws_cuenta := c_sipros_erp4.ws_cuenta;/* dmap converted statement end */
ws_cvecta := c_sipros_erp4.apd_cvecta;
ws_tipmov := c_sipros_erp4.apd_tipmov;
wn_cargos := c_sipros_erp4.cargos;
wn_abonos := c_sipros_erp4.abonos;
-- determina importe
if ws_tipmov = 'C' then
wn_cargos := 0;
else
wn_abonos := 0;
end if;
--corta la cuenta para las cuentas tipo "s"
if ws_cvecta = 'S' then
ws_cuenta := oracle.substr(ws_cuenta,7,3);
select count(distinct ape_keyemp)
into strict wn_canemp
from sipros_erp_enc,
sipros_erp_det
where ape_keypol = apd_keypol
and oracle.substr(ape_keylot,1,10) = oracle.substr(ws_lote,1,10)
and ape_status = ws_tiprep
and oracle.substr(ape_keypol,12,1) = ws_tippol
and apd_tipmov = ws_tipmov
and apd_ssbcta = ws_cuenta;/* dmap converted statement start */
else
select count(distinct ape_keyemp)
into strict wn_canemp
from sipros_erp_enc,
sipros_erp_det
where ape_keypol = apd_keypol
and oracle.substr(ape_keylot,1,10) = oracle.substr(ws_lote,1,10)
and ape_status = ws_tiprep
and oracle.substr(ape_keypol,12,1) = ws_tippol
and apd_tipmov = ws_tipmov
and  concat(apd_cuenta, apd_subcta , apd_ssbcta)  = ws_cuenta;/* dmap converted statement end */
end if;
--busca descripcion de la cuenta
ws_descta := 'NO EXISTE CUENTA';
for c_cuenta4 in (select pam_nompar
from glcopams
where pam_keypar = 'CCTA'
and pam_folini = ws_cuenta) loop
ws_descta := c_cuenta4.pam_nompar;
end loop;
-- inserta valores en tabla temporal
insert into tmp_facfin
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
ws_nomusu,
ws_tippol,
ws_cuenta,
wn_cargos,
wn_abonos,
wn_canemp,
ws_cvecta,
ws_tipmov,
ws_descta,
ws_tiprep);
end loop;
end if;
end if;
--saca encabezados del reporte
select  distinct
tmp_despro,
tmp_descia,
tmp_destip,
tmp_nomusu
into strict
ws_despro,
ws_descia,
ws_destip,
ws_nomusu
from  tmp_facfin;
select count(*) into strict wn_cargos
from tmp_facfin;
insert into glwkcrys(cry_nomrep,cry_chr001,cry_dec001,cry_dec002) values ('PRUEBA',ws_despro,wn_cargos,8);
for c_sipros_erp5 in (select  tmp_canemp,
tmp_cuenta,
tmp_descta,
tmp_cvecta,
tmp_tipmov,
sum(tmp_cargos) cargos,
sum(tmp_abonos) abonos
from  tmp_facfin
group by tmp_canemp,tmp_cuenta,tmp_descta,tmp_cvecta,tmp_tipmov
order by  2) loop
wn_canemp := c_sipros_erp5.tmp_canemp;
ws_cuenta := c_sipros_erp5.tmp_cuenta;
ws_descta := c_sipros_erp5.tmp_descta;
ws_cvecta := c_sipros_erp5.tmp_cvecta;
ws_tipmov := c_sipros_erp5.tmp_tipmov;
wn_cargos := c_sipros_erp5.cargos;
wn_abonos := c_sipros_erp5.abonos;
insert into glwkcrys(cry_nomrep, cry_idepcc, cry_keyusu, cry_dec006, cry_chr003,
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
cry_dec007,
cry_chr021,
cry_chr022,
cry_dec009,
cry_chr007,
cry_chr023,
cry_chr012,
cry_dat001,
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
wn_canemp,
ws_cvecta,
ws_tipmov,
wn_totemp,
ws_descta,
ws_tiprep,
ws_lote,
wd_fecpol,
wd_fecmod);
end loop;
select count(*) into strict wn_cargos
from tmp_facfin;
--exception
--    when others then
--        sp_glgenerr ('tvfacfin', ws_idepcc, wn_keyusu, sp_glgethor,
--		     sqlcode, 0, oracle.substr(sqlerrm, 1, 60));
end;
$body$
language plpgsql
;
