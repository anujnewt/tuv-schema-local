-- dmap_object_gen_tag : type : view name : xxtdl_int_list_channels_all_vw
set search_path = xx_lmktedial,oracle,dmap_extension,public;/* dmap converted statement start */
create or replace view "xxtdl_int_list_channels_all_vw"  ("row_id", "id_service", "nom_service", "ind_desc_service", "id_parameter", "nom_parameter", "ind_desc_parameter", "ind_used_by", "ind_value_parameter", "ind_estatus", "fec_creation_date", "val_mostrar", "val_value", "selected") as select md5(cast(can.ctid as text)),
sct.id_service,
sct.nom_service,
sct.ind_desc_service,
can.id_parameter,
can.nom_parameter,
can.ind_desc_parameter,
can.ind_used_by,
can.ind_value_parameter,
can.ind_estatus,
can.fec_creation_date,
'false' val_mostrar,
'abcedario' val_value,
case when(select count(*)
from xx_lmktedial.xxtdl_int_services_params_tab prm
where prm.id_service    = sct.id_service
and prm.ind_parameter = can.nom_parameter
and prm.ind_val_parameter   = '1'
) > 0
then 'true'
else 'false' end as selected
from xx_lmktedial.xxtdl_int_config_param_tab can,
xx_lmktedial.xxtdl_int_services_cat_tab sct
where can.ind_used_by = 'CHANNEL_PARAMETER';/* dmap converted statement end */
-- estimed cost of view [ xxtdl_int_list_channels_all_vw ]: 3.00;
