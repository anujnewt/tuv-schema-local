create or replace procedure labprod.pkg_protele_sv_valida_sv_insert_per ( num_emp integer) as $body$
declare
-- pgv moved types start
-- pgv moved types end
num_r_insertados   integer;
n_meses_expiracion integer;
ckeycon            char(3);
n_keyemp           integer;
n_anio_trabajados  integer;
n_annio_proceso    integer;
n_mes_proceso      integer;
n_dia_proceso      integer;
n_keypro           integer;
n_annio_proc_ant   integer;
n_confianza        integer;
d_fecha_ingreso    timestamp(0);
c_keydep           char(16);
c_keypue           char(16);
c_periodo          char(9);
c_tab_vacaciones   char(3);
n_r_anio_trab      integer;
n_dias_vacaciones  integer;
d_f_expiracion     timestamp(0);
d_fecha_calculo    timestamp(0);
d_fecha_calculo1   timestamp(0);
d_fecha_calculo2   timestamp(0);
n_existe           integer;
p_adj_days         integer;
ws_vac_status      char(02);
wd_vac_salper      decimal(10,2);
nagnostrab         decimal(12,6);
idiasvac           decimal(16,2);
dfecini            timestamp(0);
dfecnow            timestamp(0);
nkeyemp            integer;
nkeypro            integer;
ckeydep            char(16);
ckeypue            char(16);
o_num_r_insertados integer;
begin 

-- package does not have global variables
--dmap conversion comment: gtt declaration added
num_r_insertados   := 0; -- o_num_r_insertados out integer
n_meses_expiracion := 6;
ckeycon            := '607'; ---  el numero de concepto para la actualizacion de datos fijos.
/* dmap converted statement start */
----obtengo parametros de acuerdo al numero de empleado
select year(clock_timestamp()) - year(emp_fecaux),
year(clock_timestamp()) - ,
year(clock_timestamp()),
month(emp_fecaux),
day(emp_fecaux),
emp_keypro,
year(clock_timestamp()) - 1,
emp_tipemp,
emp_fecaux,
emp_keydep,
emp_keypue
into strict n_anio_trabajados,
c_periodo,
n_annio_proceso,
n_mes_proceso,
n_dia_proceso,
n_keypro,
n_annio_proc_ant,
n_confianza,
d_fecha_ingreso,
c_keydep,
c_keypue
from nmcoempl
where emp_status = 1
and emp_keyemp   = num_emp;/* dmap converted statement end */
---------------------se valida que la fecha de proceso no sea biciesto-------------------------------------------
if n_mes_proceso = 2 and n_dia_proceso = 29 then
n_dia_proceso := 28;
end if;
--------------------obtengo la tabla que le corresponde para la obtencion de las vacaciones---------------------
begin
select pam_folfin
into strict c_tab_vacaciones
from glcopams
where pam_keypar = 'TTV'
and pam_nompar   = 'TABLA DE VACACIONES'
and pam_cvesec   = to_char(n_keypro);
exception
when no_data_found then
null;
end;
-------------------obtengo el rango de a?os trabajados en el que cae el empleado---------------------------------
begin
select min(tab_eledos)
into strict n_r_anio_trab
from nmlotabn
where tab_keytab= trim(both c_tab_vacaciones)
and tab_eledos >= n_anio_trabajados
order by  tab_eledos;
exception
when no_data_found then
null;
end;
--------------------valido si el empleado es de confianza (1) o no (2)-------------------------------------------
if n_confianza = 2 then
select distinct tab_elecua
into strict n_dias_vacaciones
from nmlotabn
where tab_keytab = trim(both c_tab_vacaciones)
and tab_eledos   = n_r_anio_trab;
else
-----obtengo los dias que le corresponden de vacaciones-------
select distinct tab_eletre
into strict n_dias_vacaciones
from nmlotabn
where tab_keytab      = trim(both c_tab_vacaciones)
and tab_eledos        = n_r_anio_trab;
if nullif(n_dias_vacaciones::text, '') is null then
n_anio_trabajados  := n_anio_trabajados + '.000002';
end if;
end if;/* dmap converted statement start */
-----------------------------armo la fecha para poder calcular la fecha de expiracion-----------------------------
d_fecha_calculo  := to_date( concat(to_char(n_dia_proceso), '/' , to_char(n_mes_proceso) , '/' , to_char(n_annio_proceso)) , 'dd/mm/yyyy');/* dmap converted statement end *//* dmap converted statement start */
d_fecha_calculo2 := to_date( concat(to_char(n_dia_proceso), '/' , to_char(n_mes_proceso) , '/' , to_char(n_annio_proceso + 1)) , 'dd/mm/yyyy');/* dmap converted statement end */
d_fecha_calculo1 := d_fecha_calculo2                                                                                  - 1;
----------lo meto en un ciclo para validar que sea una fecha valida, ya que la fecha pudiera se invalida.--------
d_f_expiracion := add_months(d_fecha_calculo1, n_meses_expiracion);
--------------verifico que el empleado no tenga ya calculado su periodo de vacaciones para el periodo------------
begin
select count(*)
into strict n_existe
from nmcocvac
where vac_keyemp = num_emp
and vac_period   = c_periodo;
exception
when no_data_found then
n_existe  := 0;
end;
if n_existe  = 0  then
begin
insert
into nmcocvac(
vac_keyemp,
vac_antigu,
vac_diavac,
vac_period,
vac_fecini,
vac_fecfin,
vac_fecpre,
vac_dtomad,
vac_salper,
vac_status,
vac_cosrea
)
values (
num_emp,
n_anio_trabajados,
n_dias_vacaciones,
c_periodo,
d_fecha_calculo,
d_fecha_calculo1,
d_f_expiracion,
0,
n_dias_vacaciones,
'V',
0
);
/* commit; */
o_num_r_insertados := num_r_insertados + 1;
exception
when others then
null;
end;/* dmap converted statement start */
else
select (year(clock_timestamp())+1) - year(emp_fecaux), concat(
year(clock_timestamp()), '-'
, (year(clock_timestamp()) +1)) ,
(year(clock_timestamp()) +1),
month(emp_fecaux),
day(emp_fecaux),
emp_keypro,
year(clock_timestamp()),
emp_tipemp,
emp_fecaux,
emp_keydep,
emp_keypue
into strict n_anio_trabajados,
c_periodo,
n_annio_proceso,
n_mes_proceso,
n_dia_proceso,
n_keypro,
n_annio_proc_ant,
n_confianza,
d_fecha_ingreso,
c_keydep,
c_keypue
from nmcoempl
where emp_status = 1
and emp_keyemp   = num_emp;/* dmap converted statement end */
---------------------se valida que la fecha de proceso no sea biciesto-------------------------------------------
if n_mes_proceso = 2 and n_dia_proceso = 29 then
n_dia_proceso := 28;
end if;
--------------------obtengo la tabla que le corresponde para la obtencion de las vacaciones---------------------
begin
select pam_folfin
into strict c_tab_vacaciones
from glcopams
where pam_keypar = 'TTV'
and pam_nompar   = 'TABLA DE VACACIONES'
and pam_cvesec   = to_char(n_keypro);
exception
when no_data_found then
null;
end;
-------------------obtengo el rango de a?os trabajados en el que cae el empleado---------------------------------
begin
select min(tab_eledos)
into strict n_r_anio_trab
from nmlotabn
where tab_keytab= trim(both c_tab_vacaciones)
and tab_eledos >= n_anio_trabajados
order by  tab_eledos;
exception
when no_data_found then
null;
end;
--------------------valido si el empleado es de confianza (1) o no (2)-------------------------------------------
if n_confianza = 2 then
select distinct tab_elecua
into strict n_dias_vacaciones
from nmlotabn
where tab_keytab = trim(both c_tab_vacaciones)
and tab_eledos   = n_r_anio_trab;
else
-----obtengo los dias que le corresponden de vacaciones-------
select distinct tab_eletre
into strict n_dias_vacaciones
from nmlotabn
where tab_keytab      = trim(both c_tab_vacaciones)
and tab_eledos        = n_r_anio_trab;
if nullif(n_dias_vacaciones::text, '') is null then
n_anio_trabajados  := n_anio_trabajados + '.000002';
end if;
end if;/* dmap converted statement start */
-----------------------------armo la fecha para poder calcular la fecha de expiracion-----------------------------
d_fecha_calculo  := to_date( concat(to_char(n_dia_proceso), '/' , to_char(n_mes_proceso) , '/' , to_char(n_annio_proceso)) , 'dd/mm/yyyy');/* dmap converted statement end *//* dmap converted statement start */
d_fecha_calculo2 := to_date( concat(to_char(n_dia_proceso), '/' , to_char(n_mes_proceso) , '/' , to_char(n_annio_proceso + 1)) , 'dd/mm/yyyy');/* dmap converted statement end */
d_fecha_calculo1 := d_fecha_calculo2                                                                                  - 1;
----------lo meto en un ciclo para validar que sea una fecha valida, ya que la fecha pudiera se invalida.--------
d_f_expiracion := add_months(d_fecha_calculo1, n_meses_expiracion);
begin
insert
into nmcocvac(
vac_keyemp,
vac_antigu,
vac_diavac,
vac_period,
vac_fecini,
vac_fecfin,
vac_fecpre,
vac_dtomad,
vac_salper,
vac_status,
vac_cosrea
)
values (
num_emp,
n_anio_trabajados,
n_dias_vacaciones,
c_periodo,
d_fecha_calculo,
d_fecha_calculo1,
d_f_expiracion,
0,
n_dias_vacaciones,
'V',
0
);
/* commit; */
o_num_r_insertados := num_r_insertados + 1;
exception
when others then
null;
end;
end if;
/* commit; */
--actualizo el estatus a expirado (e) a todos los registros que su fecha de expiracion sea menor a la fecha de proceso
update nmcocvac set vac_status = 'E'
where to_char(vac_fecpre,'RR/MM/DD') <= to_char(clock_timestamp(),'RR/MM/DD')
and vac_status = 'V';
/* commit; */
perform dbms_output.put_line('Parametros periodo:  ');/* dmap converted statement start */
perform dbms_output.put_line( concat('P1:  ', num_emp)) ;/* dmap converted statement end *//* dmap converted statement start */
perform dbms_output.put_line( concat('P2:  ', n_anio_trabajados)) ;/* dmap converted statement end *//* dmap converted statement start */
perform dbms_output.put_line( concat('P3:  ', n_dias_vacaciones)) ;/* dmap converted statement end *//* dmap converted statement start */
perform dbms_output.put_line( concat('P4:  ', c_periodo)) ;/* dmap converted statement end *//* dmap converted statement start */
perform dbms_output.put_line( concat('P5:  ', d_fecha_calculo)) ;/* dmap converted statement end *//* dmap converted statement start */
perform dbms_output.put_line( concat('P6:  ', d_fecha_calculo1)) ;/* dmap converted statement end *//* dmap converted statement start */
perform dbms_output.put_line( concat('P7:  ', d_f_expiracion)) ;/* dmap converted statement end *//* dmap converted statement start */
perform dbms_output.put_line( concat('P8:  ', 0)) ;/* dmap converted statement end *//* dmap converted statement start */
perform dbms_output.put_line( concat('P9:  ', n_dias_vacaciones)) ;/* dmap converted statement end *//* dmap converted statement start */
perform dbms_output.put_line( concat('P10:  ', 'V')) ;/* dmap converted statement end *//* dmap converted statement start */
perform dbms_output.put_line( concat('P11:  ', 0)) ;/* dmap converted statement end *//* dmap converted statement start */
perform dbms_output.put_line( concat('o_num_r_insertados:  ', o_num_r_insertados)) ;/* dmap converted statement end *//* dmap converted statement start */
perform dbms_output.put_line( concat('Count Periodo:  ', n_existe)) ;/* dmap converted statement end */end;
$body$
language plpgsql
;
