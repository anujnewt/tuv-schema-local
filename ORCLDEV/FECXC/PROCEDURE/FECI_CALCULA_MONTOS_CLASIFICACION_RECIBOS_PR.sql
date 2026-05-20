create or replace procedure fecxc."feci_calcula_montos_clasificacion_recibos_pr"  ( p_recibo numeric, p_usuario numeric ) as $body$
declare
-- pgv moved types start
-- pgv moved types end
v_fecha_actual timestamp(0);
begin 

-- obtenemos la fecha actual del sistema
select clock_timestamp() into strict v_fecha_actual;/* dmap converted statement start */
-- realiza tus c?ulos o acciones con la fecha actual
-- por ejemplo:
-- insert into una_tabla (recibo_id, fecha_registro, usuario_id)
-- values (p_recibo, v_fecha_actual, p_usuario);
-- tambi?puedes mostrar la fecha en la salida
perform dbms_output.put_line( concat('Fecha actual del sistema: ', to_char(v_fecha_actual, 'DD-MON-YYYY HH24:MI:SS'))) ;/* dmap converted statement end */end;
$body$
language plpgsql
;
