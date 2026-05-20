-- dmap_object_gen_tag : type : table name : feci_estimacion_tab
set search_path = feci,oracle,dmap_extension,public;
create table "feci_estimacion_tab"  (
id_estimacion  bigint generated always as identity  (start with 1 increment by 1  maxvalue 999999999999999999 minvalue 1 no cycle cache 20 ),
cod_grupo_forecast varchar(20) not null,
cod_segmento varchar(20) not null,
num_anio numeric not null,
num_mes numeric not null,
num_semana numeric not null,
num_importe_mxn numeric not null,
num_importe_usd numeric not null,
fec_creacion timestamp(0) not null,
fec_ult_modificacion timestamp(0) not null,
id_usuario_creacion numeric not null,
id_usuario_ult_modif numeric not null,
ind_estado numeric not null
) ;
-- dmap_object_gen_tag : type : alter table name : feci_estimacion_tab
set search_path = feci,oracle,dmap_extension,public;
alter table feci_estimacion_tab add constraint estimacion_pk primary key (id_estimacion);
-- dmap_object_gen_tag : type : alter table name : feci_estimacion_tab
set search_path = feci,oracle,dmap_extension,public;
alter table feci_estimacion_tab alter column id_estimacion set not null;
-- dmap_object_gen_tag : type : alter table name : feci_estimacion_tab
set search_path = feci,oracle,dmap_extension,public;
alter table feci_estimacion_tab alter column cod_grupo_forecast set not null;
-- dmap_object_gen_tag : type : alter table name : feci_estimacion_tab
set search_path = feci,oracle,dmap_extension,public;
alter table feci_estimacion_tab alter column cod_segmento set not null;
-- dmap_object_gen_tag : type : alter table name : feci_estimacion_tab
set search_path = feci,oracle,dmap_extension,public;
alter table feci_estimacion_tab alter column num_anio set not null;
-- dmap_object_gen_tag : type : alter table name : feci_estimacion_tab
set search_path = feci,oracle,dmap_extension,public;
alter table feci_estimacion_tab alter column num_mes set not null;
-- dmap_object_gen_tag : type : alter table name : feci_estimacion_tab
set search_path = feci,oracle,dmap_extension,public;
alter table feci_estimacion_tab alter column num_semana set not null;
-- dmap_object_gen_tag : type : alter table name : feci_estimacion_tab
set search_path = feci,oracle,dmap_extension,public;
alter table feci_estimacion_tab alter column num_importe_mxn set not null;
-- dmap_object_gen_tag : type : alter table name : feci_estimacion_tab
set search_path = feci,oracle,dmap_extension,public;
alter table feci_estimacion_tab alter column num_importe_usd set not null;
-- dmap_object_gen_tag : type : alter table name : feci_estimacion_tab
set search_path = feci,oracle,dmap_extension,public;
alter table feci_estimacion_tab alter column fec_creacion set not null;
-- dmap_object_gen_tag : type : alter table name : feci_estimacion_tab
set search_path = feci,oracle,dmap_extension,public;
alter table feci_estimacion_tab alter column fec_ult_modificacion set not null;
-- dmap_object_gen_tag : type : alter table name : feci_estimacion_tab
set search_path = feci,oracle,dmap_extension,public;
alter table feci_estimacion_tab alter column id_usuario_creacion set not null;
-- dmap_object_gen_tag : type : alter table name : feci_estimacion_tab
set search_path = feci,oracle,dmap_extension,public;
alter table feci_estimacion_tab alter column id_usuario_ult_modif set not null;
-- dmap_object_gen_tag : type : alter table name : feci_estimacion_tab
set search_path = feci,oracle,dmap_extension,public;
alter table feci_estimacion_tab alter column ind_estado set not null;
