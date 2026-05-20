-- dmap_object_gen_tag : type : table name : pendium_apoderado_ep_tab
set search_path = usrdrc,oracle,dmap_extension,public;
create table "pendium_apoderado_ep_tab"  (
id_apod_ep_pk decimal(38, 1) not null,
id_opoder_ep_fk numeric(38) not null,
id_ep_fk numeric(38) not null,
ind_tipoapoderado numeric(38),
desc_tipoapoderado varchar(20),
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
attribute_category varchar(250),
id_empl_fk numeric not null,
desc_nom_empl varchar(250) not null,
ind_aprevoca varchar(20),
desc_revoca varchar(4000),
ind_status numeric(38),
des_grupo varchar(200),
id_grupo_fk numeric
) ;
-- dmap_object_gen_tag : type : alter table name : pendium_apoderado_ep_tab
set search_path = usrdrc,oracle,dmap_extension,public;
alter table pendium_apoderado_ep_tab add constraint pendium_apoderado_ep_ta_pk primary key (id_apod_ep_pk);
-- dmap_object_gen_tag : type : alter table name : pendium_apoderado_ep_tab
set search_path = usrdrc,oracle,dmap_extension,public;
alter table pendium_apoderado_ep_tab alter column id_apod_ep_pk set not null;
-- dmap_object_gen_tag : type : alter table name : pendium_apoderado_ep_tab
set search_path = usrdrc,oracle,dmap_extension,public;
alter table pendium_apoderado_ep_tab alter column id_opoder_ep_fk set not null;
-- dmap_object_gen_tag : type : alter table name : pendium_apoderado_ep_tab
set search_path = usrdrc,oracle,dmap_extension,public;
alter table pendium_apoderado_ep_tab alter column id_ep_fk set not null;
-- dmap_object_gen_tag : type : alter table name : pendium_apoderado_ep_tab
set search_path = usrdrc,oracle,dmap_extension,public;
alter table pendium_apoderado_ep_tab alter column id_empl_fk set not null;
-- dmap_object_gen_tag : type : alter table name : pendium_apoderado_ep_tab
set search_path = usrdrc,oracle,dmap_extension,public;
alter table pendium_apoderado_ep_tab alter column desc_nom_empl set not null;
