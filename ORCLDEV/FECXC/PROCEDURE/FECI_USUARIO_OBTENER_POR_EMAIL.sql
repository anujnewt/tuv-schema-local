create or replace procedure fecxc."feci_usuario_obtener_por_email"  ( email varchar ) as $body$
declare
-- pgv moved types start
-- pgv moved types end
feci_cursor refcursor;
rolid numeric;
begin 

select id_rol into strict rolid from feci_usuario_tab where des_email = email;
open feci_cursor for
select  id_operacion  ,des_agrupador,cod_operacion,des_nombre,cod_tipo_operacion
from feci_operacion_tab
where ind_estado = 1 and id_operacion in (select id_operacion from feci_rol_operacion_tab where id_rol = rolid and ind_estado = 1);
dbms_sql_return_result(feci_cursor);end;
$body$
language plpgsql
;
