create or replace procedure fecxc."feci_regresa_tipo_cambio_recibo_pr"  ( p_recibo numeric, p_tipo varchar ) as $body$
declare
-- pgv moved types start
-- pgv moved types end
feci_cursors refcursor;
begin 

open feci_cursors for
select tipo_cambio_origen,tipo_cambio_dolar
from fecxc.feci_recibos_vw
where folio_recibo = p_recibo and tipo_recibo = p_tipo;
dbms_sql_return_result(feci_cursors);end;
$body$
language plpgsql
;
