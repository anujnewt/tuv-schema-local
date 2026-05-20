create or replace procedure labconf."sp_tvorasip"  (wi_proceso smallint, conta_a decimal, psconceptos varchar, psconceptosopci varchar, pskeyusu integer) as $body$
declare
-- pgv moved types start
-- pgv moved types end
--variables
-- tabla de 'ap_sipros'
isoi_keyemp integer;
ssoi_keycon varchar(3);
ssoi_refere varchar(20);
ssoi_tipope varchar(1);
ssoi_import decimal(11,2);
isoi_fecope timestamp(0);
wd_fecope   timestamp(0);
ssoi_tipmon varchar(1);
ssoi_tipcam decimal(11,4);
ssoi_tipreg varchar(1);
ssoi_keypre decimal(11,6);
isoi_keypro smallint;
isoi_status varchar(1);
ssoi_refamo varchar(16);
sper_keyper varchar(7);
dper_fecini timestamp(0);
ipre_impsal decimal(12,2);
ipre_impamo decimal(12,2);
semp_keydep varchar(16);
semp_keypue varchar(16);
semp_keycat varchar(16);
semp_keyloc varchar(16);
wn_fec_mov integer;
wn_hor_mov integer;
wn_min_mov integer;
wn_seg_mov integer;
wn_tot_mov decimal(16,6);
wn_tot_mo2 decimal(16,6);
ws_tmp_mov varchar(2);
wi_valido  integer;
wi_refere  integer;
--   conta_a    decimal(10,6);
largo_a    integer;
shominse   varchar(6);
count_pres integer;
icountapres integer;
i          integer;
conta      decimal(16,6);
-- lectura de la tabla 'ap_sipros' para actualizar el proceso      ---
-- asi como el status del empleado, para poder hacer despues el filtro ---
--si no hay filtros de conceptos y conceptos opci
c_1 record;
c_2 record;
c_3 record;
c_4 record;
c_5 record;
c_6 record;
c_7 record;
c_8 record;
c_9 record;
c_10 record;
c_11 record;
c_12 record;
c_13 record;
c_14 record;
c_15 record;
c_16 record;
begin
--set debug file to '/tmp/algo.txt';
--trace on;
if psconceptos = '*' and psconceptosopci = '*' then
-------------------------------------------
-------------------------------------------
for c_1 in (
select soi_keyemp, soi_refamo
--into isoi_keyemp, ssoi_refamo
from ap_sipros
where nullif(soi_feccar::text, '') is null
and   nullif(soi_stacar::text, '') is null)
loop
-- obtengo el proceso y el status de la tabla de empleados
select emp_keypro, emp_status into strict isoi_keypro,isoi_status
from nmcoempl
where emp_keyemp = c_1.soi_keyemp
and emp_keypro = wi_proceso;
update ap_sipros
set soi_keypro = isoi_keypro,
soi_status = isoi_status
where soi_keyemp = c_1.soi_keyemp
and   nullif(soi_feccar::text, '') is null
and   nullif(soi_stacar::text, '') is null
and   soi_refamo = c_1.soi_refamo;
end loop;
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
--for i = 1 to 1
-- valido si el numero de empleado existe
wi_valido := 0;
select count(*) into strict wi_valido
from nmcoempl
where emp_keyemp = c_2.soi_keyemp;
if wi_valido = 0 then
-- si no existe el empleado rechazo el movimiento ----
update ap_sipros
set soi_tipreg = 'E',
soi_keypre = 0,
soi_feccar = clock_timestamp(),
soi_stacar = 'P'
where soi_keyemp = c_2.soi_keyemp
and   nullif(soi_feccar::text, '') is null
and   nullif(soi_stacar::text, '') is null
and   soi_refamo = c_2.soi_refamo;
--continue for;
-- �continue? pus si va de 1 a 1 ?
else
-- valido si el numero de concepto existe
wi_valido := 0;
select count(*) into strict wi_valido
from nmloconc
where con_keycon = c_2.soi_keycon;
if wi_valido = 0 then
--- si el concepto no existe rechazo el movimiento ---
update ap_sipros
set soi_tipreg = 'O',
soi_keypre = 0,
soi_feccar = clock_timestamp(),
soi_stacar = 'P'
where soi_keyemp = c_2.soi_keyemp
and   soi_keycon = c_2.soi_keycon
and   nullif(soi_feccar::text, '') is null
and   nullif(soi_stacar::text, '') is null
and   soi_refamo = c_2.soi_refamo;
--continue for;
-- �continue? pus si va de 1 a 1 ?
else
-- valido si la referencia existe para ese empleado
-- y ese concepto
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
soi_feccar = clock_timestamp(),
soi_stacar = 'P'
where soi_keyemp = c_2.soi_keyemp
and   soi_keycon = c_2.soi_keycon
and   soi_refere = c_2.soi_refere
and   soi_tipreg = 'A'
and   nullif(soi_feccar::text, '') is null
and   nullif(soi_stacar::text, '') is null
and   soi_refamo = c_2.soi_refamo;
end if;
end if;
end if;
-- obtengo el proceso y el status de la tabla de empleados
select emp_keypro, emp_status into strict isoi_keypro,isoi_status
from nmcoempl
where emp_keyemp = c_2.soi_keyemp;
update ap_sipros
set soi_keypro = isoi_keypro,
soi_status = isoi_status
where soi_keyemp = c_2.soi_keyemp
and (soi_tipreg = 'A' or soi_tipreg = 'C')
and   nullif(soi_feccar::text, '') is null
and   nullif(soi_stacar::text, '') is null
and   soi_refamo = c_2.soi_refamo;
--- rechazo los prestamos nuevos (anticipos = 'A')
--- y el proceso sea igual al proceso enviado por parametro
--- para los empleados dados de baja (10-agosto-2001)
update ap_sipros
set soi_tipreg = 'R',
soi_keypre = 0,
soi_feccar = clock_timestamp(),
soi_stacar = 'P'
where soi_tipreg = 'A'
and soi_status = 2
and   nullif(soi_feccar::text, '') is null
and   nullif(soi_stacar::text, '') is null
and   soi_refamo = c_2.soi_refamo
and   soi_keypro = wi_proceso;
--- rechazo cualquier registro cuyo tipreg no sea 'A', 'C' y no haya
--- sido rechazado anteriormente (fecha de carga nula)
--- y el proceso sea igual al proceso enviado por parametro
update ap_sipros
set  soi_keypre = 0,
soi_tipreg = 'R',
soi_feccar = clock_timestamp(),
soi_stacar = 'P'
where soi_tipreg not in ('A','C','R','E','O')
and   nullif(soi_feccar::text, '') is null
and   nullif(soi_stacar::text, '') is null
and   soi_refamo = c_2.soi_refamo
and   soi_keypro = wi_proceso;
--end for;
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
wn_fec_mov := 0;
wn_hor_mov := 0;
wn_min_mov := 0;
wn_seg_mov := 0;
wn_tot_mov := '0.0';
ws_tmp_mov:= null;
wn_fec_mov := (clock_timestamp())::numeric;
wn_tot_mov := wn_fec_mov + conta_a;
update ap_sipros
set soi_keypre = wn_tot_mov,
soi_feccar = clock_timestamp(),
soi_stacar = 'P'
where soi_keyemp = c_3.soi_keyemp
and   soi_keycon = c_3.soi_keycon
and   soi_refere = c_3.soi_refere
and   soi_tipreg = 'A'
and   nullif(soi_feccar::text, '') is null
and   nullif(soi_stacar::text, '') is null
and   soi_refamo = c_3.soi_refamo;
conta := conta + 0.000001;
end loop;
-- inserto en la tabla 'nmlopres' los anticipos del dia de hoy---
-- cuando el proceso sea igual al proceso enviado por parametro ---
-- y empleados activos (23-julio-2001)
for c_4 in (
select
soi_keyemp, soi_keycon, soi_refere, soi_tipope,
soi_import, soi_fecope, soi_tipmon, soi_tipcam,
soi_tipreg, soi_keypre, soi_keypro, soi_status, soi_refamo
--into
--isoi_keyemp, ssoi_keycon, ssoi_refere, ssoi_tipope,
--ssoi_import, isoi_fecope, ssoi_tipmon, ssoi_tipcam,
--ssoi_tipreg, ssoi_keypre, isoi_keypro, isoi_status
from
ap_sipros
where soi_tipreg = 'A'
and   soi_status = 1
and   soi_feccar = clock_timestamp()
and   soi_keypre <> 0
and   soi_keypro = wi_proceso)
loop
-- selecciono fecha para insertar en prestamos con 45 dias de colchon
--carsi let wd_fecope = isoi_fecope + 45;
dper_fecini := c_4.soi_fecope + 30;
--carsi select per_keyper, per_fecini into sper_keyper, dper_fecini
select per_keyper into strict sper_keyper
from nmloperi
where per_keypro= c_4.soi_keypro
and  per_fecini <= c_4.soi_fecope     --carsi wd_fecope
and  per_fecfin >= c_4.soi_fecope     --carsi wd_fecope
and  per_keynom=1;
--actualizo tipo de cambio a 1 para moneda nacional
if c_4.soi_tipmon = '1' then
if c_4.soi_tipcam = 0.0 then
c_4.soi_tipcam := 1.0;
end if;
end if;
-- para emleados activos....--
if c_4.soi_status = 1 then
icountapres := 0;
-- verifico si la llave existe en la tabla 'nmlopres'
select count(*) into strict icountapres
from nmlopres
where pre_keypre = c_4.soi_keypre;
-- si no existe, se inserta el prestamo con estatus=2 --
if icountapres = 0 then
insert into nmlopres(
pre_keyemp, pre_keycon, pre_keypre, pre_refere, pre_fecreg,
pre_tippre, pre_unipre, pre_imppre, pre_gastos, pre_plazop,
pre_unides, pre_impdes, pre_porint, pre_perini, pre_fecini,
pre_fecaut, pre_cveaut, pre_fechab, pre_uniamo, pre_impamo,
pre_unisal, pre_impsal, pre_uniult, pre_impult, pre_numpag,
pre_intpag, pre_status, pre_ultact, pre_refcon, pre_ctreve,
pre_fe1aux, pre_fe2aux, pre_ca1aux, pre_ca2aux, pre_ca3aux,
pre_ca4aux, pre_uniope, pre_keypro
)
values (
c_4.soi_keyemp, c_4.soi_keycon, c_4.soi_keypre, c_4.soi_refere, c_4.soi_fecope,
1          , null       , c_4.soi_import, null       , 1          ,
null       , c_4.soi_import, 0          , sper_keyper, dper_fecini,
c_4.soi_fecope, null       , null       , 0          , 0          ,
0          , c_4.soi_import, 0          , 0          , 0          ,
0          , 2          , c_4.soi_fecope, null       , c_4.soi_refamo,
null       , null       , c_4.soi_tipmon, c_4.soi_tipcam, null       ,
null       , null       , c_4.soi_keypro
);
else
-- si existe la llave rechazo el movimiento --
update ap_sipros
set soi_tipreg = 'R'
where soi_keyemp = c_4.soi_keyemp
and   soi_keycon = c_4.soi_keycon
and   soi_refere = c_4.soi_refere
and   soi_keypre = c_4.soi_keypre
and   soi_tipreg = 'A'
and   soi_stacar = 'P'
and   soi_feccar = clock_timestamp();
end if;
end if;
end loop;
else
--si hay filtros de conceptos y  no hay conceptos opci
if psconceptos <> '*' and psconceptosopci = '*' then
for c_5 in (
select soi_keyemp, soi_refamo, soi_keycon
--into isoi_keyemp, ssoi_refamo, ssoi_keycon
from ap_sipros
where nullif(soi_feccar::text, '') is null
and   nullif(soi_stacar::text, '') is null
and   soi_keycon in ( select dat_valore
from glcodats,glcousua
where usu_keyusu = pskeyusu
and usu_keymen = dat_keymen
and dat_idecam = 'keycon' ))
loop
-- obtengo el proceso y el status de la tabla de empleados
select emp_keypro, emp_status into strict isoi_keypro,isoi_status
from nmcoempl
where emp_keyemp = c_5.soi_keyemp
and emp_keypro = wi_proceso;
update ap_sipros
set soi_keypro = isoi_keypro,
soi_status = isoi_status
where soi_keyemp = c_5.soi_keyemp
and   soi_keycon = c_5.soi_keycon
and   nullif(soi_feccar::text, '') is null
and   nullif(soi_stacar::text, '') is null
and   soi_refamo = c_5.soi_refamo;
end loop;
-- lectura de la tabla 'ap_sipros' para fecha y carga nulas --
-- asi como el filtro de proceso ---
-- validacion del archivo de entrada ---
for c_6 in (
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
and   soi_keypro = wi_proceso
and   soi_keycon in ( select dat_valore
from glcodats,glcousua
where usu_keyusu = pskeyusu
and usu_keymen = dat_keymen
and dat_idecam = 'keycon' ))
loop
--for i = 1 to 1
-- valido si el numero de empleado existe
wi_valido := 0;
select count(*) into strict wi_valido
from nmcoempl
where emp_keyemp = c_6.soi_keyemp;
if wi_valido = 0 then
-- si no existe el empleado rechazo el movimiento ----
update ap_sipros
set soi_tipreg = 'E',
soi_keypre = 0,
soi_feccar = clock_timestamp(),
soi_stacar = 'P'
where soi_keyemp = c_6.soi_keyemp
and   soi_keycon = c_6.soi_keycon
and   nullif(soi_feccar::text, '') is null
and   nullif(soi_stacar::text, '') is null
and   soi_refamo = c_6.soi_refamo;
--continue for;  nel
else
-- valido si el numero de concepto existe
wi_valido := 0;
select count(*) into strict wi_valido
from nmloconc
where con_keycon = c_6.soi_keycon;
if wi_valido = 0 then
--- si el concepto no existe rechazo el movimiento ---
update ap_sipros
set soi_tipreg = 'O',
soi_keypre = 0,
soi_feccar = clock_timestamp(),
soi_stacar = 'P'
where soi_keyemp = c_6.soi_keyemp
and   soi_keycon = c_6.soi_keycon
and   nullif(soi_feccar::text, '') is null
and   nullif(soi_stacar::text, '') is null
and   soi_refamo = c_6.soi_refamo;
--continue for; neta?
else
-- valido si la referencia existe para ese empleado
-- y ese concepto
wi_valido := 0;
select count(*) into strict wi_valido
from nmlopres
where pre_keyemp = c_6.soi_keyemp
and pre_keycon  = c_6.soi_keycon
and pre_refere  = c_6.soi_refere;
if wi_valido > 0 then
--- si ya existe el prestamo rechazo los anticipos ---
update ap_sipros
set soi_tipreg = 'R',
soi_keypre = 0,
soi_feccar = clock_timestamp(),
soi_stacar = 'P'
where soi_keyemp = c_6.soi_keyemp
and   soi_keycon = c_6.soi_keycon
and   soi_refere = c_6.soi_refere
and   soi_tipreg = 'A'
and   nullif(soi_feccar::text, '') is null
and   nullif(soi_stacar::text, '') is null
and   soi_refamo = c_6.soi_refamo;
end if;
end if;
end if;
-- obtengo el proceso y el status de la tabla de empleados
select emp_keypro, emp_status into strict isoi_keypro,isoi_status
from nmcoempl
where emp_keyemp = c_6.soi_keyemp;
update ap_sipros
set soi_keypro = isoi_keypro,
soi_status = isoi_status
where soi_keyemp = c_6.soi_keyemp
and   soi_keycon = c_6.soi_keycon
and (soi_tipreg = 'A' or soi_tipreg = 'C')
and   nullif(soi_feccar::text, '') is null
and   nullif(soi_stacar::text, '') is null
and   soi_refamo = c_6.soi_refamo;
--- rechazo los prestamos nuevos (anticipos = 'A')
--- y el proceso sea igual al proceso enviado por parametro
--- para los empleados dados de baja (10-agosto-2001)
update ap_sipros
set soi_tipreg = 'R',
soi_keypre = 0,
soi_feccar = clock_timestamp(),
soi_stacar = 'P'
where soi_tipreg = 'A'
and soi_status = 2
and   nullif(soi_feccar::text, '') is null
and   nullif(soi_stacar::text, '') is null
and   soi_refamo = c_6.soi_refamo
and   soi_keypro = wi_proceso
and   soi_keycon in ( select dat_valore
from glcodats,glcousua
where usu_keyusu = pskeyusu
and usu_keymen = dat_keymen
and dat_idecam = 'keycon' );
--- rechazo cualquier registro cuyo tipreg no sea 'A', 'C' y no haya
--- sido rechazado anteriormente (fecha de carga nula)
--- y el proceso sea igual al proceso enviado por parametro
update ap_sipros
set  soi_keypre = 0,
soi_tipreg = 'R',
soi_feccar = clock_timestamp(),
soi_stacar = 'P'
where soi_tipreg not in ('A','C','R','E','O')
and   nullif(soi_feccar::text, '') is null
and   nullif(soi_stacar::text, '') is null
and   soi_refamo = c_6.soi_refamo
and   soi_keypro = wi_proceso
and   soi_keycon in ( select dat_valore
from glcodats,glcousua
where usu_keyusu = pskeyusu
and usu_keymen = dat_keymen
and dat_idecam = 'keycon' );
--end for;
end loop;
-- empiezo con los anticipos
-- asigno la llave de prestamos mientras sea 'A' (anticipos)
-- y el proceso sea igual al proceso enviado por parametro
-- para empleados activos (23 - julio- 2001)
conta := conta_a;
for c_7 in (
select
soi_keyemp, soi_keycon, soi_refere, soi_tipope,
soi_import, soi_fecope, soi_tipmon, soi_tipcam,
soi_tipreg, soi_keypre, soi_keypro, soi_status, soi_refamo
--into
-- isoi_keyemp, ssoi_keycon, ssoi_refere, ssoi_tipope,
-- ssoi_import, isoi_fecope, ssoi_tipmon, ssoi_tipcam,
-- ssoi_tipreg, ssoi_keypre, isoi_keypro, isoi_status, ssoi_refamo
from
ap_sipros
where soi_tipreg = 'A'
and   soi_status = 1   --- 23-julio-2001  ---
and   nullif(soi_feccar::text, '') is null
and   nullif(soi_stacar::text, '') is null
and   soi_keypro = wi_proceso
and   soi_keycon in ( select dat_valore
from glcodats,glcousua
where usu_keyusu = pskeyusu
and usu_keymen = dat_keymen
and dat_idecam = 'keycon' ))
loop
wn_fec_mov := 0;
wn_hor_mov := 0;
wn_min_mov := 0;
wn_seg_mov := 0;
wn_tot_mov := '0.0';
ws_tmp_mov:= null;
wn_fec_mov := (clock_timestamp())::numeric;
wn_tot_mov := wn_fec_mov + conta_a;
update ap_sipros
set soi_keypre = wn_tot_mov,
soi_feccar = clock_timestamp(),
soi_stacar = 'P'
where soi_keyemp = c_7.soi_keyemp
and   soi_keycon = c_7.soi_keycon
and   soi_refere = c_7.soi_refere
and   soi_tipreg = 'A'
and   nullif(soi_feccar::text, '') is null
and   nullif(soi_stacar::text, '') is null
and   soi_refamo = c_7.soi_refamo;
conta := conta + '0.000001';
end loop;
-- inserto en la tabla 'nmlopres' los anticipos del dia de hoy---
-- cuando el proceso sea igual al proceso enviado por parametro ---
-- y empleados activos (23-julio-2001)
for c_8 in (
select
soi_keyemp, soi_keycon, soi_refere, soi_tipope,
soi_import, soi_fecope, soi_tipmon, soi_tipcam,
soi_tipreg, soi_keypre, soi_keypro, soi_status, soi_refamo
--into
-- isoi_keyemp, ssoi_keycon, ssoi_refere, ssoi_tipope,
-- ssoi_import, isoi_fecope, ssoi_tipmon, ssoi_tipcam,
-- ssoi_tipreg, ssoi_keypre, isoi_keypro, isoi_status
from
ap_sipros
where soi_tipreg = 'A'
and   soi_status = 1
and   soi_feccar = clock_timestamp()
and   soi_keypre <> 0
and   soi_keypro = wi_proceso
and   soi_keycon in ( select dat_valore
from glcodats,glcousua
where usu_keyusu = pskeyusu
and usu_keymen = dat_keymen
and dat_idecam = 'keycon' ))
loop
-- selecciono fecha para insertar en prestamos con 45 dias de colchon
--carsi let wd_fecope = isoi_fecope + 45;
dper_fecini := c_8.soi_fecope + 30;
--carsi select per_keyper, per_fecini into sper_keyper, dper_fecini
select per_keyper into strict sper_keyper
from nmloperi
where per_keypro=c_8.soi_keypro
and  per_fecini <= c_8.soi_fecope     --carsi wd_fecope
and  per_fecfin >= c_8.soi_fecope     --carsi wd_fecope
and  per_keynom=1;
--actualizo tipo de cambio a 1 para moneda nacional
if c_8.soi_tipmon = '1' then
if c_8.soi_tipcam = 0.0 then
c_8.soi_tipcam := 1.0;
end if;
end if;
-- para emleados activos....--
if c_8.soi_status = 1 then
icountapres := 0;
-- verifico si la llave existe en la tabla 'nmlopres'
select count(*) into strict icountapres
from nmlopres
where pre_keypre = c_8.soi_keypre;
-- si no existe, se inserta el prestamo con estatus=4 --
if icountapres = 0 then
insert into nmlopres(
pre_keyemp, pre_keycon, pre_keypre, pre_refere, pre_fecreg,
pre_tippre, pre_unipre, pre_imppre, pre_gastos, pre_plazop,
pre_unides, pre_impdes, pre_porint, pre_perini, pre_fecini,
pre_fecaut, pre_cveaut, pre_fechab, pre_uniamo, pre_impamo,
pre_unisal, pre_impsal, pre_uniult, pre_impult, pre_numpag,
pre_intpag, pre_status, pre_ultact, pre_refcon, pre_ctreve,
pre_fe1aux, pre_fe2aux, pre_ca1aux, pre_ca2aux, pre_ca3aux,
pre_ca4aux, pre_uniope, pre_keypro
)
values (
c_8.soi_keyemp, c_8.soi_keycon, c_8.soi_keypre, c_8.soi_refere, c_8.soi_fecope,
1          , null       , ssoi_import, null       , 1          ,
null       , c_8.soi_import, 0          , sper_keyper, dper_fecini,
c_8.soi_fecope, null       , null       , 0          , 0          ,
0          , c_8.soi_import, 0          , 0          , 0          ,
0          , 4          , c_8.soi_fecope, null       , c_8.soi_refamo,
null       , null       , c_8.soi_tipmon, c_8.soi_tipcam, null       ,
null       , null       , c_8.soi_keypro
);
else
-- si existe la llave rechazo el movimiento --
update ap_sipros
set soi_tipreg = 'R'
where soi_keyemp = c_8.soi_keyemp
and   soi_keycon = c_8.soi_keycon
and   soi_refere = c_8.soi_refere
and   soi_keypre = c_8.soi_keypre
and   soi_tipreg = 'A'
and   soi_stacar = 'P'
and   soi_feccar = clock_timestamp();
end if;
end if;
end loop;
else
--si no hay filtros de conceptos y  hay conceptos opci
if psconceptos = '*' and psconceptosopci <> '*' then
for c_9 in (
select soi_keyemp, soi_refamo, soi_keycon--, emp_keypro, emp_status
--into isoi_keyemp, ssoi_refamo, ssoi_keycon
from ap_sipros
where nullif(soi_feccar::text, '') is null
and   nullif(soi_stacar::text, '') is null
and   soi_keycon not in ( select pam_folfin
from glcopams
where pam_keypar='Z03Q'
and pam_nompar = 'USUARIOS SIN RESTRICCION' ))
loop
-- obtengo el proceso y el status de la tabla de empleados
select emp_keypro, emp_status into strict isoi_keypro,isoi_status
from nmcoempl
where emp_keyemp = c_9.soi_keyemp;
--igneos.i (es necesario)?
--and emp_keypro = wi_proceso;
update ap_sipros
set soi_keypro = isoi_keypro,
soi_status = isoi_status
where soi_keyemp = c_9.soi_keyemp
and   soi_keycon = c_9.soi_keycon
and   nullif(soi_feccar::text, '') is null
and   nullif(soi_stacar::text, '') is null
and   soi_refamo = c_9.soi_refamo;
end loop;
-- lectura de la tabla 'ap_sipros' para fecha y carga nulas --
-- asi como el filtro de proceso ---
-- validacion del archivo de entrada ---
for c_10 in (
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
and   soi_keypro = wi_proceso
and   soi_keycon not in ( select pam_folfin
from glcopams
where pam_keypar='Z03Q'
and pam_nompar = 'USUARIOS SIN RESTRICCION' ))
loop
--for i = 1 to 1
-- valido si el numero de empleado existe
wi_valido := 0;
select count(*) into strict wi_valido
from nmcoempl
where emp_keyemp = c_10.soi_keyemp;
if wi_valido = 0 then
-- si no existe el empleado rechazo el movimiento ----
update ap_sipros
set soi_tipreg = 'E',
soi_keypre = 0,
soi_feccar = clock_timestamp(),
soi_stacar = 'P'
where soi_keyemp = c_10.soi_keyemp
and   soi_keycon = c_10.soi_keycon
and   nullif(soi_feccar::text, '') is null
and   nullif(soi_stacar::text, '') is null
and   soi_refamo = c_10.soi_refamo;
--continue for; seguro?
else
-- valido si el numero de concepto existe
wi_valido := 0;
select count(*) into strict wi_valido
from nmloconc
where con_keycon = c_10.soi_keycon;
if wi_valido = 0 then
--- si el concepto no existe rechazo el movimiento ---
update ap_sipros
set soi_tipreg = 'O',
soi_keypre = 0,
soi_feccar = clock_timestamp(),
soi_stacar = 'P'
where soi_keyemp = c_10.soi_keyemp
and   soi_keycon = c_10.soi_keycon
and   nullif(soi_feccar::text, '') is null
and   nullif(soi_stacar::text, '') is null
and   soi_refamo = c_10.soi_refamo;
--continue for;
else
-- valido si la referencia existe para ese empleado
-- y ese concepto
wi_valido := 0;
select count(*) into strict wi_valido
from nmlopres
where pre_keyemp = c_10.soi_keyemp
and pre_keycon  = c_10.soi_keycon
and pre_refere  = c_10.soi_refere;
if wi_valido > 0 then
--- si ya existe el prestamo rechazo los anticipos ---
update ap_sipros
set soi_tipreg = 'R',
soi_keypre = 0,
soi_feccar = clock_timestamp(),
soi_stacar = 'P'
where soi_keyemp = c_10.soi_keyemp
and   soi_keycon = c_10.soi_keycon
and   soi_refere = c_10.soi_refere
and   soi_tipreg = 'A'
and   nullif(soi_feccar::text, '') is null
and   nullif(soi_stacar::text, '') is null
and   soi_refamo = c_10.soi_refamo;
end if;
end if;
end if;
-- obtengo el proceso y el status de la tabla de empleados
select emp_keypro, emp_status into strict isoi_keypro,isoi_status
from nmcoempl
where emp_keyemp = c_10.soi_keyemp;
update ap_sipros
set soi_keypro = isoi_keypro,
soi_status = isoi_status
where soi_keyemp = c_10.soi_keyemp
and   soi_keycon = c_10.soi_keycon
and (soi_tipreg = 'A' or soi_tipreg = 'C')
and   nullif(soi_feccar::text, '') is null
and   nullif(soi_stacar::text, '') is null
and   soi_refamo = c_10.soi_refamo;
--- rechazo los prestamos nuevos (anticipos = 'A')
--- y el proceso sea igual al proceso enviado por parametro
--- para los empleados dados de baja (10-agosto-2001)
update ap_sipros
set soi_tipreg = 'R',
soi_keypre = 0,
soi_feccar = clock_timestamp(),
soi_stacar = 'P'
where soi_tipreg = 'A'
and soi_status = 2
and   nullif(soi_feccar::text, '') is null
and   nullif(soi_stacar::text, '') is null
and   soi_refamo = c_10.soi_refamo
and   soi_keypro = wi_proceso
and   soi_keycon not in ( select pam_folfin
from glcopams
where pam_keypar='Z03Q'
and pam_nompar = 'USUARIOS SIN RESTRICCION' );
--- rechazo cualquier registro cuyo tipreg no sea 'A', 'C' y no haya
--- sido rechazado anteriormente (fecha de carga nula)
--- y el proceso sea igual al proceso enviado por parametro
update ap_sipros
set  soi_keypre = 0,
soi_tipreg = 'R',
soi_feccar = clock_timestamp(),
soi_stacar = 'P'
where soi_tipreg not in ('A','C','R','E','O')
and   nullif(soi_feccar::text, '') is null
and   nullif(soi_stacar::text, '') is null
and   soi_refamo = c_10.soi_refamo
and   soi_keypro = wi_proceso
and   soi_keycon not in ( select pam_folfin
from glcopams
where pam_keypar='Z03Q'
and pam_nompar = 'USUARIOS SIN RESTRICCION' );
--end for;
end loop;
-- empiezo con los anticipos
-- asigno la llave de prestamos mientras sea 'A' (anticipos)
-- y el proceso sea igual al proceso enviado por parametro
-- para empleados activos (23 - julio- 2001)
conta := conta_a;
for c_11 in (
select
soi_keyemp, soi_keycon, soi_refere, soi_tipope,
soi_import, soi_fecope, soi_tipmon, soi_tipcam,
soi_tipreg, soi_keypre, soi_keypro, soi_status, soi_refamo
--into
-- isoi_keyemp, ssoi_keycon, ssoi_refere, ssoi_tipope,
-- ssoi_import, isoi_fecope, ssoi_tipmon, ssoi_tipcam,
-- ssoi_tipreg, ssoi_keypre, isoi_keypro, isoi_status, ssoi_refamo
from
ap_sipros
where soi_tipreg = 'A'
and   soi_status = 1   --- 23-julio-2001  ---
and   nullif(soi_feccar::text, '') is null
and   nullif(soi_stacar::text, '') is null
and   soi_keypro = wi_proceso
and   soi_keycon not in ( select pam_folfin
from glcopams
where pam_keypar='Z03Q'
and pam_nompar = 'USUARIOS SIN RESTRICCION' ))
loop
wn_fec_mov := 0;
wn_hor_mov := 0;
wn_min_mov := 0;
wn_seg_mov := 0;
wn_tot_mov := '0.0';
ws_tmp_mov:= null;
wn_fec_mov := (clock_timestamp())::numeric;
wn_tot_mov := wn_fec_mov + conta_a;
update ap_sipros
set soi_keypre = wn_tot_mov,
soi_feccar = clock_timestamp(),
soi_stacar = 'P'
where soi_keyemp = c_11.soi_keyemp
and   soi_keycon = c_11.soi_keycon
and   soi_refere = c_11.soi_refere
and   soi_tipreg = 'A'
and   nullif(soi_feccar::text, '') is null
and   nullif(soi_stacar::text, '') is null
and   soi_refamo = c_11.soi_refamo;
conta := conta + '0.000001';
end loop;
-- inserto en la tabla 'nmlopres' los anticipos del dia de hoy---
-- cuando el proceso sea igual al proceso enviado por parametro ---
-- y empleados activos (23-julio-2001)
for c_12 in (
select
soi_keyemp, soi_keycon, soi_refere, soi_tipope,
soi_import, soi_fecope, soi_tipmon, soi_tipcam,
soi_tipreg, soi_keypre, soi_keypro, soi_status, soi_refamo
--into
-- isoi_keyemp, ssoi_keycon, ssoi_refere, ssoi_tipope,
-- ssoi_import, isoi_fecope, ssoi_tipmon, ssoi_tipcam,
--  ssoi_tipreg, ssoi_keypre, isoi_keypro, isoi_status
from
ap_sipros
where soi_tipreg = 'A'
and   soi_status = 1
and   soi_feccar = clock_timestamp()
and   soi_keypre <> 0
and   soi_keypro = wi_proceso
and   soi_keycon not in ( select pam_folfin
from glcopams
where pam_keypar='Z03Q'
and pam_nompar = 'USUARIOS SIN RESTRICCION' ))
loop
-- selecciono fecha para insertar en prestamos con 45 dias de colchon
--carsi let wd_fecope = isoi_fecope + 45;
dper_fecini := isoi_fecope + 30;
--carsi select per_keyper, per_fecini into sper_keyper, dper_fecini
select per_keyper into strict sper_keyper
from nmloperi
where per_keypro= c_12.soi_keypro
and  per_fecini <= c_12.soi_fecope     --carsi wd_fecope
and  per_fecfin >= c_12.soi_fecope     --carsi wd_fecope
and  per_keynom=1;
--actualizo tipo de cambio a 1 para moneda nacional
if c_12.soi_tipmon = '1' then
if c_12.soi_tipcam = 0.0 then
c_12.soi_tipcam := 1.0;
end if;
end if;
-- para emleados activos....--
if c_12.soi_status = 1 then
icountapres := 0;
-- verifico si la llave existe en la tabla 'nmlopres'
select count(*) into strict icountapres
from nmlopres
where pre_keypre = c_12.soi_keypre;
-- si no existe, se inserta el prestamo con estatus=4 --
if icountapres = 0 then
insert into nmlopres(
pre_keyemp, pre_keycon, pre_keypre, pre_refere, pre_fecreg,
pre_tippre, pre_unipre, pre_imppre, pre_gastos, pre_plazop,
pre_unides, pre_impdes, pre_porint, pre_perini, pre_fecini,
pre_fecaut, pre_cveaut, pre_fechab, pre_uniamo, pre_impamo,
pre_unisal, pre_impsal, pre_uniult, pre_impult, pre_numpag,
pre_intpag, pre_status, pre_ultact, pre_refcon, pre_ctreve,
pre_fe1aux, pre_fe2aux, pre_ca1aux, pre_ca2aux, pre_ca3aux,
pre_ca4aux, pre_uniope, pre_keypro
)
values (
c_12.soi_keyemp, c_12.soi_keycon, c_12.soi_keypre, c_12.soi_refere, c_12.soi_fecope,
1          , null       , c_12.soi_import, null       , 1          ,
null       , c_12.soi_import, 0          , sper_keyper, dper_fecini,
c_12.soi_fecope, null       , null       , 0          , 0          ,
0          , c_12.soi_import, 0          , 0          , 0          ,
0          , 4          , c_12.soi_fecope, null       , c_12.soi_refamo,
null       , null       , c_12.soi_tipmon, c_12.soi_tipcam, null       ,
null       , null       , c_12.soi_keypro
);
else
-- si existe la llave rechazo el movimiento --
update ap_sipros
set soi_tipreg = 'R'
where soi_keyemp = c_12.soi_keyemp
and   soi_keycon = c_12.soi_keycon
and   soi_refere = c_12.soi_refere
and   soi_keypre = c_12.soi_keypre
and   soi_tipreg = 'A'
and   soi_stacar = 'P'
and   soi_feccar = clock_timestamp();
end if;
end if;
end loop;
else
--si hay filtros de conceptos y conceptos opci
for c_13 in (
select soi_keyemp, soi_refamo, soi_keycon
--into isoi_keyemp, ssoi_refamo, ssoi_keycon
from ap_sipros
where nullif(soi_feccar::text, '') is null
and   nullif(soi_stacar::text, '') is null
and   soi_keycon in ( select dat_valore
from glcodats,glcousua
where usu_keyusu = pskeyusu
and usu_keymen = dat_keymen
and dat_idecam = 'keycon' )
and   soi_keycon not in ( select pam_folfin
from glcopams
where pam_keypar='Z03Q'
and pam_nompar = 'USUARIOS SIN RESTRICCION' ))
loop
-- obtengo el proceso y el status de la tabla de empleados
select emp_keypro, emp_status into strict isoi_keypro,isoi_status
from nmcoempl
where emp_keyemp = c_13.soi_keyemp
and emp_keypro = wi_proceso;
update ap_sipros
set soi_keypro = isoi_keypro,
soi_status = isoi_status
where soi_keyemp = c_13.soi_keyemp
and   soi_keycon = c_13.soi_keycon
and   nullif(soi_feccar::text, '') is null
and   nullif(soi_stacar::text, '') is null
and   soi_refamo = c_13.soi_refamo;
end loop;
-- lectura de la tabla 'ap_sipros' para fecha y carga nulas --
-- asi como el filtro de proceso ---
-- validacion del archivo de entrada ---
for c_14 in (
select
soi_keyemp, soi_keycon, soi_refere, soi_tipope,
soi_import, soi_fecope, soi_tipmon, soi_tipcam,
soi_tipreg, soi_keypre, soi_keypro, soi_status, soi_refamo
--into
-- isoi_keyemp, ssoi_keycon, ssoi_refere, ssoi_tipope,
--- ssoi_import, isoi_fecope, ssoi_tipmon, ssoi_tipcam,
-- ssoi_tipreg, ssoi_keypre, isoi_keypro, isoi_status, ssoi_refamo
from
ap_sipros
where nullif(soi_feccar::text, '') is null
and   nullif(soi_stacar::text, '') is null
and   soi_keypro = wi_proceso
and   soi_keycon in ( select dat_valore
from glcodats,glcousua
where usu_keyusu = pskeyusu
and usu_keymen = dat_keymen
and dat_idecam = 'keycon' )
and   soi_keycon not in ( select pam_folfin
from glcopams
where pam_keypar='Z03Q'
and pam_nompar = 'USUARIOS SIN RESTRICCION' ))
loop
--for i = 1 to 1
-- valido si el numero de empleado existe
wi_valido := 0;
select count(*) into strict wi_valido
from nmcoempl
where emp_keyemp = c_14.soi_keyemp;
if wi_valido = 0 then
-- si no existe el empleado rechazo el movimiento ----
update ap_sipros
set soi_tipreg = 'E',
soi_keypre = 0,
soi_feccar = clock_timestamp(),
soi_stacar = 'P'
where soi_keyemp = c_14.soi_keyemp
and   soi_keycon = c_14.soi_keycon
and   nullif(soi_feccar::text, '') is null
and   nullif(soi_stacar::text, '') is null
and   soi_refamo = c_14.soi_refamo;
--continue for;
else
-- valido si el numero de concepto existe
wi_valido := 0;
select count(*) into strict wi_valido
from nmloconc
where con_keycon = c_14.soi_keycon;
if wi_valido = 0 then
--- si el concepto no existe rechazo el movimiento ---
update ap_sipros
set soi_tipreg = 'O',
soi_keypre = 0,
soi_feccar = clock_timestamp(),
soi_stacar = 'P'
where soi_keyemp = c_14.soi_keyemp
and   soi_keycon = c_14.soi_keycon
and   nullif(soi_feccar::text, '') is null
and   nullif(soi_stacar::text, '') is null
and   soi_refamo = c_14.soi_refamo;
--continue for;
else
-- valido si la referencia existe para ese empleado
-- y ese concepto
wi_valido := 0;
select count(*) into strict wi_valido
from nmlopres
where pre_keyemp = c_14.soi_keyemp
and pre_keycon  = c_14.soi_keycon
and pre_refere  = c_14.soi_refere;
if wi_valido > 0 then
--- si ya existe el prestamo rechazo los anticipos ---
update ap_sipros
set soi_tipreg = 'R',
soi_keypre = 0,
soi_feccar = clock_timestamp(),
soi_stacar = 'P'
where soi_keyemp = c_14.soi_keyemp
and   soi_keycon = c_14.soi_keycon
and   soi_refere = c_14.soi_refere
and   soi_tipreg = 'A'
and   nullif(soi_feccar::text, '') is null
and   nullif(soi_stacar::text, '') is null
and   soi_refamo = c_14.soi_refamo;
end if;
end if;
end if;
-- obtengo el proceso y el status de la tabla de empleados
select emp_keypro, emp_status into strict isoi_keypro,isoi_status
from nmcoempl
where emp_keyemp = c_14.soi_keyemp;
update ap_sipros
set soi_keypro = isoi_keypro,
soi_status = isoi_status
where soi_keyemp = c_14.soi_keyemp
and   soi_keycon = c_14.soi_keycon
and (soi_tipreg = 'A' or soi_tipreg = 'C')
and   nullif(soi_feccar::text, '') is null
and   nullif(soi_stacar::text, '') is null
and   soi_refamo = c_14.soi_refamo;
--- rechazo los prestamos nuevos (anticipos = 'A')
--- y el proceso sea igual al proceso enviado por parametro
--- para los empleados dados de baja (10-agosto-2001)
update ap_sipros
set soi_tipreg = 'R',
soi_keypre = 0,
soi_feccar = clock_timestamp(),
soi_stacar = 'P'
where soi_tipreg = 'A'
and soi_status = 2
and   nullif(soi_feccar::text, '') is null
and   nullif(soi_stacar::text, '') is null
and   soi_refamo = c_14.soi_refamo
and   soi_keypro = wi_proceso
and   soi_keycon in ( select dat_valore
from glcodats,glcousua
where usu_keyusu = pskeyusu
and usu_keymen = dat_keymen
and dat_idecam = 'keycon' )
and   soi_keycon not in ( select pam_folfin
from glcopams
where pam_keypar='Z03Q'
and pam_nompar = 'USUARIOS SIN RESTRICCION' );
--- rechazo cualquier registro cuyo tipreg no sea 'A', 'C' y no haya
--- sido rechazado anteriormente (fecha de carga nula)
--- y el proceso sea igual al proceso enviado por parametro
update ap_sipros
set  soi_keypre = 0,
soi_tipreg = 'R',
soi_feccar = clock_timestamp(),
soi_stacar = 'P'
where soi_tipreg not in ('A','C','R','E','O')
and   nullif(soi_feccar::text, '') is null
and   nullif(soi_stacar::text, '') is null
and   soi_refamo = c_14.soi_refamo
and   soi_keypro = wi_proceso
and   soi_keycon in ( select dat_valore
from glcodats,glcousua
where usu_keyusu = pskeyusu
and usu_keymen = dat_keymen
and dat_idecam = 'keycon' )
and   soi_keycon not in ( select pam_folfin
from glcopams
where pam_keypar='Z03Q'
and pam_nompar = 'USUARIOS SIN RESTRICCION' );
--end for;
end loop;
-- empiezo con los anticipos
-- asigno la llave de prestamos mientras sea 'A' (anticipos)
-- y el proceso sea igual al proceso enviado por parametro
-- para empleados activos (23 - julio- 2001)
conta := conta_a;
for c_15 in (
select
soi_keyemp, soi_keycon, soi_refere, soi_tipope,
soi_import, soi_fecope, soi_tipmon, soi_tipcam,
soi_tipreg, soi_keypre, soi_keypro, soi_status, soi_refamo
--into
-- isoi_keyemp, ssoi_keycon, ssoi_refere, ssoi_tipope,
--ssoi_import, isoi_fecope, ssoi_tipmon, ssoi_tipcam,
-- ssoi_tipreg, ssoi_keypre, isoi_keypro, isoi_status, ssoi_refamo
from
ap_sipros
where soi_tipreg = 'A'
and   soi_status = 1   --- 23-julio-2001  ---
and   nullif(soi_feccar::text, '') is null
and   nullif(soi_stacar::text, '') is null
and   soi_keypro = wi_proceso
and   soi_keycon in ( select dat_valore
from glcodats,glcousua
where usu_keyusu = pskeyusu
and usu_keymen = dat_keymen
and dat_idecam = 'keycon' )
and   soi_keycon not in ( select pam_folfin
from glcopams
where pam_keypar='Z03Q'
and pam_nompar = 'USUARIOS SIN RESTRICCION' ))
loop
wn_fec_mov := 0;
wn_hor_mov := 0;
wn_min_mov := 0;
wn_seg_mov := 0;
wn_tot_mov := '0.0';
ws_tmp_mov:= null;
wn_fec_mov := (clock_timestamp())::numeric;
wn_tot_mov := wn_fec_mov + conta_a;
update ap_sipros
set soi_keypre = wn_tot_mov,
soi_feccar = clock_timestamp(),
soi_stacar = 'P'
where soi_keyemp = c_15.soi_keyemp
and   soi_keycon = c_15.soi_keycon
and   soi_refere = c_15.soi_refere
and   soi_tipreg = 'A'
and   nullif(soi_feccar::text, '') is null
and   nullif(soi_stacar::text, '') is null
and   soi_refamo = c_15.soi_refamo;
conta := conta + '0.000001';
end loop;
-- inserto en la tabla 'nmlopres' los anticipos del dia de hoy---
-- cuando el proceso sea igual al proceso enviado por parametro ---
-- y empleados activos (23-julio-2001)
for c_16 in (
select
soi_keyemp, soi_keycon, soi_refere, soi_tipope,
soi_import, soi_fecope, soi_tipmon, soi_tipcam,
soi_tipreg, soi_keypre, soi_keypro, soi_status, soi_refamo
--into
-- isoi_keyemp, ssoi_keycon, ssoi_refere, ssoi_tipope,
-- ssoi_import, isoi_fecope, ssoi_tipmon, ssoi_tipcam,
-- ssoi_tipreg, ssoi_keypre, isoi_keypro, isoi_status
from
ap_sipros
where soi_tipreg = 'A'
and   soi_status = 1
and   soi_feccar = clock_timestamp()
and   soi_keypre <> 0
and   soi_keypro = wi_proceso
and   soi_keycon in ( select dat_valore
from glcodats,glcousua
where usu_keyusu = pskeyusu
and usu_keymen = dat_keymen
and dat_idecam = 'keycon' )
and   soi_keycon not in ( select pam_folfin
from glcopams
where pam_keypar='Z03Q'
and pam_nompar = 'USUARIOS SIN RESTRICCION' ))
loop
-- selecciono fecha para insertar en prestamos con 45 dias de colchon
--carsi let wd_fecope = isoi_fecope + 45;
dper_fecini := c_16.soi_fecope + 30;
--carsi select per_keyper, per_fecini into sper_keyper, dper_fecini
select per_keyper into strict sper_keyper
from nmloperi
where per_keypro= c_16.soi_keypro
and  per_fecini <= c_16.soi_fecope     --carsi wd_fecope
and  per_fecfin >= c_16.soi_fecope     --carsi wd_fecope
and  per_keynom=1;
--actualizo tipo de cambio a 1 para moneda nacional
if c_16.soi_tipmon = '1' then
if c_16.soi_tipcam = 0.0 then
c_16.soi_tipcam := 1.0;
end if;
end if;
-- para empleados activos.... --
if c_16.soi_status = 1 then
icountapres := 0;
-- verifico si la llave existe en la tabla 'nmlopres'
select count(*) into strict icountapres
from nmlopres
where pre_keypre = c_16.soi_keypre;
-- si no existe, se inserta el prestamo con estatus=4 --
if icountapres = 0 then
insert into nmlopres(
pre_keyemp, pre_keycon, pre_keypre, pre_refere, pre_fecreg,
pre_tippre, pre_unipre, pre_imppre, pre_gastos, pre_plazop,
pre_unides, pre_impdes, pre_porint, pre_perini, pre_fecini,
pre_fecaut, pre_cveaut, pre_fechab, pre_uniamo, pre_impamo,
pre_unisal, pre_impsal, pre_uniult, pre_impult, pre_numpag,
pre_intpag, pre_status, pre_ultact, pre_refcon, pre_ctreve,
pre_fe1aux, pre_fe2aux, pre_ca1aux, pre_ca2aux, pre_ca3aux,
pre_ca4aux, pre_uniope, pre_keypro
)
values (
c_16.soi_keyemp, c_16.soi_keycon, c_16.soi_keypre, c_16.soi_refere, c_16.soi_fecope,
1          , null       , c_16.soi_import, null       , 1          ,
null       , c_16.soi_import, 0          , sper_keyper, dper_fecini,
c_16.soi_fecope, null       , null       , 0          , 0          ,
0          , c_16.soi_import, 0          , 0          , 0          ,
0          , 4          , c_16.soi_fecope, null       , c_16.soi_refamo,
null       , null       , c_16.soi_tipmon, c_16.soi_tipcam, null       ,
null       , null       , c_16.soi_keypro
);
else
-- si existe la llave rechazo el movimiento --
update ap_sipros
set soi_tipreg = 'R'
where soi_keyemp = c_16.soi_keyemp
and   soi_keycon = c_16.soi_keycon
and   soi_refere = c_16.soi_refere
and   soi_keypre = c_16.soi_keypre
and   soi_tipreg = 'A'
and   soi_stacar = 'P'
and   soi_feccar = clock_timestamp();
end if;
end if;
end loop;
end if;
end if;
end if;
--trace off;
-- inserto en la tabla de amortizaciones
--execute procedure sp_tvsoin_insamo(wi_proceso, psconceptos, psconceptosopci, pskeyusu);
end;
$body$
language plpgsql
;
