create or replace procedure labprod.api_catalogos_setdepartamentoenc ( id_transaccion varchar, dep_keydep varchar, dep_desdep varchar, dep_refcon varchar, dep_keycen varchar, dep_tipdep varchar, dep_nu1aux varchar, dep_nu2aux varchar, dep_nu3aux varchar, dep_nu4aux varchar, dep_nu5aux varchar, dep_ca1aux varchar, dep_ca2aux varchar, dep_ca3aux varchar, dep_ca4aux varchar, dep_ca5aux varchar, status inout varchar, code inout varchar, message inout varchar, fecha inout timestamp(0)) as $body$
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
select count(id_transaccion) into strict existe from labprod.api_departamento where api_departamento.id_transaccion = setdepartamentoenc.id_transaccion;
if existe != 0  then
status := 'ERROR';
code := '006';
message := 'ID_TRANSACCION DUPLICADO';
end if;
if code = '1' then
begin
call api_catalogos_setdepartamento(id_transaccion,fn_decode(dep_keydep) ,fn_decode(dep_desdep) ,fn_decode(dep_refcon) ,fn_decode(dep_keycen) ,fn_decode(dep_tipdep) ,
fn_decode(dep_nu1aux) ,fn_decode(dep_nu2aux) ,fn_decode(dep_nu3aux) ,fn_decode(dep_nu4aux) ,fn_decode(dep_nu5aux) ,fn_decode(dep_ca1aux) ,fn_decode(dep_ca2aux) ,
fn_decode(dep_ca3aux) ,fn_decode(dep_ca4aux) ,fn_decode(dep_ca5aux) ,setdepartamentoenc.status ,setdepartamentoenc.code ,setdepartamentoenc.message,setdepartamentoenc.fecha);
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
