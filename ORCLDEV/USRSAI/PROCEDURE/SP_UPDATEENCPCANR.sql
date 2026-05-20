create or replace procedure usrsai."sp_updateencpcanr"  ( numco numeric, keydep varchar, observ varchar, stspet numeric,aux inout numeric) as $body$
declare
-- pgv moved types start
-- pgv moved types end
begin
aux := 0;
select count(*) into strict aux
from encpetco
where epc_numpco = numco;
if aux >= 1 then
update encpcanr
set epc_observ = observ,
epc_keydep = keydep,
epc_stspet = stspet
where epc_numpco = numco;
end if;end;
$body$
language plpgsql
;
