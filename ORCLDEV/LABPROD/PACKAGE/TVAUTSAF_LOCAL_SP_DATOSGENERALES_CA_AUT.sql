create or replace procedure labprod.dmap_tvautsaf_local_sp_datosgenerales_ca_aut (cliente varchar,keyemp varchar, recurp nmcoempl.emp_recurp%type, nombre varchar, paterno varchar, materno varchar, domicilio varchar, colonia varchar, ciudad varchar, municipio varchar, entidad varchar, codigopostal varchar, telefono varchar, clavebanco varchar, cuentabanco varchar, salariomensual varchar, fechaingreso timestamp(0), tipopago varchar, metodopago varchar, tipocontrato varchar, proceso varchar, localidad varchar, status varchar, fecha timestamp(0)) as $body$
declare
-- pgv moved types start
-- pgv moved types end
-- pragma autonomous_transaction;
existe_curp integer;
existe_empleado integer;
--dmap conversion comment: global temp variables moved as local temp variables
total_temp integer;
banco_temp varchar;
bandera_temp integer;
nombre__temp varchar;
--dmap conversion comment: declaration boundary ends
begin 

call dmap_extension.pkg_var_dmap_tab_to_gtt_init('LABPROD', 'TVAUTSAF_LOCAL');
--dmap conversion comment: gtt declaration added
begin
select 	count(*)
into strict 		existe_empleado
from 		saf_dgca
where 	"numcliente" = cliente
and  		"numnomina" = keyemp;
exception
when others then
insert into labprod.datosgenerales_errsaf values (keyemp, 'SELECT', clock_timestamp(),
' SELECT COUNT(*) FROM SAF_DGCA cliente, empleado '
);
existe_empleado := 0;
/* commit; */
end;
begin
select count(*) into strict existe_curp
from saf_dgca
where "numcliente" = cliente and "clave" = recurp;
exception
when others then
insert into labprod.datosgenerales_errsaf values (keyemp, 'SELECT', clock_timestamp(),
' SELECT COUNT(*) FROM SAF_DGCA cliente, curp'
);
existe_curp := 0;
/* commit; */
end;
if existe_empleado > 0  then
begin
update	saf_dgca
set			"clave" = recurp,
"nombre" = nombre, "appaterno" = paterno, "apmaterno" = materno, "domicilio" = domicilio, "colonia" = colonia,
"ciudad" = ciudad, "munidele" = municipio, "idestado" = entidad, "codpostal" = codigopostal, "telefono" = telefono,
"idbanco" = clavebanco, "clabe" = cuentabanco, "salario" = salariomensual, "fechaingreso" = fechaingreso, "idtipopago" = tipopago,
"metodopago" = metodopago, "idtipocontratacion" = tipocontrato, "idempresa" = proceso, "idubicacion" = localidad, "idestatus" = status,
"exito" = 'N', "fechasol" = fecha
where		"numcliente" = cliente
and			"numnomina" = keyemp;
exception
when others then
insert into labprod.datosgenerales_errsaf values (keyemp, 'UP_CAJ', clock_timestamp(),
' existe empleado > 0'
);
end;
/* commit; */
else
if existe_curp > 0  then
begin
update saf_dgca set "numnomina" = keyemp,
"nombre" = nombre, "appaterno" = paterno, "apmaterno" = materno, "domicilio" = domicilio, "colonia" = colonia,
"ciudad" = ciudad, "munidele" = municipio, "idestado" = entidad, "codpostal" = codigopostal, "telefono" = telefono,
"idbanco" = clavebanco, "clabe" = cuentabanco, "salario" = salariomensual, "fechaingreso" = fechaingreso, "idtipopago" = tipopago,
"metodopago" = metodopago, "idtipocontratacion" = tipocontrato, "idempresa" = proceso, "idubicacion" = localidad, "idestatus" = status,
"exito" = 'N', "fechasol" = fecha
where "numcliente" = cliente and "clave" = recurp;
exception
when others then
insert into labprod.datosgenerales_errsaf values (keyemp, 'UP_CAJ', clock_timestamp(),
' existe curp > 0'
);
end;
/* commit; */
else
begin
insert into saf_dgca values (' ', cliente, recurp, keyemp, nombre, paterno, materno, domicilio, colonia,
ciudad, municipio, entidad, codigopostal, telefono, clavebanco, cuentabanco, salariomensual, fechaingreso,
tipopago, metodopago, tipocontrato, proceso, localidad, status, 'N', fecha, fecha);
exception
when others then
null;
end;
/* commit; */
end if;
end if;end;
$body$
language plpgsql
;
