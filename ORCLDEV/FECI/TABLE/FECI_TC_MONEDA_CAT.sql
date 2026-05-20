-- dmap_object_gen_tag : type : table name : feci_tc_moneda_cat
set search_path = feci,oracle,dmap_extension,public;
create table "feci_tc_moneda_cat"  (
id_tc_moneda  bigint generated always as identity  (start with 1 increment by 1  maxvalue 999999999999999999 minvalue 1 no cycle cache 20 ),
fec_fecha_tc timestamp(0) not null,
cod_mon_origen varchar(20) not null,
cod_mon_destino varchar(20) not null,
num_tipo_cambio numeric not null,
num_factor numeric,
fec_creacion timestamp(0) not null,
fec_ult_modificacion timestamp(0) not null,
id_usuario_creacion numeric not null,
id_usuario_ult_modif numeric not null,
ind_estado numeric not null
) ;
-- dmap_object_gen_tag : type : alter table name : feci_tc_moneda_cat
set search_path = feci,oracle,dmap_extension,public;
alter table feci_tc_moneda_cat add constraint tc_moneda_pk primary key (id_tc_moneda);
-- dmap_object_gen_tag : type : alter table name : feci_tc_moneda_cat
set search_path = feci,oracle,dmap_extension,public;
alter table feci_tc_moneda_cat alter column id_tc_moneda set not null;
-- dmap_object_gen_tag : type : alter table name : feci_tc_moneda_cat
set search_path = feci,oracle,dmap_extension,public;
alter table feci_tc_moneda_cat alter column fec_fecha_tc set not null;
-- dmap_object_gen_tag : type : alter table name : feci_tc_moneda_cat
set search_path = feci,oracle,dmap_extension,public;
alter table feci_tc_moneda_cat alter column cod_mon_origen set not null;
-- dmap_object_gen_tag : type : alter table name : feci_tc_moneda_cat
set search_path = feci,oracle,dmap_extension,public;
alter table feci_tc_moneda_cat alter column cod_mon_destino set not null;
-- dmap_object_gen_tag : type : alter table name : feci_tc_moneda_cat
set search_path = feci,oracle,dmap_extension,public;
alter table feci_tc_moneda_cat alter column num_tipo_cambio set not null;
-- dmap_object_gen_tag : type : alter table name : feci_tc_moneda_cat
set search_path = feci,oracle,dmap_extension,public;
alter table feci_tc_moneda_cat alter column fec_creacion set not null;
-- dmap_object_gen_tag : type : alter table name : feci_tc_moneda_cat
set search_path = feci,oracle,dmap_extension,public;
alter table feci_tc_moneda_cat alter column fec_ult_modificacion set not null;
-- dmap_object_gen_tag : type : alter table name : feci_tc_moneda_cat
set search_path = feci,oracle,dmap_extension,public;
alter table feci_tc_moneda_cat alter column id_usuario_creacion set not null;
-- dmap_object_gen_tag : type : alter table name : feci_tc_moneda_cat
set search_path = feci,oracle,dmap_extension,public;
alter table feci_tc_moneda_cat alter column id_usuario_ult_modif set not null;
-- dmap_object_gen_tag : type : alter table name : feci_tc_moneda_cat
set search_path = feci,oracle,dmap_extension,public;
alter table feci_tc_moneda_cat alter column ind_estado set not null;
