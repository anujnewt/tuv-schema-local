create or replace procedure xxmor.xxmor_funcional_pkg_xxmor_call_ws_sp ( p_soap_request varchar, p_req varchar ) as $body$
declare
-- pgv moved types start
-- pgv moved types end
soap_request   varchar(30000);
soap_respond   varchar(30000);
http_req       utl_http.req;
http_resp      utl_http.resp;
launch_url     varchar(240);
--dmap conversion comment: global temp variables moved as local temp variables
glo_document_temp text;
--dmap conversion comment: declaration boundary ends
begin
call dmap_extension.pkg_var_dmap_tab_to_gtt_init('XXMOR', 'XXMOR_FUNCIONAL_PKG');
--dmap conversion comment: gtt declaration added
http_req:= utl_http.begin_request(p_req ,'POST', 'HTTP/1.1' );
utl_http.set_header(http_req, 'Content-Type', 'text/xml');
utl_http.set_header(http_req, 'Content-Length', length(p_soap_request));
utl_http.set_header(http_req, 'SOAPAction', 'process');
utl_http.write_text(http_req, p_soap_request);
http_resp:= utl_http.get_response(http_req);
utl_http.read_text(http_resp, soap_respond);
utl_http.end_response(http_resp);
exception
when utl_http.end_of_body then
utl_http.end_response(http_resp);end;
$body$
language plpgsql
;
