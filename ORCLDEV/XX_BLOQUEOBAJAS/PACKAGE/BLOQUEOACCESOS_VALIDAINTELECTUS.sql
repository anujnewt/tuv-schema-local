create or replace  function  xx_bloqueobajas.bloqueoaccesos_validaintelectus (p_proceso numeric) returns numeric as $body$
declare
-- pgv moved types start
-- pgv moved types end
valida numeric;
begin
-- package does not have global variables
--dmap conversion comment: gtt declaration added
/*if (p_proceso = 10 or p_proceso = 12) then
valida := 1;
else
valida := 0;
end if;*/
return 0;end;
$body$
language plpgsql
stable;
