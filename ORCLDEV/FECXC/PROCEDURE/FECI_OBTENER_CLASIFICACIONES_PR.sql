create or replace procedure fecxc."feci_obtener_clasificaciones_pr"  ( p_empresa varchar default null, p_segmento varchar default null, p_fecha_inicio timestamp(0) default null, p_fecha_fin timestamp(0) default null, p_tipo_recibo varchar default null) as $body$
declare
-- pgv moved types start
-- pgv moved types end
feci_cursor refcursor;
v_query varchar(10000);
begin 

/* dmap converted statement start */
-- este procedimiento obtiene los recibos seg?n el estado especificado.
-- construir la consulta din?ca
v_query :=  concat('SELECT * FROM FECXC.FECI_CLASIFICACIONES_VW WHERE FEC_OPERATIVA >= TO_DATE(TO_CHAR(', p_fecha_inicio , ', ''YYYY-MM-DD''), ''YYYY-MM-DD'') AND FEC_OPERATIVA <= TO_DATE(TO_CHAR(' , p_fecha_fin , ', ''YYYY-MM-DD''), ''YYYY-MM-DD'')') ; /* dmap converted statement end *//* dmap converted statement start *//* dmap converted statement */
if nullif(p_tipo_recibo::text, '') is not null then
v_query :=  concat(v_query, ' AND TIPO_RECIBO IN (' , p_tipo_recibo , ')') ;/* dmap converted statement end */
end if;/* dmap converted statement start */
if nullif(p_empresa::text, '') is not null then
v_query :=  concat(v_query, ' AND COD_EMPRESA IN (' , p_empresa , ')') ;/* dmap converted statement end */
end if;/* dmap converted statement start */
if nullif(p_segmento::text, '') is not null then
v_query :=  concat(v_query, ' AND COD_SEGMENTO IN (' , p_segmento , ')') ;/* dmap converted statement end */
end if;
-- abre un cursor para ejecutar la consulta din?ca
open feci_cursor for execute v_query;
dbms_sql_return_result(feci_cursor);
perform dbms_output.put_line(v_query);
--dbms_output.put_line('Consulta generada: ' || v_query );
-- puedes agregar aqu?l manejo de excepciones, por ejemplo:
-- exception
--   when no_data_found then
--     dbms_output.put_line('No se encontraron datos.');
--   when others then
--     dbms_output.put_line('Error: ' || sqlerrm);
end;
$body$
language plpgsql
;
