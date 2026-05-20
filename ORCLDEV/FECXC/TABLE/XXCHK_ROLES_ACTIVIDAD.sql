-- dmap_object_gen_tag : type : table name : xxchk_roles_actividad
set search_path = fecxc,oracle,dmap_extension,public;
create table "xxchk_roles_actividad"  (
id_rol numeric(38) not null,
e_codigo numeric(38) not null,
id_estado_cheque numeric(38) not null
) ;
-- dmap_object_gen_tag : type : alter table name : xxchk_roles_actividad
set search_path = fecxc,oracle,dmap_extension,public;
alter table xxchk_roles_actividad add constraint pk_xxchk_roles_actividad primary key (id_rol,e_codigo,id_estado_cheque);
-- dmap_object_gen_tag : type : alter table name : xxchk_roles_actividad
set search_path = fecxc,oracle,dmap_extension,public;
alter table xxchk_roles_actividad alter column id_rol set not null;
-- dmap_object_gen_tag : type : alter table name : xxchk_roles_actividad
set search_path = fecxc,oracle,dmap_extension,public;
alter table xxchk_roles_actividad alter column e_codigo set not null;
-- dmap_object_gen_tag : type : alter table name : xxchk_roles_actividad
set search_path = fecxc,oracle,dmap_extension,public;
alter table xxchk_roles_actividad alter column id_estado_cheque set not null;
-- dmap_object_gen_tag : type : alter table name : xxchk_roles_actividad
set search_path = fecxc,oracle,dmap_extension,public;
alter table xxchk_roles_actividad add constraint fk_xxchk_ro_xxchk_edo_xxchk_ca foreign key (e_codigo,id_estado_cheque) references xxchk_cat_edo_cheque(e_codigo,id_estado_cheque) on delete no action not deferrable initially immediate;
-- dmap_object_gen_tag : type : alter table name : xxchk_roles_actividad
set search_path = fecxc,oracle,dmap_extension,public;
alter table xxchk_roles_actividad add constraint fk_xxchk_estarol_tosegrol foreign key (id_rol) references xxchk_roles(id_rol) on delete no action not deferrable initially immediate;
