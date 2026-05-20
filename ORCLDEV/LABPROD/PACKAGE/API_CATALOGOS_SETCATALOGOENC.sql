create or replace procedure labprod.api_catalogos_setcatalogoenc ( id_transaccion varchar, pam_keypar varchar, pam_cvesec varchar, pam_nompar varchar, pam_folini varchar, pam_folfin varchar, status inout varchar, code inout varchar, message inout varchar, fecha inout timestamp(0)) as $body$
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
select count(id_transaccion) into strict existe from labprod.api_catalogo where api_catalogo.id_transaccion = setcatalogoenc.id_transaccion;
if existe != 0  then
status := 'ERROR';
code := '006';
message := 'ID_TRANSACCION DUPLICADO';
end if;
if code = '1' then
begin
call api_catalogos_setcatalogo(id_transaccion,fn_decode(pam_keypar),fn_decode(pam_cvesec),fn_decode(pam_nompar),fn_decode(pam_folini),fn_decode(pam_folfin),
call setcatalogoenc.status,setcatalogoenc.code,setcatalogoenc.message,setcatalogoenc.fecha);
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
