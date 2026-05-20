create or replace  function  labprod.pkg_protele_sv_valida_sv_usuario_red ( num integer) returns varchar as $body$
declare
-- pgv moved types start
-- pgv moved types end
user_red varchar(30);
begin 

-- package does not have global variables
--dmap conversion comment: gtt declaration added
select usuario into strict user_red from mail where emp_keyemp = num;
return user_red;
exception
when no_data_found then
return 'No hay datos';end;
$body$
language plpgsql
stable;
