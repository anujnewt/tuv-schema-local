create or replace procedure labprod.api_catalogos_setlocpagoenc ( id_transaccion varchar, loc_keyloc varchar, loc_desloc varchar, loc_domloc varchar, loc_colloc varchar, loc_ciuloc varchar, loc_estloc varchar, loc_codpos varchar, loc_lardis varchar, loc_teluno varchar, loc_teldos varchar, loc_teltre varchar, loc_cvezon varchar, loc_reggeo varchar, loc_keyban varchar, loc_keysuc varchar, loc_ca1aux varchar, loc_ca2aux varchar, loc_ca3aux varchar, loc_ca4aux varchar, loc_ca5aux varchar, loc_refcon varchar, status inout varchar, code inout varchar, message inout varchar, fecha inout timestamp(0)) as $body$
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
select count(id_transaccion) into strict  existe  from labprod.api_locpago where api_locpago.id_transaccion = setlocpagoenc.id_transaccion;
if existe != 0  then
status := 'ERROR';
code := '006';
message := 'ID_TRANSACCION DUPLICADO';
end if;
if nullif(loc_cvezon::text, '') is not null then
if f_is_int(fn_decode(loc_cvezon)) = 0 then
status := 'ERROR';
code := '006';
message := 'LOC_CVEZON NO ES DE TIPO INT';
end if;
end if;
if code = '1' then
begin
call api_catalogos_setlocpago(id_transaccion ,fn_decode(loc_keyloc)  ,fn_decode(loc_desloc)  ,fn_decode(loc_domloc)  ,fn_decode(loc_colloc)  ,fn_decode(loc_ciuloc)  ,
fn_decode(loc_estloc)  ,fn_decode(loc_codpos)  ,fn_decode(loc_lardis)  ,fn_decode(loc_teluno)  ,fn_decode(loc_teldos)  ,fn_decode(loc_teltre)  ,
fn_decode(loc_cvezon)  ,fn_decode(loc_reggeo)  ,fn_decode(loc_keyban)  ,fn_decode(loc_keysuc)  ,fn_decode(loc_ca1aux)  ,fn_decode(loc_ca2aux)  ,
fn_decode(loc_ca3aux)  ,fn_decode(loc_ca4aux)  ,fn_decode(loc_ca5aux)  ,fn_decode(loc_refcon)  ,setlocpagoenc.status ,setlocpagoenc.code ,setlocpagoenc.message ,
call setlocpagoenc.fecha);
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
