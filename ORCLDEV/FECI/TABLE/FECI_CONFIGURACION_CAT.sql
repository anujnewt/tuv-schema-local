-- dmap_object_gen_tag : type : table name : feci_configuracion_cat
set search_path = feci,oracle,dmap_extension,public;
create table "feci_configuracion_cat"  (
id_configuracion  bigint generated always as identity  (start with 1 increment by 1  maxvalue 999999999999999999 minvalue 1 no cycle cache 20 ),
cod_configuracion varchar(20) not null,
des_configuracion varchar(250) not null,
fec_creacion timestamp(0) not null,
fec_ult_modificacion timestamp(0) not null,
id_usuario_creacion numeric not null,
id_usuario_ult_modif numeric not null,
ind_estado numeric not null
) ;
-- dmap_object_gen_tag : type : alter table name : feci_configuracion_cat
set search_path = feci,oracle,dmap_extension,public;
alter table feci_configuracion_cat add constraint configuracion_pk primary key (id_configuracion);
-- dmap_object_gen_tag : type : alter table name : feci_configuracion_cat
set search_path = feci,oracle,dmap_extension,public;
alter table feci_configuracion_cat alter column id_configuracion set not null;
-- dmap_object_gen_tag : type : alter table name : feci_configuracion_cat
set search_path = feci,oracle,dmap_extension,public;
alter table feci_configuracion_cat alter column cod_configuracion set not null;
-- dmap_object_gen_tag : type : alter table name : feci_configuracion_cat
set search_path = feci,oracle,dmap_extension,public;
alter table feci_configuracion_cat alter column des_configuracion set not null;
-- dmap_object_gen_tag : type : alter table name : feci_configuracion_cat
set search_path = feci,oracle,dmap_extension,public;
alter table feci_configuracion_cat alter column fec_creacion set not null;
-- dmap_object_gen_tag : type : alter table name : feci_configuracion_cat
set search_path = feci,oracle,dmap_extension,public;
alter table feci_configuracion_cat alter column fec_ult_modificacion set not null;
-- dmap_object_gen_tag : type : alter table name : feci_configuracion_cat
set search_path = feci,oracle,dmap_extension,public;
alter table feci_configuracion_cat alter column id_usuario_creacion set not null;
-- dmap_object_gen_tag : type : alter table name : feci_configuracion_cat
set search_path = feci,oracle,dmap_extension,public;
alter table feci_configuracion_cat alter column id_usuario_ult_modif set not null;
-- dmap_object_gen_tag : type : alter table name : feci_configuracion_cat
set search_path = feci,oracle,dmap_extension,public;
alter table feci_configuracion_cat alter column ind_estado set not null;
