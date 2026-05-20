CREATE OR REPLACE PROCEDURE labprod.tvautsaf_local_sp_datosgenerales_nc_aut(cliente varchar,keyemp varchar,recurp nmcoempl.emp_recurp%TYPE,nombre varchar,paterno varchar,materno varchar,domicilio varchar,colonia varchar,ciudad varchar,municipio varchar,entidad varchar,codigopostal varchar,telefono varchar,clavebanco varchar,cuentabanco varchar,salariomensual varchar,fechaingreso timestamp(0),tipopago varchar,metodopago varchar,tipocontrato varchar,proceso varchar,localidad varchar,status varchar,fecha timestamp(0)) 


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


v_sql := FORMAT('CALL dmap_tvautsaf_local_sp_datosgenerales_nc_aut(cliente=> %L,keyemp=> %L,recurp=> %L,nombre=> %L,paterno=> %L,materno=> %L,domicilio=> %L,colonia=> %L,ciudad=> %L,municipio=> %L,entidad=> %L,codigopostal=> %L,telefono=> %L,clavebanco=> %L,cuentabanco=> %L,salariomensual=> %L,fechaingreso=> %L,tipopago=> %L,metodopago=> %L,tipocontrato=> %L,proceso=> %L,localidad=> %L,status=> %L,fecha=> %L)' , cliente,keyemp,recurp,nombre,paterno,materno,domicilio,colonia,ciudad,municipio,entidad,codigopostal,telefono,clavebanco,cuentabanco,salariomensual,fechaingreso,tipopago,metodopago,tipocontrato,proceso,localidad,status,fecha);


SELECT * INTO output1 FROM dblink(v_con_name, v_sql) AS t(result text);


END;

$$ LANGUAGE plpgsql;
CREATE OR REPLACE PROCEDURE labprod.tvautsaf_local_sp_datosgenerales_nc_aut(cliente varchar,keyemp varchar,recurp nmcoempl.emp_recurp%TYPE,nombre varchar,paterno varchar,materno varchar,domicilio varchar,colonia varchar,ciudad varchar,municipio varchar,entidad varchar,codigopostal varchar,telefono varchar,clavebanco varchar,cuentabanco varchar,salariomensual varchar,fechaingreso timestamp(0),tipopago varchar,metodopago varchar,tipocontrato varchar,proceso varchar,localidad varchar,status varchar,fecha timestamp(0)) 


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


v_sql := FORMAT('CALL dmap_tvautsaf_local_sp_datosgenerales_nc_aut(cliente=> %L,keyemp=> %L,recurp=> %L,nombre=> %L,paterno=> %L,materno=> %L,domicilio=> %L,colonia=> %L,ciudad=> %L,municipio=> %L,entidad=> %L,codigopostal=> %L,telefono=> %L,clavebanco=> %L,cuentabanco=> %L,salariomensual=> %L,fechaingreso=> %L,tipopago=> %L,metodopago=> %L,tipocontrato=> %L,proceso=> %L,localidad=> %L,status=> %L,fecha=> %L)' , cliente,keyemp,recurp,nombre,paterno,materno,domicilio,colonia,ciudad,municipio,entidad,codigopostal,telefono,clavebanco,cuentabanco,salariomensual,fechaingreso,tipopago,metodopago,tipocontrato,proceso,localidad,status,fecha);


SELECT * INTO output1 FROM dblink(v_con_name, v_sql) AS t(result text);


END;

$$ LANGUAGE plpgsql;
