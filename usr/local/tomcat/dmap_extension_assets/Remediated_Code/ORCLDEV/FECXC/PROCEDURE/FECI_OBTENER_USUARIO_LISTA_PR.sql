create or replace procedure fecxc."feci_obtener_usuario_lista_pr"  (INOUT feci_cursors refcursor) as $body$
declare
-- pgv moved types start
-- pgv moved types end
--feci_cursors refcursor;

begin 

open feci_cursors for
select
usr.id_usuario
,usr.id_rol
,usr.des_nombres
,usr.des_apellidos
,usr.des_email
,usr.ind_estado
,rol.nom_rol
,rol.cod_rol
,rol.id_rol
from feci_usuario_tab usr
join feci_rol_tab rol on usr.id_rol = rol.id_rol
where  usr.ind_estado=1;
end;
$body$
language plpgsql
;
