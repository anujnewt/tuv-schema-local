create or replace procedure usrsai."sp_deletepctmp"  (numpet numeric, aux inout numeric) as $body$
declare
-- pgv moved types start
-- pgv moved types end
begin
aux := 0;
--cuenta registros
select count(*) into strict aux
from  detpetco
where dpc_numpco = numpet;
--encabezado
delete from encpetco
where epc_numpco = numpet;
--detalle
delete from detpetco
where dpc_numpco = numpet;end;
$body$
language plpgsql
;
