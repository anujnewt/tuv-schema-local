-- dmap_object_gen_tag : type : view name : xxmor_retencion_ord_det_vw
set search_path = xxmor,oracle,dmap_extension,public;/* dmap converted statement start */

create or replace view "xxmor_retencion_ord_det_vw"  ("id_solicitud", "linea", "linea_hna", "stnid", "fecha_inicio", "fecha_fin", "duracion", "buyuntid", "hora_inicio", "hora_fin", "spots", "lunes", "martes", "miercoles", "jueves", "viernes", "sabado", "domingo", "spots_x_semana", "tipo_servicio", "usr_chr", "spot_chr", "bn", "p", "marca", "version", "tarifasp_sin_desc", "tarifasp_con_desc", "tot_linea_sin_desc", "tot_linea_con_desc", "sobrecargo", "observaciones", "created_by", "created_date", "updated_date", "updated_by", "linea_estatus", "fecha_concom", "tracking_id_concom", "getrate_sin_ajuste", "getrate_con_ajuste") as select
distinct d.id_solicitud,  d.linea,  d.linea_hna,  d.stnid,  d.fecha_inicio,  d.fecha_fin,  d.duracion,  d.buyuntid,  d.hora_inicio,  d.hora_fin,  d.spots,  d.lunes,  d.martes,  d.miercoles,  d.jueves,  d.viernes,  d.sabado,  d.domingo,  d.spots_x_semana,  d.tipo_servicio,  d.usr_chr,  d.spot_chr,  d.bn,  d.p,  d.marca,  d.version,  d.tarifasp_sin_desc,  d.tarifasp_con_desc,  d.tot_linea_sin_desc,  d.tot_linea_con_desc,  d.sobrecargo,  d.observaciones,  d.created_by,  d.created_date,  d.updated_date,  d.updated_by,  d.linea_estatus,  d.fecha_concom,  d.tracking_id_concom,  d.getrate_sin_ajuste,  d.getrate_con_ajuste
from xxmor_solicitudes_det_tab d,
xxmor_concom_rpta_tab cr
where d.id_solicitud = cr.id_solicitud::NUMERIC
and d.linea = (cr.numlinea_concom)::numeric
and cr.id_seg_neg = 1::NUMERIC
and cr.estatus_orduni = 10
and upper(cr.accion_concom) = 'RETENCION'
;/* dmap converted statement end */
-- estimed cost of view [ xxmor_retencion_ord_det_vw ]: 1.00;
