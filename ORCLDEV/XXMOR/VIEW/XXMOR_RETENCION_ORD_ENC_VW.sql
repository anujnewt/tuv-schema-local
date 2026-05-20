-- dmap_object_gen_tag : type : view name : xxmor_retencion_ord_enc_vw
set search_path = xxmor,oracle,dmap_extension,public;/* dmap converted statement start */

create or replace view "xxmor_retencion_ord_enc_vw"  ("id_solicitud", "id_request", "id_seg_neg", "id_fza_ventas", "ident_fza_ventas", "id_solicitud_hna", "proc_por_linea", "garantizado", "advid", "mcontid", "mcontid_cutin", "email", "agyestnum", "accthdrid", "rtcrddscr", "rtcrd", "rtcrddscr_cutin", "rtcrd_cutin", "comentarios", "secnum", "plataforma_canal", "agrupador", "prdid_desc", "prdid", "total_spots", "total_sin_desc", "total_con_desc", "tipo_facturacion", "descuento", "target", "created_date", "created_by", "updated_date", "updated_by", "orden_estatus", "fecha_concom", "tracking_id_concom", "aux1", "aux2", "aux3") as select distinct e.id_solicitud,  e.id_request,  e.id_seg_neg,  e.id_fza_ventas,  f.ident_fza_ventas,  e.id_solicitud_hna,  e.proc_por_linea,  e.garantizado,  e.advid,  e.mcontid,  e.mcontid_cutin,  e.email,  e.agyestnum,  e.accthdrid,  e.rtcrddscr,  e.rtcrd,  e.rtcrddscr_cutin,  e.rtcrd_cutin,  e.comentarios,  e.secnum,  e.plataforma_canal,  e.agrupador,  e.prdid_desc,  e.prdid,  e.total_spots,  e.total_sin_desc,  e.total_con_desc,  e.tipo_facturacion,  e.descuento,  e.target,  e.created_date,  e.created_by,  e.updated_date,  e.updated_by,  e.orden_estatus,  e.fecha_concom,  e.tracking_id_concom,  e.aux1,  e.aux2,  e.aux3
from xxmor_solicitudes_enc_tab e,
xxmor_concom_rpta_tab c,
xxmor_fzas_vtas_tab f
where e.id_fza_ventas = f.id_fza_ventas::NUMERIC
and e.id_solicitud = c.id_solicitud::NUMERIC
and upper(c.accion_concom) = 'RETENCION'
and c.estatus_orduni = 10
;/* dmap converted statement end */
-- estimed cost of view [ xxmor_retencion_ord_enc_vw ]: 1.00;
