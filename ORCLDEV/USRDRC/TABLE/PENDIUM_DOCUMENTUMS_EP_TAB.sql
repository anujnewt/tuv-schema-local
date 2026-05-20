-- dmap_object_gen_tag : type : table name : pendium_documentums_ep_tab
set search_path = usrdrc,oracle,dmap_extension,public;
create table "pendium_documentums_ep_tab"  (
id_doc_ep_pk decimal(38, 1) not null,
id_ep_fk numeric(38),
desc_title varchar(500),
id_documentcve varchar(200),
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
attribute_category varchar(250),
ind_status numeric(38),
fec_rec varchar(20),
fec_ent varchar(20)
) ;
-- dmap_object_gen_tag : type : alter table name : pendium_documentums_ep_tab
set search_path = usrdrc,oracle,dmap_extension,public;
alter table pendium_documentums_ep_tab add constraint pendium_documentums_ep_ta_pk primary key (id_doc_ep_pk);
