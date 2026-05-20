create or replace  function  xx_bloqueobajas.bloqueoaccesos_tipousuario (p_keyemp numeric) returns varchar as $body$
declare
-- pgv moved types start
-- pgv moved types end
tiporol varchar(20) := 'NORMAL';
valida numeric;
begin
-- package does not have global variables
--dmap conversion comment: gtt declaration added
/* c????digo para saber que rol le corresponde al empleado*/
/*if (p_keyemp = 2031329 or
p_keyemp = 2031322 or
p_keyemp = 2031720 or
p_keyemp = 2017175 or
p_keyemp = 2041671 or
p_keyemp = 2042937 or
p_keyemp = 2043917) then
tiporol := reg_control;
end if;
*/
return tiporol;end;
$body$
language plpgsql
stable;
