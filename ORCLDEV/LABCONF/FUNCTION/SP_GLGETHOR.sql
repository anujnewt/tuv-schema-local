create or replace  function  labconf."sp_glgethor"  () returns varchar as $body$
declare
-- pgv moved types start
-- pgv moved types end
begin
return to_char(clock_timestamp(), 'HH24:MI:SS');end;
--dmap converted function completed
$body$
language plpgsql
stable;
