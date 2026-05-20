create or replace procedure feci."feci_obtener_recibos_pr"  ( p_ver varchar, p_fecha_inicio timestamp(0), p_fecha_fin timestamp(0), p_tipo_recibo varchar default null, p_empresa text default null, p_folio_inicial varchar default null, p_folio_final varchar default null, p_clase_cliente text default null) as $body$
declare
-- pgv moved types start
-- pgv moved types end
feci_cursor refcursor;
v_query varchar(10000);
begin
/* dmap converted statement start */
-- este procedimiento obtiene los recibos seg?n el estado especificado.
-- construir la consulta din?ca
v_query :=  concat('SELECT FOLIO_RECIBO, TIPO_RECIBO, FEC_CONTABILIDAD, FEC_OPERATIVA, IMPORTE, COD_MONEDA, DES_MONEDA, COD_EMPRESA, DES_EMPRESA, COD_CLIENTE, REF_CLIENTE, NOM_CLIENTE, CLASE_CLIENTE, METODO_PAGO, NOM_BANCO_EMISOR, NUM_CHEQUERA, NUM_CHEQUE, NUM_OPERACION, TIPO_CAMBIO_ORIGEN, FEC_TC_ORIGEN, TIPO_CAMBIO_DOLAR, FEC_TC_DOLAR, ID_USUARIO_CLASIFICACION, FEC_CLASIFICACION, ID_USUARIO_APLICACION, FEC_APLICACION, COD_ESTADO_RECIBO, FEC_CREACION, FEC_ULT_MODIFICACION, ID_USUARIO_CREACION, ID_USUARIO_ULT_MODIF, IND_ESTADO, FEC_DEPOSITO FROM FECI_RECIBOS_VW WHERE COD_ESTADO_RECIBO IN ( ', p_ver , ' )') ; /* dmap converted statement end *//* dmap converted statement start *//* dmap converted statement */
if nullif(p_fecha_inicio::text, '') is not null then
if nullif(p_fecha_fin::text, '') is not null then
v_query :=  concat(v_query, '  and fec_operativa >= to_date(''' , to_char(p_fecha_inicio, 'YYYY-MM-DD') , ''', ''yyyy-mm-dd'')
and fec_operativa <= to_date(''' , to_char(p_fecha_fin, 'YYYY-MM-DD') , ''', ''yyyy-mm-dd'')') ;/* dmap converted statement end */
end if;
end if;/* dmap converted statement start */
if nullif(p_tipo_recibo::text, '') is not null then
v_query :=  concat(v_query, ' AND TIPO_RECIBO IN (' , p_tipo_recibo , ')') ;/* dmap converted statement end */
end if;/* dmap converted statement start */
if nullif(p_empresa::text, '') is not null then
v_query :=  concat(v_query, ' AND COD_EMPRESA IN (' , p_empresa , ')') ;/* dmap converted statement end */
end if;/* dmap converted statement start */
if nullif(p_folio_inicial::text, '') is not null  then
if  nullif(p_folio_final::text, '') is not null then
if p_folio_inicial =  p_folio_final then
v_query :=  concat(v_query, ' and folio_recibo =''' , p_folio_inicial , '''') ;/* dmap converted statement end *//* dmap converted statement start */
else
v_query :=  concat(v_query, ' and folio_recibo between ''' , p_folio_inicial , ''' and ''' , p_folio_final , '''') ;/* dmap converted statement end */
end if;/* dmap converted statement start */
else
v_query :=  concat(v_query, ' and folio_recibo =''' , p_folio_inicial , '''') ;/* dmap converted statement end */
end if;
end if;/* dmap converted statement start */
if nullif(p_clase_cliente::text, '') is not null  then
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
