create or replace procedure fecxc."feci_obtener_recibos_pr2"  ( entrada varchar, p_fecha_inicio timestamp(0), p_fecha_fin timestamp(0), p_empresa varchar default null, p_folio_inicial numeric default null, p_folio_final numeric default null, p_clase_cliente varchar default null) as $body$
declare
-- pgv moved types start
-- pgv moved types end
feci_cursor refcursor;
v_query varchar(10000);
begin 

/* dmap converted statement start */
-- este procedimiento obtiene los recibos seg?n el estado especificado.
-- construir la consulta din?ca
v_query :=  concat('SELECT * FROM FECXC.FECI_RECIBOS_VW WHERE COD_ESTADO_RECIBO IN (', entrada , ') AND FEC_OPERATIVA >= TO_DATE(TO_CHAR(' , p_fecha_inicio , ', ''YYYY-MM-DD''), ''YYYY-MM-DD'') AND FEC_OPERATIVA <= TO_DATE(TO_CHAR(' , p_fecha_fin , ', ''YYYY-MM-DD''), ''YYYY-MM-DD'')') ; /* dmap converted statement end *//* dmap converted statement start *//* dmap converted statement */
if nullif(p_empresa::text, '') is not null then
v_query :=  concat(v_query, ' AND COD_EMPRESA IN (' , p_empresa , ')') ;/* dmap converted statement end */
end if;/* dmap converted statement start */
if nullif(p_folio_inicial::text, '') is not null  then
if  nullif(p_folio_final::text, '') is not null then
v_query :=  concat(v_query, ' AND FOLIO_RECIBO BETWEEN  ', p_folio_inicial , ' AND ', p_folio_final , '') ;/* dmap converted statement end */
end if;
end if;/* dmap converted statement start */
if nullif(p_folio_inicial::text, '') is not null  then
v_query :=  concat(v_query, ' AND CLASE_CLIENTE IN (' , p_clase_cliente , ')') ;/* dmap converted statement end */
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
