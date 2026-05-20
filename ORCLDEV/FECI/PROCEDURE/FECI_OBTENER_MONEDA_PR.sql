create or replace procedure feci."feci_obtener_moneda_pr"  () as $body$
declare
-- pgv moved types start
-- pgv moved types end
--feci_cursor refcursor;
feci_cursor refcursor;
begin
open feci_cursor for
select id_moneda,cod_moneda,des_moneda,fec_creacion,
fec_ult_modificacion,id_usuario_creacion,id_usuario_ult_modif,
ind_estado
from feci_moneda_cat where ind_estado =1;
dbms_sql.return_result(feci_cursor);end;
$body$
language plpgsql
;
