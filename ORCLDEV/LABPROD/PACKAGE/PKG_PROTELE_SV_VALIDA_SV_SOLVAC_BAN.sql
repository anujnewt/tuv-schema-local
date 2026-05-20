create or replace  function  labprod.pkg_protele_sv_valida_sv_solvac_ban ( user_vacsol varchar, num_vacdep integer) returns integer as $body$
declare
-- pgv moved types start
-- pgv moved types end
vacsol integer;
begin 

-- package does not have global variables
--dmap conversion comment: gtt declaration added
select 1
into strict vacsol
from solvacnoper
where 1         =1
and emp_vacdep  = num_vacdep
and emp_vacsol in (select emp_keyemp from mail where lower(usuario) = lower(user_vacsol)
);
return vacsol;
exception
when no_data_found then
return 0;end;
$body$
language plpgsql
stable;
