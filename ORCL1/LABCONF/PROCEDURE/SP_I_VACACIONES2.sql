create or replace procedure labconf."sp_i_vacaciones2"  (ffechaproceso timestamp(0),o_num_r_procesados inout integer, o_num_r_insertados inout integer, o_num_r_actualizados inout integer, o_iregfijp inout integer, o_iregfijn inout integer) as $body$
declare
-- pgv moved types start
-- pgv moved types end
num_r_procesados         integer;
num_r_insertados         integer;
num_r_actualizados       integer;
--ffechaproceso      	  date;
n_meses_expiracion       integer;
ckeycon            	  char(3);
n_keyemp                 integer;
n_anio_trabajados        integer;
n_annio_proceso          integer;
n_mes_proceso            integer;
n_dia_proceso            integer;
n_keypro                 integer;
n_annio_proc_ant         integer;
n_confianza              integer;
d_fecha_ingreso          timestamp(0);
c_keydep                 char(16);
c_keypue                 char(16);
c_periodo          		char(9);
c_tab_vacaciones   	char(3);
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
ws_pva_stapas      char(30);
iregfijp           integer;
iregfijn           integer;
iexistecon         integer;
cpereje            char(7);
--pfecha          date;
--igneos.i
cursor1  cursor(ffechaproceso_c1  timestamp(0)) is
select emp_keyemp, year(ffechaproceso_c1) - year(emp_fecaux), year(ffechaproceso_c1) -1 || '-' || year(ffechaproceso_c1),
year(ffechaproceso_c1), month(emp_fecaux), day(emp_fecaux), emp_keypro, year(ffechaproceso_c1) - 1,
emp_tipemp,emp_fecaux,emp_keydep,emp_keypue
from nmcoempl
where emp_status = 1 and year(emp_fecaux)  < year(ffechaproceso_c1) and month(emp_fecaux) = month(ffechaproceso_c1)
and day(emp_fecaux)   = day(ffechaproceso_c1);
-------------------------
cursor3 cursor for
select emp_keyemp, emp_keypro, emp_keydep, emp_keypue
from nmcoempl where emp_status = 1;
begin
--i.i
--pfecha := sysdate;
num_r_procesados   := 0;
num_r_actualizados := 0;
num_r_insertados   := 0;
n_meses_expiracion := 6;
--  el numero de concepto para la actualizaci�e datos fijos.
ckeycon := '607';
--se lee y evalua la fecha de procesamiento
--ffechaproceso := sysdate;
--ffechaproceso := 'OCT 09 2011';
--ffechaproceso := day(sysdate) || '/' || month(sysdate) || '/' || year(sysdate);
--if year(ffechaproceso) = 1900 and month(ffechaproceso) = 1 and day(ffechaproceso) = 1 then
--        ffechaproceso := day(sysdate) || '/' || month(sysdate) || '/' || year(sysdate);
--end if;
----------------------------------
--igneos.i
open cursor1(ffechaproceso);
loop
fetch cursor1 into n_keyemp,n_anio_trabajados,c_periodo,n_annio_proceso,n_mes_proceso,n_dia_proceso,n_keypro,
n_annio_proc_ant,n_confianza,d_fecha_ingreso,c_keydep,c_keypue;
exit when not found; /* apply on cursor1 */
/* the original statement block */
--lleva la cuenta de los registros procesados
num_r_procesados := num_r_procesados + 1;
--se valida que la fecha de proceso no sea biciesto
if n_mes_proceso = 2 and n_dia_proceso = 29 then n_dia_proceso := 28; end if;
--obtengo la tabla que le corresponde para la obtenci�e las vacaciones
begin select pam_folfin into strict c_tab_vacaciones
from glcopams where pam_keypar = 'TTV' and pam_nompar = 'TABLA DE VACACIONES' and pam_cvesec = to_char(n_keypro);
exception
when no_data_found then
null;
end;
--foreach
--obtengo el rango de a�trabajados en el que cae el empleado
begin
select min(tab_eledos) into strict n_r_anio_trab from nmlotabn
where tab_keytab= trim(both c_tab_vacaciones) and tab_eledos >= n_anio_trabajados  order by  tab_eledos;
exception
when no_data_found then
null;
end;
--exit foreach;
--end foreach;
--valido si el empleado es de confianza (1) o no (2)
if n_confianza = 2 then
select distinct tab_elecua into strict n_dias_vacaciones from nmlotabn
where tab_keytab = trim(both c_tab_vacaciones) and  tab_eledos = n_r_anio_trab;
else
--obtengo los d� que le corresponden de vacaciones
select distinct tab_eletre into strict n_dias_vacaciones from nmlotabn
where tab_keytab = trim(both c_tab_vacaciones) and  tab_eledos = n_r_anio_trab;
if nullif(n_dias_vacaciones::text, '') is null then
n_anio_trabajados := n_anio_trabajados + '.000002';
end if;
end if;/* dmap converted statement start */
--to_timestamp('2003/07/09','yyyy/mm/dd')
--armo la fecha para poder calcular la fecha de expiraci�
d_fecha_calculo := to_date( concat(to_char(n_dia_proceso), '/' , to_char(n_mes_proceso) , '/' , to_char(n_annio_proceso)) , 'dd/mm/yyyy');/* dmap converted statement end *//* dmap converted statement start */
d_fecha_calculo2 := to_date( concat(to_char(n_dia_proceso), '/' , to_char(n_mes_proceso) , '/' , to_char(n_annio_proceso + 1)) , 'dd/mm/yyyy');/* dmap converted statement end */
d_fecha_calculo1 := d_fecha_calculo2 - 1;
--lo meto en un ciclo para validar que sea una fecha valida, ya que la fecha pudiera se invalida.
--d_f_expiracion := add_months(to_timestamp(d_fecha_calculo1,'dd/mm/yyyy'), n_meses_expiracion);
d_f_expiracion := add_months(d_fecha_calculo1, n_meses_expiracion);
--verifico que el empleado no tenga ya calculado su periodo de vacaciones para el periodo
n_existe := 0;
select count(*) into strict n_existe
from nmcocvac where vac_keyemp = n_keyemp and  vac_period = c_periodo;
if n_existe = 0 then
begin
insert into nmcocvac( vac_keyemp, vac_antigu, vac_diavac,vac_period, vac_fecini, vac_fecfin,vac_fecpre, vac_dtomad, vac_salper,vac_status, vac_cosrea)
values (n_keyemp, n_anio_trabajados, n_dias_vacaciones,c_periodo, d_fecha_calculo, d_fecha_calculo1,d_f_expiracion, 0, n_dias_vacaciones,'V', 0);
num_r_insertados := num_r_insertados + 1;
exception
when others then
null;
end;
else
wd_vac_salper := '0.00';
begin
select distinct vac_status into strict ws_vac_status from nmcocvac
where vac_keyemp = n_keyemp and   vac_period = c_periodo;
exception
when no_data_found then
null;
end;
if ws_vac_status = 'A' then
select distinct vac_salper * -1 , vac_antigu into strict wd_vac_salper, nagnostrab
from nmcocvac where vac_keyemp = n_keyemp and vac_status = 'A' and vac_period = c_periodo;
idiasvac := n_dias_vacaciones - wd_vac_salper;
select vac_fecini, to_timestamp(ffechaproceso) into strict dfecini, dfecnow
from nmcocvac where vac_keyemp = n_keyemp and vac_status = 'A' and vac_period = c_periodo;
update nmcocvac set vac_diavac = n_dias_vacaciones, vac_salper = idiasvac,
vac_status = 'V', vac_fecini = d_fecha_calculo, vac_fecfin = d_fecha_calculo1, vac_fecpre = d_f_expiracion,
vac_antigu = n_anio_trabajados
where vac_keyemp = n_keyemp and vac_period = c_periodo;
num_r_actualizados := num_r_actualizados + 1;
end if;
end if;
/* commit; */
end loop;
close cursor1;
----------------------------------------------------------------------
--actualizo el estatus a expirado (e) a todos los registros que su fecha de expiraci�ea menor a la fecha de proceso
update nmcocvac set vac_status = 'E' where vac_fecpre < to_timestamp(ffechaproceso) and vac_status = 'V';
--actualizo datos en tablas de datos fijos
iregfijp := 0;
iregfijn := 0;
----------------------------------
--igneos.i
open cursor3;
loop
fetch cursor3 into nkeyemp, nkeypro, ckeydep, ckeypue;
exit when not found; /* apply on cursor3 */
/* the original statement block */
wd_vac_salper := '0.0';
-- actualizo la tabla de datos fijos
begin
select upper(dat_valpar) into strict ws_pva_stapas from nmlodata where dat_keyemp = nkeyemp and dat_keypar = '28';
exception
when no_data_found then
null;
end;
--i.i
wd_vac_salper := '0.0';
if ws_pva_stapas = 'S' or ws_pva_stapas = 'SI' then
select sum(vac_salper) into strict wd_vac_salper from nmcocvac where vac_status in ('V','A','P') and vac_keyemp = nkeyemp;
iregfijp := iregfijp + 1;
else
select sum(vac_salper) into strict wd_vac_salper from nmcocvac where vac_status in ('V','A') and vac_keyemp = nkeyemp;
iregfijn := iregfijn + 1;
end if;
iexistecon := 0;
begin
select pro_pereje into strict cpereje from nmloproc where pro_keypro = nkeypro;
exception
when no_data_found then
null;
end;
begin
select distinct dfi_keyemp into strict iexistecon from nmlodfij
where dfi_keycon = ckeycon and dfi_keyemp = nkeyemp and dfi_keypro = nkeypro;
exception
when no_data_found then
null;
end;
if nullif(ckeycon::text, '') is not null then
if nullif(iexistecon::text, '') is null then
insert into nmlodfij values (nkeyemp,ckeycon,nkeypro,cpereje,2020999,ckeydep, ckeypue,ffechaproceso,wd_vac_salper,0.0,' ',' ');
else
update nmlodfij set dfi_cantid = wd_vac_salper where dfi_keyemp = nkeyemp and dfi_keycon = ckeycon and dfi_keypro = nkeypro;
end if;
end if;
end loop;
close cursor3;
---------------------------------
o_num_r_procesados := num_r_procesados;
o_num_r_insertados := num_r_insertados;
o_num_r_actualizados := num_r_actualizados;
o_iregfijp := iregfijp;
o_iregfijn := iregfijn;end;
$body$
language plpgsql
;
