create or replace procedure xxmor.xxmor_funcional_pkg_xxmor_sol_estatus_pr ( p_respuesta xxmor_funcional_pkg_xxmor_funcional_pkg_mor_rpta_concom_type ) as $body$
declare
-- pgv moved types start
-- pgv moved types end
v_enc_estatus_act        integer := 0;
v_det_estatus_act        integer := 0;
v_enc_estatus_nvo        integer := 0;
v_det_estatus_nvo        integer := 0;
v_enc_est_tipo_act       varchar(1);
v_det_est_tipo_act       varchar(1);
v_enc_est_tipo_nvo       varchar(1);
v_det_est_tipo_nvo       varchar(1);
v_distinct_status        integer := 0;
v_proc_por_linea         integer;
v_masterc_topado         integer := 0;
v_ln_status_46           varchar(2);
--dmap conversion comment: global temp variables moved as local temp variables
glo_document_temp text;
--dmap conversion comment: declaration boundary ends
begin
call dmap_extension.pkg_var_dmap_tab_to_gtt_init('XXMOR', 'XXMOR_FUNCIONAL_PKG');
--dmap conversion comment: gtt declaration added
/*--causa un problema de distribuited transaction
if p_respuesta.numlinea_concom is not null then
update xxmor_solicitudes_det_tab
set    tracking_id_concom = (select tracking_id_concom
from   xxmor_solicitudes_enc_tab
where  id_solicitud = p_respuesta.id_solicitud
)
where  id_solicitud = p_respuesta.id_solicitud
and    linea        = p_respuesta.numlinea_concom;
end if;
*/
--si se trata de una autorizacion hay que cambiar el estatus de la linea
if nullif(p_respuesta.numlinea_concom::text, '') is not null and upper(p_respuesta.accion_concom) = 'AUTORIZACION' then
update xxmor_solicitudes_det_tab
set    linea_estatus = 45--, updated_date =sysdate, updated_by =sol_estatus_pr
where  id_solicitud  = p_respuesta.id_solicitud
and    linea         = p_respuesta.numlinea_concom
and    linea_estatus not in (36,46);
end if;
--si se trata de una autorizacion de cps hay que cambiar el estatus del encabezado
if nullif(p_respuesta.numlinea_concom::text, '') is null and upper(p_respuesta.accion_concom) = 'AUTORIZACION' and p_respuesta.campo_concom = 'CPS' then
update xxmor_solicitudes_enc_tab
set    orden_estatus = 45--, updated_date =sysdate, updated_by =sol_estatus_pr
where  id_solicitud  = p_respuesta.id_solicitud
and    orden_estatus not in (36,46);
end if;
/*
select count(1)
into   v_masterc_topado
from   xxmor_concom_rpta_tab
where  instr(upper(desc_concom),master topado) > 0
and    numlinea_concom is null
and    id_solicitud    = p_respuesta.id_solicitud
and    estatus_orduni  = 10;
if v_masterc_topado > 0 then
update xxmor_solicitudes_enc_tab
set orden_estatus  = 45
where id_solicitud = p_respuesta.id_solicitud;
end if;
*/
select (case when nullif(se.proc_por_linea::text, '') is not null then 1 else 0 end)
into strict   v_proc_por_linea
from   xxmor_solicitudes_enc_tab se
where  se.id_solicitud = p_respuesta.id_solicitud;/* dmap converted statement start */
perform dbms_output.put_line( concat('procesar x Linea: ', v_proc_por_linea)) ;/* dmap converted statement end */
--estatus y tipo de estatus del encabezado
begin
select e.id_notificacion,
e.tipo_estatus
into strict   v_enc_estatus_act,
v_enc_est_tipo_act
from   xxmor_solicitudes_enc_tab se,
xxmor_ordenes_estatus_tab e
where  se.id_solicitud         = p_respuesta.id_solicitud
and    coalesce(se.orden_estatus,1) = e.id_notificacion
and    se.id_seg_neg           = e.id_seg_neg;
exception when no_data_found then
null;
end;/* dmap converted statement start */
perform dbms_output.put_line( concat(' P_Respuesta.accion_concom: ', p_respuesta.accion_concom)) ;/* dmap converted statement end *//* dmap converted statement start */
--si es linea
if nullif(p_respuesta.numlinea_concom::text, '') is not null or nullif(trim(both from p_respuesta.numlinea_concom::text), '') is not null then
perform dbms_output.put_line( concat('es Linea, ACCION_CONCOM: ', p_respuesta.accion_concom)) ;/* dmap converted statement end */
--si la linea ya esta bien
if upper(p_respuesta.accion_concom) = upper('LineaBien') then
v_det_estatus_nvo := 47;
update xxmor_solicitudes_det_tab
set    linea_estatus = v_det_estatus_nvo --, updated_date =sysdate, updated_by =sol_estatus_pr
where  id_solicitud = p_respuesta.id_solicitud
and    linea        = p_respuesta.numlinea_concom;
else
select coalesce(e.tipo_estatus,'T'),
coalesce(id_notificacion,1)
into strict   v_det_est_tipo_act,
v_det_estatus_act
from   xxmor_solicitudes_det_tab d,
xxmor_ordenes_estatus_tab e
where  id_solicitud    = p_respuesta.id_solicitud
and    linea           = p_respuesta.numlinea_concom
and    d.linea_estatus = e.id_notificacion;/* dmap converted statement start */
--si el estatus no esta en rechazado o semana confirmacin
perform dbms_output.put_line( concat('Estatus actual: ', v_det_estatus_act)) ;/* dmap converted statement end */
if v_det_estatus_act not in (36,46) then
--if instr(upper(p_respuesta.accion_concom), upper(rechazo)) > 0 or
--   instr(upper(p_respuesta.accion_concom), upper(semana)) > 0 or
--then
--            v_det_est_tipo_act := t;
--end if;
v_det_est_tipo_act := 'T';/* dmap converted statement start */
-- si el estatus es transitorio
perform dbms_output.put_line( concat('Tipo Estatus actual: ', v_det_est_tipo_act , ' P_Respuesta.accion_concom: ', p_respuesta.accion_concom)) ;/* dmap converted statement end */
if v_det_est_tipo_act = 'T' then
--si la respuesta de concom indica que es rechazo poner el estatus 46 (rechazo)
if position(upper('Rechazo') in upper(p_respuesta.accion_concom)) > 0 or position(upper('Rechazo') in upper(p_respuesta.estatus_concom)) > 0then          --rechazo
v_det_estatus_nvo := 46;
--si la respuesta de concom indica que es semana confirmacion poner el estatus 36 (rechazo)
elsif position(upper('Retencion') in upper(p_respuesta.accion_concom)) > 0 then
v_det_estatus_nvo := 36;
--si no poner error 45
else
v_det_estatus_nvo := 45;
end if;/* dmap converted statement start */
perform dbms_output.put_line( concat('Estatus nuevo de la linea: ', v_det_estatus_nvo)) ;/* dmap converted statement end */
--actualizamos el estatus
update xxmor_solicitudes_det_tab
set    linea_estatus = v_det_estatus_nvo--, updated_date =sysdate, updated_by =sol_estatus_pr
where  id_solicitud = p_respuesta.id_solicitud
and    linea        = p_respuesta.numlinea_concom;
/*if v_det_estatus_nvo in (45,46,36) then
v_enc_estatus_nvo  := 45;
update xxmor_solicitudes_enc_tab
set orden_estatus = v_enc_estatus_nvo
where id_solicitud = p_respuesta.id_solicitud;
dbms_output.put_line(estatus nuevo de la orden: ||v_enc_estatus_nvo);
end if;
*/
--si una linea es rechazada o retenida y la orden no es procesar x linea se rechaza toda la orden
if v_det_estatus_nvo in (36,46) and v_proc_por_linea = 0 then
update xxmor_solicitudes_enc_tab
set   orden_estatus = v_det_estatus_nvo --, updated_date =sysdate, updated_by =sol_estatus_pr
where id_solicitud = p_respuesta.id_solicitud;
end if;
end if;
end if;
end if;
--si es encabezado
else
perform dbms_output.put_line('Entro a modificar encabezado ');
if upper(p_respuesta.accion_concom) = 'ENCABEZADOBIEN'   then
v_enc_estatus_nvo := 47;
elsif v_enc_estatus_act not in (36, 46) then
if position(upper('Rechazo') in upper(p_respuesta.accion_concom)) > 0 or position(upper('Rechazo') in upper(p_respuesta.estatus_concom)) > 0 then
v_enc_estatus_nvo := 46;
update xxmor_solicitudes_det_tab
set    linea_estatus = v_enc_estatus_nvo
where  id_solicitud = p_respuesta.id_solicitud;
/*insert into xxmor_concom_rpta_tab (id_solicitud, id_seg_neg, id_rpta_concom,
resultadogeneral, trackingid, desc_concom,
posicion_concom, id_concom, numlinea_concom,
estatus_concom, campo_concom, detalle_concom,
accion_concom, tiporegla_concom, estatus_orduni,
created_date, created_by
)
select e.id_solicitud, 1, xxmor_id_rpta_concom_sq.nextval,
null, xxmor_id_rpta_concom_sq.nextval, null,
linea, null, linea,
error, hdr_rechazado, rechazo - el encabezado de la orden fue rechazado,
rechazo, null, 10,
sysdate, orduni2
from   xxmor_solicitudes_det_tab d,
xxmor_solicitudes_enc_tab e
where  e.id_solicitud = p_respuesta.id_solicitud
and    e.id_solicitud = d.id_solicitud;
*/
--si la respuesta de concom indica que es semana confirmacion poner el estatus 36 (rechazo)
elsif position(upper('semana') in upper(p_respuesta.accion_concom)) > 0 then
v_enc_estatus_nvo := 36;
elsif position(upper('EncabezadoBien') in upper(p_respuesta.accion_concom)) > 0 then
v_enc_estatus_nvo := 47;
--si no poner error 45
else
v_enc_estatus_nvo := 45;
end if;
--if v_enc_est_tipo_act in (45) then
update xxmor_solicitudes_enc_tab
set    orden_estatus = v_enc_estatus_nvo--, updated_date =sysdate, updated_by =sol_estatus_pr
where  id_solicitud = p_respuesta.id_solicitud;
--end if;
end if;
end if;
--si todas las lineas tienen el mismo estatus se pone dicho estatus
select count(*)
into strict   v_distinct_status
from (select distinct linea_estatus
from   xxmor_solicitudes_det_tab
where  id_solicitud = p_respuesta.id_solicitud
) alias1;/* dmap converted statement start */
perform dbms_output.put_line( concat('Num de diferentes status de la orden: ', v_distinct_status)) ;/* dmap converted statement end */
if v_distinct_status = 1 then
select distinct linea_estatus
into strict  v_det_estatus_act
from xxmor_solicitudes_det_tab
where id_solicitud = p_respuesta.id_solicitud;
--le hace ruido al trigger
update xxmor_solicitudes_enc_tab
set orden_estatus = v_det_estatus_act--, updated_date =sysdate, updated_by =sol_estatus_pr
where id_solicitud = p_respuesta.id_solicitud;
--jlbs
end if;end;
$body$
language plpgsql
;
