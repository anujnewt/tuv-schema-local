-- dmap_object_gen_tag : type : table name : ss_user_change_log_tab
set search_path = usrdrc,oracle,dmap_extension,public;
create table "ss_user_change_log_tab"  (
id_user_change_log numeric not null,
id_user numeric,
cve_password varchar(255),
fec_change_date timestamp(0),
des_status varchar(100),
num_created_by numeric(15),
fec_creation_date timestamp(0),
num_last_updated_by numeric(15),
fec_last_update_date timestamp(0),
num_last_update_login numeric(15),
atributo1 varchar(250),
atributo2 varchar(250),
atributo3 varchar(250),
atributo4 varchar(250),
atributo5 varchar(250),
atributo6 varchar(250),
atributo7 varchar(250),
atributo8 varchar(250),
atributo9 varchar(250),
atributo10 varchar(250),
atributo11 varchar(250),
atributo12 varchar(250),
atributo13 varchar(250),
atributo14 varchar(250),
atributo15 varchar(250),
attribute_category varchar(250)
) ;
-- dmap_object_gen_tag : type : alter table name : ss_user_change_log_tab
set search_path = usrdrc,oracle,dmap_extension,public;
alter table ss_user_change_log_tab add constraint ss_user_change_log_pk primary key (id_user_change_log);
-- dmap_object_gen_tag : type : alter table name : ss_user_change_log_tab
set search_path = usrdrc,oracle,dmap_extension,public;
alter table ss_user_change_log_tab alter column id_user_change_log set not null;
