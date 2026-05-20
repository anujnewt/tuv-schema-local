-- dmap_object_gen_tag : type : view name : xxmor_getspotrate_vw
set search_path = xxmor,oracle,dmap_extension,public;/* dmap converted statement start */
create or replace view "xxmor_getspotrate_vw"  ("id_solicitud", "id_request", "id_seg_neg", "id_fza_ventas", "linea", "rtcrddscr", "rtcrd", "mcontid", "advid", "stnid", "pgmid", "fecha_1a_tran", "hora_inicio", "hora_fin", "duracion", "sobrecargo", "marca", "agencia", "fecha_captura", "dia_semana") as select e.id_solicitud,
e.id_request,
e.id_seg_neg,
e.id_fza_ventas,
d.linea,
e.rtcrddscr,
e.rtcrd,
e.mcontid,
e.advid,
d.stnid,
d.buyuntid as pgmid,
to_char(
to_timestamp(xxmor_funcional_pkg.
xxmor_sol_fechas_fun(e.id_solicitud,  d.linea,  'F_1A_T'), 'yyyymmdd'),
'yyyy-mm-dd')
as fecha_1a_tran,
d.hora_inicio || '0000' as hora_inicio,
d.hora_fin || '0000' as hora_fin,
d.duracion,
trim(both replace(replace(upper(d.sobrecargo),  'DESC. ',  '-'),  '%',  ''))
as sobrecargo,
d.marca,
'' as agencia,
to_char(statement_timestamp(),  'yyyy-mm-dd') as fecha_captura,
case
when (sabado)::numeric  > 0 then 'S'
when (domingo)::numeric  > 0 then 'D'
else 'L-V'
end
as "dia_semana"
from xxmor.xxmor_solicitudes_enc_tab e,
xxmor.xxmor_solicitudes_det_tab d
where e.id_solicitud = d.id_solicitud and id_seg_neg = 1
;/* dmap converted statement end */
-- estimed cost of view [ xxmor_getspotrate_vw ]: 1.30;
