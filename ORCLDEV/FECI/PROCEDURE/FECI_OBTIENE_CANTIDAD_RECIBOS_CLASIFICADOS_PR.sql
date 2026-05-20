create or replace procedure feci."feci_obtiene_cantidad_recibos_clasificados_pr"  () as $body$
declare
-- pgv moved types start
-- pgv moved types end
--feci_cursor refcursor;
feci_cursor refcursor;
begin
-- utiliza la variable p_contador para almacenar el conteo
open feci_cursor for
select count(*) as cantidad
from feci_recibos_vw
where cod_estado_recibo = 'CLSF';
dbms_sql.return_result(feci_cursor);end;
$body$
language plpgsql
;
