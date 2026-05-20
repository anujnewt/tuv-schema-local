create or replace procedure feci."feci_obtener_grupo_forecast_pr"  () as $body$
declare
-- pgv moved types start
-- pgv moved types end
--feci_cursor refcursor;
feci_cursor refcursor;
begin
open feci_cursor for
select id_grupo_forecast,cod_grupo_forecast,des_grupo_forecast,
fec_creacion,fec_ult_modificacion,id_usuario_creacion,id_usuario_ult_modif,
ind_estado
from feci_grupo_forecast_cat where ind_estado =1;
dbms_sql.return_result(feci_cursor);end;
$body$
language plpgsql
;
