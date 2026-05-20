-- dmap_object_gen_tag : type : table name : feci_moneda_cat
set search_path = feci,oracle,dmap_extension,public;
create table "feci_moneda_cat"  (
id_moneda  bigint generated always as identity  (start with 1 increment by 1  maxvalue 999999999999999999 minvalue 1 no cycle cache 20 ),
cod_moneda varchar(20) not null,
des_moneda varchar(250) not null,
fec_creacion timestamp(0) not null,
fec_ult_modificacion timestamp(0) not null,
id_usuario_creacion numeric not null,
id_usuario_ult_modif numeric not null,
ind_estado numeric not null
) ;
-- dmap_object_gen_tag : type : alter table name : feci_moneda_cat
set search_path = feci,oracle,dmap_extension,public;
alter table feci_moneda_cat add constraint moneda_pk primary key (id_moneda);
-- dmap_object_gen_tag : type : alter table name : feci_moneda_cat
set search_path = feci,oracle,dmap_extension,public;
alter table feci_moneda_cat alter column id_moneda set not null;
-- dmap_object_gen_tag : type : alter table name : feci_moneda_cat
set search_path = feci,oracle,dmap_extension,public;
alter table feci_moneda_cat alter column cod_moneda set not null;
-- dmap_object_gen_tag : type : alter table name : feci_moneda_cat
set search_path = feci,oracle,dmap_extension,public;
alter table feci_moneda_cat alter column des_moneda set not null;
-- dmap_object_gen_tag : type : alter table name : feci_moneda_cat
set search_path = feci,oracle,dmap_extension,public;
alter table feci_moneda_cat alter column fec_creacion set not null;
-- dmap_object_gen_tag : type : alter table name : feci_moneda_cat
set search_path = feci,oracle,dmap_extension,public;
alter table feci_moneda_cat alter column fec_ult_modificacion set not null;
-- dmap_object_gen_tag : type : alter table name : feci_moneda_cat
set search_path = feci,oracle,dmap_extension,public;
alter table feci_moneda_cat alter column id_usuario_creacion set not null;
-- dmap_object_gen_tag : type : alter table name : feci_moneda_cat
set search_path = feci,oracle,dmap_extension,public;
alter table feci_moneda_cat alter column id_usuario_ult_modif set not null;
-- dmap_object_gen_tag : type : alter table name : feci_moneda_cat
set search_path = feci,oracle,dmap_extension,public;
alter table feci_moneda_cat alter column ind_estado set not null;
