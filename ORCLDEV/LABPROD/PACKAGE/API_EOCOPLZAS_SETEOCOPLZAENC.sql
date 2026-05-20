create or replace procedure labprod.api_eocoplzas_seteocoplzaenc ( id_transaccion varchar, plz_keyplz varchar, plz_keysol varchar, plz_keypro varchar, plz_keyest varchar, plz_keydep varchar, plz_keypue varchar, plz_keycen varchar, plz_keycat varchar, plz_keyloc varchar, plz_keyims varchar, plz_tipplz varchar, plz_tipcon varchar, plz_contra varchar, plz_fecini varchar, plz_fecfin varchar, plz_turnop varchar, plz_keyhor varchar, plz_keyemp varchar, plz_cveuoc varchar, plz_titula varchar, plz_cverem varchar, plz_status varchar, plz_keymot varchar, plz_fecmov varchar, plz_hormov varchar, plz_cosplz varchar, plz_keysue varchar, plz_tiptab varchar, plz_sueniv varchar, plz_subniv varchar, plz_cobert varchar, plz_fecocu varchar, plz_salplz varchar, plz_origen varchar, plz_codocu varchar, plz_limocu varchar, plz_ca1aux varchar, plz_ca2aux varchar, plz_ca3aux varchar, plz_ca4aux varchar, plz_ca5aux varchar, plz_ca6aux varchar, plz_ca7aux varchar, plz_ca8aux varchar, status inout varchar, code inout varchar, message inout varchar, fecha inout timestamp(0)) as $body$
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
select count(id_transaccion) into strict  existe  from labprod.api_eocoplza where api_eocoplza.id_transaccion = seteocoplzaenc.id_transaccion;
if existe != 0  then
status := 'ERROR';
code := '006';
message := 'ID_TRANSACCI?N DUPLICADO';
end if;
if nullif(plz_keyplz::text, '') is not null then
if f_is_int(fn_decode(plz_keyplz)) = 0 then
status := 'ERROR';
code := '006';
message := 'PLZ_KEYPLZ NO ES DE TIPO INT';
end if;
end if;
if nullif(plz_keysol::text, '') is not null then
if f_is_int(fn_decode(plz_keysol)) = 0 then
status := 'ERROR';
code := '006';
message := 'PLZ_KEYSOL NO ES DE TIPO INT';
end if;
end if;
if nullif(plz_keypro::text, '') is not null then
if f_is_int(fn_decode(plz_keypro)) = 0 then
status := 'ERROR';
code := '006';
message := 'PLZ_KEYPRO NO ES DE TIPO INT';
end if;
end if;
if nullif(plz_turnop::text, '') is not null then
if f_is_int(fn_decode(plz_turnop)) = 0 then
status := 'ERROR';
code := '006';
message := 'PLZ_TURNOP NO ES DE TIPO INT';
end if;
end if;
if nullif(plz_keyemp::text, '') is not null then
if f_is_int(fn_decode(plz_keyemp)) = 0 then
status := 'ERROR';
code := '006';
message := 'PLZ_KEYEMP NO ES DE TIPO INT';
end if;
end if;
if nullif(plz_cveuoc::text, '') is not null then
if f_is_int(fn_decode(plz_cveuoc)) = 0 then
status := 'ERROR';
code := '006';
message := 'PLZ_CVEUOC NO ES DE TIPO INT';
end if;
end if;
if nullif(plz_titula::text, '') is not null then
if f_is_int(fn_decode(plz_titula)) = 0 then
status := 'ERROR';
code := '006';
message := 'PLZ_TITULA NO ES DE TIPO INT';
end if;
end if;
if nullif(plz_cverem::text, '') is not null then
if f_is_int(fn_decode(plz_cverem)) = 0 then
status := 'ERROR';
code := '006';
message := 'PLZ_CVEREM NO ES DE TIPO INT';
end if;
end if;
if nullif(plz_cosplz::text, '') is not null then
if f_is_int(fn_decode(plz_cosplz)) = 0 then
status := 'ERROR';
code := '006';
message := 'PLZ_COSPLZ NO ES DE TIPO INT';
end if;
end if;
if nullif(plz_sueniv::text, '') is not null then
if f_is_int(fn_decode(plz_sueniv)) = 0 then
status := 'ERROR';
code := '006';
message := 'PLZ_SUENIV NO ES DE TIPO INT';
end if;
end if;
if nullif(plz_subniv::text, '') is not null then
if  f_is_int(fn_decode(plz_subniv)) = 0   then
status := 'ERROR';
code := '006';
message := 'PLZ_SUBNIV NO ES DE TIPO INT';
end if;
end if;
if nullif(plz_salplz::text, '') is not null then
if f_is_int(fn_decode(plz_salplz)) = 0 then
status := 'ERROR';
code := '006';
message := 'PLZ_SALPLZ NO ES DE TIPO INT';
end if;
end if;
if nullif(plz_fecini::text, '') is not null then
if isdate(fn_decode(plz_fecini),'YYYY-MM-DD') = 'FALSE' then
status := 'ERROR';
code := '006';
message := 'PLZ_FECINI NO ES UNA FECHA VALIDA';
end if;
end if;
if nullif(plz_fecfin::text, '') is not null then
if isdate(fn_decode(plz_fecfin),'YYYY-MM-DD') = 'FALSE' then
status := 'ERROR';
code := '006';
message := 'PLZ_FECFIN NO ES ES UNA FECHA VALIDA';
end if;
end if;
if nullif(plz_fecmov::text, '') is not null then
if isdate(fn_decode(plz_fecmov),'YYYY-MM-DD') = 'FALSE' then
status := 'ERROR';
code := '006';
message := 'PLZ_FECMOV NO ES ES UNA FECHA VALIDA';
end if;
end if;
if  nullif(plz_fecocu::text, '') is not null then
if isdate(fn_decode( plz_fecocu),'YYYY-MM-DD') = 'FALSE' then
status := 'ERROR';
code := '006';
message := ' PLZ_FECOCU NO ES ES UNA FECHA VALIDA';
end if;
end if;
if  nullif(plz_limocu::text, '') is not null then
if isdate(fn_decode( plz_limocu),'YYYY-MM-DD') = 'FALSE' then
status := 'ERROR';
code := '006';
message := ' PLZ_LIMOCU NO ES ES UNA FECHA VALIDA';
end if;
end if;
if code = 1 then
begin
call api_eocoplzas_seteocoplza(id_transaccion,fn_decode(plz_keyplz),fn_decode(plz_keysol),fn_decode(plz_keypro),fn_decode(plz_keyest),fn_decode(plz_keydep),fn_decode(plz_keypue),fn_decode(plz_keycen),
fn_decode(plz_keycat),fn_decode(plz_keyloc),fn_decode(plz_keyims),fn_decode(plz_tipplz),fn_decode(plz_tipcon),fn_decode(plz_contra),to_timestamp(fn_decode(plz_fecini),'YYYY-MM-DD'),
to_timestamp(fn_decode(plz_fecfin),'YYYY-MM-DD') ,fn_decode(plz_turnop) ,fn_decode(plz_keyhor) ,fn_decode(plz_keyemp) ,fn_decode(plz_cveuoc) ,fn_decode(plz_titula) ,fn_decode(plz_cverem) ,
fn_decode(plz_status) ,fn_decode(plz_keymot) ,to_timestamp(fn_decode(plz_fecmov),'YYYY-MM-DD'),fn_decode(plz_hormov) ,fn_decode(plz_cosplz) ,fn_decode(plz_keysue) ,fn_decode(plz_tiptab) ,
fn_decode(plz_sueniv) ,fn_decode(plz_subniv) ,fn_decode(plz_cobert) ,to_timestamp(fn_decode(plz_fecocu),'YYYY-MM-DD'),fn_decode(plz_salplz) ,fn_decode(plz_origen) ,fn_decode(plz_codocu) ,
to_timestamp(fn_decode(plz_limocu),'YYYY-MM-DD'),fn_decode(plz_ca1aux) ,fn_decode(plz_ca2aux) ,fn_decode(plz_ca3aux) ,fn_decode(plz_ca4aux) ,fn_decode(plz_ca5aux) ,fn_decode(plz_ca6aux) ,
fn_decode(plz_ca7aux) ,fn_decode(plz_ca8aux) ,seteocoplzaenc.status ,seteocoplzaenc.code ,seteocoplzaenc.message ,seteocoplzaenc.fecha);
exception when others then
code := sqlstate;
message := sqlerrm;
status :='ERROR';
end;
end if;
end if;end;
$body$
language plpgsql
;
