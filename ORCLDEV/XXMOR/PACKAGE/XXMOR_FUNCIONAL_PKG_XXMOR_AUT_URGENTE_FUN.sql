create or replace procedure xxmor.xxmor_funcional_pkg_xxmor_aut_urgente_fun ( p_id_solicitud numeric, p_tipo numeric ) as $body$
declare
-- pgv moved types start
-- pgv moved types end
--dmap conversion comment: global temp variables moved as local temp variables
glo_document_temp text;
--dmap conversion comment: declaration boundary ends
begin
call dmap_extension.pkg_var_dmap_tab_to_gtt_init('XXMOR', 'XXMOR_FUNCIONAL_PKG');
--dmap conversion comment: gtt declaration added
begin
execute 'ALTER SESSION SET NLS_TERRITORY=MEXICO;' ; /* dmap converted statement */
end;/* dmap converted statement start */
insert into xxmor_concom_rpta_tab(id_solicitud, id_seg_neg, id_rpta_concom,
resultadogeneral, trackingid, desc_concom,
posicion_concom, id_concom, numlinea_concom,
estatus_concom, campo_concom, detalle_concom,
accion_concom, tiporegla_concom, estatus_orduni,
created_date, created_by
)
select id_solicitud, 1, nextval('xxmor_id_rpta_concom_sq'),
p_tipo, nextval('xxmor_id_rpta_concom_sq'), null,
'LINEA', null, linea,
'ERROR', 'URGENTE',  concat('Autorizacion - Linea URGENTE: La linea tiene transmisiones que estan fuera de la hora de cierre (', to_char(c.dia_cierre_ini,'DD/MM/YYYY hh24:mi'), ')') ,
'AUTORIZACION', null, '10',
clock_timestamp(), 'ORDUNI2'
from   xxmor_solicitudes_det_tab d,
(select id_seg_neg,
id_fza_ventas,
dia,
dia_cierre,
to_char(hora_cierre,'hh24:mi') as hora_cierre,
to_char(clock_timestamp(),'D') hoy,
case when dia = (to_char(clock_timestamp(),'D'))::numeric  then
to_date( concat(to_char(clock_timestamp(), 'yyyymmdd'), ' ', to_char(hora_cierre, 'HH24:MI')) ,'YYYYMMDD HH24:MI')
end as dia_cierre_ini,
next_day(to_date( concat(to_char(clock_timestamp(), 'yyyymmdd'), '23:59:59') ,'YYYYMMDDHH24:MI:SS'),
case when dia_cierre=1 then  'MON' when dia_cierre=2 then  'TUE' when dia_cierre=3 then  'WED' when dia_cierre=4 then  'THU' when dia_cierre=5 then  'FRI' when dia_cierre=6 then  'SAT' when dia_cierre=7 then  'SUN' end
) as dia_cierre_fin
from   xxmor_conf_ords_urgentes_tab
) c
where  id_solicitud = p_id_solicitud
and    nullif(c.dia_cierre_ini::text, '') is not null
--        and to_char(to_date(xxmor_funcional_pkg_xxmor_sol_fechas_fun(id_solicitud,linea, f_1a_t),yyyymmdd),d) = c.dia_cierre
--        and to_date(xxmor_funcional_pkg_xxmor_sol_fechas_fun(id_solicitud,1, f_1a_t)||lpad(hora_inicio::text, 4, 0::text),yyyymmddhh24mi)
--              between c.dia_cierre_ini and c.dia_cierre_fin
and    to_char(to_timestamp(xxmor_funcional_pkg_xxmor_sol_fechas_fun(id_solicitud,linea, 'F_1A_T'),'YYYYMMDd'),'D') = c.dia_cierre
and    to_timestamp(xxmor_funcional_pkg_xxmor_sol_fechas_fun(id_solicitud,linea, 'F_1A_T'),'yyyymmdd')
between trunc(c.dia_cierre_ini+1) and trunc(c.dia_cierre_fin)
and    clock_timestamp() > c.dia_cierre_ini
and    c.id_fza_ventas = (select id_fza_ventas
from   xxmor_solicitudes_enc_tab
where  id_solicitud = p_id_solicitud
)
and    not exists (select 1
from   xxmor_concom_rpta_tab c
where  c.id_solicitud     = d.id_solicitud
and    c.numlinea_concom  = d.linea
and    nullif(c.numlinea_concom::text, '') is not null
and    c.campo_concom     = 'URGENTE'
and    (d.linea)::numeric  = (c.numlinea_concom)::numeric
)
and not exists (select 1
from   xxmor_concom_rpta_tab c
where  c.id_solicitud         = d.id_solicitud
and    c.numlinea_concom      = d.linea
and    nullif(c.numlinea_concom::text, '') is not null
and    upper(c.accion_concom) = 'RECHAZO'
and    (d.linea)::numeric      = (c.numlinea_concom)::numeric
)
and exists (select 1
from   xxmor_solicitudes_est_rep_tab er
where  er.id_solicitud     = d.id_solicitud
and    er.linea            = d.linea
and    nullif(er.estat_id_foraneo::text, '') is null
);/* dmap converted statement end */end;
$body$
language plpgsql
;
