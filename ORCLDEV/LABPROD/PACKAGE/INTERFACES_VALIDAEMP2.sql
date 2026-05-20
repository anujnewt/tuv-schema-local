create or replace procedure labprod.interfaces_validaemp2 ( emp_keyemp numeric,emp_keydep varchar,emp_keypue varchar,emp_keyloc varchar, emp_keycen varchar,emp_keyims varchar,emp_keypro varchar,emp_munemp varchar,emp_entemp varchar,emp_keyplz numeric, estatus inout varchar, code inout varchar, message inout varchar, fecha inout timestamp(0) ) as $body$
declare
-- pgv moved types start
-- pgv moved types end
--countemp numeric;
countdep numeric;
countpue numeric;
countloc numeric;
countcen numeric;
countims numeric;
countpro numeric;
countemp numeric;
countmun numeric;
countentemp numeric;
countplz numeric;
band numeric := 0;
begin 

-- package does not have global variables
--dmap conversion comment: gtt declaration added
estatus := 'OK';
code := '1';
message := 'Pendiente de validar';
fecha := clock_timestamp();
begin
if nullif(validaemp2.emp_entemp::text, '') is not null then
select count(*) into strict countentemp from labprod.glcopams where glcopams.pam_cvesec = validaemp2.emp_entemp and glcopams.pam_keypar='EF';
if countentemp = 0  then
/*update labprod.api_movimientosper set
estatus = 2,
code = error,
message = entidad federativa [string] no existe,
api_movimientosper.fecha_proc = sysdate
where api_movimientosper.id_transaccion = validaemp2.id_transaccion and api_movimientosper.code = ok;
*/
estatus := 'ERROR';
code := '5';/* dmap converted statement start */
message :=  concat('Entidad Federativa ', validaemp2.emp_entemp  , ' no existe') ;/* dmap converted statement end */
/* commit; */
end if;
end if;
exception when no_data_found then
begin
countentemp := 0;
end;
end;
begin
if nullif(validaemp2.emp_munemp::text, '') is not null then
select count(*) into strict countmun from labprod.glcopams where glcopams.pam_cvesec = validaemp2.emp_munemp and glcopams.pam_keypar='MU';
if countmun = 0  then
/*update labprod.api_movimientosper set
estatus = 2,
code = error,
message = municipio [string] no existe,
api_movimientosper.fecha_proc = sysdate
where api_movimientosper.id_transaccion = validaemp2.id_transaccion and api_movimientosper.code = ok;
*/
estatus := 'ERROR';
code := '5';/* dmap converted statement start */
message :=  concat('Municipio ', validaemp2.emp_munemp , ' no existe') ;/* dmap converted statement end */
/* commit; */
end if;
end if;
exception when no_data_found then
begin
countmun := 0;
end;
end;
begin
select count(*) into strict countdep from labprod.nmcodeps where nmcodeps.dep_keydep = validaemp2.emp_keydep;
if countdep = 0  then
/* update labprod.api_movimientosper set
estatus = 2,
code = error,
message = departamento [string] no existe,
api_movimientosper.fecha_proc = sysdate
where api_movimientosper.id_transaccion = validaemp2.id_transaccion and api_movimientosper.code = ok;
*/
estatus := 'ERROR';
code := '5';/* dmap converted statement start */
message :=  concat('Departamento ', validaemp2.emp_keydep , ' no existe') ;/* dmap converted statement end */
/* commit; */
end if;
exception when no_data_found then
begin
countdep := 0;
perform dbms_output.put_line('NO EXISTE DEPARTAMENTO');
end;
end;
begin
select count(*) into strict countpue from labprod.nmcopues where nmcopues.pue_keypue = validaemp2.emp_keypue;
if countpue = 0  then
/*update api_movimientosper set message = puesto [string] no existe,
api_movimientosper.estatus = 2, api_movimientosper.code=error,
api_movimientosper.fecha_proc = sysdate
where api_movimientosper.id_transaccion = validaemp2.id_transaccion and api_movimientosper.code = ok;
*/
estatus := 'ERROR';
code := '5';/* dmap converted statement start */
message :=  concat('Puesto ', validaemp2.emp_keypue , ' no existe') ;/* dmap converted statement end */
/* commit; */
end if;
exception when no_data_found then
begin
countpue := 0;
end;
end;
begin
select count(*) into strict countloc from nmlolocp where nmlolocp.loc_keyloc = validaemp2.emp_keyloc;
if countloc = 0  then
/*update labprod.api_movimientosper set message = localidad [string] no existe,
api_movimientosper.estatus = 2, api_movimientosper.code=error,
api_movimientosper.fecha_proc = sysdate
where api_movimientosper.id_transaccion = validaemp2.id_transaccion and api_movimientosper.code = ok;
*/
estatus := 'ERROR';
code := '5';/* dmap converted statement start */
message :=  concat('LOCALIDAD ', validaemp2.emp_keyloc , ' no existe') ;/* dmap converted statement end */
/* commit; */
end if;
exception when no_data_found then
begin
countloc := 0;
end;
end;
begin
select count(*) into strict countcen from labprod.nmlocenc where nmlocenc.cen_keycen = validaemp2.emp_keycen;
if countcen = 0  then
/*update labprod.api_movimientosper set message = centro de costos [string] no existe,
api_movimientosper.estatus = 2, api_movimientosper.code=error,
api_movimientosper.fecha_proc = sysdate
where api_movimientosper.id_transaccion = validaemp2.id_transaccion and api_movimientosper.code = ok;
*/
estatus := 'ERROR';
code := '5';/* dmap converted statement start */
message :=  concat('CENTRO DE COSTOS ', validaemp2.emp_keycen , ' no existe') ;/* dmap converted statement end */
/* commit; */
end if;
exception when no_data_found then
begin
countcen := 0;
end;
end;
begin
-- mandar el rfcimss para validad....
-- select count(*) into countims from labprod.nmloimss where nmloimss.ims_keyims = validaemp2.emp_keyims;
select count(*) into strict countims from labprod.nmloimss where nmloimss.ims_rfcims = validaemp2.emp_keyims;
if countims = 0  then
/*update api_movimientosper set message = imss [string] no existe,
api_movimientosper.estatus = 2, api_movimientosper.code=error ,
api_movimientosper.fecha_proc = sysdate
where api_movimientosper.id_transaccion = validaemp2.id_transaccion and api_movimientosper.code = ok;
*/
estatus := 'ERROR';
code := '5';/* dmap converted statement start */
message :=  concat('Registro Patronal IMSS ', validaemp2.emp_keyims , ' no existe ') ;/* dmap converted statement end */
/* commit; */
end if;
if countims > 1 then
estatus := 'ERROR';
code := '5';/* dmap converted statement start */
message :=  concat('RFC en Registro Patronal IMSS ', validaemp2.emp_keyims , ' Duplicado ') ;/* dmap converted statement end */
/* commit; */
end if;
exception when no_data_found then
begin
countims := 0;
end;
end;
begin
-- mandar el rfcimss para validad....
-- select count(*) into countims from labprod.nmloimss where nmloimss.ims_keyims = validaemp2.emp_keyims;
select count(*) into strict countplz from labprod.eocoplza where eocoplza.plz_keyplz = validaemp2.emp_keyplz;
if countplz = 0  then
/*update api_movimientosper set message = imss [string] no existe,
api_movimientosper.estatus = 2, api_movimientosper.code=error ,
api_movimientosper.fecha_proc = sysdate
where api_movimientosper.id_transaccion = validaemp2.id_transaccion and api_movimientosper.code = ok;
*/
estatus := 'ERROR';
code := '5';/* dmap converted statement start */
message :=  concat('PLAZA ', validaemp2.emp_keyplz , ' no existe') ;/* dmap converted statement end */
/* commit; */
end if;
exception when no_data_found then
begin
countims := 0;
end;
end;
begin
select count(*) into strict countpro from labprod.nmloproc where nmloproc.pro_keypro = validaemp2.emp_keypro;
if countpro = 0  then
/*update labprod.api_movimientosper set message = proceso [string] no existe,
api_movimientosper.estatus = 2, api_movimientosper.code=error,
api_movimientosper.fecha_proc = sysdate
where api_movimientosper.id_transaccion = validaemp2.id_transaccion and api_movimientosper.code = ok;
*/
estatus := 'ERROR';
code := '5';/* dmap converted statement start */
message :=  concat('Proceso ', validaemp2.emp_keypro , ' no existe') ;/* dmap converted statement end */
/* commit; */
end if;
exception when no_data_found then
begin
countpro := 0;
end;
end;end;
$body$
language plpgsql
;
