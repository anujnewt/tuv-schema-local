create or replace procedure labprod.respuestasap_registrospendientes (p_result inout refcursor) as $body$
declare
-- pgv moved types start
-- pgv moved types end
begin 

-- package does not have global variables
--dmap conversion comment: gtt declaration added
open p_result for
select id_transaccion
from labprod.api_movimientosper
where estatus=1  order by  fecha_insert asc;end;
$body$
language plpgsql
;
