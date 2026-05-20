create or replace procedure feci."feci_obtener_reporte_multiplataforma"  ( p_ano1 numeric, p_mes numeric, p_dia numeric, p_moneda_column_name varchar, p_segmento varchar default null --p_segmento in varchar2 default 'MULTF'
) as $body$
declare
-- pgv moved types start
-- pgv moved types end
v_sql_query varchar(4000);
feci_cursor refcursor;
v_segmento_condition varchar(1000);
p_resultado refcursor;
begin
/* dmap converted statement start */
if nullif(p_segmento::text, '') is not null then
v_segmento_condition :=  concat('and cod_segmento in (''', p_segmento , ''')') ;/* dmap converted statement end */
else
v_segmento_condition:= null;
end if;/* dmap converted statement start */
-- construir la consulta din?ca
v_sql_query :=  concat('with pivotdata as ( select * from crosstab ( $$ select 1 as row_id,clase_cliente, cod_concepto, des_concepto, cod_segmento, des_segmento, to_char(fec_operativa, ''yyyy-mm'') as anio_mes, to_char(fec_operativa, ''yyyy'') as anio, ', p_moneda_column_name , ' FROM FECI_CLASIFICACIONES_REP_VW WHERE TRUNC(FEC_OPERATIVA) BETWEEN TO_DATE(TO_CHAR(' , p_ano1 , ' -01-01''), ''yyyy-mm-dd'') and to_date(to_char(' , p_ano1 , ' - ' , p_mes , ' - ' , p_dia , '), ''yyyy-mm-dd'') ' , v_segmento_condition , ' GROUP BY ANIO_MES  ORDER BY  ANIO_MES $$, $$ VALUES $$ ) AS ctab ( ANIO_MES TEXT, TEXT, TEXT ) ) q1  ORDER BY  ANIO') ; /* dmap converted statement end *//* dmap converted statement */
-- ejecutar la consulta din?ca
open feci_cursor for execute v_sql_query;
dbms_sql_return_result(feci_cursor);
-- open p_resultado for v_sql_query;
--dbms_output.put_line('Consulta din?ca: ' || v_sql_query);
end;
$body$
language plpgsql
;
