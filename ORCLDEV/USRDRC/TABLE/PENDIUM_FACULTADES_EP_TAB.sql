-- dmap_object_gen_tag : type : table name : pendium_facultades_ep_tab
set search_path = usrdrc,oracle,dmap_extension,public;
create table "pendium_facultades_ep_tab"  (
id_fac_ep_pk decimal(38, 1) not null,
id_opoder_ep_fk numeric(38) not null,
id_ep_fk numeric(38) not null,
ind_tipo numeric(38),
des_tipo varchar(50),
ind_delegable varchar(50),
ind_individual varchar(50),
caracteristicas varchar(4000),
mancomunado numeric(38),
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
ind_status numeric(38),
des_formae varchar(4000)
) ;
-- dmap_object_gen_tag : type : alter table name : pendium_facultades_ep_tab
set search_path = usrdrc,oracle,dmap_extension,public;
alter table pendium_facultades_ep_tab add constraint pendium_facultades_ep_ta_pk primary key (id_fac_ep_pk);
-- dmap_object_gen_tag : type : alter table name : pendium_facultades_ep_tab
set search_path = usrdrc,oracle,dmap_extension,public;
alter table pendium_facultades_ep_tab alter column id_fac_ep_pk set not null;
-- dmap_object_gen_tag : type : alter table name : pendium_facultades_ep_tab
set search_path = usrdrc,oracle,dmap_extension,public;
alter table pendium_facultades_ep_tab alter column id_opoder_ep_fk set not null;
-- dmap_object_gen_tag : type : alter table name : pendium_facultades_ep_tab
set search_path = usrdrc,oracle,dmap_extension,public;
alter table pendium_facultades_ep_tab alter column id_ep_fk set not null;
