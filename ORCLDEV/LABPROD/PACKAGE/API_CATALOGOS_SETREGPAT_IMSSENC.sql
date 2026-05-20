create or replace procedure labprod.api_catalogos_setregpat_imssenc ( id_transaccion varchar, ims_keyims varchar, ims_rfcims varchar, ims_razsoc varchar, ims_dirloc varchar, ims_numext varchar, ims_numint varchar, ims_colloc varchar, ims_codpos varchar, ims_munloc varchar, ims_entloc varchar, ims_numban varchar, ims_pririe varchar, ims_tiprie varchar, ims_luggui varchar, ims_actloc varchar, ims_keyban varchar, ims_numcot varchar, ims_bascal varchar, ims_totpag varchar, ims_keycia varchar, ims_cveedi varchar, ims_ca1aux varchar, ims_ca2aux varchar, ims_ca3aux varchar, ims_ca4aux varchar, ims_franum varchar, status inout varchar, code inout varchar, message inout varchar, fecha inout timestamp(0)) as $body$
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
code :=1;
if code = '1' then
select count(id_transaccion) into strict  existe  from labprod.api_regpat_imss where api_regpat_imss.id_transaccion = setregpat_imssenc.id_transaccion;
if existe != 0  then
status := 'ERROR';
code := '006';
message := 'ID_TRANSACCION DUPLICADO';
end if;
if nullif(ims_pririe::text, '') is not null then
if f_is_int(fn_decode(ims_pririe)) = 0 then
status := 'ERROR';
code := '006';
message := 'IMS_PRIRIE NO ES DE TIPO INT';
end if;
end if;
if nullif(ims_luggui::text, '') is not null then
if f_is_int(fn_decode(ims_luggui)) = 0 then
status := 'ERROR';
code := '006';
message := 'IMS_LUGGUI NO ES DE TIPO INT';
end if;
end if;
if nullif(ims_numcot::text, '') is not null then
if f_is_int(fn_decode(ims_numcot)) = 0 then
status := 'ERROR';
code := '006';
message := 'IMS_NUMCOT NO ES DE TIPO INT';
end if;
end if;
if nullif(ims_bascal::text, '') is not null then
if f_is_int(fn_decode(ims_bascal)) = 0 then
status := 'ERROR';
code := '006';
message := 'IMS_BASCAL NO ES DE TIPO INT';
end if;
end if;
if nullif(ims_totpag::text, '') is not null then
if f_is_int(fn_decode(ims_totpag)) = 0 then
status := 'ERROR';
code := '006';
message := 'IMS_TOTPAG NO ES DE TIPO INT';
end if;
end if;
begin
call api_catalogos_setregpat_imss(id_transaccion,fn_decode(ims_keyims),fn_decode(ims_rfcims),fn_decode(ims_razsoc),fn_decode(ims_dirloc),fn_decode(ims_numext),fn_decode(ims_numint),
fn_decode(ims_colloc),fn_decode(ims_codpos),fn_decode(ims_munloc),fn_decode(ims_entloc),fn_decode(ims_numban),fn_decode(ims_pririe),fn_decode(ims_tiprie),fn_decode(ims_luggui),
fn_decode(ims_actloc),fn_decode(ims_keyban),fn_decode(ims_numcot),fn_decode(ims_bascal),fn_decode(ims_totpag),fn_decode(ims_keycia),fn_decode(ims_cveedi),fn_decode(ims_ca1aux),
fn_decode(ims_ca2aux),fn_decode(ims_ca3aux),fn_decode(ims_ca4aux),fn_decode(ims_franum),setregpat_imssenc.status ,setregpat_imssenc.code ,setregpat_imssenc.message ,
call setregpat_imssenc.fecha);
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
