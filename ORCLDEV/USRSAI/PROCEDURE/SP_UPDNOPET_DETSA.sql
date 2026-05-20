create or replace procedure usrsai."sp_updnopet_detsa"  ( numsol numeric, idereg numeric, numpet numeric, aux inout numeric) as $body$
declare
-- pgv moved types start
-- pgv moved types end
aux2 numeric;
begin
aux := 0;
select count(*) into strict aux
from  detsolact
where dsa_numsol = numsol
and dsa_idereg = idereg;
if aux >= 1 then
update detsolact
set dsa_numpet = numpet,
dsa_stsreg = 4
where dsa_numsol = numsol
and dsa_idereg = idereg;
end if;
-- actualiza el estado de una solicitud cuando todos las solicitudes-actor han sido atendidas
select count(*) into strict aux2
from detsolact
where nullif(dsa_numpet::text, '') is null and dsa_numsol = numsol;
if aux2 = 0 then
update encsolact
set esa_stssol = 4
where esa_numsol = numsol;
end if;end;
$body$
language plpgsql
;
