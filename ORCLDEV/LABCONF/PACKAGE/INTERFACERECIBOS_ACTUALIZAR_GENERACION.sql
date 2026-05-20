create or replace procedure labconf.interfacerecibos_actualizar_generacion (idgeneracion numeric, mensaje varchar, eserror numeric) as $body$
declare
-- pgv moved types start
-- pgv moved types end
begin 

-- package does not have global variables
--dmap conversion comment: gtt declaration added
update labconf.recibos_generacion set
eje_feceje = clock_timestamp(),
eje_mensaj = oracle.substr(actualizar_generacion.mensaje,1,4000),
eje_error = actualizar_generacion.eserror
where id = idgeneracion;end;
$body$
language plpgsql
;
