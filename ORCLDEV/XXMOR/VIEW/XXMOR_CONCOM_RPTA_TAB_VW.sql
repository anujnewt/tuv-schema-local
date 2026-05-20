-- dmap_object_gen_tag : type : view name : xxmor_concom_rpta_tab_vw
set search_path = xxmor,oracle,dmap_extension,public;/* dmap converted statement start */
create or replace view "xxmor_concom_rpta_tab_vw"  ("id_solicitud", "id_rpta_concom", "resultadogeneral", "trackingid", "desc_concom", "posicion_concom", "id_concom", "numlinea_concom", "estatus_concom", "campo_concom", "detalle_concom", "accion_concom", "tiporegla_concom", "estatus_orduni", "created_date", "created_by", "updated_date", "updated_by", "id_seg_neg", "take_it") as select id_solicitud,  id_rpta_concom,  resultadogeneral,  trackingid,  desc_concom,  posicion_concom,  id_concom,  numlinea_concom,
estatus_concom,  campo_concom,  detalle_concom,  accion_concom,  tiporegla_concom,  estatus_orduni,  created_date,  created_by,
updated_date,  updated_by,  id_seg_neg, coalesce(updated_by, 0) as "take_it"
from xxmor_concom_rpta_tab
;/* dmap converted statement end */
-- estimed cost of view [ xxmor_concom_rpta_tab_vw ]: 1.00;
