-- dmap_object_gen_tag : type : view name : xxtdl_int_services_cat_vw
set search_path = xx_lmktedial,oracle,dmap_extension,public;/* dmap converted statement start */
create or replace view "xxtdl_int_services_cat_vw"  ("id_service", "nom_service", "ind_desc_service", "ind_service_wsdl", "ind_origin", "ind_destiny", "ind_system", "ind_synchronous", "ind_cron_config", "ind_cron_active", "ind_cron_exe", "ind_cron_begin", "ind_cron_stop", "ind_show_param", "ind_parameters", "ind_estatus", "attribute_category", "attribute1", "attribute2", "attribute3", "attribute4", "attribute5", "attribute6", "attribute7", "attribute8", "attribute9", "attribute10", "attribute11", "attribute12", "attribute13", "attribute14", "attribute15", "fec_creation_date", "num_created_by", "fec_last_update_date", "num_last_updated_by", "num_last_update_login") as select scat.id_service,
scat.nom_service,
scat.ind_desc_service,
scat.ind_service_wsdl,
scat.ind_origin,
scat.ind_destiny,
scat.ind_system,
scat.ind_synchronous,
'abcdefghij' ind_cron_config,
(select max(cr.ind_estatus)
from xx_lmktedial.xxtdl_int_cron_config_tab cr
where cr.id_service = scat.id_service
) ind_cron_active,
'abcdefghij' ind_cron_exe,
'abcdefghij' ind_cron_begin,
'abcdefghij' ind_cron_stop,
'abcdefghij' ind_show_param,
'abcdefghij' ind_parameters,
scat.ind_estatus,
scat.attribute_category,
scat.attribute1,
scat.attribute2,
scat.attribute3,
scat.attribute4,
scat.attribute5,
scat.attribute6,
scat.attribute7,
scat.attribute8,
scat.attribute9,
scat.attribute10,
scat.attribute11,
scat.attribute12,
scat.attribute13,
scat.attribute14,
scat.attribute15,
scat.fec_creation_date,
scat.num_created_by,
scat.fec_last_update_date,
scat.num_last_updated_by,
scat.num_last_update_login
from xx_lmktedial.xxtdl_int_services_cat_tab scat
where scat.ind_system = 'Integration';/* dmap converted statement end */
-- estimed cost of view [ xxtdl_int_services_cat_vw ]: 1.00;
