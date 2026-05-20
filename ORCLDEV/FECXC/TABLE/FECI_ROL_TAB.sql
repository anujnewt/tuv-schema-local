-- dmap_object_gen_tag : type : table name : feci_rol_tab
set search_path = fecxc,oracle,dmap_extension,public;
create table "feci_rol_tab"  (
id_rol  bigint generated always as identity  (start with 22 increment by 1  maxvalue 999999999999999999 minvalue 1 no cycle cache 20 ),
cod_rol varchar(20) not null,
nom_rol varchar(250) not null,
fec_creacion timestamp(0) not null,
fec_ult_modificacion timestamp(0) not null,
id_usuario_creacion numeric not null,
id_usuario_ult_modif numeric not null,
ind_estado numeric not null
) ;
-- dmap_object_gen_tag : type : alter table name : feci_rol_tab
set search_path = fecxc,oracle,dmap_extension,public;
alter table feci_rol_tab add constraint rol_pk primary key (id_rol);
-- dmap_object_gen_tag : type : alter table name : feci_rol_tab
set search_path = fecxc,oracle,dmap_extension,public;
alter table feci_rol_tab alter column id_rol set not null;
-- dmap_object_gen_tag : type : alter table name : feci_rol_tab
set search_path = fecxc,oracle,dmap_extension,public;
alter table feci_rol_tab alter column cod_rol set not null;
-- dmap_object_gen_tag : type : alter table name : feci_rol_tab
set search_path = fecxc,oracle,dmap_extension,public;
alter table feci_rol_tab alter column nom_rol set not null;
-- dmap_object_gen_tag : type : alter table name : feci_rol_tab
set search_path = fecxc,oracle,dmap_extension,public;
alter table feci_rol_tab alter column fec_creacion set not null;
-- dmap_object_gen_tag : type : alter table name : feci_rol_tab
set search_path = fecxc,oracle,dmap_extension,public;
alter table feci_rol_tab alter column fec_ult_modificacion set not null;
-- dmap_object_gen_tag : type : alter table name : feci_rol_tab
set search_path = fecxc,oracle,dmap_extension,public;
alter table feci_rol_tab alter column id_usuario_creacion set not null;
-- dmap_object_gen_tag : type : alter table name : feci_rol_tab
set search_path = fecxc,oracle,dmap_extension,public;
alter table feci_rol_tab alter column id_usuario_ult_modif set not null;
-- dmap_object_gen_tag : type : alter table name : feci_rol_tab
set search_path = fecxc,oracle,dmap_extension,public;
alter table feci_rol_tab alter column ind_estado set not null;
