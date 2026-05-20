create or replace procedure labprod.dmap_sp_datosgenerales_aut  (cliente varchar,keyemp varchar, recurp nmcoempl.emp_recurp%type, nombre varchar, paterno varchar, materno varchar, domicilio varchar, colonia varchar, ciudad varchar, municipio varchar, entidad varchar, codigopostal varchar, telefono varchar, clavebanco varchar, cuentabanco varchar, salariomensual varchar, fechaingreso timestamp(0), tipopago varchar, metodopago varchar, tipocontrato varchar, proceso varchar, localidad varchar, status varchar, fecha timestamp(0)) as $body$
declare
-- pgv moved types start
-- pgv moved types end
-- pragma autonomous_transaction;
existe integer;
begin
begin
select count(*) into strict existe
from foempleadoslabora
where "numcliente" = cliente and "clave" = recurp and "numnomina" = keyemp;/* dmap converted statement start */
exception
when others then
insert into datosgenerales_errsaf values (keyemp, 'SELECT', clock_timestamp(),
concat(' SELECT COUNT(*) FROM FoEmpleadosLABORA where "NumCliente" = ', cliente , ' and "Clave" = ' , recurp , ' and "NumNomina" = ' , keyemp , ';  '
)) ;/* dmap converted statement end */
return;
end;
/* commit; */
if existe > 0  then
begin
update foempleadoslabora set
"nombre" = nombre, "appaterno" = paterno, "apmaterno" = materno, "domicilio" = domicilio, "colonia" = colonia,
"ciudad" = ciudad, "munidele" = municipio, "idestado" = entidad, "codpostal" = codigopostal, "telefono" = telefono,
"idbanco" = clavebanco, "clabe" = cuentabanco, "salario" = salariomensual, "fechaingreso" = fechaingreso, "idtipopago" = tipopago,
"metodopago" = metodopago, "idtipocontratacion" = tipocontrato, "idempresa" = proceso, "idubicacion" = localidad, "idestatus" = status,
"exito" = 'N', "fechasol" = fecha
where "numcliente" = cliente and "clave" = recurp and "numnomina" = keyemp;
exception
when others then
null;
end;
/* commit; */
else
begin
insert into foempleadoslabora values (' ', cliente, recurp, keyemp, nombre, paterno, materno, domicilio, colonia,
ciudad, municipio, entidad, codigopostal, telefono, clavebanco, cuentabanco, salariomensual, fechaingreso,
tipopago, metodopago, tipocontrato, proceso, localidad, status, 'N', fecha, fecha);
exception
when others then
null;
end;
/* commit; */
end if;end;
$body$
language plpgsql
;
CREATE OR REPLACE PROCEDURE labprod.sp_datosgenerales_aut(cliente varchar,keyemp varchar,recurp nmcoempl.emp_recurp%TYPE,nombre varchar,paterno varchar,materno varchar,domicilio varchar,colonia varchar,ciudad varchar,municipio varchar,entidad varchar,codigopostal varchar,telefono varchar,clavebanco varchar,cuentabanco varchar,salariomensual varchar,fechaingreso timestamp(0),tipopago varchar,metodopago varchar,tipocontrato varchar,proceso varchar,localidad varchar,status varchar,fecha timestamp(0)) 


AS

$$

DECLARE

v_sql text;

v_con_count int;

v_con_name text;

output1 text;

BEGIN

v_con_name := 'pragma_at_dmap_dblink';

SELECT count(1) INTO v_con_count FROM dblink_get_connections()

WHERE dblink_get_connections__>'{pragma_at_dmap_dblink}';


IF v_con_count = 0 THEN

    PERFORM dblink_connect(v_con_name, 'pragma_at_dmap_dblink');

END IF;


v_sql := FORMAT('CALL dmap_sp_datosgenerales_aut(cliente=> %L,keyemp=> %L,recurp=> %L,nombre=> %L,paterno=> %L,materno=> %L,domicilio=> %L,colonia=> %L,ciudad=> %L,municipio=> %L,entidad=> %L,codigopostal=> %L,telefono=> %L,clavebanco=> %L,cuentabanco=> %L,salariomensual=> %L,fechaingreso=> %L,tipopago=> %L,metodopago=> %L,tipocontrato=> %L,proceso=> %L,localidad=> %L,status=> %L,fecha=> %L)' , cliente,keyemp,recurp,nombre,paterno,materno,domicilio,colonia,ciudad,municipio,entidad,codigopostal,telefono,clavebanco,cuentabanco,salariomensual,fechaingreso,tipopago,metodopago,tipocontrato,proceso,localidad,status,fecha);


SELECT * INTO output1 FROM dblink(v_con_name, v_sql) AS t(result text);


END;

$$ LANGUAGE plpgsql;
CREATE OR REPLACE PROCEDURE labprod.sp_datosgenerales_aut(cliente varchar,keyemp varchar,recurp nmcoempl.emp_recurp%TYPE,nombre varchar,paterno varchar,materno varchar,domicilio varchar,colonia varchar,ciudad varchar,municipio varchar,entidad varchar,codigopostal varchar,telefono varchar,clavebanco varchar,cuentabanco varchar,salariomensual varchar,fechaingreso timestamp(0),tipopago varchar,metodopago varchar,tipocontrato varchar,proceso varchar,localidad varchar,status varchar,fecha timestamp(0)) 


AS

$$

DECLARE

v_sql text;

v_con_count int;

v_con_name text;

output1 text;

BEGIN

v_con_name := 'pragma_at_dmap_dblink';

SELECT count(1) INTO v_con_count FROM dblink_get_connections()

WHERE dblink_get_connections@>'{pragma_at_dmap_dblink}';


IF v_con_count = 0 THEN

    PERFORM dblink_connect(v_con_name, 'pragma_at_dmap_dblink');

END IF;


v_sql := FORMAT('CALL dmap_sp_datosgenerales_aut(cliente=> %L,keyemp=> %L,recurp=> %L,nombre=> %L,paterno=> %L,materno=> %L,domicilio=> %L,colonia=> %L,ciudad=> %L,municipio=> %L,entidad=> %L,codigopostal=> %L,telefono=> %L,clavebanco=> %L,cuentabanco=> %L,salariomensual=> %L,fechaingreso=> %L,tipopago=> %L,metodopago=> %L,tipocontrato=> %L,proceso=> %L,localidad=> %L,status=> %L,fecha=> %L)' , cliente,keyemp,recurp,nombre,paterno,materno,domicilio,colonia,ciudad,municipio,entidad,codigopostal,telefono,clavebanco,cuentabanco,salariomensual,fechaingreso,tipopago,metodopago,tipocontrato,proceso,localidad,status,fecha);


SELECT * INTO output1 FROM dblink(v_con_name, v_sql) AS t(result text);


END;

$$ LANGUAGE plpgsql;
