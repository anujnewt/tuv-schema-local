create or replace procedure xxmor.xxmor_funcional_pkg_xxmor_revisar_semana_conf_pr () as $body$
declare
-- pgv moved types start
-- pgv moved types end
v_req      varchar(3000);
v_loc_proc varchar(3000);
fzas_con_sc_cur cursor for
select distinct f.id_fza_ventas, f.ident_fza_ventas
from   xxmor_solicitudes_det_tab d,
xxmor_solicitudes_enc_tab e,
xxmor_concom_rpta_tab     r,
xxmor_fzas_vtas_tab       f
where  e.id_solicitud   = d.id_solicitud
and    e.id_fza_ventas  = f.id_fza_ventas
and    d.id_solicitud   = r.id_solicitud
and    d.linea          = r.numlinea_concom
and    e.id_seg_neg     = 1
and    position(upper('RETENCION') in upper(r.accion_concom)) > 0
and    r.estatus_orduni = '10';
--dmap conversion comment: global temp variables moved as local temp variables
glo_document_temp text;
--dmap conversion comment: declaration boundary ends
begin
call dmap_extension.pkg_var_dmap_tab_to_gtt_init('XXMOR', 'XXMOR_FUNCIONAL_PKG');
--dmap conversion comment: gtt declaration added
--4    semana_confirmar    direccion del ws de liberar ordenes    http://10.7.0.251:8003/soa-infra/services/default/morbsrecibirsolicitudes/morbsliberarsemanaconf_client_ep    ws
select valor_parametro
into strict   v_loc_proc
from   xxmor_conf_params_grls_tab
where  nombre_parametro = 'SEMANA_CONFIRMAR';/* dmap converted statement start */
--dbms_output.put_line( to_char(v_id_remision)||<   >||to_char(v_id_warehouse));
for fza_conf in fzas_con_sc_cur loop
v_req := concat('<soapenv:envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:mor="http://xmlns.oracle.com/mor_jws/morbsrecibirsolicitudes/morbsliberarsemanaconf">
<soapenv:header/>
<soapenv:body>
<mor:process>
<mor:idfzaventas>', FZA_CONF.ID_FZA_VENTAS, '</mor:idfzaventas>
<mor:identfzaventas>', FZA_CONF.IDENT_FZA_VENTAS, '</mor:identfzaventas>
</mor:process>
</soapenv:body>
</soapenv:envelope>') ;/* dmap converted statement end */
call xxmor_funcional_pkg_xxmor_call_ws_sp(v_req, v_loc_proc);
end loop;
delete from xxmor_ejecuciones_prog_tab
where nombre_proceso = 'XXMOR_REVISAR_SEMANA_CONF_PR'
and hora_ini_ejecucion <= clock_timestamp() - interval '1 days';
insert into xxmor_ejecuciones_prog_tab(id_ejecucion, nombre_proceso)
values (nextval('xxmor_ejecuciones_prog_seq'), 'XXMOR_REVISAR_SEMANA_CONF_PR');
/*update xxmor_ejecuciones_prog_tab
set hoa_fin_ejecucion = sysdate, status_ejecucion = b
where id_ejecucion = xxmor_ejecuciones_prog_seq.currval;
*/
/* commit; */
end;
$body$
language plpgsql
;
