-- dmap_object_gen_tag : type : table name : xxcofidi_usuario_tab
set search_path = cofidi,oracle,dmap_extension,public;
create table "xxcofidi_usuario_tab"  (
id_usuario_pk numeric(38) not null,
user_name varchar(50) not null,
cve_usuario varchar(50),
nom_usuario varchar(255),
ap_paterno varchar(255),
ap_materno varchar(255),
puesto varchar(255),
correo_electronico varchar(255),
fec_vigencia timestamp,
fec_creacion timestamp not null,
fec_ultima_modificacion timestamp,
comentarios varchar(255),
id_rol_fk numeric(38) not null,
id_estado_fk numeric(38) not null,
cambiar_contrasenia numeric(1) default 0,
eliminar_reg numeric(1) default 0,
consultar_usuarios numeric(1) default 0,
generar_reporte_usuarios numeric(1) default 0,
administrar_usuarios numeric(1) default 0,
consultar_bitacora numeric(1) default 0,
consultar_documentos numeric(1) default 0,
administrar_catalogos numeric(1) default 0,
tipo_usuario numeric(1) default 0,
intentos_logeo numeric(3) not null default 0
) ;
-- dmap_object_gen_tag : type : alter table name : xxcofidi_usuario_tab
set search_path = cofidi,oracle,dmap_extension,public;
alter table xxcofidi_usuario_tab add constraint xxcofidi_usuario_uk_idx01 unique (user_name);
-- dmap_object_gen_tag : type : alter table name : xxcofidi_usuario_tab
set search_path = cofidi,oracle,dmap_extension,public;
alter table xxcofidi_usuario_tab add constraint xxcofidi_usuario_pk_idx01 primary key (id_usuario_pk);
-- dmap_object_gen_tag : type : alter table name : xxcofidi_usuario_tab
set search_path = cofidi,oracle,dmap_extension,public;
alter table xxcofidi_usuario_tab alter column id_usuario_pk set not null;
-- dmap_object_gen_tag : type : alter table name : xxcofidi_usuario_tab
set search_path = cofidi,oracle,dmap_extension,public;
alter table xxcofidi_usuario_tab alter column user_name set not null;
-- dmap_object_gen_tag : type : alter table name : xxcofidi_usuario_tab
set search_path = cofidi,oracle,dmap_extension,public;
alter table xxcofidi_usuario_tab alter column fec_creacion set not null;
-- dmap_object_gen_tag : type : alter table name : xxcofidi_usuario_tab
set search_path = cofidi,oracle,dmap_extension,public;
alter table xxcofidi_usuario_tab alter column id_rol_fk set not null;
-- dmap_object_gen_tag : type : alter table name : xxcofidi_usuario_tab
set search_path = cofidi,oracle,dmap_extension,public;
alter table xxcofidi_usuario_tab alter column id_estado_fk set not null;
-- dmap_object_gen_tag : type : alter table name : xxcofidi_usuario_tab
set search_path = cofidi,oracle,dmap_extension,public;
alter table xxcofidi_usuario_tab alter column intentos_logeo set not null;
-- dmap_object_gen_tag : type : alter table name : xxcofidi_usuario_tab
set search_path = cofidi,oracle,dmap_extension,public;
alter table xxcofidi_usuario_tab add constraint xxcofidi_usuario_estado_idx foreign key (id_estado_fk) references xxcofidi_estado_ct_tab(id_estado_pk) on delete no action not deferrable initially immediate;
-- dmap_object_gen_tag : type : alter table name : xxcofidi_usuario_tab
set search_path = cofidi,oracle,dmap_extension,public;
alter table xxcofidi_usuario_tab add constraint xxcofidi_usuario_rol_fk_idx01 foreign key (id_rol_fk) references xxcofidi_rol_ct_tab(id_rol_pk) on delete no action not deferrable initially immediate;
