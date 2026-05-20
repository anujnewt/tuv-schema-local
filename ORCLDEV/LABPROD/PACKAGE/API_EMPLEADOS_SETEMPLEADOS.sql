create or replace procedure labprod.api_empleados_setempleados ( id_transaccion varchar, id_origen varchar, emp_keyemp numeric, emp_keydep varchar, emp_keypue varchar, emp_keycen varchar, emp_keyloc varchar, emp_apepat varchar, emp_apemat varchar, emp_nombre varchar, emp_domemp varchar, emp_numext varchar, emp_numint varchar, emp_colemp varchar, emp_cidemp varchar, emp_munemp varchar, emp_entemp varchar, emp_codemp varchar, emp_telemp varchar, emp_regrfc varchar, emp_recurp varchar, emp_regims varchar, emp_cvesex varchar, emp_keyims varchar, emp_cvezon numeric, emp_keypro numeric, emp_tipemp varchar, emp_tipsal varchar, emp_status numeric, emp_salhor numeric, emp_saldia numeric, emp_salmes numeric, emp_forpag varchar, emp_ctaban varchar, emp_cvebaj varchar, emp_fecaux timestamp(0), emp_jorlab varchar, emp_unijor numeric, emp_ca2aux varchar, emp_fecven timestamp(0), emp_fecpla timestamp(0), emp_ca1aux varchar, emp_fecha_mov timestamp(0), emp_fecha_imss timestamp(0), emp_tipmov varchar, emp_submov varchar, emp_keyplz numeric, status inout varchar, code inout varchar, message inout varchar, fecha inout timestamp(0) ) as $body$
declare
-- pgv moved types start
-- pgv moved types end
band numeric;
domicilio varchar(100);
nombrecomp varchar(60);
emp_keyempband numeric;
estatus numeric;
movimientos numeric;
codevalida numeric;
codevalida2 numeric;
stemp numeric;
stmov varchar(3);
stsub varchar(3);
salmes  numeric;
apemat varchar(60);
keyempstgn numeric;
begin 

-- package does not have global variables
--dmap conversion comment: gtt declaration added
fecha := clock_timestamp();
stemp := 0;
salmes := setempleados.emp_salmes;
if id_transaccion = 0 then
status := 'OK';
code := '0';
message := 'PRUEBA DE SERVICIO';
else
code :='1';
codevalida:='1';
codevalida2:='1';
apemat := setempleados.emp_apemat;
select count(*) into strict emp_keyempband from labprod.nmcoempl where nmcoempl.emp_keyemp = setempleados.emp_keyemp;
select count(*) into strict keyempstgn from labprod.api_movimientosper where
api_movimientosper.estatus  in ('1','4','5') and  api_movimientosper.emp_keyemp  = setempleados.emp_keyemp and api_movimientosper.emp_tipmov = '1';
if emp_keyempband = '1' then
select nmcoempl.emp_status into strict estatus  from labprod.nmcoempl where nmcoempl.emp_keyemp = setempleados.emp_keyemp;
end if;
if emp_keyempband = '0' then
estatus:='0';
end if;
select count(*) into strict movimientos from labprod.api_movimientosper where id_transaccion = setempleados.id_transaccion;
-- valida si existe una alta en stagin y si existe el empleado en laborad
call interfaces_validaemp(emp_tipmov,emp_submov,status,codevalida,message,fecha);
if  codevalida = '1' then
code := '1';
else
code := codevalida;
status := status;
message := message;
end if;
if code = '1' then
call interfaces_validaemp2(emp_keyemp,emp_keydep,emp_keypue ,emp_keyloc ,emp_keycen,emp_keyims,emp_keypro ,emp_munemp ,emp_entemp,emp_keyplz,
status,code,message ,fecha );
end if;
if emp_keyempband = 1 and  setempleados.emp_tipmov = '1' then
message:= 'EL EMPLEADO YA EXISTE EN LABORA';
status := 'ERROR';
code := '3';
end if;
if keyempstgn >= 1 and  setempleados.emp_tipmov = '1' then
message:= 'EL EMPLEADO YA SE ENCUENTRA EN STAGIN';
status := 'ERROR';
code := '3';
end if;
if nullif(emp_keydep::text, '') is null then
message:= 'EMP_KEYDEP  NO PUEDE SER NULL ';
status := 'ERROR';
code := '3';
end if;
if nullif(emp_jorlab::text, '') is null then
message:= 'EMP_JORLAB  NO PUEDE SER NULL ';
status := 'ERROR';
code := '3';
end if;
if nullif(emp_keypue::text, '') is null then
message:= 'EMP_KEYPUE  NO PUEDE SER NULL ';
status := 'ERROR';
code := '3';
end if;
if nullif(emp_keyloc::text, '') is null then
message:= 'EMP_KEYLOC  NO PUEDE SER NULL ';
status := 'ERROR';
code := '3';
end if;
if nullif(emp_keycen::text, '') is null then
message:= 'EMP_KEYCEN  NO PUEDE SER NULL ';
status := 'ERROR';
code := '3';
end if;
if nullif(emp_keyims::text, '') is null then
message:= 'EMP_KEYIMS  NO PUEDE SER NULL ';
status := 'ERROR';
code := '3';
end if;
if nullif(emp_regrfc::text, '') is null then
message:= 'EMP_REGRFC  NO PUEDE SER NULL ';
status := 'ERROR';
code := '3';
end if;
if nullif(emp_recurp::text, '') is null	then
message:= 'EMP_RECURP  NO PUEDE SER NULL';
status := 'ERROR';
code := '3';
end if;
if nullif(emp_regims::text, '') is null	then
message:= 'EMP_REGIMS  NO PUEDE SER NULL';
status := 'ERROR';
code := '3';
end if;
if nullif(emp_fecha_imss::text, '') is null then
message:= 'EMP_FECHA_IMSS  NO PUEDE SER NULL';
status := 'ERROR';
code := '3';
end if;
if length(emp_keyemp) > 10	then
message:= 'EMP_KEYEMP  LONGITUD MAYOR A 10 ';
status := 'ERROR';
code := '3';
end if;
if length(emp_keydep) > 16	then
message:= 'EMP_KEYDEP  LONGITUD MAYOR A 16 ';
status := 'ERROR';
code := '3';
end if;
if length(emp_keypue) > 16	then
message:= 'EMP_KEYPUE  LONGITUD MAYOR A 16 ';
status := 'ERROR';
code := '3';
end if;
if length(emp_keycen) > 16	then
message:= 'EMP_KEYCEN  LONGITUD MAYOR A 16 ';
status := 'ERROR';
code := '3';
end if;
if length(emp_keyloc) > 16	then
message:= 'EMP_KEYLOC  LONGITUD MAYOR A 16 ';
status := 'ERROR';
code := '3';
end if;
if length(emp_apepat) > 90	then
message:= 'EMP_APEPAT  LONGITUD MAYOR A 90';
status := 'ERROR';
code := '3';
end if;
if length(emp_apemat) > 90	then
message:= 'EMP_APEMAT  LONGITUD MAYOR A 90';
status := 'ERROR';
code := '3';
end if;
if apemat = 'X' or  apemat = '.' or apemat = 'x' then
apemat := null;
end if;
if length(emp_nombre) > 90	then
message:= 'EMP_NOMBRE  LONGITUD MAYOR A 90';
status := 'ERROR';
code := '3';
end if;
if length(emp_domemp) > 100	then
message:= 'EMP_DOMEMP  LONGITUD MAYOR A 100';
status := 'ERROR';
code := '3';
end if;
if length(emp_numext) > 10	then
message:= 'EMP_NUMEXT  LONGITUD MAYOR A 10';
status := 'ERROR';
code := '3';
end if;
if length(emp_numint) > 10	then
message:= 'EMP_NUMINT  LONGITUD MAYOR A 10';
status := 'ERROR';
code := '3';
end if;
if length(emp_colemp) > 100	then
message:= 'EMP_COLEMP  LONGITUD MAYOR A 100';
status := 'ERROR';
code := '3';
end if;
if length(emp_munemp) > 6	then
message:= 'EMP_MUNEMP  LONGITUD MAYOR A 6';
status := 'ERROR';
code := '3';
end if;
if length(emp_entemp) > 2	then
message:= 'EMP_ENTEMP  LONGITUD MAYOR A 2';
status := 'ERROR';
code := '3';
end if;
if length(emp_codemp) > 5	then
message:= 'EMP_CODEMP  LONGITUD MAYOR A 5';
status := 'ERROR';
code := '3';
end if;
if length(emp_telemp) > 60	then
message:= 'EMP_TELEMP  LONGITUD MAYOR A 60';
status := 'ERROR';
code := '3';
end if;
if length(emp_regrfc) > 13	then
message:= 'EMP_REGRFC  LONGITUD MAYOR A 13';
status := 'ERROR';
code := '3';
end if;
if length(emp_recurp) > 18	then
message:= 'EMP_RECURP  LONGITUD MAYOR A 18';
status := 'ERROR';
code := '3';
end if;
if length(emp_regims) > 12	then
message:= 'EMP_REGIMS  LONGITUD MAYOR A 12';
status := 'ERROR';
code := '3';
end if;
if length(emp_cvesex) > 1	then
message:= 'EMP_CVESEX  LONGITUD MAYOR A 1';
status := 'ERROR';
code := '3';
end if;
if length(emp_keyims) > 16	then
message:= 'EMP_KEYIMS  LONGITUD MAYOR A 16';
status := 'ERROR';
code := '3';
end if;
if length(emp_tipemp) > 6	then
message:= 'EMP_TIPEMP  LONGITUD MAYOR A 6';
status := 'ERROR';
code := '3';
end if;
if length(emp_tipsal) > 1	then
message:= 'EMP_TIPSAL  LONGITUD MAYOR A 1';
status := 'ERROR';
code := '3';
end if;
if length(emp_forpag) > 2	then
message:= 'EMP_FORPAG  LONGITUD MAYOR A 2';
status := 'ERROR';
code := '3';
end if;
if length(emp_ctaban) > 18	then
message:= 'EMP_CTABAN  LONGITUD MAYOR A 18';
status := 'ERROR';
code := '3';
end if;
if length(emp_cvebaj) > 4	then
message:= 'EMP_CVEBAJ  LONGITUD MAYOR A 4';
status := 'ERROR';
code := '3';
end if;
if length(emp_jorlab) > 1	then
message:= 'EMP_JORLAB  LONGITUD MAYOR A 1';
status := 'ERROR';
code := '3';
end if;
if length(emp_ca2aux) > 10	then
message:= 'EMP_CA2AUX  LONGITUD MAYOR A 10';
status := 'ERROR';
code := '3';
end if;
if length(emp_ca1aux) > 10	then
message:= 'EMP_CA1AUX  LONGITUD MAYOR A 10';
status := 'ERROR';
code := '3';
end if;
if length(emp_tipmov) > 2	then
message:= 'EMP_TIPMOV  LONGITUD MAYOR A 2';
status := 'ERROR';
code := '3';
end if;
if length(emp_submov) > 6	then
message:= 'EMP_SUBMOV  LONGITUD MAYOR A 6';
status := 'ERROR';
code := '2';
end if;
if emp_tipmov = '2'	then
if nullif(emp_cvebaj::text, '') is null then
message:= 'EMP_CVEBAJ  NO PUEDE SER NULL';
status := 'ERROR';
code := '3';
end if;
end if;
if  nullif(salmes::text, '') is null  then
salmes := 0;
end if;
if  movimientos > 0 then
status := 'ERROR';
code := '3';
message := 'ID_TRANSACCION DUPLICADO';
end if;
if code !='1' then
insert into labprod.api_movimientosper(id_transaccion,id_origen,emp_keyemp,emp_keydep,emp_keypue,emp_keycen,emp_keyloc,emp_apepat,emp_apemat,emp_nombre,emp_domemp,emp_numext,emp_numint,emp_colemp,emp_cidemp,emp_munemp,emp_entemp,emp_codemp,emp_telemp,emp_regrfc,emp_recurp,emp_regims,emp_cvesex,emp_keyims,emp_cvezon,emp_keypro,emp_tipemp,emp_tipsal,emp_status,emp_salhor,emp_saldia,emp_salmes,emp_forpag,emp_ctaban,emp_cvebaj,emp_fecaux,emp_jorlab,emp_unijor,emp_ca2aux,emp_fecven,emp_fecpla,emp_ca1aux,emp_fecha_mov,emp_fecha_imss,emp_tipmov,emp_submov,fecha_insert,fecha_proc,emp_salint,keyper,estatus,code,message,
emp_salivc,emp_salinf,emp_intsin,emp_infsin,emp_keyplz)
values (id_transaccion,id_origen,emp_keyemp,emp_keydep,emp_keypue,emp_keycen,emp_keyloc,emp_apepat,apemat,emp_nombre,emp_domemp,emp_numext,emp_numint,emp_colemp,emp_cidemp,emp_munemp,emp_entemp,emp_codemp,emp_telemp,emp_regrfc,emp_recurp,emp_regims,emp_cvesex,emp_keyims,emp_cvezon,emp_keypro,emp_tipemp,emp_tipsal,emp_status,emp_salhor,emp_saldia,salmes,emp_forpag,emp_ctaban,emp_cvebaj,emp_fecaux,emp_jorlab,emp_unijor,emp_ca2aux,emp_fecven,emp_fecpla,emp_ca1aux,emp_fecha_mov,emp_fecha_imss,emp_tipmov,emp_submov,clock_timestamp(),null,0,null,setempleados.code,setempleados.status,setempleados.message,
0,0,0,0,emp_keyplz);
/* commit; */
end if;
if code = '1' then
status := 'OK';
code := '1';
message := 'SE INSERT?? A STAGGING CON ??XITO';
begin
insert into labprod.api_movimientosper(id_transaccion,id_origen,emp_keyemp,emp_keydep,emp_keypue,emp_keycen,emp_keyloc,emp_apepat,emp_apemat,emp_nombre,emp_domemp,emp_numext,emp_numint,emp_colemp,emp_cidemp,emp_munemp,emp_entemp,emp_codemp,emp_telemp,emp_regrfc,emp_recurp,emp_regims,emp_cvesex,emp_keyims,emp_cvezon,emp_keypro,emp_tipemp,emp_tipsal,emp_status,emp_salhor,emp_saldia,emp_salmes,emp_forpag,emp_ctaban,emp_cvebaj,emp_fecaux,emp_jorlab,emp_unijor,emp_ca2aux,emp_fecven,emp_fecpla,emp_ca1aux,emp_fecha_mov,emp_fecha_imss,emp_tipmov,emp_submov,fecha_insert,fecha_proc,emp_salint,keyper,estatus,code,message,
emp_salivc,emp_salinf,emp_intsin,emp_infsin,emp_keyplz)
values (id_transaccion,id_origen,emp_keyemp,emp_keydep,emp_keypue,emp_keycen,emp_keyloc,emp_apepat,apemat,emp_nombre,emp_domemp,emp_numext,emp_numint,emp_colemp,emp_cidemp,emp_munemp,emp_entemp,emp_codemp,emp_telemp,emp_regrfc,emp_recurp,emp_regims,emp_cvesex,emp_keyims,emp_cvezon,emp_keypro,emp_tipemp,emp_tipsal,emp_status,emp_salhor,emp_saldia,salmes,emp_forpag,emp_ctaban,emp_cvebaj,emp_fecaux,emp_jorlab,emp_unijor,emp_ca2aux,emp_fecven,emp_fecpla,emp_ca1aux,emp_fecha_mov,emp_fecha_imss,emp_tipmov,emp_submov,clock_timestamp(),null,0,null,code,status,message,
0,0,0,0,emp_keyplz);
--agregado por ehc
if emp_tipmov = '2' then
insert into labprod.sccobaja(baj_keyemp,baj_status,baj_fecbaj,baj_fecims,baj_cvebaj,baj_cvemot,baj_perbaj,baj_feccap,baj_horcap,baj_keyusu,baj_idplz)
values (emp_keyemp,1,emp_fecha_mov,emp_fecha_mov,emp_submov,emp_cvebaj,'',clock_timestamp(),to_char(clock_timestamp(), 'HH24:MI:SS'),0,emp_keyplz);
end if;
/* commit; */
exception when others then
begin
status := 'ERROR';/* dmap converted statement start */
code :=  concat('ERR-ORA', sqlstate) ;/* dmap converted statement end */
message := oracle.substr(sqlerrm, 1 , 149);
end;
end;
end if;
end if;end;
$body$
language plpgsql
;
