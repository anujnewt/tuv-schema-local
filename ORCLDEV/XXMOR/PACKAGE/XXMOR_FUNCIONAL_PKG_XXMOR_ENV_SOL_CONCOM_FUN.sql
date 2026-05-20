create or replace  function  xxmor.xxmor_funcional_pkg_xxmor_env_sol_concom_fun ( p_id_solicitud integer ) returns varchar as $body$
declare
-- pgv moved types start
-- pgv moved types end
lineas_cur cursor for
select linea
from xxmor_solicitudes_det_tab d
left outer join (select distinct id_solicitud, numlinea_concom
from   xxmor_concom_rpta_tab
where  id_solicitud    = p_id_solicitud
and    nullif(numlinea_concom::text, '') is not null
and    id_seg_neg      = 1
except
select distinct id_solicitud, numlinea_concom
from   xxmor_concom_rpta_tab
where  id_solicitud    = p_id_solicitud
and    nullif(numlinea_concom::text, '') is not null
and    estatus_orduni  = '10'
and    id_seg_neg      = 1
) cr on (d.id_solicitud = cr.id_solicitud and d.linea = cr.numlinea_concom)
where d.id_solicitud = p_id_solicitud and exists (select 1
from   xxmor_solicitudes_est_rep_tab er
where  er.id_solicitud     = d.id_solicitud
and    er.linea            = d.linea
and    nullif(er.estat_id_foraneo::text, '') is null
);
v_dir_ws          varchar(250);
v_lineas_env      varchar(2250);
v_soap_call       varchar(1500);
--dmap conversion comment: global temp variables moved as local temp variables
glo_document_temp text;
--dmap conversion comment: declaration boundary ends
begin
call dmap_extension.pkg_var_dmap_tab_to_gtt_init('XXMOR', 'XXMOR_FUNCIONAL_PKG');/* dmap converted statement start */
--dmap conversion comment: gtt declaration added
for c_lineas in lineas_cur loop
v_lineas_env :=  concat(v_lineas_env, c_lineas.linea, ',') ;/* dmap converted statement end */
end loop;/* dmap converted statement start */
perform dbms_output.put_line( concat('-> ', v_lineas_env)) ;/* dmap converted statement end */
select oracle.substr(v_lineas_env,1,length(v_lineas_env)-1)
into strict v_lineas_env
;/* dmap converted statement start */
perform dbms_output.put_line( concat('-> ', v_lineas_env)) ;/* dmap converted statement end *//* dmap converted statement start */
select  concat('<soapenv:envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:mor="http://xmlns.oracle.com/mor_jws/morbsrecibirsolicitudes/morbsenviarlineaaconcom">
<soapenv:header/>
<soapenv:body>
<mor:process>
<mor:idsolicitud>', P_ID_SOLICITUD, '</mor:idsolicitud>
<mor:lineas>', V_LINEAS_ENV, '</mor:lineas>
</mor:process>
</soapenv:body>
</soapenv:envelope>'
) into strict v_soap_call
;/* dmap converted statement end */
select valor_parametro
into strict   v_dir_ws
from   xxmor_conf_params_grls_tab
where  nombre_parametro = 'ServicioEnvSolConcom';
call xxmor_funcional_pkg_xxmor_call_ws_sp(v_soap_call,v_dir_ws);
return '1';end;
$body$
language plpgsql
;
