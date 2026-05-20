create or replace procedure xxmor.xxmor_funcional_pkg_xxmor_aut_openlog_fun ( p_id_solicitud numeric, p_tipo numeric, o_res inout varchar ) as $body$
declare
-- pgv moved types start
-- pgv moved types end
v_trackingid        varchar(100);
--dmap conversion comment: global temp variables moved as local temp variables
glo_document_temp text;
--dmap conversion comment: declaration boundary ends
begin
call dmap_extension.pkg_var_dmap_tab_to_gtt_init('XXMOR', 'XXMOR_FUNCIONAL_PKG');
--dmap conversion comment: gtt declaration added
begin
select nextval('xxmor_id_rpta_concom_sq')
into strict   v_trackingid
;
--se le quito la hora 11-07-2012 por que causa q algunas ordenes no generen autorizacion por openlog
insert into xxmor_concom_rpta_tab(id_solicitud, id_seg_neg, id_rpta_concom,
resultadogeneral, trackingid, desc_concom,
posicion_concom, id_concom, numlinea_concom,
estatus_concom, campo_concom, detalle_concom,
accion_concom, tiporegla_concom, estatus_orduni,
created_date, created_by
)
select e.id_solicitud, 1, nextval('xxmor_id_rpta_concom_sq'),
p_tipo, v_trackingid, null,
'LINEA', null, d.linea,
'ERROR', 'OPENLOG', 'AUTORIZACION - Openlog.- La primera transmision tiene una fecha menor a la actual',
'AUTORIZACION', null, '10',
clock_timestamp(), 'ORDUNI2'
from   xxmor_solicitudes_enc_tab e,
xxmor_solicitudes_det_tab d
where  e.id_solicitud = p_id_solicitud
and    e.id_solicitud = d.id_solicitud
and    trunc(clock_timestamp()) >= (select to_timestamp(det.fecha_inicio,'yyyymmdd')
+  case when lunes     != 0 then 0
when martes    != 0 then 1
when miercoles != 0 then 2
when jueves    != 0 then 3
when viernes   != 0 then 4
when sabado    != 0 then 5
when domingo   != 0 then 6
else 999 end
from   xxmor_solicitudes_det_tab det
where  det.id_solicitud = d.id_solicitud
and    det.linea        = d.linea
and    not exists ( select 1
from   xxmor_concom_rpta_tab c
where  det.id_solicitud             = c.id_solicitud
and    nullif(c.numlinea_concom::text, '') is not null
and    upper(c.accion_concom)       = 'RECHAZO'
and    (c.numlinea_concom)::numeric  = det.linea
)
and not exists ( select 1
from   xxmor_concom_rpta_tab c
where  det.id_solicitud             = c.id_solicitud
and    nullif(c.numlinea_concom::text, '') is not null
and    upper(c.accion_concom)       = 'REENVIO'
and    c.estatus_orduni             = '10'
and    (c.numlinea_concom)::numeric  = det.linea
)
)
and    not exists (select 1
from   xxmor_concom_rpta_tab c
where  c.id_solicitud               = e.id_solicitud
and    nullif(c.numlinea_concom::text, '') is not null
and (c.campo_concom              = 'OPENLOG'
or upper(c.accion_concom)   = 'RECHAZO'
)
and    (c.numlinea_concom)::numeric  = d.linea
)
and    not exists (select 1
from   xxmor_concom_rpta_tab c
where  c.id_solicitud               = e.id_solicitud
and    nullif(c.numlinea_concom::text, '') is not null
and    upper(c.accion_concom)       = 'REENVIO'
and    c.estatus_orduni             = '10'
and    (c.numlinea_concom)::numeric  = d.linea
)
and    exists (select 1
from   xxmor_solicitudes_est_rep_tab er
where  er.id_solicitud  = d.id_solicitud
and    er.linea         = d.linea
and    nullif(estat_id_foraneo::text, '') is null
);
end;
select 'OK'
into strict   o_res
;end;
$body$
language plpgsql
;
