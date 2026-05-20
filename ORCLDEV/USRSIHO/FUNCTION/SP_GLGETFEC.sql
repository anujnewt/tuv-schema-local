create or replace  function  usrsiho."sp_glgetfec"  () returns timestamp(0) as $body$
declare
-- pgv moved types start
-- pgv moved types end
begin
return to_timestamp(clock_timestamp(),'mm/dd/yyyy');end;
--dmap converted function completed
$body$
language plpgsql
stable;
