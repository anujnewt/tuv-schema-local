-- dmap_object_gen_tag : type : view name : xxchk_empresas_x_usuario
set search_path = fecxc,oracle,dmap_extension,public;/* dmap converted statement start */
create or replace view "xxchk_empresas_x_usuario"  ("id_rol", "e_codigo", "codusuario") as select distinct r.id_rol, re.e_codigo, codusuario
from    xxchk_roles r,
xxchk_roles_xempresa re,
xxchk_roles_x_usuario ru
where r.id_rol = re.id_rol
and	  r.id_rol = ru.id_rol
and	  re.id_rol= ru.id_rol;/* dmap converted statement end */
-- estimed cost of view [ xxchk_empresas_x_usuario ]: 1.00;
