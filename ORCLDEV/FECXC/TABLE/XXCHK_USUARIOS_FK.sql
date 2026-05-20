-- dmap_object_gen_tag : type : index name : xxchk_usuarios_fk
set search_path = fecxc,oracle,dmap_extension,public;
create index xxchk_usuarios_fk on xxchk_roles_x_usuario (id_rol);
