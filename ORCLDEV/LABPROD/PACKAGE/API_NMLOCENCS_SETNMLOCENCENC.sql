create or replace procedure labprod.api_nmlocencs_setnmlocencenc ( id_transaccion varchar, cen_keycen varchar, cen_descen varchar, cen_refcon varchar, cen_nu1aux varchar, cen_nu2aux varchar, cen_nu3aux varchar, cen_nu4aux varchar, cen_nu5aux varchar, cen_ca1aux varchar, cen_ca2aux varchar, cen_ca3aux varchar, cen_ca4aux varchar, cen_ca5aux varchar, status inout varchar, code inout varchar, message inout varchar, fecha inout timestamp(0) ) as $body$
declare
-- pgv moved types start
-- pgv moved types end
existe integer;
begin 

-- package does not have global variables
--dmap conversion comment: gtt declaration added
if id_transaccion = '0' then
status := 'OK';
code := '0';
message := 'PRUEBA DE SERVICIO';
else
code := '1';
select count(id_transaccion) into strict  existe  from labprod.api_nmlocenc where api_nmlocenc.id_transaccion = setnmlocencenc.id_transaccion;
if existe != 0  then
status := 'ERROR';
code := '006';
message := 'ID_TRANSACCION DUPLICADO';
end if;
if code ='1' then
begin
call api_nmlocencs_setnmlocenc(id_transaccion, fn_decode(cen_keycen),fn_decode(cen_descen),fn_decode(cen_refcon),fn_decode(cen_nu1aux),fn_decode(cen_nu2aux),fn_decode(cen_nu3aux),fn_decode(cen_nu4aux),
fn_decode(cen_nu5aux),fn_decode(cen_ca1aux),fn_decode(cen_ca2aux),fn_decode(cen_ca3aux),fn_decode(cen_ca4aux),fn_decode(cen_ca5aux),setnmlocencenc.status,
call setnmlocencenc.code,setnmlocencenc.message,setnmlocencenc.fecha);
exception when others then
code := sqlstate;
message := oracle.substr(sqlerrm, 1 , 150);
status :='ERROR';
end;
end if;
end if;end;
$body$
language plpgsql
;
