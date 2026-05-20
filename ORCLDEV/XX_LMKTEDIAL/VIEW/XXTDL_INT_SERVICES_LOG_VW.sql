-- dmap_object_gen_tag : type : view name : xxtdl_int_services_log_vw
set search_path = xx_lmktedial,oracle,dmap_extension,public;/* dmap converted statement start */
create or replace view "xxtdl_int_services_log_vw"  ("id_log_services", "id_service", "nom_service", "id_file_xml", "id_request", "nom_file", "ind_parameters", "show_request", "show_response", "ind_process", "ind_process_nom", "ind_response", "num_user", "fec_response", "fec_request", "num_process_id", "num_pgm_process_id", "ind_calculate_status", "ind_estatus", "attribute_category", "attribute1", "attribute2", "attribute3", "attribute4", "attribute5", "attribute6", "attribute7", "attribute8", "attribute9", "attribute10", "attribute11", "attribute12", "attribute13", "attribute14", "attribute15", "fec_creation_date", "num_created_by", "fec_last_update_date", "num_last_updated_by", "num_last_update_login") as select slog.id_log_services,
slog.id_service,
(select csv.ind_desc_service
from xx_lmktedial.xxtdl_int_services_cat_tab csv
where csv.id_service = slog.id_service
) nom_service,
xfl.id_file_xml,
xfl.id_request,
xfl.nom_file,
xfl.attribute1 as ind_parameters,
(case when(select count(1)
from xx_lmktedial.xxtdl_int_xml_files_tab xtb
where xtb.id_request       = xfl.id_request
and xtb.id_service       = xfl.id_service
and xtb.id_file_xml      = xfl.id_file_xml
and upper(ind_file_type) = upper('REQUEST')
) > 0 then 'true'
else 'false'
end
) as show_request,
(case when(select count(1)
from xx_lmktedial.xxtdl_int_xml_files_tab xtb
where xtb.id_request       = xfl.id_request
and xtb.id_service       = xfl.id_service
and xtb.id_file_xml      = xfl.id_file_xml
and upper(ind_file_type) = upper('RESPONSE')
) > 0 then 'true'
else 'false'
end
) as show_response,
slog.ind_process,
(select csv.nom_parameter
from xx_lmktedial.xxtdl_int_config_param_tab csv
where csv.id_parameter = slog.ind_process
) ind_process_nom,
slog.ind_response,
slog.num_user,
slog.fec_response,
slog.fec_request,
slog.num_process_id,
slog.num_pgm_process_id,
(select distinct case xtb.ind_estatus
when 'R' then 'CREADO'
when 'C' then 'COMPLETO'
when 'E' then 'COMPLETO CON ERROR'
when 'L' then 'EN LANDMARK'
when 'F' then 'ERROR AL ENVIAR A LANDMARK'
when 'M' then 'LEIDO, CON ERRORES EN PARADIGM'
when 'W' then 'LEIDO, EN TABLAS DE PARADIGM'
else 'DESCONOCIDO'
end case
from xx_lmktedial.xxtdl_int_xml_files_tab xtb
where xtb.id_request       = xfl.id_request
and xtb.id_service       = xfl.id_service
and xtb.id_file_xml      = xfl.id_file_xml
)
as ind_calculate_status,
xfl.ind_estatus,
slog.attribute_category,
slog.attribute1,
slog.attribute2,
slog.attribute3,
slog.attribute4,
slog.attribute5,
slog.attribute6,
slog.attribute7,
slog.attribute8,
slog.attribute9,
slog.attribute10,
slog.attribute11,
slog.attribute12,
slog.attribute13,
slog.attribute14,
slog.attribute15,
slog.fec_creation_date,
slog.num_created_by,
xfl.fec_last_update_date,
slog.num_last_updated_by,
slog.num_last_update_login
from xx_lmktedial.xxtdl_int_services_log_tab slog,
xx_lmktedial.xxtdl_int_xml_files_tab    xfl
where slog.id_log_services = xfl.id_request
and slog.id_service      = xfl.id_service;/* dmap converted statement end */
-- estimed cost of view [ xxtdl_int_services_log_vw ]: 1.00;
