create or replace procedure feci."feci_obtener_clase_cliente_pr"  () as $body$
declare
-- pgv moved types start
-- pgv moved types end
--feci_cursors refcursor;
feci_cursors refcursor;
begin
open feci_cursors for
select
id_clase_cliente,cod_clase_cliente,des_clase_cliente,fec_creacion,fec_ult_modificacion,fec_ult_modificacion,
id_usuario_creacion,id_usuario_ult_modif,ind_estado
from feci_clase_cliente_cat where  ind_estado =1;
dbms_sql.return_result(feci_cursors);end;
$body$
language plpgsql
;
