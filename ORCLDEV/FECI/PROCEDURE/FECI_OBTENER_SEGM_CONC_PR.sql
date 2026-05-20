create or replace procedure feci."feci_obtener_segm_conc_pr"  () as $body$
declare
-- pgv moved types start
-- pgv moved types end
--feci_cursor refcursor;
feci_cursor refcursor;
begin
open feci_cursor for
select
id_segmento,id_grupo_forecast,id_concepto,fec_creacion,
fec_ult_modificacion,id_usuario_ult_modif,ind_estado
from feci_segm_conc_cat where ind_estado =1;
dbms_sql.return_result(feci_cursor);end;
$body$
language plpgsql
;
