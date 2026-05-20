create or replace  function  labprod.pkg_protele_sv_valida_sv_emp_keyloc (p_num_emp integer) returns integer as $body$
declare
-- pgv moved types start
-- pgv moved types end
v_emp_keyloc integer;
begin 

-- package does not have global variables
--dmap conversion comment: gtt declaration added
select emp_keyloc
into strict v_emp_keyloc
from nmcoempl
where emp_keyemp = p_num_emp;
return v_emp_keyloc;
exception
when no_data_found then
return 0;end;
$body$
language plpgsql
stable;
