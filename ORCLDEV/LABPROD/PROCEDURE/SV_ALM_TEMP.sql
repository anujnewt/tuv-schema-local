create or replace procedure labprod."sv_alm_temp"  ( numero integer, dias numeric, tipo varchar, status varchar, inicio varchar, fin varchar, auto_ integer, per integer, fec_act varchar) as $body$
declare
flg5 text;
flg1 text;
flg2 text;
flg11 text;
flg3 text;
flg4 text;
flg9 text;
flg7 text;
flg8 text;
flg6 text;
flg10 text;
flg0 text;
-- pgv moved types start
-- pgv moved types end
oper       integer;
moper      integer;
aux        integer;
antigu     integer;
anti       integer;
consec     integer;
numd       decimal(6,2);
tdias      decimal(6,2);
perm       varchar(10);
nomb       varchar(60);
period     varchar(10);
dias_temp  decimal;
numtemp    integer;
periodtemp varchar(10);
autotemp   integer;
aux_temp integer;
permtemp varchar(10);
finicio timestamp(0);
ffinal timestamp(0);
factual timestamp(0);
---cursor 1
temporal cursor for select max(id_ope)+1, max(con_emp) +1, count( *) from svtempsc
;
---cursor 2
temporal_2 cursor(numtemp  integer)
for(select distinct(id_ope)
from svtempsc
where svtempsc.num_emp = numtemp
and svtempsc.sta_sol   = 'P'
);
---cursor 3
temporal_3 cursor(numtemp  integer)
for(select min(vac_period)
from nmcocvac
where vac_status = 'V'
and vac_keyemp   = numtemp
);
---cursor 4
temporal_4 cursor(numtemp  integer, periodtemp  varchar)
for(select vac_antigu
from nmcocvac
where vac_status = 'V'
and vac_keyemp   = numtemp
and vac_period   = periodtemp
);
---cursor 5
temporal_5 cursor(numtemp  integer)
for(select max(vac_period)
from nmcocvac
where vac_status = 'V'
and vac_keyemp   = numtemp
);
---cursor 6
temporal_6 cursor(numtemp  integer, periodtemp  varchar)
for(select vac_antigu
from nmcocvac
where vac_status = 'V'
and vac_keyemp   = numtemp
and vac_period   = periodtemp
);
---cursor 7
temporal_7 cursor(numtemp  integer, periodtemp  varchar)
for(select vac_dtomad
from nmcocvac
where nmcocvac.vac_keyemp = numtemp
and nmcocvac.vac_period   = periodtemp
);
---cursor 8
temporal_8 cursor(auto_  integer)
for( select emp_nomemp from nmcoempl where emp_keyemp = auto_
);
---cursor 9
temporal_9 cursor(numtemp  integer)
for(select num_dia,per_vac
from svtempsc
where svtempsc.num_emp = numtemp
and svtempsc.sta_sol   = 'A'
);
---cursor 10
temporal_10 cursor(numtemp  integer, perm  varchar)
for(select vac_salper
from nmcocvac
where vac_status = 'V'
and vac_keyemp   = numtemp
and vac_period= trim(both perm)
);
temporal_11 cursor(numtemp  integer)
for(select min(vac_period)
from nmcocvac
where vac_status = 'V'
and vac_keyemp   = numtemp
);
---cursor 6
temporal_12 cursor(numtemp  integer, periodtemp  varchar)
for(select vac_antigu
from nmcocvac
where vac_status = 'V'
and vac_keyemp   = numtemp
and vac_period   = periodtemp
);
begin
--asignacion de fechas
--select to_timestamp(inicio,'yyyy/MM/dd') into finicio from dual;
--  select to_timestamp(fin,'yyyy/MM/dd') into ffinal from dual;
-- select to_timestamp(fec_act,'yyyy/MM/dd') into factual from dual;
--finaliza asignacion de fechas
--inicia cursor 1
open temporal;
fetch temporal into oper, consec, moper;
close temporal;/* dmap converted statement start */
perform dbms_output.put_line( concat('VARIABLE oper 1 despues primer select:', oper)) ;/* dmap converted statement end *//* dmap converted statement start */
perform dbms_output.put_line( concat('VARIABLE consec 1 despues primer select:', consec)) ;/* dmap converted statement end *//* dmap converted statement start */
perform dbms_output.put_line( concat('VARIABLE moper 1 despues primer select:', moper)) ;/* dmap converted statement end */
if moper  = 0 then
consec := 1000;
oper   := 1000;
end if;/* dmap converted statement start */
perform dbms_output.put_line( concat('VARIABLE consec 2 despues del 1er If:', consec)) ;/* dmap converted statement end *//* dmap converted statement start */
perform dbms_output.put_line( concat('VARIABLE oper 2 despues del 1er If:', oper)) ;/* dmap converted statement end */
--termina cursor 1
--inicia cursor 2
open temporal_2(numero);
fetch temporal_2 into aux;
close temporal_2;/* dmap converted statement start */
perform dbms_output.put_line( concat('VARIABLE AUX 1 despues segundo select:', aux)) ;/* dmap converted statement end */
if aux  > 0 then
oper := aux;
end if;/* dmap converted statement start */
perform dbms_output.put_line( concat('VARIABLE oper 3 despues del 2do If:', oper)) ;/* dmap converted statement end */
--termina curso 2
if status = 'P' then
delete
from svtempsc
where svtempsc.num_emp = numero
and svtempsc.sta_sol   = 'P'
and svtempsc.tipo_sol  = 'S';
if per                 = 1 then
--inicia cursor 3
open temporal_3(numero);
fetch temporal_3 into period;
close temporal_3;
---termina cursor 3
--inicia cursor 4
open temporal_4(numero, period);
fetch temporal_4 into antigu;
close temporal_4;
--termina cursor 4
end if;
if per = 2 then
--inicia cursor5
open temporal_5(numero);
fetch temporal_5 into period;
close temporal_5;
---termina cursor 5
--inicia cursor 6
open temporal_6(numero, period);
fetch temporal_6 into antigu;
close temporal_6;
--termina cursor 6
end if;
update svtempsc
set tipo_sol           = 'S'
where svtempsc.num_emp = numero
and svtempsc.sta_sol   = 'P'
and svtempsc.tipo_sol  = 'P';
insert
into svtempsc(
id_ope,
num_emp,
num_dia,
tipo_sol,
sta_sol,
dia_ini,
dia_fin,
per_vac,
ant_emp,
fec_sol,
con_emp
)
values (
oper,
numero,
dias,
tipo,
status,
to_timestamp(inicio,'yyyy/MM/dd'),
to_timestamp(fin,'yyyy/MM/dd'),
period,
antigu,
to_timestamp(fec_act,'yyyy/MM/dd'),
consec
);
-- return oper;
return;
end if;
if status = 'I' then
--inicia cursor5
open temporal_11(numero);
fetch temporal_11 into period;
close temporal_11;
---termina cursor5
--inicia cursor 6
open temporal_12(numero, period);
fetch temporal_12 into antigu;
close temporal_12;
--termina cursor 6
insert
into svtempsc(
id_ope,
num_emp,
num_dia,
tipo_sol,
sta_sol,
dia_ini,
dia_fin,
con_emp,
per_vac,
ant_emp
)
values (
oper,
numero,
dias,
'C',
status,
to_timestamp(inicio,'yyyy/MM/dd'),
to_timestamp(fin,'yyyy/MM/dd'),
consec,
period,
antigu
);
insert
into nmcorvac(
rva_keyemp,
rva_antigu,
rva_fecsol,
rva_period,
rva_fecini,
rva_fecfin,
rva_diadis,
rva_consec
)
select num_emp,
ant_emp,
fec_sol,
per_vac,
dia_ini,
dia_fin,
num_dia,
con_emp
from svtempsc
where svtempsc.num_emp = numero
and svtempsc.sta_sol   = 'I'
and svtempsc.tipo_sol  = 'C';
update svtempsc set tipo_sol = 'T' where sta_sol = 'I' and num_emp = numero;
--inicia cursor 7
open temporal_7(numero, period);
fetch temporal_7 into numd;
close temporal_7;
--termina cursor 7
dias_temp := dias * -1.0;
if numd    < dias_temp then
--update
update nmcocvac
set vac_dtomad            = 0,
vac_salper              = vac_diavac
where nmcocvac.vac_keyemp = numero
and nmcocvac.vac_status   = 'V'
and nmcocvac.vac_period   = period;
---update
update nmcocvac
set vac_dtomad            = (vac_dtomad-(dias_temp-numd)),
vac_salper              = vac_salper +(dias_temp-numd)
where nmcocvac.vac_keyemp = numero
and nmcocvac.vac_status   = 'V'
and nmcocvac.vac_period  <> period;
end if;
if numd >= dias_temp then
update nmcocvac
set vac_dtomad            = (vac_dtomad-dias_temp),
vac_salper              = vac_salper + dias_temp
where nmcocvac.vac_keyemp = numero
and nmcocvac.vac_status   = 'V'
and nmcocvac.vac_period   = period;
end if;
return;
end if;
if status = 'C' then
update svtempsc set sta_sol = 'C' where svtempsc.id_ope = aux;
--  return aux;
return;/* dmap converted statement start */
perform dbms_output.put_line( concat('VARIABLE AUX ANTES DEL IF A:', aux_temp)) ;/* dmap converted statement end */
end if;/* dmap converted statement start */
if status = 'A' then
perform dbms_output.put_line( concat('VARIABLE AUX:', aux)) ;/* dmap converted statement end */
--update
update svtempsc set sta_sol = 'A' where svtempsc.id_ope = aux;
--inicia cursor 8
open temporal_8(auto_);
fetch temporal_8 into nomb;
close temporal_8;/* dmap converted statement start */
--termina cursor 8
perform dbms_output.put_line( concat('VARIABLE AUX:', nomb)) ;/* dmap converted statement end */
insert
into nmcorvac(
rva_keyemp,
rva_antigu,
rva_fecsol,
rva_period,
rva_fecini,
rva_fecfin,
rva_diadis,
rva_autori,
rva_consec
)
select num_emp,
ant_emp,
fec_sol,
per_vac,
dia_ini,
dia_fin,
num_dia,
nomb,
con_emp
from svtempsc
where svtempsc.num_emp = numero
and svtempsc.sta_sol   = 'A';
--return aux;
return;
end if;
if status = 'T' then
--inicia cursor 9
open temporal_9(numero);
loop
fetch temporal_9 into tdias,perm;
flg0 := found;
flg1 := found;
flg2 := found;
flg3 := found;
flg4 := found;
flg5 := found;
flg6 := found;
flg7 := found;
flg8 := found;
flg9 := found;
flg10 := found;
flg11 := found;
exit when (not flg0)or(not flg1)or(not flg2)or(not flg3)or(not flg4)or(not flg5)or(not flg6)or(not flg7)or(not flg8)or(not flg9)or(not flg10)or(not flg11);/* dmap converted statement start *//* apply on temporal_9 */
perform dbms_output.put_line( concat('variable tdias :', tdias)) ;/* dmap converted statement end *//* dmap converted statement start */
perform dbms_output.put_line( concat('variable perm :', perm)) ;/* dmap converted statement end */
--termina cursor 9
--dbms_output.put_line('variable tdias :' || tdias);
--dbms_output.put_line('variable perm :' || perm);
--inicia cursor 10
open temporal_10(numero,perm);
loop
fetch temporal_10 into numd;
flg0 := found;
flg1 := found;
flg2 := found;
flg3 := found;
flg4 := found;
flg5 := found;
flg6 := found;
flg7 := found;
flg8 := found;
flg9 := found;
flg10 := found;
flg11 := found;
exit when (not flg0)or(not flg1)or(not flg2)or(not flg3)or(not flg4)or(not flg5)or(not flg6)or(not flg7)or(not flg8)or(not flg9)or(not flg10)or(not flg11);/* dmap converted statement start *//* apply on temporal_10 */
perform dbms_output.put_line( concat('variable numd:', numd)) ;/* dmap converted statement end *//* dmap converted statement start */
--end loop;
--close temporal_10;
--end loop;
--close temporal_9;
--inicia cursor 10
--dbms_output.put_line('variable numd:' || numd);
perform dbms_output.put_line( concat('numero:', numero)) ;/* dmap converted statement end */
--update
update svtempsc
set sta_sol            = 'T'
where svtempsc.num_emp = numero
and svtempsc.sta_sol   = 'A';
if numd                < tdias then
--update
update nmcocvac
set vac_dtomad            = vac_diavac,
vac_salper              = 0
where nmcocvac.vac_keyemp = numero
and nmcocvac.vac_status   = 'V'
and nmcocvac.vac_period   = trim(both perm);
--update
update nmcocvac
set vac_dtomad            = (vac_dtomad+(tdias-numd)),
vac_salper              = vac_salper -(tdias-numd)
where nmcocvac.vac_keyemp = numero
and nmcocvac.vac_status   = 'V'
and nmcocvac.vac_period  <> trim(both perm);
end if;/* dmap converted statement start */
perform dbms_output.put_line( concat('variable tdias antes de numd >= :', tdias)) ;/* dmap converted statement end *//* dmap converted statement start */
perform dbms_output.put_line( concat('variable numd antes de numd >=:', numd)) ;/* dmap converted statement end */
if numd >= tdias then
--update
update nmcocvac
set vac_dtomad            = (vac_dtomad+tdias),
vac_salper              = vac_salper -tdias
where nmcocvac.vac_keyemp = numero
and nmcocvac.vac_status   = 'V'
and nmcocvac.vac_period   = trim(both perm);
end if;
end loop;
close temporal_10;
end loop;
close temporal_9;
--return;
end if;
/* commit; */
end;
$body$
language plpgsql
;
