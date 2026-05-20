create or replace procedure xx_bloqueobajas.bloqueoaccesos_clavesbaja (p_result inout refcursor) as $body$
declare
-- pgv moved types start
-- pgv moved types end
begin
-- package does not have global variables
--dmap conversion comment: gtt declaration added
open p_result for select motivobaja,descripcion from xx_bloqueobajas.motivosbaja  order by  motivobaja;end;
$body$
language plpgsql
;
