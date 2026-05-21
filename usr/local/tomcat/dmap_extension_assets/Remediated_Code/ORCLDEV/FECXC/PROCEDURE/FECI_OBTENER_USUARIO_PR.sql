create or replace procedure fecxc."feci_obtener_usuario_pr"  ( email varchar, INOUT feci_cursors refcursor ) as $body$
declare
-- pgv moved types start
-- pgv moved types end

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
from fecxc.feci_usuario_tab u
join fecxc.feci_rol_tab r on u.id_rol = r.id_rol
where u.des_email = email and u.ind_estado=1;
end;
$body$
language plpgsql
;
