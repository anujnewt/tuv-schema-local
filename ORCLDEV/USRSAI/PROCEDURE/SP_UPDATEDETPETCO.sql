create or replace procedure usrsai."sp_updatedetpetco"  ( numpco numeric, idereg numeric, clasif varchar, tabulador numeric, sindicato varchar, siscon varchar, fecgra varchar, person varchar, numcap varchar, tabulade numeric, padiftab numeric, totcap numeric, conjunto varchar, tipval numeric, tipopago numeric, numllamados numeric, cont inout numeric) as $body$
--se agrego numllamados como un argumento al final ig-cons-0823
declare
-- pgv moved types start
-- pgv moved types end
begin
select count(*) into strict cont from detpetco
where dpc_idereg = idereg and dpc_numpco = numpco;
if cont >= 1 then
--se especifico la actualizaci?el campo dpc_numllama con el valor del argumento numllamados ig-cons-0823
update detpetco
set dpc_clasif = clasif,
dpc_tabulador = tabulador,
dpc_sindicato = sindicato,
dpc_siscon = siscon,
dpc_fecgra = to_timestamp(fecgra,'dd/mm/yyyy'),
dpc_person = person,
dpc_numcap = numcap,
dpc_tabulade = tabulade,
dpc_padiftab = padiftab,
dpc_totcap = totcap,
dpc_conjunto = conjunto,
dpc_tipval = tipval,
dpc_tipopago = tipopago,
dpc_numllama = numllamados
where dpc_idereg = idereg
and dpc_numpco = numpco;
end if;end;
$body$
language plpgsql
;
