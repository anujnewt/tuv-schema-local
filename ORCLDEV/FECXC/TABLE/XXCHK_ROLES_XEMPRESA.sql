-- dmap_object_gen_tag : type : table name : xxchk_roles_xempresa
set search_path = fecxc,oracle,dmap_extension,public;
create table "xxchk_roles_xempresa"  (
id_rol numeric(38) not null,
e_codigo numeric(38) not null
) ;
-- dmap_object_gen_tag : type : alter table name : xxchk_roles_xempresa
set search_path = fecxc,oracle,dmap_extension,public;
alter table xxchk_roles_xempresa add constraint pk_xxchk_roles_xempresa primary key (id_rol,e_codigo);
-- dmap_object_gen_tag : type : alter table name : xxchk_roles_xempresa
set search_path = fecxc,oracle,dmap_extension,public;
alter table xxchk_roles_xempresa alter column id_rol set not null;
-- dmap_object_gen_tag : type : alter table name : xxchk_roles_xempresa
set search_path = fecxc,oracle,dmap_extension,public;
alter table xxchk_roles_xempresa alter column e_codigo set not null;
-- dmap_object_gen_tag : type : alter table name : xxchk_roles_xempresa
set search_path = fecxc,oracle,dmap_extension,public;
alter table xxchk_roles_xempresa add constraint fk_xxchk_ro_xxchk_emp_fecxc_em foreign key (e_codigo) references fecxc_empresas(e_codigo) on delete no action not deferrable initially immediate;
-- dmap_object_gen_tag : type : alter table name : xxchk_roles_xempresa
set search_path = fecxc,oracle,dmap_extension,public;
alter table xxchk_roles_xempresa add constraint fk_xxchk_rol_seg foreign key (id_rol) references xxchk_roles(id_rol) on delete no action not deferrable initially immediate;
