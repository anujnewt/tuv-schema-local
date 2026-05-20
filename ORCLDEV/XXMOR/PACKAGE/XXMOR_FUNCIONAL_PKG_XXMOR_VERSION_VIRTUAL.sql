create or replace  function  xxmor.xxmor_funcional_pkg_xxmor_version_virtual ( p_agrupador integer ) returns varchar as $body$
declare
-- pgv moved types start
-- pgv moved types end
lstwscall                   varchar(2500);
v_ws_url                    varchar(100);
v_aux                       varchar(100);
--cursor para llenar los parametros del ws que genera/revisa las versiones virtuales
/*cursor cur_lineas_orden is
select *
from    xxmor_vers_virt_aux_vw
where id_solicitud = p_id_solicitud;*/
cur_lineas_orden cursor for
select *
from   xxmor_vers_virt_aux_vw
where  id_solicitud in (select et.id_solicitud
from   xxmor.xxmor_solicitudes_orig_enc_tab oe,
xxmor.xxmor_solicitudes_enc_tab      et
where  oe.id_request = et.id_request
and    oe.aux1       = p_agrupador
);
--dmap conversion comment: global temp variables moved as local temp variables
glo_document_temp text;
--dmap conversion comment: declaration boundary ends
begin
call dmap_extension.pkg_var_dmap_tab_to_gtt_init('XXMOR', 'XXMOR_FUNCIONAL_PKG');
--dmap conversion comment: gtt declaration added
select valor_parametro
into strict   v_ws_url
from   xxmor_conf_params_grls_tab
where  nombre_parametro = 'WS_Version_Virtual';/* dmap converted statement start */
for lrowvervirtual in cur_lineas_orden loop
lstwscall :=  concat('
<soapenv:envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:tem="http://tempuri.org/">
<soapenv:header/>
<soapenv:body>
<tem:s_insertarversionvirtual>
<tem:sadvid>', lrowVerVirtual.ADVID , '</tem:sadvid>
<tem:sextcpynum>', lrowVerVirtual.EXTCPYNUM , '</tem:sextcpynum>
<tem:inomanclen>', lrowVerVirtual.NOMANCLEN , '</tem:inomanclen>
<tem:dtancstrdt>', lrowVerVirtual.ANCSTRDT , '</tem:dtancstrdt>
<tem:dtancedt>', lrowVerVirtual.ANCEDT , '</tem:dtancedt>
<tem:susrchr>', lrowVerVirtual.USRCHR , '</tem:susrchr>
<tem:ssptchr>', lrowVerVirtual.SPTCHR , '</tem:ssptchr>
<tem:sprdid1>', lrowVerVirtual.PRDID1 , '</tem:sprdid1>
<tem:svidsrc>', lrowVerVirtual.VIDSRC , '</tem:svidsrc>
<tem:saudsrc>', lrowVerVirtual.AUDSRC , '</tem:saudsrc>
<tem:sbrnd>', lrowVerVirtual.BRND , '</tem:sbrnd>
<tem:sautoid>', lrowVerVirtual.AUTOID , '</tem:sautoid>
<tem:sproactday>', lrowVerVirtual.PROACTDAY , '</tem:sproactday>
<tem:sactday>', lrowVerVirtual.ACTDAY , '</tem:sactday>
<tem:spropgmid>', lrowVerVirtual.PROPGMID , '</tem:spropgmid>
<tem:sprostn>', lrowVerVirtual.PROSTN , '</tem:sprostn>
</tem:s_insertarversionvirtual>
</soapenv:body>
</soapenv:envelope>') ;/* dmap converted statement end */
--dbms_output.put_line(lstwscall);
call xxmor_funcional_pkg_xxmor_call_ws_sp(lstwscall, v_ws_url);
end loop;
return v_aux;end;
$body$
language plpgsql
;
