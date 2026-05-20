-- dmap_object_gen_tag : type : table name : fecxc_roles
set search_path = fecxc,oracle,dmap_extension,public;
create table "fecxc_roles"  (
id_rol numeric(38) not null,
desc_rol varchar(100)
) ;
-- dmap_object_gen_tag : type : alter table name : fecxc_roles
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxc_roles add constraint pk_fecxc_roles primary key (id_rol);
-- dmap_object_gen_tag : type : alter table name : fecxc_roles
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxc_roles alter column id_rol set not null;
