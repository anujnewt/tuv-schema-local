create or replace procedure labconf.interfacerecibos_insertar_ejecucion (idejecucion inout numeric) as $body$
declare
-- pgv moved types start
-- pgv moved types end
begin 

-- package does not have global variables
--dmap conversion comment: gtt declaration added
insert into labconf.recibos_interface(eje_feceje,eje_mensaj,eje_error)
values (clock_timestamp(),'INICIO EJECUCION DE INTERFACE DE RECIBOS',0)
returning id into idejecucion;end;
$body$
language plpgsql
;
