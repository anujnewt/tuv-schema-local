create or replace  function  labprod.pkg_protele_sv_valida_sv_status_sol ( num integer) returns integer as $body$
declare
-- pgv moved types start
-- pgv moved types end
n_existe integer;
begin 

-- package does not have global variables
--dmap conversion comment: gtt declaration added
select count(*)
into strict n_existe
from svtempsc
where num_emp = num
and sta_sol  in ('A','P');
return n_existe;
exception
when no_data_found then
return 0;end;
$body$
language plpgsql
stable;
