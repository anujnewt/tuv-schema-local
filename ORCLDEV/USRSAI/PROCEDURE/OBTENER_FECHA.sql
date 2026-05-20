create or replace procedure usrsai."obtener_fecha"  (p_texto inout varchar) as $body$
declare
-- pgv moved types start
-- pgv moved types end
begin
/* dmap converted statement start */
p_texto :=  concat('La fecha actual es ', to_char(clock_timestamp(),'DD/MM/YYYY')) ;/* dmap converted statement end */end;
$body$
language plpgsql
;
