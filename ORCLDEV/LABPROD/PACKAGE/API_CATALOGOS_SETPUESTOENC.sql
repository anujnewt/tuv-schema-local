create or replace procedure labprod.api_catalogos_setpuestoenc ( id_transaccion varchar, pue_keypue varchar, pue_despue varchar, pue_refcon varchar, pue_nu1aux varchar, pue_nu2aux varchar, pue_nu3aux varchar, pue_nu4aux varchar, pue_nu5aux varchar, pue_ca1aux varchar, pue_ca2aux varchar, pue_ca3aux varchar, pue_ca4aux varchar, pue_ca5aux varchar, pue_sueniv varchar, pue_subniv varchar, pue_keysue varchar, pue_cobert varchar, pue_arepue varchar, pue_subare varchar , pue_nivpue varchar, pue_grppue varchar, pue_subgrp varchar, pue_tippue varchar, status inout varchar, code inout varchar, message inout varchar, fecha inout timestamp(0)) as $body$
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
code :=  '1';
select count(id_transaccion) into strict  existe  from labprod.api_puesto where api_puesto.id_transaccion = setpuestoenc.id_transaccion;
if existe != 0  then
status := 'ERROR';
code := '006';
message := 'ID_TRANSACCION DUPLICADO';
end if;
if nullif(pue_sueniv::text, '') is not null then
if f_is_int(fn_decode(pue_sueniv)) = 0 then
status := 'ERROR';
code := '006';
message := 'PUE_SUENIV NO ES DE TIPO INT';
end if;
end if;
if nullif(pue_subniv::text, '') is not null then
if f_is_int(fn_decode(pue_subniv)) = 0 then
status := 'ERROR';
code := '006';
message := 'PUE_SUBNIV NO ES DE TIPO INT';
end if;
end if;
if nullif(pue_nivpue::text, '') is not null then
if f_is_int(fn_decode(pue_nivpue)) = 0 then
status := 'ERROR';
code := '006';
message := 'PUE_NIVPUE NO ES DE TIPO INT';
end if;
end if;
if code = '1' then
begin
call api_catalogos_setpuesto(id_transaccion ,fn_decode(pue_keypue),fn_decode(pue_despue),fn_decode(pue_refcon),fn_decode(pue_nu1aux),fn_decode(pue_nu2aux),fn_decode(pue_nu3aux),
fn_decode(pue_nu4aux),fn_decode(pue_nu5aux),fn_decode(pue_ca1aux),fn_decode(pue_ca2aux),fn_decode(pue_ca3aux),fn_decode(pue_ca4aux),fn_decode(pue_ca5aux),
fn_decode(pue_sueniv),fn_decode(pue_subniv),fn_decode(pue_keysue),fn_decode(pue_cobert),fn_decode(pue_arepue),fn_decode(pue_subare),fn_decode(pue_nivpue),
fn_decode(pue_grppue),fn_decode(pue_subgrp),fn_decode(pue_tippue),setpuestoenc.status ,setpuestoenc.code ,setpuestoenc.message,setpuestoenc.fecha);
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
