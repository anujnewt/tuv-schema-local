create or replace procedure xx_bloqueobajas.bloqueoaccesos_bitacoraacceso (p_usuario varchar, p_ip varchar, p_nombrepc varchar, p_tipo numeric, p_motivo varchar) as $body$
declare
-- pgv moved types start
-- pgv moved types end
p_resp numeric;
p_accion varchar(10);
begin
-- package does not have global variables
--dmap conversion comment: gtt declaration added
if (p_tipo = 1 ) then
p_accion := 'ACEPTADO';
insert into xx_bloqueobajas.bitacoraacceso values (p_usuario, clock_timestamp(), 'AE','Acceso correcto');
else
p_accion := 'DENEGADO';
insert into xx_bloqueobajas.bitacoraacceso values (p_usuario, clock_timestamp(), 'AF',p_motivo);
end if;
/*insert into lab_bloqueo.bitacoraacceso(usuario,accion,dirip,nombrepc,fecha,motivo)
values(
upper( p_usuario),
p_tipo,
p_ip,
p_nombrepc,
now() at time zone current_setting('TIMEZONE'),
p_motivo
);
/* commit; */
*/
end;
$body$
language plpgsql
;
