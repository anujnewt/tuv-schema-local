create or replace procedure xx_bloqueobajas.pkg_notificaciones_get_destinatarios (p_tipo numeric, p_result inout refcursor) as $body$
declare
-- pgv moved types start
-- pgv moved types end
begin
-- package does not have global variables
--dmap conversion comment: gtt declaration added
open p_result for
select tipodestinatario,destinatario
from xx_bloqueobajas.destinatarios
where tiponotificacion = p_tipo;end;
$body$
language plpgsql
;
