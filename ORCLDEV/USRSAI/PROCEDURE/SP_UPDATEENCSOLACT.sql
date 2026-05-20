create or replace procedure usrsai."sp_updateencsolact"  (numsol numeric,keydep varchar, nomresp varchar, fecgra varchar, fecair varchar, observ varchar, stssol numeric, obscar varchar, aux inout numeric) as $body$
declare
-- pgv moved types start
-- pgv moved types end
begin
aux := 0;
select count(*) into strict aux
from encsolact
where esa_numsol = numsol;
if aux >= 1 then
update encsolact
set esa_keydep = keydep,
esa_observ = observ,
esa_fecgra = to_timestamp(fecgra,'dd/mm/yyyy'),
esa_fecair = to_timestamp(fecair,'dd/mm/yyyy'),
esa_stssol = stssol,
esa_nomresp = nomresp,
esa_obscar = obscar
where esa_numsol = numsol;
end if;end;
$body$
language plpgsql
;
