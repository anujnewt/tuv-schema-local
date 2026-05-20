create or replace procedure usrsai."sp_updatedetsolact_tu"  ( numsol numeric, idereg numeric, keyemp numeric, nomart varchar, person varchar, keypue varchar, keynac varchar, numcap varchar, coment varchar, stsreg numeric, tipodis varchar, revdis varchar, sindicato varchar, aux inout numeric) as $body$
declare
-- pgv moved types start
-- pgv moved types end
begin
aux := 0;
select count(*) into strict aux
from detsolact
where dsa_numsol = numsol
and dsa_idereg = idereg;
if aux > 0 then
update detsolact
set dsa_keyemp = keyemp,
dsa_nomart = nomart,
dsa_person = person,
dsa_keypue = keypue,
dsa_keynac = keynac,
dsa_numcap = numcap,
dsa_coment = coment,
dsa_stsreg = stsreg,
dsa_tipodis = tipodis,
dsa_revdis = revdis,
dsa_sindicato = sindicato
where dsa_numsol = numsol
and dsa_idereg = idereg;
end if;end;
$body$
language plpgsql
;
