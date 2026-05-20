create or replace  function  labprod."fn_vac_estatus"  ( fecini timestamp(0) ) returns varchar as $body$
declare
-- pgv moved types start
-- pgv moved types end
estatus varchar(10);
begin
if fecini > clock_timestamp() then
estatus := 'ANTICIPADO';
else
estatus := 'VIGENTE';
end if;
return estatus;end;
--dmap converted function completed
$body$
language plpgsql
stable;
