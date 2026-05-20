create or replace  function  labprod."sp_newkeyinc"  () returns numeric as $body$
declare
-- pgv moved types start
-- pgv moved types end
num_sec integer;
begin
select nextval('labprod.nmcoinci_seq') into strict num_sec;
return num_sec;end;
--dmap converted function completed
$body$
language plpgsql
stable;
