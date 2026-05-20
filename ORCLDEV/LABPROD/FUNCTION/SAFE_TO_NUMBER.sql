create or replace  function  labprod."safe_to_number"  (p varchar) returns numeric as $body$
declare
-- pgv moved types start
-- pgv moved types end
v numeric;
begin
v := (p)::numeric;
return v;
exception when others then return 0;end;
--dmap converted function completed
$body$
language plpgsql
stable;
