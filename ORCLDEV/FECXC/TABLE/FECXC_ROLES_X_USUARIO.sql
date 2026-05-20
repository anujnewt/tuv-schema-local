-- dmap_object_gen_tag : type : table name : fecxc_roles_x_usuario
set search_path = fecxc,oracle,dmap_extension,public;
create table "fecxc_roles_x_usuario"  (
id_rol numeric(38) not null,
codusuario varchar(40) not null
) ;
-- dmap_object_gen_tag : type : alter table name : fecxc_roles_x_usuario
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxc_roles_x_usuario add constraint pk_fecxc_roles_x_usuario primary key (id_rol,codusuario);
-- dmap_object_gen_tag : type : alter table name : fecxc_roles_x_usuario
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxc_roles_x_usuario alter column id_rol set not null;
-- dmap_object_gen_tag : type : alter table name : fecxc_roles_x_usuario
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxc_roles_x_usuario alter column codusuario set not null;
-- dmap_object_gen_tag : type : alter table name : fecxc_roles_x_usuario
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxc_roles_x_usuario add constraint fk_fecxc_ro_usuarios_fecxc_ro foreign key (id_rol) references fecxc_roles(id_rol) on delete no action not deferrable initially immediate;
