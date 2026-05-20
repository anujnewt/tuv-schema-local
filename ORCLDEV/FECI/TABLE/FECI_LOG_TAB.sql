-- dmap_object_gen_tag : type : table name : feci_log_tab
set search_path = feci,oracle,dmap_extension,public;
create table "feci_log_tab"  (
id_log  bigint generated always as identity  (start with 1 increment by 1  maxvalue 999999999999999999 minvalue 1 no cycle cache 20 ),
clase varchar(250) not null,
mensaje varchar(500) not null,
excepcion varchar(4000),
nivel varchar(100) not null,
fecha_hora timestamp(0) not null,
clave_rastreo varchar(100) not null
) ;
-- dmap_object_gen_tag : type : alter table name : feci_log_tab
set search_path = feci,oracle,dmap_extension,public;
alter table feci_log_tab add constraint log_pk primary key (id_log);
-- dmap_object_gen_tag : type : alter table name : feci_log_tab
set search_path = feci,oracle,dmap_extension,public;
alter table feci_log_tab alter column id_log set not null;
-- dmap_object_gen_tag : type : alter table name : feci_log_tab
set search_path = feci,oracle,dmap_extension,public;
alter table feci_log_tab alter column clase set not null;
-- dmap_object_gen_tag : type : alter table name : feci_log_tab
set search_path = feci,oracle,dmap_extension,public;
alter table feci_log_tab alter column mensaje set not null;
-- dmap_object_gen_tag : type : alter table name : feci_log_tab
set search_path = feci,oracle,dmap_extension,public;
alter table feci_log_tab alter column nivel set not null;
-- dmap_object_gen_tag : type : alter table name : feci_log_tab
set search_path = feci,oracle,dmap_extension,public;
alter table feci_log_tab alter column fecha_hora set not null;
-- dmap_object_gen_tag : type : alter table name : feci_log_tab
set search_path = feci,oracle,dmap_extension,public;
alter table feci_log_tab alter column clave_rastreo set not null;
