-- dmap_object_gen_tag : type : table name : xxtdl_int_dataxchange_tab
set search_path = xxmor,oracle,dmap_extension,public;
create table "xxtdl_int_dataxchange_tab"  (
id_dataxchange numeric not null,
id_channel_group_uid numeric,
ind_channel_group varchar(150),
des_description varchar(250),
id_nprogrammeuid numeric,
id_programme_type_uid numeric,
last_update_date_pgm timestamp(0),
id_series_uid numeric,
id_nepisodeuid numeric,
last_update_date_ep timestamp(0),
num_no_of_versions numeric,
id_nversionuid numeric,
id_nversionstatusuid numeric,
id_vversionstatuscode varchar(150),
id_vversioncode varchar(150),
des_title varchar(250),
last_update_date_ver timestamp(0),
id_material_type_uid numeric,
id_material_uid numeric,
id_media_type_uid numeric,
fec_creation_pgm timestamp(0),
fec_creation_epd timestamp(0),
fec_creation_ver timestamp(0),
id_creation_versioncd varchar(150),
fec_pivot_date_pgm timestamp(0),
fec_pivot_date_epd timestamp(0),
fec_pivot_date_ver timestamp(0),
id_pivot_versioncd varchar(150),
ind_estatus_lmk varchar(1),
ind_estatus_int varchar(1),
ind_estatus_tdl varchar(1),
id_request numeric,
id_request_row numeric,
fec_updated_tdl timestamp(0),
fec_updated_int timestamp(0),
ind_estatus varchar(1),
attribute_category varchar(150),
attribute1 varchar(150),
attribute2 varchar(150),
attribute3 varchar(150),
attribute4 varchar(150),
attribute5 varchar(150),
attribute6 varchar(150),
attribute7 varchar(150),
attribute8 varchar(150),
attribute9 varchar(150),
attribute10 varchar(150),
attribute11 varchar(150),
attribute12 varchar(150),
attribute13 varchar(150),
attribute14 varchar(150),
attribute15 varchar(150),
fec_creation_date timestamp(0) not null,
num_created_by numeric not null,
fec_last_update_date timestamp(0) not null,
num_last_updated_by numeric not null,
num_last_update_login numeric
) ;
-- dmap_object_gen_tag : type : alter table name : xxtdl_int_dataxchange_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxtdl_int_dataxchange_tab add primary key (id_dataxchange);
-- dmap_object_gen_tag : type : alter table name : xxtdl_int_dataxchange_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxtdl_int_dataxchange_tab alter column id_dataxchange set not null;
-- dmap_object_gen_tag : type : alter table name : xxtdl_int_dataxchange_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxtdl_int_dataxchange_tab alter column fec_creation_date set not null;
-- dmap_object_gen_tag : type : alter table name : xxtdl_int_dataxchange_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxtdl_int_dataxchange_tab alter column num_created_by set not null;
-- dmap_object_gen_tag : type : alter table name : xxtdl_int_dataxchange_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxtdl_int_dataxchange_tab alter column fec_last_update_date set not null;
-- dmap_object_gen_tag : type : alter table name : xxtdl_int_dataxchange_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxtdl_int_dataxchange_tab alter column num_last_updated_by set not null;
