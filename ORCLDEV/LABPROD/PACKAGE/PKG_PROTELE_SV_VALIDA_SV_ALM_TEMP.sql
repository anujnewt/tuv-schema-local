create or replace procedure labprod.pkg_protele_sv_valida_sv_alm_temp ( numero integer, dias numeric, status varchar, inicio varchar, fin varchar, auto_ integer, per integer --fec_act in varchar2
) as $body$
declare
flg5 text;
flg1 text;
flg2 text;
flg3 text;
flg4 text;
flg6 text;
flg0 text;
-- pgv moved types start
-- pgv moved types end
oper          integer;
moper         integer;
aux           integer;
antigu        integer;
anti          integer;
consec        integer;
numd          decimal(6,2);
tdias         decimal(6,2);
perm          varchar(10);
nomb          varchar(60);
period        varchar(10);
tipo          varchar(5);
dias_temp     decimal;
numtemp       integer;
periodtemp    varchar(10);
autotemp      integer;
aux_temp      integer;
permtemp      varchar(10);
o_act_estatus integer;
dias_dsp      integer;  -- variable utilizada para ontener los dias disponibles del periodo mas antiguo
dias_dsp2      integer;  -- variable utilizada para ontener los dias disponibles del periodo mas nuevo
---cursor 1 id operaci??n m?!ximo
temporal for cursor(select max(id_ope)+1, max(con_emp) +1, count( *) from svtempsc
)
;
---cursor 2  id de operaciones pendientes
temporal_2 cursor(numtemp  integer)
for(select distinct(id_ope)
from svtempsc
where svtempsc.num_emp = numtemp
and svtempsc.sta_sol   = 'P'
);
---cursor 3 periodo m?-nimo
temporal_3 cursor(numtemp  integer)
for(select min(vac_period)
from nmcocvac
where vac_status = 'V'
and vac_keyemp   = numtemp
)
;
---cursor 4
temporal_4 cursor(numtemp  integer, periodtemp  varchar)
for(select vac_antigu
from nmcocvac
where vac_status = 'V'
and vac_keyemp   = numtemp
and vac_period   = periodtemp
)
;
---cursor 5
temporal_5 cursor(numtemp  integer)
for(select max(vac_period)
from nmcocvac
where vac_status = 'V'
and vac_keyemp   = numtemp
)
;
---cursor 6
temporal_6 cursor(numtemp  integer, periodtemp  varchar)
for(select vac_antigu
from nmcocvac
where vac_status = 'V'
and vac_keyemp   = numtemp
and vac_period   = periodtemp
)
;
---cursor 7
temporal_7 cursor(numtemp  integer, periodtemp  varchar)
for(select vac_dtomad
from nmcocvac
where nmcocvac.vac_keyemp = numtemp
and nmcocvac.vac_period   = periodtemp
)
;
---cursor 8
temporal_8 cursor(auto_  integer)
for( select emp_nomemp from nmcoempl where emp_keyemp = auto_
)
;
---cursor 9
temporal_9 cursor(numtemp  integer)
for(select num_dia,
per_vac
from svtempsc
where svtempsc.num_emp = numtemp
and svtempsc.sta_sol   = 'A'
)
;
---cursor 10
temporal_10 cursor(numtemp  integer, perm  varchar)
for(select vac_salper
from nmcocvac
where vac_status = 'V'
and vac_keyemp   = numtemp
and vac_period   = trim(both perm)
)
;
begin 

-- package does not have global variables
--dmap conversion comment: gtt declaration added
--inicia cursor 1: obtiene id operaci??n m?!ximo
open temporal;
fetch temporal into oper, consec, moper;
close temporal;
if moper  = 0 then
consec := 1000;
oper   := 1000;
end if;
--dbms_output.put_line(variable consec 2 despues del 1er if: || consec);
--dbms_output.put_line(variable oper 2 despues del 1er if: || oper);
--termina cursor 1
--inicia cursor 2
open temporal_2(numero);
fetch temporal_2 into aux;
close temporal_2;
--dbms_output.put_line(variable aux 1 despues segundo select: || aux);
if aux  > 0 then
oper := aux;
end if;
--dbms_output.put_line(variable oper 3 despues del 2do if: || oper);
--termina curso 2
tipo          := 'S';
o_act_estatus := 0;
if status      = 'P' then
select vac_period
,vac_salper
into strict period, dias_dsp from (
select vac_period
, vac_salper
from nmcocvac
where vac_status = 'V'
and vac_keyemp   = numero
and vac_salper > 0
order by  vac_period asc) alias0 limit 1;
open temporal_4(numero, period);
fetch temporal_4 into antigu;
close temporal_4;/* dmap converted statement start */
perform dbms_output.put_line( concat('Periodo: ', period , ' Dias disponibles: ' , dias_dsp)) ;/* dmap converted statement end *//* dmap converted statement start */
if (dias_dsp < dias) then -- en caso de que el periodo mas antiguo no tenga los suficientes dias
perform dbms_output.put_line( concat('Dias no suficientes', dias_dsp , ' < ' , dias)) ;/* dmap converted statement end */
-- se inserta los dias para los que alcanza el periodo
insert into svtempsc(
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
dias_dsp,
tipo,
status,
to_timestamp(inicio,'DD/MM/YYYY'),
to_timestamp(fin,'DD/MM/YYYY'),
period,
antigu,
clock_timestamp(),
consec
);
begin
select vac_period   -- se busca el siguiemte periodo para insertr los dias soliciatdos que faltan por cubrir
,vac_salper
into strict period, dias_dsp2
from nmcocvac
where vac_status = 'V'
and vac_keyemp   = numero
and vac_salper > 0
and vac_period <> period;
exception when no_data_found then
period:= ' ';
dias_dsp2 := 0;
end;/* dmap converted statement start */
perform dbms_output.put_line( concat('Periodo: ', period)) ;/* dmap converted statement end *//* dmap converted statement start */
perform dbms_output.put_line( concat('Dias: ', dias , ' dias_dsp: ' , dias_dsp , ' dias_dsp2: ' , dias_dsp2)) ;/* dmap converted statement end *//* dmap converted statement start */
if ((period != ' ') and (dias - dias_dsp) <= dias_dsp2) then
perform dbms_output.put_line( concat('Segundo periodo: ', (dias - dias_dsp) , ' <= ' , dias_dsp2)) ;/* dmap converted statement end */
open temporal_4(numero, period);
fetch temporal_4 into antigu;
close temporal_4;
insert into svtempsc(
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
(dias - dias_dsp),
tipo,
status,
to_timestamp(inicio,'DD/MM/YYYY'),
to_timestamp(fin,'DD/MM/YYYY'),
period,
antigu,
clock_timestamp(),
consec);
/* commit; */
else
perform dbms_output.put_line('Rollback');
rollback;
end if;/* dmap converted statement start */
else
perform dbms_output.put_line( concat('Dias sufucientes ', dias_dsp , ' >= ' , dias)) ;/* dmap converted statement end */
insert into svtempsc(
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
to_timestamp(inicio,'DD/MM/YYYY'),
to_timestamp(fin,'DD/MM/YYYY'),
period,
antigu,
clock_timestamp(),
consec
);
/* commit; */
end if;
o_act_estatus := 1;
--dbms_output.put_line(parametros insert hist??rico:  );
--dbms_output.put_line(# de operaci??n:  ||oper);
--dbms_output.put_line(# empleado:  ||numero);
--dbms_output.put_line(# de d?-as:  ||dias);
--dbms_output.put_line(tipo solicitud:  ||tipo);
--dbms_output.put_line(estatus solicitud:  ||status);
--dbms_output.put_line(periodo:  ||period);
--dbms_output.put_line(antigu:  ||antigu);
--dbms_output.put_line(fecha inicio||to_date(inicio,yyyy/mm/dd));
--dbms_output.put_line(fecha fin:  ||to_date(fin,yyyy/mm/dd));
-- dbms_output.put_line(consec:  ||consec);
end if;/* dmap converted statement start */
if status = 'A' then
perform dbms_output.put_line( concat('VARIABLE AUX:', aux)) ;/* dmap converted statement end */
update svtempsc set sta_sol = 'A' where svtempsc.id_ope = aux;
/* commit; */
-- inicia cursor 8
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
select
num_emp,
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
o_act_estatus         := 1;
end if;/* dmap converted statement start */
if status = 'C' then
perform dbms_output.put_line( concat('VARIABLE AUX:', aux)) ;/* dmap converted statement end */
update svtempsc set sta_sol = 'C' where svtempsc.id_ope = aux;
/* commit; */
o_act_estatus := 1;/* dmap converted statement start */
perform dbms_output.put_line( concat('VARIABLE AUX:', oper)) ;/* dmap converted statement end */
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
exit when (not flg0)or(not flg1)or(not flg2)or(not flg3)or(not flg4)or(not flg5)or(not flg6);/* dmap converted statement start *//* apply on temporal_9 */
perform dbms_output.put_line( concat('variable tdias :', tdias)) ;/* dmap converted statement end *//* dmap converted statement start */
perform dbms_output.put_line( concat('variable perm :', perm)) ;/* dmap converted statement end */
--termina cursor 9
--dbms_output.put_line(variable tdias : || tdias);
--dbms_output.put_line(variable perm : || perm);
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
exit when (not flg0)or(not flg1)or(not flg2)or(not flg3)or(not flg4)or(not flg5)or(not flg6);/* dmap converted statement start *//* apply on temporal_10 */
perform dbms_output.put_line( concat('variable numd:', numd)) ;/* dmap converted statement end *//* dmap converted statement start */
--dbms_output.put_line(variable numd: || numd);
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
/* commit; */
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
/* commit; */
end loop;
close temporal_10;
end loop;
close temporal_9;
o_act_estatus := 1;
update nmcocvac
set vac_status            = 'E'
where nmcocvac.vac_keyemp = numero
and to_char(vac_fecpre,'YYYY/MM/DD') <= to_char(clock_timestamp(),'YYYY/MM/DD')
and vac_salper            =0
and nmcocvac.vac_status   = 'V'
and nmcocvac.vac_period   = trim(both perm);
/* commit; */
end if;
end;
$body$
language plpgsql
;
