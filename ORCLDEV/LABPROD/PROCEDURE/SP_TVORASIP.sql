create or replace procedure labprod."sp_tvorasip"  (wi_proceso smallint, conta_a varchar, psconceptos varchar, psconceptosopci varchar, pskeyusu integer, conta_o inout varchar) as $body$
declare
-- pgv moved types start
-- pgv moved types end
sper_keyper varchar(7);
dper_fecini timestamp(0);
ipre_impsal decimal(12,2);
ipre_impamo decimal(12,2);
wn_tot_mov decimal(16,6);
wi_valido  integer;
wi_refere  integer;
i          integer;
conta      decimal(16,6);
-- lectura de la tabla 'ap_sipros' para actualizar el proceso      ---
-- asi como el status del empleado, para poder hacer despues el filtro ---
--si no hay filtros de conceptos y conceptos opci
c_2 record;
c_3 record;
begin
-- lectura de la tabla 'ap_sipros' para fecha y carga nulas --
-- asi como el filtro de proceso ---
-- validacion del archivo de entrada ---
for c_2 in (
select
soi_keyemp, soi_keycon, soi_refere, soi_tipope,
soi_import, soi_fecope, soi_tipmon, soi_tipcam,
soi_tipreg, soi_keypre, soi_keypro, soi_status, soi_refamo
--into
--isoi_keyemp, ssoi_keycon, ssoi_refere, ssoi_tipope,
--ssoi_import, isoi_fecope, ssoi_tipmon, ssoi_tipcam,
--ssoi_tipreg, ssoi_keypre, isoi_keypro, isoi_status, ssoi_refamo
from
ap_sipros
where nullif(soi_feccar::text, '') is null
and   nullif(soi_stacar::text, '') is null
and   soi_keypro = wi_proceso)
loop
-- valido prestamo
wi_valido := 0;
select count(*) into strict wi_valido
from nmlopres
where pre_keyemp = c_2.soi_keyemp
and pre_keycon  = c_2.soi_keycon
and pre_refere  = c_2.soi_refere;
if wi_valido > 0 then
--- si ya existe el prestamo rechazo los anticipos ---
update ap_sipros
set soi_tipreg = 'R',
soi_keypre = 0,
soi_feccar = trunc(clock_timestamp()),
soi_stacar = 'P'
where soi_keyemp = c_2.soi_keyemp
and   soi_keycon = c_2.soi_keycon
and   soi_refere = c_2.soi_refere
and   soi_tipreg = 'A'
and   nullif(soi_feccar::text, '') is null
and   nullif(soi_stacar::text, '') is null
and   soi_refamo = c_2.soi_refamo;
/* commit; */
continue;
end if;
--- rechazo los prestamos nuevos (anticipos = 'A')
--- y el proceso sea igual al proceso enviado por parametro
--- para los empleados dados de baja (10-agosto-2001)
update ap_sipros
set soi_tipreg = 'R',
soi_keypre = 0,
soi_feccar = trunc(clock_timestamp()),
soi_stacar = 'P'
where soi_tipreg = 'A'
and soi_status = 2
and   nullif(soi_feccar::text, '') is null
and   nullif(soi_stacar::text, '') is null
and   soi_refamo = c_2.soi_refamo
and   soi_keypro = wi_proceso;
/* commit; */
--- rechazo cualquier registro cuyo tipreg no sea 'A', 'C' y no haya
--- sido rechazado anteriormente (fecha de carga nula)
--- y el proceso sea igual al proceso enviado por parametro
update ap_sipros
set  soi_keypre = 0,
soi_tipreg = 'R',
soi_feccar = trunc(clock_timestamp()),
soi_stacar = 'P'
where soi_tipreg not in ('A','C','R','E','O')
and   nullif(soi_feccar::text, '') is null
and   nullif(soi_stacar::text, '') is null
and   soi_refamo = c_2.soi_refamo
and   soi_keypro = wi_proceso;
/* commit; */
end loop;
-- empiezo con los anticipos
-- asigno la llave de prestamos mientras sea 'A' (anticipos)
-- y el proceso sea igual al proceso enviado por parametro
-- para empleados activos (23 - julio- 2001)
conta := conta_a;
for c_3 in (
select
soi_keyemp, soi_keycon, soi_refere, soi_tipope,
soi_import, soi_fecope, soi_tipmon, soi_tipcam,
soi_tipreg, soi_keypre, soi_keypro, soi_status, soi_refamo
--into
--isoi_keyemp, ssoi_keycon, ssoi_refere, ssoi_tipope,
--ssoi_import, isoi_fecope, ssoi_tipmon, ssoi_tipcam,
--ssoi_tipreg, ssoi_keypre, isoi_keypro, isoi_status, ssoi_refamo
from
ap_sipros
where soi_tipreg = 'A'
and   soi_status = 1   --- 23-julio-2001  ---
and   nullif(soi_feccar::text, '') is null
and   nullif(soi_stacar::text, '') is null
and   soi_keypro = wi_proceso)
loop
--sp_nmkeypre2('',wn_tot_mov);
--wn_tot_mov := wn_tot_mov + conta;
conta := conta + 0.000001;
dper_fecini := c_3.soi_fecope;
-- inserto en la tabla 'nmlopres' los anticipos del dia de hoy---
-- cuando el proceso sea igual al proceso enviado por parametro ---
-- y empleados activos (23-julio-2001)
--carsi select per_keyper, per_fecini into sper_keyper, dper_fecini
select per_keyper into strict sper_keyper
from nmloperi
where per_keypro= c_3.soi_keypro
and  per_fecini <= c_3.soi_fecope     --carsi wd_fecope
and  per_fecfin >= c_3.soi_fecope     --carsi wd_fecope
and  per_keynom=1;
--actualizo tipo de cambio a 1 para moneda nacional
if c_3.soi_tipmon = '1' then
if c_3.soi_tipcam = 0.0 then
c_3.soi_tipcam := 1.0;
end if;
end if;
insert into nmlopres(pre_keyemp, pre_keycon, pre_keypre, pre_refere, pre_fecreg,
pre_tippre, pre_unipre, pre_imppre, pre_gastos, pre_plazop,
pre_unides, pre_impdes, pre_porint, pre_perini, pre_fecini,
pre_fecaut, pre_cveaut, pre_fechab, pre_uniamo, pre_impamo,
pre_unisal, pre_impsal, pre_uniult, pre_impult, pre_numpag,
pre_intpag, pre_status, pre_ultact, pre_refcon, pre_ctreve,
pre_fe1aux, pre_fe2aux, pre_ca1aux, pre_ca2aux, pre_ca3aux,
pre_ca4aux, pre_uniope, pre_keypro)
values (
c_3.soi_keyemp, c_3.soi_keycon, conta, c_3.soi_refere, c_3.soi_fecope,
1          , null       , c_3.soi_import, null       , 1          ,
null       , c_3.soi_import, 0          , sper_keyper, dper_fecini,
c_3.soi_fecope, null       , null       , 0          , 0          ,
0          , c_3.soi_import, 0          , 0          , 0          ,
0          , 4          , c_3.soi_fecope, null       , c_3.soi_refamo,
null       , null       , c_3.soi_tipmon, c_3.soi_tipcam, null       ,
null       , null       , c_3.soi_keypro
);
update ap_sipros
set soi_keypre = wn_tot_mov,
soi_feccar = trunc(clock_timestamp()),
soi_stacar = 'P'
where soi_keyemp = c_3.soi_keyemp
and   soi_keycon = c_3.soi_keycon
and   soi_refere = c_3.soi_refere
and   soi_tipreg = 'A'
and   nullif(soi_feccar::text, '') is null
and   nullif(soi_stacar::text, '') is null
and   soi_refamo = c_3.soi_refamo;
/* commit; */
end loop;
conta_o := conta;end;
$body$
language plpgsql
;
