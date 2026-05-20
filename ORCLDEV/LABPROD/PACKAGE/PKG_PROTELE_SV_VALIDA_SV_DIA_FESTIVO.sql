create or replace  function  labprod.pkg_protele_sv_valida_sv_dia_festivo (p_fecha varchar) returns integer as $body$
declare
-- pgv moved types start
-- pgv moved types end
v_existe integer;
begin 

-- package does not have global variables
--dmap conversion comment: gtt declaration added
select  1
into strict v_existe
from dias_festivos
where 1=1
and to_char(fecha,'DD/MM/RRRR') = p_fecha;
return  1;
exception
when no_data_found then
return 0;end;
$body$
language plpgsql
stable;
