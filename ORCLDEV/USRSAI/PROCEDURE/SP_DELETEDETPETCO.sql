create or replace procedure usrsai."sp_deletedetpetco"  (numpco numeric, idereg numeric,cont inout numeric) as $body$
declare
-- pgv moved types start
-- pgv moved types end
begin
select count(*) into strict cont from detpetco
where dpc_idereg = idereg and dpc_numpco = numpco;
if cont >= 1 then
delete from detpetco
where dpc_idereg = idereg
and dpc_numpco = numpco;
end if;end;
$body$
language plpgsql
;
