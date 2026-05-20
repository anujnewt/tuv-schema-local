-- dmap_object_gen_tag : type : table name : feci_tipo_cambio_cat
set search_path = feci,oracle,dmap_extension,public;
create table "feci_tipo_cambio_cat"  (
id_tipo_cambio  bigint generated always as identity  (start with 1 increment by 1  maxvalue 999999999999999999 minvalue 1 no cycle cache 20 ),
fec_fecha_tc timestamp(0) not null,
cod_moneda varchar(20) not null,
num_valor numeric not null,
fec_creacion timestamp(0) not null,
fec_ult_modificacion timestamp(0) not null,
id_usuario_creacion numeric not null,
id_usuario_ult_modif numeric not null,
ind_estado numeric not null
) ;
-- dmap_object_gen_tag : type : alter table name : feci_tipo_cambio_cat
set search_path = feci,oracle,dmap_extension,public;
alter table feci_tipo_cambio_cat add constraint tipo_cambio_pk primary key (id_tipo_cambio);
-- dmap_object_gen_tag : type : alter table name : feci_tipo_cambio_cat
set search_path = feci,oracle,dmap_extension,public;
alter table feci_tipo_cambio_cat alter column id_tipo_cambio set not null;
-- dmap_object_gen_tag : type : alter table name : feci_tipo_cambio_cat
set search_path = feci,oracle,dmap_extension,public;
alter table feci_tipo_cambio_cat alter column fec_fecha_tc set not null;
-- dmap_object_gen_tag : type : alter table name : feci_tipo_cambio_cat
set search_path = feci,oracle,dmap_extension,public;
alter table feci_tipo_cambio_cat alter column cod_moneda set not null;
-- dmap_object_gen_tag : type : alter table name : feci_tipo_cambio_cat
set search_path = feci,oracle,dmap_extension,public;
alter table feci_tipo_cambio_cat alter column num_valor set not null;
-- dmap_object_gen_tag : type : alter table name : feci_tipo_cambio_cat
set search_path = feci,oracle,dmap_extension,public;
alter table feci_tipo_cambio_cat alter column fec_creacion set not null;
-- dmap_object_gen_tag : type : alter table name : feci_tipo_cambio_cat
set search_path = feci,oracle,dmap_extension,public;
alter table feci_tipo_cambio_cat alter column fec_ult_modificacion set not null;
-- dmap_object_gen_tag : type : alter table name : feci_tipo_cambio_cat
set search_path = feci,oracle,dmap_extension,public;
alter table feci_tipo_cambio_cat alter column id_usuario_creacion set not null;
-- dmap_object_gen_tag : type : alter table name : feci_tipo_cambio_cat
set search_path = feci,oracle,dmap_extension,public;
alter table feci_tipo_cambio_cat alter column id_usuario_ult_modif set not null;
-- dmap_object_gen_tag : type : alter table name : feci_tipo_cambio_cat
set search_path = feci,oracle,dmap_extension,public;
alter table feci_tipo_cambio_cat alter column ind_estado set not null;
