create or replace procedure labprod.api_empleados_setempleadosdaenc ( id_transaccion varchar, dat_keyemp varchar, dat_keypar varchar, dat_valpar varchar, status inout varchar, code inout varchar, message inout varchar, fecha inout timestamp(0)) as $body$
declare
-- pgv moved types start
-- pgv moved types end
existe integer;
begin 

-- package does not have global variables
--dmap conversion comment: gtt declaration added
fecha := clock_timestamp();
if id_transaccion = '0' then
status := 'OK';
code := '0';
message := 'PRUEBA DE SERVICIO';
else
code := '1';
select count(id_transaccion) into strict existe from labprod.api_empleadosda where api_empleadosda.id_transaccion = setempleadosdaenc.id_transaccion;
if existe != 0  then
status := 'ERROR';
code := '006';
message := 'ID_TRANSACCI??N DUPLICADO';
end if;
if code = '1' then
begin
call api_empleados_setempleadosda(id_transaccion ,fn_decode(dat_keyemp) ,fn_decode(dat_keypar) ,fn_decode(dat_valpar) ,setempleadosdaenc.status ,
call setempleadosdaenc.code ,setempleadosdaenc.message ,setempleadosdaenc.fecha);
exception when others then
code := sqlstate;
message := oracle.substr(sqlerrm, 1 , 149);
status :='ERROR';
end;
end if;
end if;end;
$body$
language plpgsql
;
