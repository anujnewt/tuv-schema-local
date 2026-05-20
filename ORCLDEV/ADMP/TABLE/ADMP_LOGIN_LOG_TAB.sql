-- dmap_object_gen_tag : type : table name : admp_login_log_tab
set search_path = admp,oracle,dmap_extension,public;
create table "admp_login_log_tab"  (
id_login_log numeric not null,
des_usuario varchar(50) not null,
fec_fecha_evento timestamp(0) not null,
des_estado varchar(50) not null,
des_descripcion varchar(100) not null,
des_tipo varchar(10) not null,
num_created_by numeric(15) not null,
fec_creation_date timestamp(0) not null,
num_last_update numeric(15) not null,
fec_last_update timestamp(0) not null,
num_last_update_login numeric(15),
atributo1 varchar(150),
atributo2 varchar(150),
atributo3 varchar(150),
atributo4 varchar(150),
atributo5 varchar(150),
atributo6 varchar(150),
atributo7 varchar(150),
atributo8 varchar(150),
atributo9 varchar(150),
atributo10 varchar(150),
atributo11 varchar(150),
atributo12 varchar(150),
atributo13 varchar(150),
atributo14 varchar(150),
atributo15 varchar(150),
attribute_category varchar(150)
) ;
-- dmap_object_gen_tag : type : alter table name : admp_login_log_tab
set search_path = admp,oracle,dmap_extension,public;
alter table admp_login_log_tab add constraint admp_login_log_pk primary key (id_login_log);
-- dmap_object_gen_tag : type : alter table name : admp_login_log_tab
set search_path = admp,oracle,dmap_extension,public;
alter table admp_login_log_tab alter column id_login_log set not null;
-- dmap_object_gen_tag : type : alter table name : admp_login_log_tab
set search_path = admp,oracle,dmap_extension,public;
alter table admp_login_log_tab alter column des_usuario set not null;
-- dmap_object_gen_tag : type : alter table name : admp_login_log_tab
set search_path = admp,oracle,dmap_extension,public;
alter table admp_login_log_tab alter column fec_fecha_evento set not null;
-- dmap_object_gen_tag : type : alter table name : admp_login_log_tab
set search_path = admp,oracle,dmap_extension,public;
alter table admp_login_log_tab alter column des_estado set not null;
-- dmap_object_gen_tag : type : alter table name : admp_login_log_tab
set search_path = admp,oracle,dmap_extension,public;
alter table admp_login_log_tab alter column des_descripcion set not null;
-- dmap_object_gen_tag : type : alter table name : admp_login_log_tab
set search_path = admp,oracle,dmap_extension,public;
alter table admp_login_log_tab alter column des_tipo set not null;
-- dmap_object_gen_tag : type : alter table name : admp_login_log_tab
set search_path = admp,oracle,dmap_extension,public;
alter table admp_login_log_tab alter column num_created_by set not null;
-- dmap_object_gen_tag : type : alter table name : admp_login_log_tab
set search_path = admp,oracle,dmap_extension,public;
alter table admp_login_log_tab alter column fec_creation_date set not null;
-- dmap_object_gen_tag : type : alter table name : admp_login_log_tab
set search_path = admp,oracle,dmap_extension,public;
alter table admp_login_log_tab alter column num_last_update set not null;
-- dmap_object_gen_tag : type : alter table name : admp_login_log_tab
set search_path = admp,oracle,dmap_extension,public;
alter table admp_login_log_tab alter column fec_last_update set not null;
