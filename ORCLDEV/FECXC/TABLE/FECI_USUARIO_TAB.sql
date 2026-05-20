-- dmap_object_gen_tag : type : table name : feci_usuario_tab
set search_path = fecxc,oracle,dmap_extension,public;
create table "feci_usuario_tab"  (
id_usuario  bigint generated always as identity  (start with 53 increment by 1  maxvalue 999999999999999999 minvalue 1 no cycle cache 20 ),
id_rol numeric,
des_email varchar(250) not null,
des_nombres varchar(150) not null,
des_apellidos varchar(250) not null,
fec_creacion timestamp(0) not null,
fec_ult_modificacion timestamp(0) not null,
id_usuario_creacion numeric not null,
id_usuario_ult_modif numeric not null,
ind_estado numeric not null
) ;
-- dmap_object_gen_tag : type : alter table name : feci_usuario_tab
set search_path = fecxc,oracle,dmap_extension,public;
alter table feci_usuario_tab add constraint usuario_pk primary key (id_usuario) deferrable;
-- dmap_object_gen_tag : type : alter table name : feci_usuario_tab
set search_path = fecxc,oracle,dmap_extension,public;
alter table feci_usuario_tab alter column id_usuario set not null;
-- dmap_object_gen_tag : type : alter table name : feci_usuario_tab
set search_path = fecxc,oracle,dmap_extension,public;
alter table feci_usuario_tab alter column des_email set not null;
-- dmap_object_gen_tag : type : alter table name : feci_usuario_tab
set search_path = fecxc,oracle,dmap_extension,public;
alter table feci_usuario_tab alter column des_nombres set not null;
-- dmap_object_gen_tag : type : alter table name : feci_usuario_tab
set search_path = fecxc,oracle,dmap_extension,public;
alter table feci_usuario_tab alter column des_apellidos set not null;
-- dmap_object_gen_tag : type : alter table name : feci_usuario_tab
set search_path = fecxc,oracle,dmap_extension,public;
alter table feci_usuario_tab alter column fec_creacion set not null;
-- dmap_object_gen_tag : type : alter table name : feci_usuario_tab
set search_path = fecxc,oracle,dmap_extension,public;
alter table feci_usuario_tab alter column fec_ult_modificacion set not null;
-- dmap_object_gen_tag : type : alter table name : feci_usuario_tab
set search_path = fecxc,oracle,dmap_extension,public;
alter table feci_usuario_tab alter column id_usuario_creacion set not null;
-- dmap_object_gen_tag : type : alter table name : feci_usuario_tab
set search_path = fecxc,oracle,dmap_extension,public;
alter table feci_usuario_tab alter column id_usuario_ult_modif set not null;
-- dmap_object_gen_tag : type : alter table name : feci_usuario_tab
set search_path = fecxc,oracle,dmap_extension,public;
alter table feci_usuario_tab alter column ind_estado set not null;
-- dmap_object_gen_tag : type : alter table name : feci_usuario_tab
set search_path = fecxc,oracle,dmap_extension,public;
alter table feci_usuario_tab add constraint fk_feci_usu_feci_usu__feci_rol foreign key (id_rol) references feci_rol_tab(id_rol) on delete no action not deferrable initially immediate;
