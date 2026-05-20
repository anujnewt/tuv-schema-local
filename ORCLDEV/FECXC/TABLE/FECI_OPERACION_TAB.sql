-- dmap_object_gen_tag : type : table name : feci_operacion_tab
set search_path = fecxc,oracle,dmap_extension,public;
create table "feci_operacion_tab"  (
id_operacion  bigint generated always as identity  (start with 21 increment by 1  maxvalue 999999999999999999 minvalue 1 no cycle cache 20 ),
des_agrupador varchar(100) not null,
cod_operacion varchar(100) not null,
des_nombre varchar(100) not null,
cod_tipo_operacion varchar(20),
fec_creacion timestamp(0) not null,
fec_ult_modificacion timestamp(0) not null,
id_usuario_creacion numeric not null,
id_usuario_ult_modif numeric not null,
ind_estado numeric not null
) ;
-- dmap_object_gen_tag : type : alter table name : feci_operacion_tab
set search_path = fecxc,oracle,dmap_extension,public;
alter table feci_operacion_tab add constraint operacion_pk primary key (id_operacion);
-- dmap_object_gen_tag : type : alter table name : feci_operacion_tab
set search_path = fecxc,oracle,dmap_extension,public;
alter table feci_operacion_tab alter column id_operacion set not null;
-- dmap_object_gen_tag : type : alter table name : feci_operacion_tab
set search_path = fecxc,oracle,dmap_extension,public;
alter table feci_operacion_tab alter column des_agrupador set not null;
-- dmap_object_gen_tag : type : alter table name : feci_operacion_tab
set search_path = fecxc,oracle,dmap_extension,public;
alter table feci_operacion_tab alter column cod_operacion set not null;
-- dmap_object_gen_tag : type : alter table name : feci_operacion_tab
set search_path = fecxc,oracle,dmap_extension,public;
alter table feci_operacion_tab alter column des_nombre set not null;
-- dmap_object_gen_tag : type : alter table name : feci_operacion_tab
set search_path = fecxc,oracle,dmap_extension,public;
alter table feci_operacion_tab alter column fec_creacion set not null;
-- dmap_object_gen_tag : type : alter table name : feci_operacion_tab
set search_path = fecxc,oracle,dmap_extension,public;
alter table feci_operacion_tab alter column fec_ult_modificacion set not null;
-- dmap_object_gen_tag : type : alter table name : feci_operacion_tab
set search_path = fecxc,oracle,dmap_extension,public;
alter table feci_operacion_tab alter column id_usuario_creacion set not null;
-- dmap_object_gen_tag : type : alter table name : feci_operacion_tab
set search_path = fecxc,oracle,dmap_extension,public;
alter table feci_operacion_tab alter column id_usuario_ult_modif set not null;
-- dmap_object_gen_tag : type : alter table name : feci_operacion_tab
set search_path = fecxc,oracle,dmap_extension,public;
alter table feci_operacion_tab alter column ind_estado set not null;
