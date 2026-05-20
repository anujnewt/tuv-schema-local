create or replace  function  xxmor.xxmor_funcional_pkg_xxmor_sol_totales_fun ( p_id_solicitud integer, p_linea integer, p_tipo varchar ) returns numeric as $body$
declare
-- pgv moved types start
-- pgv moved types end
v_total     numeric;
--dmap conversion comment: global temp variables moved as local temp variables
glo_document_temp text;
--dmap conversion comment: declaration boundary ends
begin
call dmap_extension.pkg_var_dmap_tab_to_gtt_init('XXMOR', 'XXMOR_FUNCIONAL_PKG');
--dmap conversion comment: gtt declaration added
--total spots por orden
case when p_tipo = 'SP_X_O' then
begin
--dbms_output.put_line(p_tipo);
select sum(ceil(to_number((((dmap_interval_to_days(to_timestamp(fecha_fin::text,'YYYYMMDD') - to_timestamp(fecha_inicio,'YYYYMMDD')))+1)/7)))
* (lunes::numeric+martes::numeric+miercoles::numeric+jueves::numeric+viernes::numeric+sabado::numeric+domingo)
)
into strict   v_total
from   xxmor_solicitudes_det_tab
where  id_solicitud = p_id_solicitud;
exception
when others then
v_total := null;
end;
--total spots por linea
when p_tipo = 'SP_X_L' then
begin
select  ceil(to_number((((dmap_interval_to_days(to_timestamp(fecha_fin::text,'YYYYMMDD') - to_timestamp(fecha_inicio,'YYYYMMDD')))+1)/7)))
* (lunes::numeric+martes::numeric+miercoles::numeric+jueves::numeric+viernes::numeric+sabado::numeric+domingo) as tot_spots
into strict    v_total
from    xxmor_solicitudes_det_tab
where   id_solicitud = p_id_solicitud
and     linea        = p_linea;
exception
when others then
v_total := null;
end;
-- total con descuento master contract por orden
when p_tipo = 'TCD_X_O' then
begin
select sum(tarifasp_sin_desc * xxmor_funcional_pkg_xxmor_desc_mcontid_fun(id_solicitud)
* ceil(to_number((((dmap_interval_to_days(to_timestamp(fecha_fin::text,'YYYYMMDD') - to_timestamp(fecha_inicio,'YYYYMMDD')))+1)/7)))
* (lunes::numeric+martes::numeric+miercoles::numeric+jueves::numeric+viernes::numeric+sabado::numeric+domingo)
)
into strict   v_total
from   xxmor_solicitudes_det_tab
where  id_solicitud = p_id_solicitud;
exception
when others then
v_total := null;
end;
-- total con descuento master contract mas sobrecargo por orden
when p_tipo = 'TCDSC_X_O' then
begin
select sum(case
when nullif(sobrecargo::text, '') is not null then
(tarifasp_sin_desc * xxmor_funcional_pkg_xxmor_desc_mcontid_fun(id_solicitud)
* ceil(to_number((((dmap_interval_to_days(to_timestamp(fecha_fin::text,'YYYYMMDD') - to_timestamp(fecha_inicio,'YYYYMMDD')))+1)/7)))
* (lunes::numeric+martes::numeric+miercoles::numeric+jueves::numeric+viernes::numeric+sabado::numeric+domingo)
) *
(case
when abs((trim(both replace(replace(upper(coalesce(sobrecargo,'0')), 'DESC. ', '-'), '%', '')))::numeric ) < 1 then (1 + (trim(both replace(replace(upper(coalesce(sobrecargo,'0')), 'DESC. ', '-'), '%', '')))::numeric )
else
(1 + ((trim(both replace(replace(upper(coalesce(sobrecargo,'0')), 'DESC. ', '-'), '%', '')))::numeric /100))
end)
else
(tarifasp_sin_desc * xxmor_funcional_pkg_xxmor_desc_mcontid_fun(id_solicitud)
* ceil(to_number((((dmap_interval_to_days(to_timestamp(fecha_fin::text,'YYYYMMDD') - to_timestamp(fecha_inicio,'YYYYMMDD')))+1)/7)))
* (lunes::numeric+martes::numeric+miercoles::numeric+jueves::numeric+viernes::numeric+sabado::numeric+domingo)
)
end) monto_lin_desc_sob
into strict   v_total
from   xxmor_solicitudes_det_tab
where  id_solicitud = p_id_solicitud;
exception
when others then
v_total := null;
end;
--total sin descuento por orden
when p_tipo = 'TSD_X_O' then
begin
select sum(tarifasp_sin_desc * ceil(to_number((((dmap_interval_to_days(to_timestamp(fecha_fin::text,'YYYYMMDD') - to_timestamp(fecha_inicio,'YYYYMMDD')))+1)/7)))
*(lunes::numeric+martes::numeric+miercoles::numeric+jueves::numeric+viernes::numeric+sabado::numeric+domingo)
)
into strict   v_total
from   xxmor_solicitudes_det_tab
where  id_solicitud = p_id_solicitud;
exception
when others then
v_total := null;
end;
--total por orden
when p_tipo = 'TOT_X_O' then
select trunc(100 * sum(tarifasp_sin_desc * ceil(to_number((((dmap_interval_to_days(to_timestamp(fecha_fin::text,'YYYYMMDD') - to_timestamp(fecha_inicio,'YYYYMMDD')))+1)/7)))
*(lunes::numeric+martes::numeric+miercoles::numeric+jueves::numeric+viernes::numeric+sabado::numeric+domingo)
),2)
into strict   v_total
from   xxmor_solicitudes_det_tab d,
(select distinct
id_solicitud,
numlinea_concom
from   xxmor_concom_rpta_tab
where  id_solicitud    = p_id_solicitud
and    nullif(numlinea_concom::text, '') is not null
and    id_seg_neg      = 1
except
select distinct
id_solicitud,
numlinea_concom
from   xxmor_concom_rpta_tab
where  id_solicitud    = p_id_solicitud
and    nullif(numlinea_concom::text, '') is not null
and    estatus_orduni  = '10'
and    id_seg_neg      = 1
)                         cr
where  d.id_solicitud = cr.id_solicitud
and    d.linea        = cr.numlinea_concom
and    d.id_solicitud = p_id_solicitud;
--total spots x semana de una linea
when p_tipo = 'SS_X_L' then
begin
select lunes::numeric+martes::numeric+miercoles::numeric+jueves::numeric+viernes::numeric+sabado::numeric+domingo as tot_spots
into strict   v_total
from   xxmor_solicitudes_det_tab
where  id_solicitud = p_id_solicitud
and    linea        = p_linea;
exception
when others then
v_total := null;
end;
--encabezado total de spots para insertar en sistema final
when p_tipo = 'TOT_SPOTS_BIEN' then
select sum(ceil(to_number((((dmap_interval_to_days(to_timestamp(fecha_fin::text,'YYYYMMDD') - to_timestamp(fecha_inicio,'YYYYMMDD')))+1)/7)))
*(lunes::numeric+martes::numeric+miercoles::numeric+jueves::numeric+viernes::numeric+sabado::numeric+domingo)
)
into strict   v_total
from   xxmor_solicitudes_det_tab d,
(select distinct
id_solicitud,
numlinea_concom
from   xxmor_concom_rpta_tab
where  id_solicitud    = p_id_solicitud
and    nullif(numlinea_concom::text, '') is not null
and    id_seg_neg      = 1
except
select distinct
id_solicitud,
numlinea_concom
from   xxmor_concom_rpta_tab
where  id_solicitud    = p_id_solicitud
and    nullif(numlinea_concom::text, '') is not null
and    estatus_orduni  = '10'
and    id_seg_neg      = 1
)                         cr
where  d.id_solicitud = cr.id_solicitud
and    d.linea        = cr.numlinea_concom
and    d.id_solicitud = p_id_solicitud;
when p_tipo = 'TOT_PARA_' then
begin
select lunes::numeric+martes::numeric+miercoles::numeric+jueves::numeric+viernes::numeric+sabado::numeric+domingo as tot_spots
into strict   v_total
from   xxmor_solicitudes_det_tab d
where  id_solicitud = p_id_solicitud
and    linea        = p_linea;
exception
when others then
v_total := null;
end;
end case;
return trunc(v_total,2);end;
$body$
language plpgsql
;
