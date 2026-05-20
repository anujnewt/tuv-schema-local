create or replace  function  xxmor.xxmor_funcional_pkg_xxmor_sol_fechas_fun ( p_id_solicitud integer, p_linea integer, p_tipo varchar ) returns varchar as $body$
declare
-- pgv moved types start
-- pgv moved types end
v_total     varchar(100);
--dmap conversion comment: global temp variables moved as local temp variables
glo_document_temp text;
--dmap conversion comment: declaration boundary ends
begin
call dmap_extension.pkg_var_dmap_tab_to_gtt_init('XXMOR', 'XXMOR_FUNCIONAL_PKG');/* dmap converted statement start */
--dmap conversion comment: gtt declaration added
if p_tipo = 'F_1A_T' then
begin
select to_char(to_timestamp(fecha_inicio,'yyyymmdd')
,0+,0  case
when lunes != 0 then 0
when martes != 0 then 1
when miercoles != 0 then 2
when jueves != 0 then 3
when viernes != 0 then 4
when sabado!= 0 then 5
when domingo != 0 then 6
else null
end,'YYYYMMDD')
into strict v_total
from xxmor_solicitudes_det_tab
where id_solicitud = p_id_solicitud
and linea = p_linea;/* dmap converted statement end */
exception
when others then
v_total := '00010101';
end;/* dmap converted statement start */
elsif p_tipo = 'F_U_T' then
begin
select to_char(to_timestamp(fecha_fin,'yyyymmdd')
,0-,0  case
when domingo != 0 then 0
when sabado != 0 then 1
when viernes != 0 then 2
when jueves  != 0 then 3
when miercoles != 0 then 4
when martes != 0 then 5
when lunes != 0 then 6
else null
end,'YYYYMMDD')
into strict v_total
from xxmor_solicitudes_det_tab
where id_solicitud = p_id_solicitud
and linea = p_linea;/* dmap converted statement end */
exception
when others then
v_total := '00010101';
end;
/*
--fecha exacta primera transmision para copys por orden
elsif p_tipo = fecopy_pt_xo then
begin
select to_char(to_date(fecha_inicio, yyyymmdd)
-  case
when domingo != 0 then 0
when sabado != 0 then 1
when viernes != 0 then 2
when jueves  != 0 then 3
when miercoles != 0 then 4
when martes != 0 then 5
when lunes != 0 then 6
else null
end,yyyymmdd)
into v_total
from xxmor_solicitudes_det_tab
where id_solicitud = p_id_solicitud
and linea = (select min(to_date(fecha_inicio,yyyymmdd)
from xxmor_solicitudes_det_tab
where id_solicitud = p_id_solicitud);
exception
when others then
v_total := 00010101;
end;
--fecha exacta ultima transmision para copys por orden
elsif p_tipo = fecopy_ut_xo then
begin
select to_char(to_date(fecha_fin, yyyymmdd)
-  case
when domingo != 0 then 0
when sabado != 0 then 1
when viernes != 0 then 2
when jueves  != 0 then 3
when miercoles != 0 then 4
when martes != 0 then 5
when lunes != 0 then 6
else null
end,yyyymmdd)
into v_total
from xxmor_solicitudes_det_tab
where id_solicitud = p_id_solicitud
and linea = (select max(to_date(fecha_inicio,yyyymmdd)
from xxmor_solicitudes_det_tab
where id_solicitud = p_id_solicitud);
exception
when others then
v_total := 00010101;
end;
*/
--regresa la fecha inicio a nivel de encabezado (debe ser la fecha menor de las lineas que estan listas para ser enviadas a paradigm o que ya se enviaron)
elsif  p_tipo = 'FI_ENC' then
select  to_char(min(to_timestamp(fecha_inicio,'YYYYMMDD')),'YYYY-MM-DD')
into strict v_total
from xxmor_solicitudes_det_tab d,
(select distinct id_solicitud, numlinea_concom
from xxmor_concom_rpta_tab
where nullif(numlinea_concom::text, '') is not null
and     id_seg_neg = 1
except
select distinct id_solicitud, numlinea_concom
from xxmor_concom_rpta_tab
where estatus_orduni = '10'
and     id_seg_neg = 1) cr
where  d.id_solicitud = cr.id_solicitud
and d.linea = cr.numlinea_concom
and d.id_solicitud = p_id_solicitud
and exists (select 1
from  xxmor_solicitudes_enc_tab e
where e.id_solicitud = d.id_solicitud
and     e.id_seg_neg = 1
);
--regresa la fecha final a nivel de encabezado (debe ser la fecha mayor de las lineas que estan listas para ser enviadas a paradigm o que ya se enviaron)
elsif  p_tipo = 'FF_ENC' then
select  to_char(max(to_timestamp(fecha_fin,'YYYYMMDD')),'YYYY-MM-DD')
into strict v_total
from xxmor_solicitudes_det_tab d,
(select distinct id_solicitud, numlinea_concom
from xxmor_concom_rpta_tab
where nullif(numlinea_concom::text, '') is not null
and     id_seg_neg = 1
except
select distinct id_solicitud, numlinea_concom
from xxmor_concom_rpta_tab
where estatus_orduni = '10'
and     id_seg_neg = 1) cr
where  d.id_solicitud = cr.id_solicitud
and d.linea = cr.numlinea_concom
and d.id_solicitud = p_id_solicitud
and exists (select 1
from  xxmor_solicitudes_enc_tab e
where e.id_solicitud = d.id_solicitud
and     e.id_seg_neg = 1
);
-- regresa la fecha para calcular rtcrd_ca
--elsif  p_tipo = ff_rtcrd_ca then
--regresa la fecha inicial para los copys(debe ser la fecha menor de las lineas de la orden) 06jun2013
elsif  p_tipo = 'FI_COPY' then
select to_char(min(to_timestamp(fecha_inicio,'YYYYMMDD')),'YYYY-MM-DD')
into strict   v_total
from   xxmor_solicitudes_det_tab d,
(select distinct id_solicitud, numlinea_concom
from   xxmor_concom_rpta_tab
where  nullif(numlinea_concom::text, '') is not null
and    id_seg_neg      = 1
) cr
where  d.id_solicitud = cr.id_solicitud
and    d.linea        = cr.numlinea_concom
and    d.id_solicitud = p_id_solicitud
and    exists (select 1
from   xxmor_solicitudes_enc_tab e
where  e.id_solicitud = d.id_solicitud
and    e.id_seg_neg   = 1
);
--regresa la fecha final para los copys(debe ser la fecha mayor de las lineas de la orden) 06jun2013
elsif  p_tipo = 'FF_COPY' then
select to_char(max(to_timestamp(fecha_fin,'YYYYMMDD')),'YYYY-MM-DD')
into strict   v_total
from   xxmor_solicitudes_det_tab d,
(select distinct id_solicitud, numlinea_concom
from   xxmor_concom_rpta_tab
where  nullif(numlinea_concom::text, '') is not null
) cr
where  d.id_solicitud = cr.id_solicitud
and    d.linea        = cr.numlinea_concom
and    d.id_solicitud = p_id_solicitud
and    exists (select 1
from   xxmor_solicitudes_enc_tab e
where  e.id_solicitud = d.id_solicitud
and    e.id_seg_neg   = 1
);
end if;
return v_total;end;
$body$
language plpgsql
;
