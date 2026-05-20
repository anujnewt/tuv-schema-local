create or replace procedure fecxc."feci_obtener_tipo_cambio_fecha_pr"  ( p_fecha timestamp(0) ) as $body$
declare
-- pgv moved types start
-- pgv moved types end
feci_cursor refcursor;
begin 

open feci_cursor for
select * from fecxc.feci_tipo_cambio_cat
where
fec_fecha_tc = to_timestamp(to_char(p_fecha, 'yyyy-MM-dd'),'yyyy-MM-dd')
and ind_estado =1;
dbms_sql_return_result(feci_cursor);end;
$body$
language plpgsql
;
