create or replace  function  labprod.pkg_protele_sv_valida_sv_fec_aux (num_empleado integer) returns varchar as $body$
declare
-- pgv moved types start
-- pgv moved types end
v_fec_aux varchar(30);
begin 

-- package does not have global variables
--dmap conversion comment: gtt declaration added
select to_char(emp_fecaux, 'DD-MON-RRRR')
into strict v_fec_aux
from nmcoempl
where emp_keyemp = num_empleado;
return v_fec_aux;
exception
when no_data_found then
return null;end;
$body$
language plpgsql
stable;
