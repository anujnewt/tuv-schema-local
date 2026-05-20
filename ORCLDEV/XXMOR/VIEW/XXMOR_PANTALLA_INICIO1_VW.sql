-- dmap_object_gen_tag : type : view name : xxmor_pantalla_inicio1_vw
set search_path = xxmor,oracle,dmap_extension,public;/* dmap converted statement start */

create or replace view "xxmor_pantalla_inicio1_vw"  ("id_notificacion", "desc_notificacion", "ordenes") as select
est.id_notificacion,
est.desc_notificacion,
(select count(*)  from xxmor_solicitudes_enc_tab where orden_estatus = est.id_notificacion::VARCHAR and id_seg_neg::NUMERIC = 1::NUMERIC) ordenes
from
xxmor_ordenes_estatus_tab est
where (select count(*) from xxmor_solicitudes_enc_tab where orden_estatus = est.id_notificacion::VARCHAR and id_seg_neg::NUMERIC = 1::NUMERIC) != 0
order by  id_notificacion asc
;/* dmap converted statement end */
-- estimed cost of view [ xxmor_pantalla_inicio1_vw ]: 1.00;
