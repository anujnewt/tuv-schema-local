-- dmap_object_gen_tag : type : table name : xxchk_roles
set search_path = fecxc,oracle,dmap_extension,public;
create table "xxchk_roles"  (
id_rol numeric(38) not null,
desc_rol varchar(100)
) ;
-- dmap_object_gen_tag : type : alter table name : xxchk_roles
set search_path = fecxc,oracle,dmap_extension,public;
alter table xxchk_roles add constraint pk_xxchk_roles primary key (id_rol);
-- dmap_object_gen_tag : type : alter table name : xxchk_roles
set search_path = fecxc,oracle,dmap_extension,public;
alter table xxchk_roles alter column id_rol set not null;
