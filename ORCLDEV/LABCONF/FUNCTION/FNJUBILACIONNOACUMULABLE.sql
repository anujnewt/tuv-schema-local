create or replace  function  labconf."fnjubilacionnoacumulable"  ( p_import numeric, p_salmes numeric ) returns numeric as $body$
declare
-- pgv moved types start
-- pgv moved types end
noacumulable decimal(12,2);
begin
noacumulable := p_salmes;
if noacumulable > p_import then
noacumulable := 0;
end if;
return noacumulable;end;
--dmap converted function completed
$body$
language plpgsql
stable;
