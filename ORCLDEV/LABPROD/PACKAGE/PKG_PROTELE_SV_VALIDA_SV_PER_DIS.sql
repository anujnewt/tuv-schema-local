create or replace  function  labprod.pkg_protele_sv_valida_sv_per_dis ( num integer) returns integer as $body$
declare
-- pgv moved types start
-- pgv moved types end
n_existe integer;
n_ant    integer;
begin 

-- package does not have global variables
--dmap conversion comment: gtt declaration added
begin
select round((clock_timestamp() - emp_fecaux)::numeric,0)
into strict n_ant
from nmcoempl
where emp_keyemp = num;
exception
when no_data_found then
return 0;
end;
if n_ant >= 365 then
begin
select count(*)
into strict n_existe
from nmcocvac
where vac_keyemp      = num
and year(vac_fecfin) >= year(clock_timestamp())-1
and vac_status        = 'V'
and vac_diavac        > 0;
return n_existe;
exception
when no_data_found then
return 0;
end;
else
return 0;
end if;end;
$body$
language plpgsql
stable;
