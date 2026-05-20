-- dmap_object_gen_tag : type : table name : feci_porcentaje_iva_cat
set search_path = fecxc,oracle,dmap_extension,public;
create table "feci_porcentaje_iva_cat"  (
id_porcentaje_iva  bigint generated always as identity  (start with 5 increment by 1  maxvalue 999999999999999999 minvalue 1 no cycle cache 20 ),
cod_porcentaje_iva varchar(20) not null,
num_valor numeric,
fec_creacion timestamp(0) not null,
fec_ult_modificacion timestamp(0) not null,
id_usuario_creacion numeric not null,
id_usuario_ult_modif numeric not null,
ind_estado numeric not null
) ;
-- dmap_object_gen_tag : type : alter table name : feci_porcentaje_iva_cat
set search_path = fecxc,oracle,dmap_extension,public;
alter table feci_porcentaje_iva_cat add constraint porcentaje_iva_pk primary key (id_porcentaje_iva);
-- dmap_object_gen_tag : type : alter table name : feci_porcentaje_iva_cat
set search_path = fecxc,oracle,dmap_extension,public;
alter table feci_porcentaje_iva_cat alter column id_porcentaje_iva set not null;
-- dmap_object_gen_tag : type : alter table name : feci_porcentaje_iva_cat
set search_path = fecxc,oracle,dmap_extension,public;
alter table feci_porcentaje_iva_cat alter column cod_porcentaje_iva set not null;
-- dmap_object_gen_tag : type : alter table name : feci_porcentaje_iva_cat
set search_path = fecxc,oracle,dmap_extension,public;
alter table feci_porcentaje_iva_cat alter column fec_creacion set not null;
-- dmap_object_gen_tag : type : alter table name : feci_porcentaje_iva_cat
set search_path = fecxc,oracle,dmap_extension,public;
alter table feci_porcentaje_iva_cat alter column fec_ult_modificacion set not null;
-- dmap_object_gen_tag : type : alter table name : feci_porcentaje_iva_cat
set search_path = fecxc,oracle,dmap_extension,public;
alter table feci_porcentaje_iva_cat alter column id_usuario_creacion set not null;
-- dmap_object_gen_tag : type : alter table name : feci_porcentaje_iva_cat
set search_path = fecxc,oracle,dmap_extension,public;
alter table feci_porcentaje_iva_cat alter column id_usuario_ult_modif set not null;
-- dmap_object_gen_tag : type : alter table name : feci_porcentaje_iva_cat
set search_path = fecxc,oracle,dmap_extension,public;
alter table feci_porcentaje_iva_cat alter column ind_estado set not null;
