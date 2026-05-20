-- dmap_object_gen_tag : type : table name : xxtdl_int_service_bitacora_tab
set search_path = xxmor,oracle,dmap_extension,public;
create table "xxtdl_int_service_bitacora_tab"  (
id_bitacora varchar(150) not null,
id_log_services numeric,
id_service numeric,
ind_process numeric,
num_process_id numeric,
num_pgm_process_id numeric,
ind_evento varchar(500),
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
-- dmap_object_gen_tag : type : alter table name : xxtdl_int_service_bitacora_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxtdl_int_service_bitacora_tab add primary key (id_bitacora);
-- dmap_object_gen_tag : type : alter table name : xxtdl_int_service_bitacora_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxtdl_int_service_bitacora_tab alter column fec_creation_date set not null;
-- dmap_object_gen_tag : type : alter table name : xxtdl_int_service_bitacora_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxtdl_int_service_bitacora_tab alter column num_created_by set not null;
-- dmap_object_gen_tag : type : alter table name : xxtdl_int_service_bitacora_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxtdl_int_service_bitacora_tab alter column fec_last_update_date set not null;
-- dmap_object_gen_tag : type : alter table name : xxtdl_int_service_bitacora_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxtdl_int_service_bitacora_tab alter column num_last_updated_by set not null;
