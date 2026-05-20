-- dmap_object_gen_tag : type : table name : ss_user_tab
set search_path = usrdrc,oracle,dmap_extension,public;
create table "ss_user_tab"  (
id_user numeric not null,
nom_user_long_name varchar(100),
nom_username varchar(30),
cve_password varchar(255),
id_status numeric,
nom_user_long_name2 varchar(100),
num_change_password numeric default 0,
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
-- dmap_object_gen_tag : type : alter table name : ss_user_tab
set search_path = usrdrc,oracle,dmap_extension,public;
alter table ss_user_tab add constraint ss_user_pk primary key (id_user);
-- dmap_object_gen_tag : type : alter table name : ss_user_tab
set search_path = usrdrc,oracle,dmap_extension,public;
alter table ss_user_tab alter column id_user set not null;
