-- dmap_object_gen_tag : type : table name : admp_log_tab
set search_path = admp,oracle,dmap_extension,public;
create table "admp_log_tab"  (
id_log numeric not null,
des_clase varchar(100),
des_metodo varchar(100),
num_linea numeric,
des_causa varchar(2000),
des_mensaje varchar(2000),
des_exception varchar(2000),
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
-- dmap_object_gen_tag : type : alter table name : admp_log_tab
set search_path = admp,oracle,dmap_extension,public;
alter table admp_log_tab add constraint admp_log_pk primary key (id_log);
-- dmap_object_gen_tag : type : alter table name : admp_log_tab
set search_path = admp,oracle,dmap_extension,public;
alter table admp_log_tab alter column id_log set not null;
-- dmap_object_gen_tag : type : alter table name : admp_log_tab
set search_path = admp,oracle,dmap_extension,public;
alter table admp_log_tab alter column num_created_by set not null;
-- dmap_object_gen_tag : type : alter table name : admp_log_tab
set search_path = admp,oracle,dmap_extension,public;
alter table admp_log_tab alter column fec_creation_date set not null;
-- dmap_object_gen_tag : type : alter table name : admp_log_tab
set search_path = admp,oracle,dmap_extension,public;
alter table admp_log_tab alter column num_last_update set not null;
-- dmap_object_gen_tag : type : alter table name : admp_log_tab
set search_path = admp,oracle,dmap_extension,public;
alter table admp_log_tab alter column fec_last_update set not null;
