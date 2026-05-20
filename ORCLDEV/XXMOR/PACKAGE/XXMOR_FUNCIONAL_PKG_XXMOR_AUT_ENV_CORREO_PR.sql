create or replace procedure xxmor.xxmor_funcional_pkg_xxmor_aut_env_correo_pr ( p_id_solicitud integer, p_mail_address varchar, p_aut_rech varchar ) as $body$
declare
-- pgv moved types start
-- pgv moved types end
/*
procedimiento para autorizar las ordenes de mercadotecnia
*/
v_flag_autom              integer; --autorizacion automatica
v_flag_mkt                integer;
v_mkt_mail_director       varchar(50);
v_mkt_mail_gerente        varchar(50);
v_mkt_mail_coordinador    varchar(50);
v_buyunit                 varchar(50);
v_rechazo                 integer := 0;
v_id_fza_ventas           integer;
v_req                     varchar(2000);
v_loc_proc                varchar(3000);
v_lineas                  varchar(2000);
lst_error                 varchar(500) := null;
buyunits_cur cursor for
select distinct coalesce(buyuntid,'NULO') as buyuntid
from  xxmor_solicitudes_det_tab
where id_solicitud = p_id_solicitud;
lineas_cur cursor for
select distinct
d.linea
from   xxmor.xxmor_solicitudes_det_tab d,
xxmor.xxmor_concom_rpta_tab c
where  d.id_solicitud          = p_id_solicitud
and    c.id_solicitud          = d.id_solicitud
and    c.numlinea_concom       = d.linea
and    c.estatus_orduni        = '20'
and    c.accion_concom         = 'AUTORIZACION'
and    c.campo_concom          = 'TARIFA_MANUAL'
and    position('__'  c.updated_by) > 0;
--dmap conversion comment: global temp variables moved as local temp variables
glo_document_temp text;
--dmap conversion comment: declaration boundary ends
begin
call dmap_extension.pkg_var_dmap_tab_to_gtt_init('XXMOR', 'XXMOR_FUNCIONAL_PKG');
--dmap conversion comment: gtt declaration added
if p_aut_rech = 'AUTORIZAR' then
update xxmor.xxmor_concom_rpta_tab
set    estatus_orduni = '20',
updated_by     = oracle.substr(p_mail_address,1,20),
updated_date   = clock_timestamp()
where  id_solicitud   = p_id_solicitud
and    accion_concom  = 'AUTORIZACION'
and    campo_concom   = 'TARIFA_MANUAL'
and    1              = (select mercadotecnia
from   xxmor.xxmor_fzas_vtas_tab
where  id_fza_ventas = (select id_fza_ventas
from   xxmor.xxmor_solicitudes_enc_tab
where  id_solicitud = p_id_solicitud
)
)
and    exists           (select 1
from   xxmor_solicitudes_det_tab d,
xxmor_cat_buyunit_mkt_tab bm
where  bm.id_seg_neg    = 1
and    coalesce(trim(both d.buyuntid),'SIN BUYUNIT') = coalesce(trim(both bm.buyuntid),'SIN BUYUNIT')
and    d.id_solicitud   = p_id_solicitud
and    bm.id_fza_ventas = (select e.id_fza_ventas
from   xxmor_solicitudes_enc_tab e
where  e.id_solicitud = d.id_solicitud
)
and (trim(both upper(bm.mkt_gerente))     = trim(both upper(p_mail_address)) or
trim(both upper(bm.mkt_coordinador)) = trim(both upper(p_mail_address)) or
trim(both upper(bm.mkt_director))    = trim(both upper(p_mail_address))
)
);/* dmap converted statement start */
--se reprocesan las lineas aurorizadas
for ren_lineas_cur in lineas_cur loop
v_lineas :=  concat(v_lineas, to_char(ren_lineas_cur.linea), ',') ;/* dmap converted statement end *//* dmap converted statement start */
perform dbms_output.put_line( concat('V_LINEAS: ', v_lineas)) ;/* dmap converted statement end */
end loop;
select oracle.substr(v_lineas,1,length(v_lineas)-1)
into strict   v_lineas
;
select valor_parametro
into strict   v_loc_proc
from   xxmor_conf_params_grls_tab
where  nombre_parametro = 'EnvLineasAConcom';/* dmap converted statement start */
v_req :=  concat('<soapenv:envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:mor="http://xmlns.oracle.com/mor_jws/morbsrecibirsolicitudes/morbsenviarlineaaconcom">
<soapenv:header/>
<soapenv:body>
<mor:process>
<mor:idsolicitud>', P_ID_SOLICITUD, '</mor:idsolicitud>
<mor:lineas>', V_LINEAS , '</mor:lineas>
</mor:process>
</soapenv:body>
</soapenv:envelope>') ;/* dmap converted statement end */
call xxmor_funcional_pkg_xxmor_call_ws_sp(v_req, v_loc_proc);
elsif p_aut_rech = 'RECHAZAR' then
insert into xxmor_concom_rpta_tab( id_solicitud, id_seg_neg, id_rpta_concom, resultadogeneral, trackingid,   desc_concom,
posicion_concom, id_concom, numlinea_concom, estatus_concom, campo_concom,
detalle_concom, accion_concom, tiporegla_concom, estatus_orduni, created_date,
created_by
)
select e.id_solicitud, id_seg_neg, nextval('xxmor_id_rpta_concom_sq'), null, nextval('xxmor_id_rpta_concom_sq'), null,
'LINEA', null,linea, 'error','sobrecargo',
'RECHAZO - La linea ha sido rechazada por Email/Tarifa Manual', 'RECHAZO', null, '10', clock_timestamp(),
oracle.substr(p_mail_address,1,20)
from   xxmor_solicitudes_det_tab d,
xxmor_solicitudes_enc_tab e
where  e.id_solicitud = p_id_solicitud
and    e.id_solicitud = d.id_solicitud
and    d.linea        in (select (numlinea_concom)::numeric
from   xxmor_concom_rpta_tab
where  id_solicitud = d.id_solicitud
and    nullif(numlinea_concom::text, '') is not null
and    campo_concom = 'TARIFA_MANUAL'
);
else
null;
end if;
/* commit; */
exception
when others then
lst_error := sqlerrm;/* dmap converted statement start */
-- se inserta en la tabla de errores el error encontrado
insert into xxmor_log_errores_tab(
id_error,
desc_error,
archivo_error,
metodo_error,
hora_error
)
values (       nextval('xxmor.xxmor_log_error_sq'),
concat('error al autorizar por correo la orden: ', P_ID_SOLICITUD, ': ', lst_error) ,
'XXMOR_FUNCIONAL_PKG',
'XXMOR_AUT_ENV_CORREO_PR',
clock_timestamp()
);/* dmap converted statement end */end;
$body$
language plpgsql
;
