create or replace procedure labconf.interfacerecibos_insertar_generacion (idgeneracion inout numeric, keypro numeric, keyper varchar) as $body$
declare
-- pgv moved types start
-- pgv moved types end
begin 

-- package does not have global variables
--dmap conversion comment: gtt declaration added
insert into labconf.recibos_generacion(eje_feceje,eje_mensaj,eje_error,eje_keypro,eje_keyper)
values (clock_timestamp(),'INICIO GENERACION DE RECIBOS',0,keypro,keyper)
returning id into idgeneracion;end;
$body$
language plpgsql
;
