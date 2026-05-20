create or replace procedure labprod."sv_fechasolicitud"  ( num_empleado integer, fec_s inout refcursor) as $body$
declare
-- pgv moved types start
-- pgv moved types end
begin
open fec_s for
select fec_sol   from svtempsc where svtempsc.num_emp=num_empleado and svtempsc.sta_sol='P';end;
$body$
language plpgsql
;
