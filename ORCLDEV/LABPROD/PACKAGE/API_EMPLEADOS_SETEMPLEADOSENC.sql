create or replace procedure labprod.api_empleados_setempleadosenc ( id_transaccion varchar, id_origen varchar, emp_keyemp varchar, emp_keydep varchar, emp_keypue varchar, emp_keycen varchar, emp_keyloc varchar, emp_apepat varchar, emp_apemat varchar, emp_nombre varchar, emp_domemp varchar, emp_numext varchar, emp_numint varchar, emp_colemp varchar, emp_cidemp varchar, emp_munemp varchar, emp_entemp varchar, emp_codemp varchar, emp_telemp varchar, emp_regrfc varchar, emp_recurp varchar, emp_regims varchar, emp_cvesex varchar, emp_keyims varchar, emp_cvezon varchar, emp_keypro varchar, emp_tipemp varchar, emp_tipsal varchar, emp_status varchar, emp_salhor varchar, emp_saldia varchar, emp_salmes varchar, emp_forpag varchar, emp_ctaban varchar, emp_cvebaj varchar, emp_fecaux varchar, emp_jorlab varchar, emp_unijor varchar, emp_ca2aux varchar, emp_fecven varchar, emp_fecpla varchar, emp_ca1aux varchar, emp_fecha_mov varchar, emp_fecha_imss varchar, emp_tipmov varchar, emp_submov varchar, emp_keyplz varchar, status inout varchar, code inout varchar, message inout varchar, fecha inout timestamp(0)) as $body$
declare
-- pgv moved types start
-- pgv moved types end
fecpla timestamp(0);
begin 

-- package does not have global variables
--dmap conversion comment: gtt declaration added
fecha := clock_timestamp();
if id_transaccion = 0 then
status := 'OK';
code := '0';
message := 'PRUEBA DE SERVICIO';
else
code := '1';
if nullif(emp_keyemp::text, '') is not null then
if f_is_int(fn_decode(emp_keyemp)) = 0 then
status := 'ERROR';
code := '3';
message := 'EMP_KEYEMP NO ES DE TIPO INT';
end if;
end if;
if nullif(emp_cvezon::text, '') is not null then
if f_is_int(fn_decode(emp_cvezon)) = 0 then
status := 'ERROR';
code := '3';
message := 'EMP_CVEZON NO ES DE TIPO INT';
end if;
end if;
if nullif(emp_keypro::text, '') is not null then
if f_is_int(fn_decode(emp_keypro)) = 0 then
status := 'ERROR';
code := '3';
message := 'EMP_KEYPRO NO ES DE TIPO INT';
end if;
end if;
if nullif(emp_status::text, '') is not null then
if f_is_int(fn_decode(emp_status)) = 0 then
status := 'ERROR';
code := '3';
message := 'EMP_STATUS NO ES DE TIPO INT';
end if;
end if;
if nullif(emp_salmes::text, '') is not null then
if f_is_int(fn_decode(emp_salmes)) = 0 then
status := 'ERROR';
code := '3';
message := 'EMP_SALMES NO ES DE TIPO INT';
end if;
end if;
if nullif(emp_saldia::text, '') is not null then
if f_is_int(fn_decode(emp_saldia)) = 0 then
status := 'ERROR';
code := '3';
message := 'EMP_SALDIA NO ES DE TIPO INT';
end if;
end if;
if nullif(emp_unijor::text, '') is not null then
if f_is_int(fn_decode(emp_unijor)) = 0 then
status := 'ERROR';
code := '3';
message := 'EMP_UNIJOR NO ES DE TIPO INT';
end if;
end if;
if  nullif(emp_fecaux::text, '') is not null then
if isdate(fn_decode( emp_fecaux),'YYYY-MM-DD') = 'FALSE' then
status := 'ERROR';
code := '3';
message := ' EMP_FECAUX NO ES ES UNA FECHA VALIDA';
end if;
end if;
if  nullif(emp_fecven::text, '') is not null then
if isdate(fn_decode( emp_fecven),'YYYY-MM-DD') = 'FALSE' then
status := 'ERROR';
code := '3';
message := ' EMP_FECVEN NO ES ES UNA FECHA VALIDA';
end if;
end if;
if  nullif(emp_fecpla::text, '') is not null then
if isdate(fn_decode( emp_fecpla),'YYYY-MM-DD') = 'FALSE' then
status := 'ERROR';
code := '3';
message := ' EMP_FECPLA NO ES ES UNA FECHA VALIDA';
end if;
end if;
if  nullif(emp_fecha_mov::text, '') is not null then
if isdate(fn_decode( emp_fecha_mov),'YYYY-MM-DD') = 'FALSE' then
status := 'ERROR';
code := '3';
message := ' EMP_FECHA_MOV NO ES ES UNA FECHA VALIDA';
end if;
end if;
if  nullif(emp_fecha_imss::text, '') is not null then
if isdate(fn_decode( emp_fecha_imss),'YYYY-MM-DD') = 'FALSE' then
status := 'ERROR';
code := '3';
message := ' EMP_FECHA_IMSS NO ES ES UNA FECHA VALIDA';
end if;
end if;
if  nullif(emp_tipmov::text, '') is null then
status := 'ERROR';
code := '3';
message := ' EMP_TIPMOV NO PUEDE SER NULL';
end if;
if  nullif(emp_submov::text, '') is null then
status := 'ERROR';
code := '3';
message := ' EMP_SUBMOV NO PUEDE SER NULL';
end if;
if  nullif(fn_decode(emp_fecha_imss)::text, '') is null then
status := 'ERROR';
code := '3';
message := ' EMP_FECHA_IMSS NO PUEDE SER NULL';
end if;
if  nullif(fn_decode(emp_fecha_mov)::text, '') is null then
status := 'ERROR';
code := '3';
message := ' EMP_FECHA_MOV NO PUEDE SER NULL';
end if;
if code = '1' then
begin
call api_empleados_setempleados(id_transaccion,fn_decode(id_origen),fn_decode(emp_keyemp) ,fn_decode(emp_keydep) ,fn_decode(emp_keypue) ,fn_decode(emp_keycen) ,fn_decode(emp_keyloc) ,fn_decode(emp_apepat) ,
fn_decode(emp_apemat) ,fn_decode(emp_nombre) ,fn_decode(emp_domemp) ,fn_decode(emp_numext) ,fn_decode(emp_numint) ,fn_decode(emp_colemp) ,fn_decode(emp_cidemp) ,
fn_decode(emp_munemp) ,fn_decode(emp_entemp) ,fn_decode(emp_codemp) ,fn_decode(emp_telemp) ,fn_decode(emp_regrfc) ,fn_decode(emp_recurp) ,fn_decode(emp_regims) ,
fn_decode(emp_cvesex) ,fn_decode(emp_keyims) ,fn_decode(emp_cvezon) ,fn_decode(emp_keypro) ,fn_decode(emp_tipemp) ,fn_decode(emp_tipsal) ,fn_decode(emp_status) ,
fn_decode(emp_salhor) ,fn_decode(emp_saldia) ,fn_decode(emp_salmes) ,fn_decode(emp_forpag) ,fn_decode(emp_ctaban) ,fn_decode(emp_cvebaj) ,to_timestamp(fn_decode(emp_fecaux),'YYYY-MM-DD') ,
fn_decode(emp_jorlab) ,fn_decode(emp_unijor) ,fn_decode(emp_ca2aux) ,to_timestamp(fn_decode(emp_fecven),'YYYY-MM-DD'),to_timestamp(fn_decode(emp_fecpla),'YYYY-MM-DD'),
fn_decode(emp_ca1aux) ,to_timestamp(fn_decode(emp_fecha_mov),'YYYY-MM-DD'),to_timestamp(fn_decode(emp_fecha_imss),'YYYY-MM-DD'),fn_decode(emp_tipmov) ,fn_decode(emp_submov) ,
fn_decode(emp_keyplz),setempleadosenc.status ,setempleadosenc.code ,setempleadosenc.message ,setempleadosenc.fecha);
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
