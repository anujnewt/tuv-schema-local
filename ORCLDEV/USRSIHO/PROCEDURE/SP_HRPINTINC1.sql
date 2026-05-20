create or replace procedure usrsiho."sp_hrpintinc1"  (pi_nomina integer, ps_fecha varchar, ps_area varchar) as $body$
declare
-- pgv moved types start
-- pgv moved types end
empleado integer;
depto    varchar(15);
area     varchar(4);
rec record;
rec2 record;
begin
-- actualizamos a nulos proceso y area de los empleados a procesar
update tmp_cont_exclu
set con_keypro  = null,
con_arefis  = null
where con_stscon ='A'
and con_keynom = pi_nomina
and con_fecpag = ps_fecha;
--foreach
for rec
in (select con_keyemp, con_keydep
-- into empleado,depto
from tmp_cont_exclu, nmlonomi
where con_keynom = nom_keynom
and con_stscon ='A'
and con_keynom = pi_nomina
and con_fecpag = ps_fecha)
loop
empleado := rec.con_keyemp;
depto    := rec.con_keydep;
-- se asigna el proceso correspondiente al empleado
update tmp_cont_exclu
set con_keypro = (select emp_keypro
from nmcoempl
where emp_keyemp = empleado
and emp_status = 1)
where con_keyemp = empleado;
--      -- se asigna el area de ubicaci?orrespondiente al empleado
--      update tmp_cont_exclu
--         set con_arefis = (select ale_arefis
--                             from holoalem
--                            where ale_keyemp = empleado)
--       where con_keyemp = empleado;
end loop;
--actualiza el area fiscal
-- foreach
for rec2
in (select distinct con_keydep
into strict depto
from tmp_cont_exclu, nmlonomi
where con_keynom = nom_keynom
and con_stscon ='A'
and con_keynom = pi_nomina
and con_fecpag = ps_fecha)
loop
depto := rec2.con_keydep;
begin
select pam_folfin
into strict area
from glcopams
where pam_keypar = (select pam_folini
from glcopams
where pam_keypar = '00'
and pam_cvesec = 'pintin')
and pam_nompar = pi_nomina
and pam_folini = depto;
exception when no_data_found then area:= null;
end;
--si no encuentra valor
if nullif(area::text, '') is null then
--si es la nomina 111, se asigna el area 1 por que el cc no esta parametrizado
if pi_nomina = 111 then
update tmp_cont_exclu
set con_arefis = 1
where con_stscon ='A'
and con_keynom = pi_nomina
and con_fecpag = ps_fecha;
else
--si es otra nomina, se asigna el area en la que el usuario esta.
update tmp_cont_exclu
set con_arefis = ps_area
where con_stscon ='A'
and con_keynom = pi_nomina
and con_fecpag = ps_fecha;
end if;
else
-- se asigna el area de ubicaci?ue esta por opci
update tmp_cont_exclu
set con_arefis = area
where con_stscon ='A'
and con_keynom = pi_nomina
and con_fecpag = ps_fecha;
end if;
end loop;end;
$body$
language plpgsql
;
