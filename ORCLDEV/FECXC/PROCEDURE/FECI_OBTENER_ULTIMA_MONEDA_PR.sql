create or replace procedure fecxc."feci_obtener_ultima_moneda_pr"  ( p_anio numeric, p_tipo varchar ) as $body$
declare
-- pgv moved types start
-- pgv moved types end
feci_cursor refcursor;
v_query varchar(10000);
begin 

/* dmap converted statement start */
v_query :=  concat('SELECT COD_MONEDA, EXTRACT(YEAR FROM FEC_PRESUPUESTO) AS ANO, MAX(FEC_CREACION) AS FEC_CREACION, MAX(ID_USUARIO_CREACION) AS ID_USUARIO_CREACION, SUM(CASE WHEN COD_MONEDA in (', p_tipo , ') THEN NUM_IMPORTE ELSE 0 END) AS SUMA_NUM_IMPORTE, (SELECT DES_NOMBRES FROM FECI_USUARIO_TAB WHERE ID_USUARIO = (SELECT MAX(ID_USUARIO_CREACION) FROM FECI_PRESUPUESTO_TAB WHERE COD_MONEDA in (' , p_tipo , ') AND EXTRACT(YEAR FROM FEC_PRESUPUESTO) = (' , p_anio , ')::numeric ) ) AS DES_NOMBRES, (SELECT DES_APELLIDOS FROM FECI_USUARIO_TAB WHERE ID_USUARIO = (SELECT MAX(ID_USUARIO_CREACION) FROM FECI_PRESUPUESTO_TAB WHERE COD_MONEDA in (' , p_tipo , ') AND EXTRACT(YEAR FROM FEC_PRESUPUESTO) = (' , p_anio , ')::numeric ) ) AS DES_APELLIDOS, (SELECT DES_MONEDA FROM FECI_MONEDA_CAT WHERE COD_MONEDA = (SELECT MAX(COD_MONEDA) FROM FECI_PRESUPUESTO_TAB WHERE COD_MONEDA in (' , p_tipo , ') AND EXTRACT(YEAR FROM FEC_PRESUPUESTO) = (' , p_anio , ')::numeric ) ) AS DESC_MONEDA FROM FECI_PRESUPUESTO_TAB WHERE COD_MONEDA in (' , p_tipo , ') AND EXTRACT(YEAR FROM FEC_PRESUPUESTO) = (' , p_anio , ')::numeric GROUP BY COD_MONEDA, EXTRACT(YEAR FROM FEC_PRESUPUESTO)') ; /* dmap converted statement end *//* dmap converted statement */
open feci_cursor for execute v_query;
dbms_sql_return_result(feci_cursor);end;
$body$
language plpgsql
;
