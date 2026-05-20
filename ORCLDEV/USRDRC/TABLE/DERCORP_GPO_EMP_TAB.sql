-- dmap_object_gen_tag : type : table name : dercorp_gpo_emp_tab
set search_path = usrdrc,oracle,dmap_extension,public;
create table "dercorp_gpo_emp_tab"  (
id_gpo_empresa numeric not null,
cve_gpo_empresa varchar(100),
nom_gpo_empresa varchar(250),
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
-- dmap_object_gen_tag : type : alter table name : dercorp_gpo_emp_tab
set search_path = usrdrc,oracle,dmap_extension,public;
alter table dercorp_gpo_emp_tab add constraint dercorp_gpo_empresa_tab_pk primary key (id_gpo_empresa);
-- dmap_object_gen_tag : type : alter table name : dercorp_gpo_emp_tab
set search_path = usrdrc,oracle,dmap_extension,public;
alter table dercorp_gpo_emp_tab alter column id_gpo_empresa set not null;
