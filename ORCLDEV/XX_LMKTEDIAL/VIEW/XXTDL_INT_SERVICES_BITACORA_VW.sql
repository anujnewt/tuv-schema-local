-- dmap_object_gen_tag : type : view name : xxtdl_int_services_bitacora_vw
set search_path = xx_lmktedial,oracle,dmap_extension,public;/* dmap converted statement start */
create or replace view "xxtdl_int_services_bitacora_vw"  ("id_bitacora", "id_log_services", "id_service", "nom_service", "ind_process", "ind_process_nom", "num_process_id", "num_pgm_process_id", "ind_evento", "ind_estatus", "attribute_category", "attribute1", "attribute2", "attribute3", "attribute4", "attribute5", "attribute6", "attribute7", "attribute8", "attribute9", "attribute10", "attribute11", "attribute12", "attribute13", "attribute14", "attribute15", "fec_creation_date", "num_created_by", "fec_last_update_date", "num_last_updated_by", "num_last_update_login") as select sbit.id_bitacora,
sbit.id_log_services,
sbit.id_service,
(select csv.ind_desc_service
from xx_lmktedial.xxtdl_int_services_cat_tab csv
where csv.id_service = sbit.id_service
) nom_service,
sbit.ind_process,
(select csv.nom_parameter
from xx_lmktedial.xxtdl_int_config_param_tab csv
where csv.id_parameter = sbit.ind_process
) ind_process_nom,
sbit.num_process_id,
sbit.num_pgm_process_id,
sbit.ind_evento,
sbit.ind_estatus,
sbit.attribute_category,
sbit.attribute1,
sbit.attribute2,
sbit.attribute3,
sbit.attribute4,
sbit.attribute5,
sbit.attribute6,
sbit.attribute7,
sbit.attribute8,
sbit.attribute9,
sbit.attribute10,
sbit.attribute11,
sbit.attribute12,
sbit.attribute13,
sbit.attribute14,
sbit.attribute15,
sbit.fec_creation_date,
sbit.num_created_by,
sbit.fec_last_update_date,
sbit.num_last_updated_by,
sbit.num_last_update_login
from xx_lmktedial.xxtdl_int_service_bitacora_tab sbit;/* dmap converted statement end */
-- estimed cost of view [ xxtdl_int_services_bitacora_vw ]: 1.00;
