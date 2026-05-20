create or replace procedure fecxc."feci_obtener_clasificacion_pr"  ( p_folio_recibo numeric, p_tipo_recibo varchar ) as $body$
declare
-- pgv moved types start
-- pgv moved types end
feci_cursor refcursor;
begin 

open feci_cursor for
select * from fecxc.feci_clasificacion_tab
where folio_recibo = p_folio_recibo
and tipo_recibo = p_tipo_recibo
and ind_estado = 1;
dbms_sql_return_result(feci_cursor);end;
$body$
language plpgsql
;
