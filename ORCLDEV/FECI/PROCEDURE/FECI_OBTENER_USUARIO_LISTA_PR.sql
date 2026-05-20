create or replace procedure feci."feci_obtener_usuario_lista_pr"  () as $body$
declare
-- pgv moved types start
-- pgv moved types end
--feci_cursors refcursor;
feci_cursors refcursor;
begin
open feci_cursors for
select
u.id_usuario
,u.id_rol
,u.des_nombres
,u.des_apellidos
,u.des_email
,r.nom_rol
,r.cod_rol
from feci_usuario_tab u
join feci_rol_tab r on u.id_rol = r.id_rol
where  u.ind_estado=1;
dbms_sql.return_result(feci_cursors);end;
$body$
language plpgsql
;
