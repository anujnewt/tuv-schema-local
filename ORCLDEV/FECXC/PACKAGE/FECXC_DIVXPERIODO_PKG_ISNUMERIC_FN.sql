create or replace  function  fecxc.fecxc_divxperiodo_pkg_isnumeric_fn ( pistvalue varchar ) returns numeric as $body$
declare
-- pgv moved types start
-- pgv moved types end
lintestvalue numeric;
begin
-- package does not have global variables
--dmap conversion comment: gtt declaration added
lintestvalue := (pistvalue)::numeric;
return 1;
exception
when others then
return 0;end;
$body$
language plpgsql
stable;
