create or replace  function  usrdrc.app_common_pkg_is_number_fn (pisttext varchar) returns integer as $body$
declare
-- pgv moved types start
-- pgv moved types end
v_new_num numeric;
begin
-- package does not have global variables
--dmap conversion comment: gtt declaration added
v_new_num := (pisttext)::numeric;
return 1;
exception
when data_exception then
return 0;end;
$body$
language plpgsql
stable;
