create or replace procedure labprod."sv_dia_festivo"  ( fec varchar, ct inout refcursor) as $body$
declare
-- pgv moved types start
-- pgv moved types end
begin
open ct for
select count(*) from dias_festivos where fecha = to_timestamp(fec,'yyyy/MM/dd');end;
$body$
language plpgsql
;
