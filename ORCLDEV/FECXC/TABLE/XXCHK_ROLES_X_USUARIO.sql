-- dmap_object_gen_tag : type : table name : xxchk_roles_x_usuario
set search_path = fecxc,oracle,dmap_extension,public;
create table "xxchk_roles_x_usuario"  (
id_rol numeric(38) not null,
codusuario varchar(40) not null
) ;
-- dmap_object_gen_tag : type : alter table name : xxchk_roles_x_usuario
set search_path = fecxc,oracle,dmap_extension,public;
alter table xxchk_roles_x_usuario add constraint pk_xxchk_roles_x_usuario primary key (id_rol,codusuario);
-- dmap_object_gen_tag : type : alter table name : xxchk_roles_x_usuario
set search_path = fecxc,oracle,dmap_extension,public;
alter table xxchk_roles_x_usuario alter column id_rol set not null;
-- dmap_object_gen_tag : type : alter table name : xxchk_roles_x_usuario
set search_path = fecxc,oracle,dmap_extension,public;
alter table xxchk_roles_x_usuario alter column codusuario set not null;
-- dmap_object_gen_tag : type : alter table name : xxchk_roles_x_usuario
set search_path = fecxc,oracle,dmap_extension,public;
alter table xxchk_roles_x_usuario add constraint fk_xxchk_ro_xxchk_usu_xxchk_ro foreign key (id_rol) references xxchk_roles(id_rol) on delete no action not deferrable initially immediate;
