create or replace  function  usrsiho."today"  () returns timestamp(0) as $body$
declare
-- pgv moved types start
-- pgv moved types end
begin
return clock_timestamp();end;
--dmap converted function completed
$body$
language plpgsql
stable;
