-- dmap_object_gen_tag : type : table name : feci_rol_operacion_tab
set search_path = feci,oracle,dmap_extension,public;
create table "feci_rol_operacion_tab"  (
id_rol numeric,
id_operacion numeric,
fec_creacion timestamp(0) not null,
fec_ult_modificacion timestamp(0) not null,
id_usuario_creacion numeric not null,
id_usuario_ult_modif numeric not null,
ind_estado numeric not null
) ;
-- dmap_object_gen_tag : type : alter table name : feci_rol_operacion_tab
set search_path = feci,oracle,dmap_extension,public;
alter table feci_rol_operacion_tab alter column fec_creacion set not null;
-- dmap_object_gen_tag : type : alter table name : feci_rol_operacion_tab
set search_path = feci,oracle,dmap_extension,public;
alter table feci_rol_operacion_tab alter column fec_ult_modificacion set not null;
-- dmap_object_gen_tag : type : alter table name : feci_rol_operacion_tab
set search_path = feci,oracle,dmap_extension,public;
alter table feci_rol_operacion_tab alter column id_usuario_creacion set not null;
-- dmap_object_gen_tag : type : alter table name : feci_rol_operacion_tab
set search_path = feci,oracle,dmap_extension,public;
alter table feci_rol_operacion_tab alter column id_usuario_ult_modif set not null;
-- dmap_object_gen_tag : type : alter table name : feci_rol_operacion_tab
set search_path = feci,oracle,dmap_extension,public;
alter table feci_rol_operacion_tab alter column ind_estado set not null;
-- dmap_object_gen_tag : type : alter table name : feci_rol_operacion_tab
set search_path = feci,oracle,dmap_extension,public;
alter table feci_rol_operacion_tab add constraint fk_feci_rol_feci_rope_feci_ope foreign key (id_operacion) references feci_operacion_tab(id_operacion) on delete no action not deferrable initially immediate;
-- dmap_object_gen_tag : type : alter table name : feci_rol_operacion_tab
set search_path = feci,oracle,dmap_extension,public;
alter table feci_rol_operacion_tab add constraint fk_feci_rol_feci_rope_feci_rol foreign key (id_rol) references feci_rol_tab(id_rol) on delete no action not deferrable initially immediate;
