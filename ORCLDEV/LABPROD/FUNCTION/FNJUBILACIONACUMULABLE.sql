create or replace  function  labprod."fnjubilacionacumulable"  ( p_import numeric, p_salmes numeric ) returns numeric as $body$
declare
-- pgv moved types start
-- pgv moved types end
acumulable decimal(12,2);
begin
acumulable := p_import - p_salmes;
if acumulable < 0 then
acumulable := 0;
end if;
return acumulable;end;
--dmap converted function completed
$body$
language plpgsql
stable;
