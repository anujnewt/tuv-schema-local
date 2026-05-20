create or replace procedure feci."feci_elimina_rol_pr"  ( p_id numeric, p_usuario numeric ) as $body$
declare
-- pgv moved types start
-- pgv moved types end
feci_cursors refcursor;
begin
update feci_rol_tab rol
set ind_estado = 0,
id_usuario_ult_modif = p_usuario,
fec_ult_modificacion = clock_timestamp()
where rol.id_rol = p_id
and not exists (
select 1
from feci_usuario_tab usr
where usr.id_rol = rol.id_rol
);
open feci_cursors for
select id_rol from feci_usuario_tab where id_rol =  p_id;
dbms_sql_return_result(feci_cursors);end;
$body$
language plpgsql
;
