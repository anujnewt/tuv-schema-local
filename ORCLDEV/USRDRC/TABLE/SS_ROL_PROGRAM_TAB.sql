-- dmap_object_gen_tag : type : table name : ss_rol_program_tab
set search_path = usrdrc,oracle,dmap_extension,public;
create table "ss_rol_program_tab"  (
id_rol numeric not null,
id_program numeric not null,
num_order_index numeric,
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
-- dmap_object_gen_tag : type : alter table name : ss_rol_program_tab
set search_path = usrdrc,oracle,dmap_extension,public;
alter table ss_rol_program_tab add constraint ss_rol_program_pk primary key (id_rol,id_program);
-- dmap_object_gen_tag : type : alter table name : ss_rol_program_tab
set search_path = usrdrc,oracle,dmap_extension,public;
alter table ss_rol_program_tab alter column id_rol set not null;
-- dmap_object_gen_tag : type : alter table name : ss_rol_program_tab
set search_path = usrdrc,oracle,dmap_extension,public;
alter table ss_rol_program_tab alter column id_program set not null;
