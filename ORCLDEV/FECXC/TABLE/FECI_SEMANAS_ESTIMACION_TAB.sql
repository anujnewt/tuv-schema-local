-- dmap_object_gen_tag : type : table name : feci_semanas_estimacion_tab
set search_path = fecxc,oracle,dmap_extension,public;
create table "feci_semanas_estimacion_tab"  (
id_semanas_estimacion  bigint generated always as identity  (start with 1 increment by 1  maxvalue 999999999999999999 minvalue 1 no cycle cache 20 ),
num_anio numeric not null,
num_mes numeric not null,
fec_inicio_semana_1 timestamp(0) not null,
fec_fin_semana_1 timestamp(0) not null,
fec_inicio_semana_2 timestamp(0) not null,
fec_fin_semana_2 timestamp(0) not null,
fec_inicio_semana_3 timestamp(0) not null,
fec_fin_semana_3 timestamp(0) not null,
fec_inicio_semana_4 timestamp(0) not null,
fec_fin_semana_4 timestamp(0) not null,
fec_inicio_semana_5 timestamp(0),
fec_fin_semana_5 timestamp(0),
fec_creacion timestamp(0) not null,
fec_ult_modificacion timestamp(0) not null,
id_usuario_creacion numeric not null,
id_usuario_ult_modif numeric not null,
ind_estado numeric not null
) ;
-- dmap_object_gen_tag : type : alter table name : feci_semanas_estimacion_tab
set search_path = fecxc,oracle,dmap_extension,public;
alter table feci_semanas_estimacion_tab add constraint semanas_estimacion_pk primary key (id_semanas_estimacion);
-- dmap_object_gen_tag : type : alter table name : feci_semanas_estimacion_tab
set search_path = fecxc,oracle,dmap_extension,public;
alter table feci_semanas_estimacion_tab alter column id_semanas_estimacion set not null;
-- dmap_object_gen_tag : type : alter table name : feci_semanas_estimacion_tab
set search_path = fecxc,oracle,dmap_extension,public;
alter table feci_semanas_estimacion_tab alter column num_anio set not null;
-- dmap_object_gen_tag : type : alter table name : feci_semanas_estimacion_tab
set search_path = fecxc,oracle,dmap_extension,public;
alter table feci_semanas_estimacion_tab alter column num_mes set not null;
-- dmap_object_gen_tag : type : alter table name : feci_semanas_estimacion_tab
set search_path = fecxc,oracle,dmap_extension,public;
alter table feci_semanas_estimacion_tab alter column fec_inicio_semana_1 set not null;
-- dmap_object_gen_tag : type : alter table name : feci_semanas_estimacion_tab
set search_path = fecxc,oracle,dmap_extension,public;
alter table feci_semanas_estimacion_tab alter column fec_fin_semana_1 set not null;
-- dmap_object_gen_tag : type : alter table name : feci_semanas_estimacion_tab
set search_path = fecxc,oracle,dmap_extension,public;
alter table feci_semanas_estimacion_tab alter column fec_inicio_semana_2 set not null;
-- dmap_object_gen_tag : type : alter table name : feci_semanas_estimacion_tab
set search_path = fecxc,oracle,dmap_extension,public;
alter table feci_semanas_estimacion_tab alter column fec_fin_semana_2 set not null;
-- dmap_object_gen_tag : type : alter table name : feci_semanas_estimacion_tab
set search_path = fecxc,oracle,dmap_extension,public;
alter table feci_semanas_estimacion_tab alter column fec_inicio_semana_3 set not null;
-- dmap_object_gen_tag : type : alter table name : feci_semanas_estimacion_tab
set search_path = fecxc,oracle,dmap_extension,public;
alter table feci_semanas_estimacion_tab alter column fec_fin_semana_3 set not null;
-- dmap_object_gen_tag : type : alter table name : feci_semanas_estimacion_tab
set search_path = fecxc,oracle,dmap_extension,public;
alter table feci_semanas_estimacion_tab alter column fec_inicio_semana_4 set not null;
-- dmap_object_gen_tag : type : alter table name : feci_semanas_estimacion_tab
set search_path = fecxc,oracle,dmap_extension,public;
alter table feci_semanas_estimacion_tab alter column fec_fin_semana_4 set not null;
-- dmap_object_gen_tag : type : alter table name : feci_semanas_estimacion_tab
set search_path = fecxc,oracle,dmap_extension,public;
alter table feci_semanas_estimacion_tab alter column fec_creacion set not null;
-- dmap_object_gen_tag : type : alter table name : feci_semanas_estimacion_tab
set search_path = fecxc,oracle,dmap_extension,public;
alter table feci_semanas_estimacion_tab alter column fec_ult_modificacion set not null;
-- dmap_object_gen_tag : type : alter table name : feci_semanas_estimacion_tab
set search_path = fecxc,oracle,dmap_extension,public;
alter table feci_semanas_estimacion_tab alter column id_usuario_creacion set not null;
-- dmap_object_gen_tag : type : alter table name : feci_semanas_estimacion_tab
set search_path = fecxc,oracle,dmap_extension,public;
alter table feci_semanas_estimacion_tab alter column id_usuario_ult_modif set not null;
-- dmap_object_gen_tag : type : alter table name : feci_semanas_estimacion_tab
set search_path = fecxc,oracle,dmap_extension,public;
alter table feci_semanas_estimacion_tab alter column ind_estado set not null;
