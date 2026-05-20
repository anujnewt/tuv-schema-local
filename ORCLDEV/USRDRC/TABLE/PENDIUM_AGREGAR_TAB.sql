-- dmap_object_gen_tag : type : table name : pendium_agregar_tab
set search_path = usrdrc,oracle,dmap_extension,public;
create table "pendium_agregar_tab"  (
id_agregar_row varchar(256),
id_meta_row varchar(256),
id_empresa varchar(256),
id_agregar varchar(256),
agregar varchar(4000),
num_created_by numeric not null,
fec_creation_date timestamp(0) not null,
num_last_updated_by numeric not null,
fec_last_update_date timestamp(0) not null,
num_last_update_login numeric,
atributo1 varchar(256),
atributo2 varchar(256),
atributo3 varchar(256),
atributo4 varchar(256),
atributo5 varchar(256),
atributo6 varchar(256),
atributo7 varchar(256),
atributo8 varchar(256),
atributo9 varchar(256),
atributo10 varchar(256),
atributo11 varchar(256),
atributo12 varchar(256),
atributo13 varchar(256),
atributo14 varchar(256),
atributo15 varchar(256),
atribute_category varchar(256)
) ;
-- dmap_object_gen_tag : type : alter table name : pendium_agregar_tab
set search_path = usrdrc,oracle,dmap_extension,public;
alter table pendium_agregar_tab alter column num_created_by set not null;
-- dmap_object_gen_tag : type : alter table name : pendium_agregar_tab
set search_path = usrdrc,oracle,dmap_extension,public;
alter table pendium_agregar_tab alter column fec_creation_date set not null;
-- dmap_object_gen_tag : type : alter table name : pendium_agregar_tab
set search_path = usrdrc,oracle,dmap_extension,public;
alter table pendium_agregar_tab alter column num_last_updated_by set not null;
-- dmap_object_gen_tag : type : alter table name : pendium_agregar_tab
set search_path = usrdrc,oracle,dmap_extension,public;
alter table pendium_agregar_tab alter column fec_last_update_date set not null;
