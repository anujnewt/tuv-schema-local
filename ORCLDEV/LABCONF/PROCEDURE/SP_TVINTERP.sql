create or replace procedure labconf."sp_tvinterp"  (wn_keypro numeric, ws_keyper varchar, wn_keynom numeric, wn_keycia numeric, ws_tippol varchar, ws_tiprep varchar, ws_nomrep varchar, ws_poliza varchar, ws_idepcc varchar, wn_keyusu numeric) as $body$
declare
-- pgv moved types start
-- pgv moved types end
ws_despro varchar(40);
ws_descia varchar(40);
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
ws_rfcban varchar(20);
ws_sucban varchar(20);
ws_desprov varchar(60);
ws_keyfac varchar(30);
ws_nomben varchar(50);
c_interp1 record;
c_ctas record;
c_interp2 record;
c_interp3 record;
begin
--obtiene la descripcion del proceso
select pro_despro
into strict ws_despro
from nmloproc
where pro_keypro = wn_keypro;
--obtiene la descripcion de la compania
select oracle.substr(cia_descia,1,40),cia_rfccia
into strict ws_descia,ws_rfcban
from nmlocias
where cia_keycia = wn_keycia;/* dmap converted statement start */
ws_desprov :=  concat(ws_rfcban, ' ' , ws_descia) ;/* dmap converted statement end */
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
--determina no. de finiquitos
select count(distinct ape_keyemp)
into strict wn_totemp
from sipros_erp_enc
where oracle.substr(ape_keypol,1,10) = ws_poliza;/* dmap converted statement start */
--lectura de las facturas
if ws_tiprep <> 'T' then
for c_interp1 in (
select apd_keypol,
apd_cveban,
concat(apd_cuenta, apd_subcta , apd_ssbcta)  cuenta,    --ws_cuenta
apd_cvecta,        --ws_cvecta
apd_tipmov,        --ws_tipmov
sum(apd_import) cargos,   --cry_dec001 dec(18,6) wn_cargos
sum(apd_import) abonos    --cry_dec002 dec(18,6) wn_abonos
from sipros_erp_det
where apd_keypol in (select ape_keypol
from sipros_erp_enc
where oracle.substr(ape_keypol,1,10) = ws_poliza
and ape_status = ws_tiprep
and oracle.substr(ape_auxca1,1,6) = 'NOMINA')
group by apd_keypol, apd_cveban,  concat(apd_cuenta, apd_subcta , apd_ssbcta) , apd_cvecta, apd_tipmov
order by  1,2) loop
ws_keyfac := c_interp1.apd_keypol;/* dmap converted statement end */
ws_sucban := c_interp1.apd_cveban;
ws_cuenta := c_interp1.cuenta;
ws_cvecta := c_interp1.apd_cvecta;
ws_tipmov := c_interp1.apd_tipmov;
wn_cargos := c_interp1.cargos;
wn_abonos := c_interp1.abonos;
-- determina importe
if ws_tipmov = 'C' then
wn_cargos := 0;
else
wn_abonos := 0;
end if;
--corta la cuenta para las cuentas tipo "s"
if ws_cvecta = 'S' then
ws_cuenta := oracle.substr(ws_cuenta,7,3);
select count(distinct apd_keyemp)
into strict wn_canemp
from sipros_erp_det
where apd_keypol in (select ape_keypol
from sipros_erp_enc
where oracle.substr(ape_keypol,1,10) = ws_poliza
and ape_status = ws_tiprep
and oracle.substr(ape_auxca1,1,6) = 'NOMINA')
and apd_tipmov = ws_tipmov
and apd_ssbcta = ws_cuenta;/* dmap converted statement start */
else
select count(distinct apd_keyemp)
into strict wn_canemp
from sipros_erp_det
where apd_keypol in (select ape_keypol
from sipros_erp_enc
where oracle.substr(ape_keypol,1,10) = ws_poliza
and ape_status = ws_tiprep
and oracle.substr(ape_auxca1,1,6) = 'NOMINA')
and apd_tipmov = ws_tipmov
and  concat(apd_cuenta, apd_subcta , apd_ssbcta)  = ws_cuenta;/* dmap converted statement end */
end if;
--busca descripcion de la cuenta
for c_ctas in (
select pam_nompar
from glcopams
where pam_keypar = 'CCTA'
and pam_folini = ws_cuenta) loop
ws_descta := c_ctas.pam_nompar;
end loop;
-- inserta valores en tabla temporal
insert into tmp_interp
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
ws_sucban,
ws_cuenta,
wn_cargos,
wn_abonos,
wn_canemp,
ws_cvecta,
ws_tipmov,
ws_descta,
ws_tiprep,
ws_keyfac);
end loop;/* dmap converted statement start */
else  --si es t
for c_interp2 in (select apd_keypol,
apd_cveban,
concat(apd_cuenta, apd_subcta , apd_ssbcta)  cuenta,    --ws_cuenta
apd_cvecta,        --ws_cvecta
apd_tipmov,        --ws_tipmov
sum(apd_import) cargos,   --cry_dec001 dec(18,6) wn_cargos
sum(apd_import) abonos    --cry_dec002 dec(18,6) wn_abonos
into strict ws_keyfac,
ws_sucban,
ws_cuenta,
ws_cvecta,
ws_tipmov,
wn_cargos,
wn_abonos
from sipros_erp_det
where apd_keypol in (select ape_keypol
from sipros_erp_enc
where oracle.substr(ape_keypol,1,10) = ws_poliza
and ape_status = ws_tiprep
and oracle.substr(ape_auxca1,1,6) = 'NOMINA')
group by apd_keypol, apd_cveban,  concat(apd_cuenta, apd_subcta , apd_ssbcta) , apd_cvecta, apd_tipmov
order by  1,2) loop
-- determina importe
if ws_tipmov = 'C' then
wn_cargos := 0;/* dmap converted statement end */
else
wn_abonos := 0;
end if;
--corta la cuenta para las cuentas tipo "s"
if ws_cvecta = 'S' then
ws_cuenta := oracle.substr(ws_cuenta,7,3);
select count(distinct apd_keyemp)
into strict wn_canemp
from sipros_erp_det
where apd_keypol in (select ape_keypol
from sipros_erp_enc
where oracle.substr(ape_keypol,1,10) = ws_poliza
and ape_status = ws_tiprep
and oracle.substr(ape_auxca1,1,6) = 'NOMINA')
and apd_tipmov = ws_tipmov
and apd_ssbcta = ws_cuenta;/* dmap converted statement start */
else
select count(distinct apd_keyemp)
into strict wn_canemp
from sipros_erp_det
where apd_keypol in (select ape_keypol
from sipros_erp_enc
where oracle.substr(ape_keypol,1,10) = ws_poliza
and ape_status = ws_tiprep
and oracle.substr(ape_auxca1,1,6) = 'NOMINA')
and apd_tipmov = ws_tipmov
and  concat(apd_cuenta, apd_subcta , apd_ssbcta)  = ws_cuenta;/* dmap converted statement end */
end if;
--busca descripcion de la cuenta
select pam_nompar
into strict ws_descta
from glcopams
where pam_keypar = 'CCS'
and pam_folini = ws_cuenta;
-- inserta valores en tabla temporal
insert into tmp_interp
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
ws_sucban,
ws_cuenta,
wn_cargos,
wn_abonos,
wn_canemp,
ws_cvecta,
ws_tipmov,
ws_descta,
ws_tiprep,
ws_keyfac);
end loop;
end if;
for c_interp3 in (select  tmp_keyfac,
tmp_sucban,
tmp_canemp,
tmp_cuenta,
tmp_descta,
tmp_cvecta,
tmp_tipmov,
sum(tmp_cargos) cargos,
sum(tmp_abonos) abonos
from  tmp_interp
group by tmp_keyfac,tmp_sucban,tmp_canemp,tmp_cuenta,tmp_descta,tmp_cvecta,tmp_tipmov
order by  1,2,4) loop
ws_keyfac := c_interp3.tmp_keyfac;
ws_sucban := c_interp3.tmp_sucban;
wn_canemp := c_interp3.tmp_canemp;
ws_cuenta := c_interp3.tmp_cuenta;
ws_descta := c_interp3.tmp_descta;
ws_cvecta := c_interp3.tmp_cvecta;
ws_tipmov := c_interp3.tmp_tipmov;
wn_cargos := c_interp3.cargos;
wn_abonos := c_interp3.abonos;
--busca beneficiario
select ape_auxca1
into strict ws_nomben
from sipros_erp_enc
where ape_keypol = ws_keyfac;
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
cry_dec007,
cry_chr021,
cry_chr022,
cry_dec009,
cry_chr007,
cry_chr023,
cry_chr012,
cry_chr010,
cry_chr002,
cry_chr009,
cry_chr001)
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
ws_poliza,
ws_sucban,
ws_desprov,
ws_keyfac,
ws_nomben);
end loop;
--exception
--    when others then
--        sp_glgenerr ('sp_tvinterp', ws_idepcc, wn_keyusu, sp_glgethor,
--		     sqlcode, 0, oracle.substr(sqlerrm, 1, 60));
end;
$body$
language plpgsql
;
