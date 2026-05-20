create or replace procedure usrsai."sp_deletedetsolact"  ( numsol numeric, idereg numeric, aux inout numeric ) as $body$
declare
-- pgv moved types start
-- pgv moved types end
begin
aux := 0;
select count(*) into strict aux
from detsolact
where dsa_numsol = numsol
and dsa_idereg = idereg;
if aux >= 1 then
delete from detsolact
where dsa_numsol = numsol
and dsa_idereg = idereg;
end if;end;
$body$
language plpgsql
;
