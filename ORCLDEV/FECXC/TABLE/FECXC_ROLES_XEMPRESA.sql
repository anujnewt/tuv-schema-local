-- dmap_object_gen_tag : type : table name : fecxc_roles_xempresa
set search_path = fecxc,oracle,dmap_extension,public;
create table "fecxc_roles_xempresa"  (
id_rol numeric(38) not null,
e_codigo numeric(38) not null
) ;
-- dmap_object_gen_tag : type : alter table name : fecxc_roles_xempresa
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxc_roles_xempresa add constraint pk_fecxc_roles_xempresa primary key (id_rol,e_codigo);
-- dmap_object_gen_tag : type : alter table name : fecxc_roles_xempresa
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxc_roles_xempresa alter column id_rol set not null;
-- dmap_object_gen_tag : type : alter table name : fecxc_roles_xempresa
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxc_roles_xempresa alter column e_codigo set not null;
-- dmap_object_gen_tag : type : alter table name : fecxc_roles_xempresa
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxc_roles_xempresa add constraint fk_fecxc_ro_empresas_fecxc_em foreign key (e_codigo) references fecxc_empresas(e_codigo) on delete no action not deferrable initially immediate;
-- dmap_object_gen_tag : type : alter table name : fecxc_roles_xempresa
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxc_roles_xempresa add constraint fk_fecxc_ro_roles_fecxc_ro foreign key (id_rol) references fecxc_roles(id_rol) on delete no action not deferrable initially immediate;
