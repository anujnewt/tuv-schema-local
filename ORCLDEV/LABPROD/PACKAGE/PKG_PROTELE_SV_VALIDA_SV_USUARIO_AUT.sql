create or replace  function  labprod.pkg_protele_sv_valida_sv_usuario_aut ( num integer, ban_solvac integer, user_vacsol varchar) returns varchar as $body$
declare
-- pgv moved types start
-- pgv moved types end
ger_auto1 integer;
num_auto1 integer;
num_auto2 integer;
num_auto3 integer;
user_red  varchar(30):='NO EXISTE';
begin 

-- package does not have global variables
--dmap conversion comment: gtt declaration added
begin
select distinct(plz_cverem)
into strict num_auto1
from eocoplza
where plz_keyemp  = num;
exception
when no_data_found then
return 'No hay datos';
end;
begin
select
case
when pue_despue like '%DIR%'
then '4'
when pue_despue like '%COORD%'
then '3'
when pue_despue like '%GTE%'
then '2'
else '1'
end
into strict ger_auto1
from nmcopues,
eocoplza
where plz_keypue = pue_keypue
and plz_keyemp   = num_auto1;
exception
when no_data_found then
return 'No hay datos';
end;
begin
select plz_cverem into strict num_auto2 from eocoplza where plz_keyemp = num_auto1;/* dmap converted statement start */
perform dbms_output.put_line( concat('num_auto2:', num_auto2)) ;/* dmap converted statement end */
exception
when no_data_found then
return 'No hay datos';
end;
if ban_solvac  = 1 then
if ger_auto1 = 1 then
select usuario into strict user_red from mail where emp_keyemp = num_auto2;/* dmap converted statement start */
perform dbms_output.put_line( concat('user_red:', user_red)) ;/* dmap converted statement end */
return user_red;
else
select usuario into strict user_red from mail where emp_keyemp = num_auto1;/* dmap converted statement start */
perform dbms_output.put_line( concat('user_red:', user_red)) ;/* dmap converted statement end */
return user_red;
end if;
else
begin
select emp_autori
into strict num_auto3
from solvacnoper
where 1         =1
and emp_vacdep  = num
and emp_vacsol in (select emp_keyemp from mail where lower(usuario) = lower(user_vacsol)
);
exception
when no_data_found then
return 'No hay datos';
end;/* dmap converted statement start */
perform dbms_output.put_line( concat('num_auto3:', num_auto3)) ;/* dmap converted statement end */
select usuario into strict user_red from mail where emp_keyemp = num_auto3;/* dmap converted statement start */
perform dbms_output.put_line( concat('user_red:', user_red)) ;/* dmap converted statement end */
return user_red;
end if;end;
$body$
language plpgsql
stable;
