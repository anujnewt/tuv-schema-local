create or replace procedure labprod.api_eocoplzas_seteocoplza ( id_transaccion varchar, plz_keyplz numeric, plz_keysol numeric, plz_keypro numeric, plz_keyest varchar, plz_keydep varchar, plz_keypue varchar, plz_keycen varchar, plz_keycat varchar, plz_keyloc varchar, plz_keyims varchar, plz_tipplz varchar, plz_tipcon varchar, plz_contra varchar, plz_fecini timestamp(0), plz_fecfin timestamp(0), plz_turnop numeric, plz_keyhor varchar, plz_keyemp numeric, plz_cveuoc numeric, plz_titula numeric, plz_cverem numeric, plz_status varchar, plz_keymot varchar, plz_fecmov timestamp(0), plz_hormov varchar, plz_cosplz numeric, plz_keysue varchar, plz_tiptab varchar, plz_sueniv numeric, plz_subniv numeric, plz_cobert varchar, plz_fecocu timestamp(0), plz_salplz numeric, plz_origen varchar, plz_codocu varchar, plz_limocu timestamp(0), plz_ca1aux varchar, plz_ca2aux varchar, plz_ca3aux varchar, plz_ca4aux varchar, plz_ca5aux varchar, plz_ca6aux varchar, plz_ca7aux varchar, plz_ca8aux varchar, status inout varchar, code inout varchar, message inout varchar, fecha inout timestamp(0) ) as $body$
declare
-- pgv moved types start
-- pgv moved types end
plaza numeric;
proceso numeric;
departamento numeric;
puesto numeric;
centrocosto numeric;
localidad numeric;
imss numeric;
empleado numeric;
emp_plz numeric;
categoria numeric;
estructura numeric;
tabulador numeric;
motivo numeric;
keyims varchar(5);
keycia varchar(5);
tipodato integer;
begin 

-- package does not have global variables
--dmap conversion comment: gtt declaration added
fecha := clock_timestamp();
keyims :=  null;
tipodato := null;
if id_transaccion = '0' then
status := 'OK';
code := '0';
message := 'PRUEBA DE SERVICIO';
else
--validaciones
code  := '1';
status := 'OK';
/*if length(plz_keyplz) > 38	then
message:= plz_keyplz longitud mayor a 38;
status := error;
code := 2;
end if;
if length(plz_keysol ) > 38	then
message:= plz_keysol  longitud mayor a 38;
status := error;
code := 2;
end if;
if length(plz_keypro) > 38	then
message:= plz_keypro longitud mayor a 38;
status := error;
code := 2;
end if;
*/
/*if length(plz_keyest) > 38	then
message:= plz_keyest longitud mayor a 3;
status := error;
code := 2;
end if;
*/
/*  if length(plz_keydep) > 16	then
message:= plz_keydep longitud mayor a 16;
status := error;
code := 2;
end if;
if length(plz_keypue) > 16	then
message:= plz_keypue longitud mayor a 16;
status := error;
code := 2;
end if;
if length(plz_keyims) > 14	then
message:= plz_keypue longitud mayor a 14;
status := error;
code := 2;
end if;
*/
select count(*) into strict proceso from labprod.nmloproc where pro_keypro = seteocoplza.plz_keypro;
if proceso  = 0 then
status := 'ERROR';
code := '001';
message := 'Proceso No existe';
end if;
select count(*) into strict departamento from labprod.nmcodeps where dep_keydep= seteocoplza.plz_keydep;
if departamento  = 0 then
status := 'ERROR';
code := '002';
message := 'Departamento No existe';
end if;
select count(*) into strict puesto from labprod.nmcopues where pue_keypue = seteocoplza.plz_keypue;
if puesto  = 0 then
status := 'ERROR';
code := '003';
message := 'Puesto No existe';
end if;
/*
select count(*) into centrocosto from labprod.nmlocenc where cen_keycen= seteocoplza.plz_keycen;
if centrocosto  = 0 then
status := error;
code := 004;
message := centro de costos no existe;
end if;
select count(*) into localidad from labprod.nmlolocp where loc_keyloc= seteocoplza.plz_keyloc;
if localidad  = 0 then
status := error;
code := 005;
message := localidad no existe;
end if;
*/
/*
select count(*) into imss from labprod.nmloimss where ims_keyims= seteocoplza.plz_keyims;
if imss  = 0 then
status := error;
code := 2;
message := imss no existe;
end if;
*/
/*select count(*) into categoria from labprod.nmlocate where cat_keycat= seteocoplza.plz_keycat;
if categoria  = 0 then
status := error;
code := 007;
message := categoria no existe;
end if;
*/
/*
if seteocoplza.plz_keyemp != 0 then
select count(*) into empleado from labprod.nmcoempl where emp_keyemp = seteocoplza.plz_keyemp;
if empleado = 0 then
status := error;
code := 008;
message := empleado no existe.;
end if;
end if;
*/
/*
select count(*) into estructura from labprod.eolodest where des_keyest = seteocoplza.plz_keyest;
if estructura = 0 then
status := error;
code := 2;
message := estructura no existe.;
end if;
*/
/*
select count(*) into motivo from labprod.glcopams where pam_keypar= mot and pam_cvesec =  seteocoplza.plz_keymot;
if motivo = 0 then
status := error;
code := 009;
message := motivo no existe.;
end if;
*/
-- imss:= null;
if nullif(plz_keyims::text, '') is not null then
select count(*) into strict imss  from labprod.nmloimss where nmloimss.ims_rfcims = seteocoplza.plz_keyims;
if imss = 0 then
status := 'ERROR';
code := '006';
message := 'Registro Patronal No existe.';
else
select ims_keyims into strict keyims from labprod.nmloimss where nmloimss.ims_rfcims = seteocoplza.plz_keyims;
end if;
end if;
if  code = '1' then
status := 'OK';
code := '3';
message := 'SE INSERT? CORRECTAMENTE EN STAGING ';/* dmap converted statement start */
perform dbms_output.put_line( concat(' ', call seteocoplza.plz_keyest )) ;/* dmap converted statement end */
insert into labprod.api_eocoplza(id_transaccion,plz_keyplz,plz_keysol,plz_keypro,plz_keyest,plz_keydep,plz_keypue,plz_keycen,plz_keycat,plz_keyloc,plz_keyims,plz_tipplz,plz_tipcon,plz_contra,plz_fecini,plz_fecfin,
plz_turnop,plz_keyhor,plz_keyemp,plz_cveuoc,plz_titula,plz_cverem,plz_status,plz_keymot,plz_fecmov,plz_hormov,plz_cosplz,plz_keysue,plz_tiptab,plz_sueniv,plz_subniv,plz_cobert,
plz_fecocu,plz_salplz,plz_origen,plz_codocu,plz_limocu,plz_ca1aux,plz_ca2aux,plz_ca3aux,plz_ca4aux,plz_ca5aux,plz_ca6aux,plz_ca7aux,plz_ca8aux,
estatus,code,message,fecha_insert)
values (seteocoplza.id_transaccion,seteocoplza.plz_keyplz,seteocoplza.plz_keysol,seteocoplza.plz_keypro,seteocoplza.plz_keyest,seteocoplza.plz_keydep,seteocoplza.plz_keypue,seteocoplza.plz_keycen,
call seteocoplza.plz_keycat,seteocoplza.plz_keyloc,seteocoplza.plz_keyims,seteocoplza.plz_tipplz,seteocoplza.plz_tipcon,seteocoplza.plz_contra,seteocoplza.plz_fecini,seteocoplza.plz_fecfin,
call seteocoplza.plz_turnop,seteocoplza.plz_keyhor,seteocoplza.plz_keyemp,seteocoplza.plz_cveuoc,seteocoplza.plz_titula,seteocoplza.plz_cverem,seteocoplza.plz_status,seteocoplza.plz_keymot,
call seteocoplza.plz_fecmov,seteocoplza.plz_hormov,seteocoplza.plz_cosplz,seteocoplza.plz_keysue,seteocoplza.plz_tiptab,seteocoplza.plz_sueniv,seteocoplza.plz_subniv,seteocoplza.plz_cobert,
call seteocoplza.plz_fecocu,seteocoplza.plz_salplz,seteocoplza.plz_origen,seteocoplza.plz_codocu,seteocoplza.plz_limocu,seteocoplza.plz_ca1aux,seteocoplza.plz_ca2aux,
call seteocoplza.plz_ca3aux,seteocoplza.plz_ca4aux,seteocoplza.plz_ca5aux,seteocoplza.plz_ca6aux,seteocoplza.plz_ca7aux,seteocoplza.plz_ca8aux,
status,code,message,fecha);
/* commit; */
select count(*) into strict plaza from labprod.eocoplza where  plz_keyplz = seteocoplza.plz_keyplz;
keycia:= seteocoplza.plz_keyest;
if nullif(keycia::text, '') is null or keycia = null then
select cia_keycia into strict keycia from labprod.nmloproc, labprod.nmlocias where pro_keypro = seteocoplza.plz_keypro and pro_keycia = cia_keycia;/* dmap converted statement start */
perform dbms_output.put_line( concat('2 ', keycia)  );/* dmap converted statement end */
end if;
if  plaza = 0 then
begin
insert into labprod.eocoplza(plz_keyplz,plz_keysol,plz_keypro,plz_keyest,plz_keydep,plz_keypue,plz_keycen,plz_keycat,plz_keyloc,plz_keyims,plz_tipplz,plz_tipcon,plz_contra,plz_fecini,plz_fecfin,
plz_turnop,plz_keyhor,plz_cveuoc,plz_titula,plz_cverem,plz_status,plz_keymot,plz_fecmov,plz_hormov,plz_cosplz,plz_keysue,plz_tiptab,plz_sueniv,plz_subniv,plz_cobert,
plz_fecocu,plz_salplz,plz_origen,plz_codocu,plz_limocu,plz_ca1aux,plz_ca2aux,plz_ca3aux,plz_ca4aux,plz_ca5aux,plz_ca6aux,plz_ca7aux,plz_ca8aux)
values (seteocoplza.plz_keyplz,seteocoplza.plz_keysol,seteocoplza.plz_keypro,keycia,seteocoplza.plz_keydep,seteocoplza.plz_keypue,seteocoplza.plz_keycen,
call seteocoplza.plz_keycat,seteocoplza.plz_keyloc,seteocoplza.keyims,seteocoplza.plz_tipplz,seteocoplza.plz_tipcon,seteocoplza.plz_contra,seteocoplza.plz_fecini,seteocoplza.plz_fecfin,
call seteocoplza.plz_turnop,seteocoplza.plz_keyhor,seteocoplza.plz_cveuoc,seteocoplza.plz_titula,seteocoplza.plz_cverem,seteocoplza.plz_status,seteocoplza.plz_keymot,
call seteocoplza.plz_fecmov,seteocoplza.plz_hormov,seteocoplza.plz_cosplz,seteocoplza.plz_keysue,seteocoplza.plz_tiptab,seteocoplza.plz_sueniv,seteocoplza.plz_subniv,seteocoplza.plz_cobert,
call seteocoplza.plz_fecocu,seteocoplza.plz_salplz,seteocoplza.plz_origen,seteocoplza.plz_codocu,seteocoplza.plz_limocu,seteocoplza.plz_ca1aux,seteocoplza.plz_ca2aux,
call seteocoplza.plz_ca3aux,seteocoplza.plz_ca4aux,seteocoplza.plz_ca5aux,seteocoplza.plz_ca6aux,seteocoplza.plz_ca7aux,seteocoplza.plz_ca8aux);
/* commit; */
status := 'OK';
code := '3';
message := 'Se proces? con ?xito';
update labprod.api_eocoplza set estatus=seteocoplza.status,code=seteocoplza.code,message=seteocoplza.message,fecha_proc=clock_timestamp()
where api_eocoplza.id_transaccion =seteocoplza.id_transaccion;
/* commit; */
exception when others then
status := 'ERROR';
code := sqlstate;
message := oracle.substr(sqlerrm, 1 , 150);
update labprod.api_eocoplza set estatus=seteocoplza.status,code=seteocoplza.code,message=seteocoplza.message,fecha_proc=clock_timestamp()
where api_eocoplza.id_transaccion =seteocoplza.id_transaccion;
/* commit; */
end;
end if;
if  plaza > 0 then
begin
update labprod.eocoplza set
eocoplza.plz_keyplz = seteocoplza.plz_keyplz, eocoplza.plz_keysol = seteocoplza.plz_keysol, eocoplza.plz_keypro = seteocoplza.plz_keypro,
eocoplza.plz_keyest = keycia ,
eocoplza.plz_keydep = seteocoplza.plz_keydep, eocoplza.plz_keypue = seteocoplza.plz_keypue,
eocoplza.plz_keycen = seteocoplza.plz_keycen, eocoplza.plz_keycat = seteocoplza.plz_keycat, eocoplza.plz_keyloc = seteocoplza.plz_keyloc,
eocoplza.plz_keyims = seteocoplza.keyims, eocoplza.plz_tipplz = seteocoplza.plz_tipplz, eocoplza.plz_tipcon = seteocoplza.plz_tipcon,
eocoplza.plz_contra = seteocoplza.plz_contra, eocoplza.plz_fecini = seteocoplza.plz_fecini, eocoplza.plz_fecfin = seteocoplza.plz_fecfin,
eocoplza.plz_turnop = seteocoplza.plz_turnop, eocoplza.plz_keyhor = seteocoplza.plz_keyhor,
eocoplza.plz_cveuoc = seteocoplza.plz_cveuoc, eocoplza.plz_titula = seteocoplza.plz_titula, eocoplza.plz_cverem = seteocoplza.plz_cverem,
eocoplza.plz_status = seteocoplza.plz_status, eocoplza.plz_keymot = seteocoplza.plz_keymot, eocoplza.plz_fecmov = seteocoplza.plz_fecmov,
eocoplza.plz_hormov = seteocoplza.plz_hormov, eocoplza.plz_cosplz = seteocoplza.plz_cosplz, eocoplza.plz_keysue = seteocoplza.plz_keysue,
eocoplza.plz_tiptab = seteocoplza.plz_tiptab, eocoplza.plz_sueniv = seteocoplza.plz_sueniv, eocoplza.plz_subniv = seteocoplza.plz_subniv,
eocoplza.plz_cobert = seteocoplza.plz_cobert, eocoplza.plz_fecocu = seteocoplza.plz_fecocu, eocoplza.plz_salplz = seteocoplza.plz_salplz,
eocoplza.plz_origen = seteocoplza.plz_origen, eocoplza.plz_codocu = seteocoplza.plz_codocu, eocoplza.plz_limocu = seteocoplza.plz_limocu,
eocoplza.plz_ca1aux = seteocoplza.plz_ca1aux, eocoplza.plz_ca2aux = seteocoplza.plz_ca2aux, eocoplza.plz_ca3aux = seteocoplza.plz_ca3aux,
eocoplza.plz_ca4aux = seteocoplza.plz_ca4aux, eocoplza.plz_ca5aux = seteocoplza.plz_ca5aux, eocoplza.plz_ca6aux = seteocoplza.plz_ca6aux,
eocoplza.plz_ca7aux = seteocoplza.plz_ca7aux, eocoplza.plz_ca8aux = seteocoplza.plz_ca8aux
where  eocoplza.plz_keyplz= seteocoplza.plz_keyplz;
/* commit; */
status := 'OK';
code := '3';
message := 'Se proces? con ?xito';
update labprod.api_eocoplza set estatus=seteocoplza.status,code=seteocoplza.code,message=seteocoplza.message,fecha_proc=clock_timestamp() where api_eocoplza.id_transaccion =seteocoplza.id_transaccion;
/* commit; */
exception when others then
status := 'ERROR';
code := sqlstate;
message := oracle.substr(sqlerrm, 1 , 150);
--update labprod.api_eocoplza set estatus=seteocoplza.status,code=seteocoplza.code,message=seteocoplza.message,fecha_proc=sysdate where api_eocoplza.id_transaccion =seteocoplza.id_transaccion;
/* commit; */
end;
end if;
delete from labprod.wesuperv where sup_keyemp = seteocoplza.plz_keyemp;
insert into labprod.wesuperv(sup_keysup,sup_keyemp) values (coalesce(seteocoplza.plz_cverem,0),coalesce(seteocoplza.plz_keyemp,0));
delete from labprod.wevaljef where val_keyemp = seteocoplza.plz_keyemp;
end if;
end if;end;
$body$
language plpgsql
;
