create or replace procedure feci."feci_obtener_rol_operacion_pr"  ( p_rol numeric ) as $body$
declare
-- pgv moved types start
-- pgv moved types end
feci_cursor refcursor;
begin
open feci_cursor for
select
oper.id_operacion,
oper.des_agrupador,
oper.cod_operacion,
oper.des_nombre,
oper.cod_tipo_operacion,
ro.id_rol
from feci_operacion_tab oper
left join feci_rol_operacion_tab ro on oper.id_operacion = ro.id_operacion
where ro.id_rol = p_rol and oper.ind_estado=1 and ro.ind_estado=1;
dbms_sql_return_result(feci_cursor);end;
$body$
language plpgsql
;
