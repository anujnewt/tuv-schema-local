create or replace procedure xxmor.xxmor_funcional_pkg_xxmor_genera_inf_rep_pr ( p_id_solicitud integer, p_id_fza_ventas integer ) as $body$
declare
-- pgv moved types start
-- pgv moved types end
--dmap conversion comment: global temp variables moved as local temp variables
glo_document_temp text;
--dmap conversion comment: declaration boundary ends
begin
call dmap_extension.pkg_var_dmap_tab_to_gtt_init('XXMOR', 'XXMOR_FUNCIONAL_PKG');--dmap conversion comment: gtt declaration added
--caso tncena (lineas que tienen hermanas y se dividen en porcentajes)
merge into xxmor_solicitudes_det_tab b
using(
select id_solicitud,  row_number() over () as linea, linea_hna, stnid, fecha_inicio, fecha_fin, duracion, buyuntid, hora_inicio, hora_fin, spots, lunes, martes, miercoles, jueves, viernes, sabado, domingo, spots_x_semana, tipo_servicio, usr_chr, spot_chr, bn, p, marca, version, tarifasp_sin_desc, tarifasp_con_desc, tot_linea_sin_desc, tot_linea_con_desc, sobrecargo, observaciones, created_by, created_date, updated_date, updated_by, linea_estatus, fecha_concom, tracking_id_concom, getrate_sin_ajuste, getrate_con_ajuste
from (select d.id_solicitud, d.linea,
case when nullif(stnid_padre::text, '') is null and nullif(stnid_hijo::text, '') is null then null
when stnid_padre = stnid_hijo and nullif(stnid_padre::text, '') is not null and nullif(stnid_hijo::text, '') is not null then linea
when stnid_padre != stnid_hijo then linea
end linea_hna,
coalesce(fc.stnid_hijo,d.stnid) as stnid, d.fecha_inicio, d.fecha_fin, d.duracion, d.buyuntid, d.hora_inicio, d.hora_fin, d.spots, d.lunes, d.martes, d.miercoles, d.jueves, d.viernes, d.sabado, d.domingo, d.spots_x_semana, d.tipo_servicio, d.usr_chr, d.spot_chr, d.bn, d.p, d.marca, d.version,
d.tarifasp_sin_desc*coalesce((stnid_porcentaje/100),1) as tarifasp_sin_desc, d.tarifasp_con_desc*coalesce((stnid_porcentaje/100),1) as tarifasp_con_desc, d.tot_linea_sin_desc*coalesce((stnid_porcentaje/100),1) as tot_linea_sin_desc, d.tot_linea_con_desc*coalesce((stnid_porcentaje/100) ,1) as tot_linea_con_desc, d.sobrecargo, d.observaciones, d.created_by, d.created_date, d.updated_date, d.updated_by, d.linea_estatus, d.fecha_concom, d.tracking_id_concom, d.getrate_sin_ajuste, d.getrate_con_ajuste
from xxmor_solicitudes_det_tab d
left outer join  xxmor_fzas_vtas_canales_tab fc on fc.id_fza_ventas = p_id_fza_ventas
and fc.stnid_padre  = d.stnid
and fc.id_seg_neg = 1
where d.id_solicitud = p_id_solicitud
order by  linea asc, fc.stnid_porcentaje desc) alias9) e
on (b.id_solicitud = e.id_solicitud and b.linea = e.linea)
when matched then
update set b.linea_hna = e.linea_hna,
b.stnid = e.stnid, b.fecha_inicio = e.fecha_inicio, b.fecha_fin = e.fecha_fin,
b.duracion = e.duracion, b.buyuntid = e.buyuntid, b.hora_inicio = e.hora_inicio, b.hora_fin = e.hora_fin,
b.spots = e.spots, b.lunes = e.lunes, b.martes = e.martes, b.miercoles = e.miercoles, b.jueves = e.jueves,
b.viernes = e.viernes, b.sabado = e.sabado, b.domingo = e.domingo, b.spots_x_semana = e.spots_x_semana,
b.tipo_servicio = e.tipo_servicio, b.usr_chr = e.usr_chr, b.spot_chr = e.spot_chr, b.bn = e.bn, b.p = e.p,
b.marca = e.marca, b.version = e.version, b.tarifasp_sin_desc = e.tarifasp_sin_desc, b.tarifasp_con_desc = e.tarifasp_con_desc,
b.tot_linea_sin_desc = e.tot_linea_sin_desc, b.tot_linea_con_desc = e.tot_linea_con_desc, b.sobrecargo = e.sobrecargo,
b.observaciones = e.observaciones
when not matched then
insert(id_solicitud,  linea, linea_hna, stnid, fecha_inicio, fecha_fin, duracion, buyuntid, hora_inicio, hora_fin, spots, lunes, martes, miercoles, jueves, viernes, sabado, domingo, spots_x_semana, tipo_servicio, usr_chr, spot_chr, bn, p, marca, version, tarifasp_sin_desc, tarifasp_con_desc, tot_linea_sin_desc, tot_linea_con_desc, sobrecargo, observaciones, created_by, created_date, updated_date, updated_by, linea_estatus, fecha_concom, tracking_id_concom, getrate_sin_ajuste, getrate_con_ajuste)
values (e.id_solicitud, e.linea, e.linea_hna,
e.stnid, e.fecha_inicio, e.fecha_fin, e.duracion, e.buyuntid, e.hora_inicio, e.hora_fin, e.spots, e.lunes, e.martes, e.miercoles, e.jueves, e.viernes, e.sabado, e.domingo, e.spots_x_semana, e.tipo_servicio, e.usr_chr, e.spot_chr, e.bn, e.p, e.marca, e.version, e.tarifasp_sin_desc, e.tarifasp_con_desc, e.tot_linea_sin_desc, e.tot_linea_con_desc, e.sobrecargo, e.observaciones, e.created_by, e.created_date, e.updated_date, e.updated_by, e.linea_estatus, e.fecha_concom, e.tracking_id_concom, e.getrate_sin_ajuste, e.getrate_con_ajuste);
--se genera la informacion para el estatus replica de las lineas hermanas
insert into xxmor_solicitudes_est_rep_tab(id_solicitud, linea,
id_sist, estat_rep
)
select p_id_solicitud, sd.linea,
fs.id_sist, 0
from   xxmor.xxmor_fzas_vtas_sistemas_tab fs,
xxmor.xxmor_solicitudes_det_tab    sd
where  sd.id_solicitud = p_id_solicitud
and    id_fza_ventas   = p_id_fza_ventas
and    id_seg_neg      = 1
and    not exists (select 1
from   xxmor_solicitudes_est_rep_tab er2
where  er2.id_solicitud = sd.id_solicitud
and    er2.linea        = sd.linea
);end;
$body$
language plpgsql
;
