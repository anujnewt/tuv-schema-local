-- dmap_object_gen_tag : type : table name : dercorp_reporte_tab
set search_path = usrdrc,oracle,dmap_extension,public;
create table "dercorp_reporte_tab"  (
id_reporte numeric not null,
id_empresa numeric,
nom_reporte varchar(250),
des_reporte varchar(250),
des_url varchar(250),
nom_file varchar(250),
des_layout varchar(250),
des_query varchar(250),
des_acceso varchar(250),
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
-- dmap_object_gen_tag : type : alter table name : dercorp_reporte_tab
set search_path = usrdrc,oracle,dmap_extension,public;
alter table dercorp_reporte_tab add constraint id_reporte_pk primary key (id_reporte);
